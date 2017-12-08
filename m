Received: from eggs.gnu.org ([2001:4830:134:3::10]:47596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGKB-00013e-3S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGKA-0001mz-7s
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:11 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGKA-0001mp-13
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:10 -0500
Received: by mail-wr0-x242.google.com with SMTP id s66so10421769wrc.9
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:52 +0100
Message-Id: <20171208105553.12249-5-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qht: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qht.c | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/util/qht.c b/util/qht.c
index ff4d2e6974..95ac32f990 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -248,18 +248,18 @@ void qht_map_lock_buckets__no_stale(struct qht *ht, struct qht_map **pmap)
     map = atomic_rcu_read(&ht->map);
     qht_map_lock_buckets(map);
     if (likely(!qht_map_is_stale__locked(ht, map))) {
-        *pmap = map;
-        return;
+        goto out;
     }
     qht_map_unlock_buckets(map);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
-    map = ht->map;
-    qht_map_lock_buckets(map);
-    qemu_mutex_unlock(&ht->lock);
+    QEMU_WITH_LOCK(QemuMutex, ht_guard, &ht->lock) {
+        map = ht->map;
+        qht_map_lock_buckets(map);
+    }
+
+out:
     *pmap = map;
-    return;
 }
 
 /*
@@ -282,17 +282,18 @@ struct qht_bucket *qht_bucket_lock__no_stale(struct qht *ht, uint32_t hash,
 
     qemu_spin_lock(&b->lock);
     if (likely(!qht_map_is_stale__locked(ht, map))) {
-        *pmap = map;
-        return b;
+        goto out;
     }
     qemu_spin_unlock(&b->lock);
 
     /* we raced with a resize; acquire ht->lock to see the updated ht->map */
-    qemu_mutex_lock(&ht->lock);
-    map = ht->map;
-    b = qht_map_to_bucket(map, hash);
-    qemu_spin_lock(&b->lock);
-    qemu_mutex_unlock(&ht->lock);
+    QEMU_WITH_LOCK(QemuMutex, ht_guard, &ht->lock) {
+        map = ht->map;
+        b = qht_map_to_bucket(map, hash);
+        qemu_spin_lock(&b->lock);
+    }
+
+out:
     *pmap = map;
     return b;
 }
@@ -427,13 +428,13 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
 
     n_buckets = qht_elems_to_buckets(n_elems);
 
-    qemu_mutex_lock(&ht->lock);
-    map = ht->map;
-    if (n_buckets != map->n_buckets) {
-        new = qht_map_create(n_buckets);
+    QEMU_WITH_LOCK(QemuMutex, ht_guard, &ht->lock) {
+        map = ht->map;
+        if (n_buckets != map->n_buckets) {
+            new = qht_map_create(n_buckets);
+        }
+        qht_do_resize_and_reset(ht, new);
     }
-    qht_do_resize_and_reset(ht, new);
-    qemu_mutex_unlock(&ht->lock);
 
     return !!new;
 }
@@ -771,19 +772,17 @@ static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
 bool qht_resize(struct qht *ht, size_t n_elems)
 {
     size_t n_buckets = qht_elems_to_buckets(n_elems);
-    size_t ret = false;
 
-    qemu_mutex_lock(&ht->lock);
-    if (n_buckets != ht->map->n_buckets) {
-        struct qht_map *new;
+    QEMU_WITH_LOCK(QemuMutex, ht_guard, &ht->lock) {
+        if (n_buckets != ht->map->n_buckets) {
+            struct qht_map *new;
 
-        new = qht_map_create(n_buckets);
-        qht_do_resize(ht, new);
-        ret = true;
+            new = qht_map_create(n_buckets);
+            qht_do_resize(ht, new);
+            return true;
+        }
     }
-    qemu_mutex_unlock(&ht->lock);
-
-    return ret;
+    return false;
 }
 
 /* pass @stats to qht_statistics_destroy() when done */
-- 
2.14.3
