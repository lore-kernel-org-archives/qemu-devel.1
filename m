Received: from eggs.gnu.org ([2001:4830:134:3::10]:43379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4z-0006m7-58
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4w-0003Yq-Mv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Feb 2018 17:33:24 -0600
Message-Id: <20180213233324.5096-3-eblake@redhat.com>
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
References: <20180213233324.5096-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qcow2: Prefer 'entries' over 'size' during
 cache creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

Using 'size' for anything other than bytes is difficult to
reason about; let's rename entries related to the number of
entries in a cache accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h |  4 ++--
 block/qcow2.c | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 883802241fb..0daf8e6d6f8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -68,10 +68,10 @@
 #define MAX_CLUSTER_BITS 21

 /* Must be at least 2 to cover COW */
-#define MIN_L2_CACHE_SIZE 2 /* cache entries */
+#define MIN_L2_CACHE_ENTRIES 2

 /* Must be at least 4 to cover all cases of refcount table growth */
-#define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
+#define MIN_REFCOUNT_CACHE_ENTRIES 4

 /* Whichever is more */
 #define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
diff --git a/block/qcow2.c b/block/qcow2.c
index 288b5299d80..f25c33df1d1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -843,6 +843,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     const char *opt_overlap_check, *opt_overlap_check_template;
     int overlap_check_template = 0;
     uint64_t l2_cache_size, l2_cache_entry_size, refcount_cache_size;
+    uint64_t l2_cache_entries, refcount_cache_entries;
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
@@ -869,21 +870,21 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         goto fail;
     }

-    l2_cache_size /= l2_cache_entry_size;
-    if (l2_cache_size < MIN_L2_CACHE_SIZE) {
-        l2_cache_size = MIN_L2_CACHE_SIZE;
+    l2_cache_entries = l2_cache_size / l2_cache_entry_size;
+    if (l2_cache_entries < MIN_L2_CACHE_ENTRIES) {
+        l2_cache_entries = MIN_L2_CACHE_ENTRIES;
     }
-    if (l2_cache_size > INT_MAX) {
+    if (l2_cache_entries > INT_MAX) {
         error_setg(errp, "L2 cache size too big");
         ret = -EINVAL;
         goto fail;
     }

-    refcount_cache_size /= s->cluster_size;
-    if (refcount_cache_size < MIN_REFCOUNT_CACHE_SIZE) {
-        refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE;
+    refcount_cache_entries = refcount_cache_size / s->cluster_size;
+    if (refcount_cache_entries < MIN_REFCOUNT_CACHE_ENTRIES) {
+        refcount_cache_entries = MIN_REFCOUNT_CACHE_ENTRIES;
     }
-    if (refcount_cache_size > INT_MAX) {
+    if (refcount_cache_entries > INT_MAX) {
         error_setg(errp, "Refcount cache size too big");
         ret = -EINVAL;
         goto fail;
@@ -908,9 +909,9 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }

     r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
-    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
+    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_entries,
                                            l2_cache_entry_size);
-    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size,
+    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_entries,
                                                  s->cluster_size);
     if (r->l2_table_cache == NULL || r->refcount_block_cache == NULL) {
         error_setg(errp, "Could not allocate metadata caches");
-- 
2.14.3
