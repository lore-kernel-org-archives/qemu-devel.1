Received: from eggs.gnu.org ([2001:4830:134:3::10]:40356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjm-0003X0-UC
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbS-0005Ix-0b
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbR-0005Hp-PC
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:44 -0400
Message-Id: <20180910232752.31565-5-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 04/12] qsp: use atomic64 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

With the seqlock, we either have to use atomics to remain
within defined behaviour (and note that 64-bit atomics aren't
always guaranteed to compile, irrespective of __nocheck), or
drop the atomics and be in undefined behaviour territory.

Fix it by dropping the seqlock and using atomic64 accessors.
This will limit scalability when !CONFIG_ATOMIC64, but those
machines (1) don't have many users and (2) are unlikely to
have many cores.

- With CONFIG_ATOMIC64:
$ tests/atomic_add-bench -n 1 -m -p
 Throughput:         13.00 Mops/s

- Forcing !CONFIG_ATOMIC64:
$ tests/atomic_add-bench -n 1 -m -p
 Throughput:         10.89 Mops/s

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 util/qsp.c | 49 ++++++++-----------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index b0c2575d10..c16af03f6a 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -84,13 +84,6 @@ struct QSPEntry {
     uint64_t n_acqs;
     uint64_t ns;
     unsigned int n_objs; /* count of coalesced objs; only used for reporting */
-#ifndef CONFIG_ATOMIC64
-    /*
-     * If we cannot update the counts atomically, then use a seqlock.
-     * We don't need an associated lock because the updates are thread-local.
-     */
-    QemuSeqLock sequence;
-#endif
 };
 typedef struct QSPEntry QSPEntry;
 
@@ -344,47 +337,16 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
     return qsp_entry_find(&qsp_ht, &orig, hash);
 }
 
-/*
- * @from is in the global hash table; read it atomically if the host
- * supports it, otherwise use the seqlock.
- */
-static void qsp_entry_aggregate(QSPEntry *to, const QSPEntry *from)
-{
-#ifdef CONFIG_ATOMIC64
-    to->ns += atomic_read__nocheck(&from->ns);
-    to->n_acqs += atomic_read__nocheck(&from->n_acqs);
-#else
-    unsigned int version;
-    uint64_t ns, n_acqs;
-
-    do {
-        version = seqlock_read_begin(&from->sequence);
-        ns = atomic_read__nocheck(&from->ns);
-        n_acqs = atomic_read__nocheck(&from->n_acqs);
-    } while (seqlock_read_retry(&from->sequence, version));
-
-    to->ns += ns;
-    to->n_acqs += n_acqs;
-#endif
-}
-
 /*
  * @e is in the global hash table; it is only written to by the current thread,
  * so we write to it atomically (as in "write once") to prevent torn reads.
- * If the host doesn't support u64 atomics, use the seqlock.
  */
 static inline void do_qsp_entry_record(QSPEntry *e, int64_t delta, bool acq)
 {
-#ifndef CONFIG_ATOMIC64
-    seqlock_write_begin(&e->sequence);
-#endif
-    atomic_set__nocheck(&e->ns, e->ns + delta);
+    atomic_set_u64(&e->ns, e->ns + delta);
     if (acq) {
-        atomic_set__nocheck(&e->n_acqs, e->n_acqs + 1);
+        atomic_set_u64(&e->n_acqs, e->n_acqs + 1);
     }
-#ifndef CONFIG_ATOMIC64
-    seqlock_write_end(&e->sequence);
-#endif
 }
 
 static inline void qsp_entry_record(QSPEntry *e, int64_t delta)
@@ -550,7 +512,12 @@ static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
 
     hash = qsp_entry_no_thread_hash(e);
     agg = qsp_entry_find(ht, e, hash);
-    qsp_entry_aggregate(agg, e);
+    /*
+     * The entry is in the global hash table; read from it atomically (as in
+     * "read once").
+     */
+    agg->ns += atomic_read_u64(&e->ns);
+    agg->n_acqs += atomic_read_u64(&e->n_acqs);
 }
 
 static void qsp_iter_diff(struct qht *orig, void *p, uint32_t hash, void *htp)
-- 
2.17.1
