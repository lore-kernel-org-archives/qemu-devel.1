Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJd-0006nf-PR
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJa-0006nx-A5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:21 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com
	([104.47.2.113]:18800
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJa-0006nb-3V
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:18 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:35 +0300
Message-ID: <1495186480-114192-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 08/13] qcow2: handle_prealloc(): find out if
 area zeroed by earlier preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c | 2 ++
 block/qcow2.c         | 8 +++++++-
 block/qcow2.h         | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index b2879b9..25210cd 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1143,6 +1143,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
+    const uint64_t old_data_end = s->data_end;
     int l2_index;
     uint64_t *l2_table;
     uint64_t entry;
@@ -1264,6 +1265,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .alloc_offset   = alloc_cluster_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,
+        .clusters_are_trailing = alloc_cluster_offset >= old_data_end,
 
         .keep_old_clusters  = keep_old_clusters,
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 503f0dc..97a66a0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1684,7 +1684,13 @@ restart:
 
     if (end <= bdrv_getlength(file)) {
         /* No need to care, file size will not be changed */
-        return false;
+
+        /* We're safe to assume that the area is zeroes if the area
+         * was allocated at the end of data (s->data_end).
+         * In this case, the only way for file length to be bigger is that
+         * the area was preallocated by another request.
+         */
+        return m->clusters_are_trailing;
     }
 
     meta = g_alloca(sizeof(*meta));
diff --git a/block/qcow2.h b/block/qcow2.h
index e28c54a..2fd8510 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -333,6 +333,10 @@ typedef struct QCowL2Meta
     /** Do not free the old clusters */
     bool keep_old_clusters;
 
+    /** True if the area is allocated after the end of data area
+     *  (i.e. >= s->data_end), which means that it is zeroed */
+    bool clusters_are_trailing;
+
     /**
      * Requests that overlap with this allocation and wait to be restarted
      * when the allocating request has completed.
-- 
2.7.4
