Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBr-0002oh-IV
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBo-0001Gh-Ed
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBo-0001GP-99
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haZG083993
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:27 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdkv8y2p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:27 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:27 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:24 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-31-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 30/67] qht: fix unlock-after-free segfault upon
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>

From: "Emilio G. Cota" <cota@braap.org>

The old map's bucket locks are being unlocked *after*
that same old map has been passed to RCU for destruction.
This is a bug that can cause a segfault, since there's
no guarantee that the deletion will be deferred (e.g.
there may be no concurrent readers).

The segfault is easily triggered in RHEL6/CentOS6 with qht-test,
particularly on a single-core system or by pinning qht-test
to a single core.

Fix it by unlocking the map's bucket locks right after having
published the new map, and (crucially) before marking the map
for deletion via call_rcu().

While at it, expand qht_do_resize() to atomically do (1) a reset,
(2) a resize, or (3) a reset+resize. This simplifies the calling
code, since the new function (qht_do_resize_reset()) acquires
and releases the buckets' locks.

Note that no qht_do_reset inline is provided, since it would have
no users--qht_reset() already performs a reset without taking
ht->lock.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1475706880-10667-3-git-send-email-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 76b553b308dc8671eb672b889b38889b1231cf1e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/qht.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/util/qht.c b/util/qht.c
index af8da3c..6c61aca 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -133,7 +133,8 @@ struct qht_map {
 /* trigger a resize when n_added_buckets > n_buckets / div */
 #define QHT_NR_ADDED_BUCKETS_THRESHOLD_DIV 8
 
-static void qht_do_resize(struct qht *ht, struct qht_map *new);
+static void qht_do_resize_reset(struct qht *ht, struct qht_map *new,
+                                bool reset);
 static void qht_grow_maybe(struct qht *ht);
 
 #ifdef QHT_DEBUG
@@ -408,6 +409,16 @@ void qht_reset(struct qht *ht)
     qht_map_unlock_buckets(map);
 }
 
+static inline void qht_do_resize(struct qht *ht, struct qht_map *new)
+{
+    qht_do_resize_reset(ht, new, false);
+}
+
+static inline void qht_do_resize_and_reset(struct qht *ht, struct qht_map *new)
+{
+    qht_do_resize_reset(ht, new, true);
+}
+
 bool qht_reset_size(struct qht *ht, size_t n_elems)
 {
     struct qht_map *new = NULL;
@@ -421,13 +432,7 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
     if (n_buckets != map->n_buckets) {
         new = qht_map_create(n_buckets);
     }
-
-    qht_map_lock_buckets(map);
-    qht_map_reset__all_locked(map);
-    if (new) {
-        qht_do_resize(ht, new);
-    }
-    qht_map_unlock_buckets(map);
+    qht_do_resize_and_reset(ht, new);
     qemu_mutex_unlock(&ht->lock);
 
     return !!new;
@@ -559,9 +564,7 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
     if (qht_map_needs_resize(map)) {
         struct qht_map *new = qht_map_create(map->n_buckets * 2);
 
-        qht_map_lock_buckets(map);
         qht_do_resize(ht, new);
-        qht_map_unlock_buckets(map);
     }
     qemu_mutex_unlock(&ht->lock);
 }
@@ -737,24 +740,31 @@ static void qht_map_copy(struct qht *ht, void *p, uint32_t hash, void *userp)
 }
 
 /*
- * Call with ht->lock and all bucket locks held.
- *
- * Creating the @new map here would add unnecessary delay while all the locks
- * are held--holding up the bucket locks is particularly bad, since no writes
- * can occur while these are held. Thus, we let callers create the new map,
- * hopefully without the bucket locks held.
+ * Atomically perform a resize and/or reset.
+ * Call with ht->lock held.
  */
-static void qht_do_resize(struct qht *ht, struct qht_map *new)
+static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
 {
     struct qht_map *old;
 
     old = ht->map;
-    g_assert_cmpuint(new->n_buckets, !=, old->n_buckets);
+    qht_map_lock_buckets(old);
 
+    if (reset) {
+        qht_map_reset__all_locked(old);
+    }
+
+    if (new == NULL) {
+        qht_map_unlock_buckets(old);
+        return;
+    }
+
+    g_assert_cmpuint(new->n_buckets, !=, old->n_buckets);
     qht_map_iter__all_locked(ht, old, qht_map_copy, new);
     qht_map_debug__all_locked(new);
 
     atomic_rcu_set(&ht->map, new);
+    qht_map_unlock_buckets(old);
     call_rcu(old, qht_map_destroy, rcu);
 }
 
@@ -766,12 +776,9 @@ bool qht_resize(struct qht *ht, size_t n_elems)
     qemu_mutex_lock(&ht->lock);
     if (n_buckets != ht->map->n_buckets) {
         struct qht_map *new;
-        struct qht_map *old = ht->map;
 
         new = qht_map_create(n_buckets);
-        qht_map_lock_buckets(old);
         qht_do_resize(ht, new);
-        qht_map_unlock_buckets(old);
         ret = true;
     }
     qemu_mutex_unlock(&ht->lock);
-- 
1.9.1
