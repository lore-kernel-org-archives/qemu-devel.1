Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fquVO-0007zf-QQ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fquVL-0003Fe-MH
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:14:34 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fquVL-0003DU-AF
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 02:14:31 -0400
Date: Sat, 18 Aug 2018 02:14:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180818061423.GA10530@flamenco>
References: <20180817051853.23792-1-cota@braap.org>
	<9419c47a-4cc9-8f52-3d63-fda767029633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9419c47a-4cc9-8f52-3d63-fda767029633@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] synchronization profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Aug 17, 2018 at 12:38:05 +0200, Paolo Bonzini wrote:
> Queued, I'll wait for more comments before sending a pull request.

Thanks!

Patchew reported some build errors on mingw, the most important of
which is that I didn't handle !CONFIG_ATOMIC64. I have a v3
that fixes this by using a seqlock if atomics aren't available
(perf wise is virtually the same, since a lock isn't necessary)
plus other little things (like a trivial seqlock fix or actually
doing atomic reads when aggregating stats; I also fixed the commit
log in the last patch).

Instead of spamming the list with a v3, I'm appending the diff
between v2 and v3.

Please fetch v3 from:
  https://github.com/cota/qemu/tree/sync-profiler-v3

Thanks,

		Emilio
---
$ git diff -O scripts/git.orderfile sync-profiler-v2..sync-profiler-v3
diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index 8dee11d101..c367516708 100644
--- a/include/qemu/seqlock.h
+++ b/include/qemu/seqlock.h
@@ -45,7 +45,7 @@ static inline void seqlock_write_end(QemuSeqLock *sl)
     atomic_set(&sl->sequence, sl->sequence + 1);
 }
 
-static inline unsigned seqlock_read_begin(QemuSeqLock *sl)
+static inline unsigned seqlock_read_begin(const QemuSeqLock *sl)
 {
     /* Always fail if a write is in progress.  */
     unsigned ret = atomic_read(&sl->sequence);
diff --git a/util/qsp.c b/util/qsp.c
index 65d9d8f0d6..61ab1cba2d 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -84,6 +84,13 @@ struct QSPEntry {
     uint64_t n_acqs;
     uint64_t ns;
     unsigned int n_objs; /* count of coalesced objs; only used for reporting */
+#ifndef CONFIG_ATOMIC64
+    /*
+     * If we cannot update the counts atomically, then use a seqlock.
+     * We don't need an associated lock because the updates are thread-local.
+     */
+    QemuSeqLock sequence;
+#endif
 };
 typedef struct QSPEntry QSPEntry;
 
@@ -137,7 +144,7 @@ QemuCondWaitFunc qemu_cond_wait_func = qemu_cond_wait_impl;
 static inline
 uint32_t do_qsp_callsite_hash(const QSPCallSite *callsite, uint64_t a)
 {
-    uint64_t b = (uint64_t)callsite->obj;
+    uint64_t b = (uint64_t)(uintptr_t)callsite->obj;
     uint32_t e = callsite->line;
     uint32_t f = callsite->type;
 
@@ -157,7 +164,7 @@ static inline uint32_t do_qsp_entry_hash(const QSPEntry *entry, uint64_t a)
 
 static uint32_t qsp_entry_hash(const QSPEntry *entry)
 {
-    return do_qsp_entry_hash(entry, (uint64_t)entry->thread_ptr);
+    return do_qsp_entry_hash(entry, (uint64_t)(uintptr_t)entry->thread_ptr);
 }
 
 static uint32_t qsp_entry_no_thread_hash(const QSPEntry *entry)
@@ -337,6 +344,57 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
     return qsp_entry_find(&qsp_ht, &orig, hash);
 }
 
+/*
+ * @from is in the global hash table; read it atomically if the host
+ * supports it, otherwise use the seqlock.
+ */
+static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
+{
+#ifdef CONFIG_ATOMIC64
+    to->ns += atomic_read(&from->ns);
+    to->n_acqs += atomic_read(&from->n_acqs);
+#else
+    unsigned int version;
+    uint64_t ns, n_acqs;
+
+    do {
+        version = seqlock_read_begin(&from->sequence);
+        ns = from->ns;
+        n_acqs = from->n_acqs;
+    } while (seqlock_read_retry(&from->sequence, version));
+
+    to->ns += ns;
+    to->n_acqs += n_acqs;
+#endif
+}
+
+/*
+ * @e is in the global hash table; it is only written to by the current thread,
+ * so we write to it atomically (as in "write once") to prevent torn reads.
+ * If the host doesn't support u64 atomics, use the seqlock.
+ */
+static inline void do_qsp_entry_record(QSPEntry *e, int64_t delta, bool acq)
+{
+#ifdef CONFIG_ATOMIC64
+    atomic_set(&e->ns, e->ns + delta);
+    if (acq) {
+        atomic_set(&e->n_acqs, e->n_acqs + 1);
+    }
+#else
+    seqlock_write_begin(&e->sequence);
+    e->ns += delta;
+    if (acq) {
+        e->n_acqs++;
+    }
+    seqlock_write_end(&e->sequence);
+#endif
+}
+
+static inline void qsp_entry_record(QSPEntry *e, int64_t delta)
+{
+    do_qsp_entry_record(e, delta, true);
+}
+
 #define QSP_GEN_VOID(type_, qsp_t_, func_, impl_)                       \
     static void func_(type_ *obj, const char *file, int line)           \
     {                                                                   \
@@ -348,8 +406,7 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
         t1 = get_clock();                                               \
                                                                         \
         e = qsp_entry_get(obj, file, line, qsp_t_);                     \
-        atomic_set(&e->ns, e->ns + t1 - t0);                            \
-        atomic_set(&e->n_acqs, e->n_acqs + 1);                          \
+        qsp_entry_record(e, t1 - t0);                                   \
     }
 
 #define QSP_GEN_RET1(type_, qsp_t_, func_, impl_)                       \
@@ -364,10 +421,7 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
         t1 = get_clock();                                               \
                                                                         \
         e = qsp_entry_get(obj, file, line, qsp_t_);                     \
-        atomic_set(&e->ns, e->ns + t1 - t0);                            \
-        if (!err) {                                                     \
-            atomic_set(&e->n_acqs, e->n_acqs + 1);                      \
-        }                                                               \
+        do_qsp_entry_record(e, t1 - t0, !err);                          \
         return err;                                                     \
     }
 
@@ -394,8 +448,7 @@ qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file, int line)
     t1 = get_clock();
 
     e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
-    atomic_set(&e->ns, e->ns + t1 - t0);
-    atomic_set(&e->n_acqs, e->n_acqs + 1);
+    qsp_entry_record(e, t1 - t0);
 }
 
 bool qsp_is_enabled(void)
@@ -500,8 +553,7 @@ static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
 
     hash = qsp_entry_no_thread_hash(e);
     agg = qsp_entry_find(ht, e, hash);
-    agg->ns += e->ns;
-    agg->n_acqs += e->n_acqs;
+    qsp_entry_aggregate(agg, e);
 }
 
 static void qsp_iter_diff(struct qht *orig, void *p, uint32_t hash, void *htp)
