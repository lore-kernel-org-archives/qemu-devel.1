Received: from eggs.gnu.org ([2001:4830:134:3::10]:44573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fW-H7
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lh-0001jn-Tw
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:47 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:28 +0300
Message-Id: <20180813010729.4844-8-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 7/8] qcow2: Set the default
 cache-clean-interval to 10 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

The default cache-clean-interval is set to 10 minutes, in order to lower
the overhead of the qcow2 caches (before the default was 0, i.e.
disabled).

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c        | 2 +-
 block/qcow2.h        | 1 +
 docs/qcow2-cache.txt | 4 ++--
 qapi/block-core.json | 3 ++-
 qemu-options.hx      | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1445cd5360..f885afa0ed 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -944,7 +944,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     /* New interval for cache cleanup timer */
     r->cache_clean_interval =
         qemu_opt_get_number(opts, QCOW2_OPT_CACHE_CLEAN_INTERVAL,
-                            s->cache_clean_interval);
+                            DEFAULT_CACHE_CLEAN_INTERVAL);
 #ifndef CONFIG_LINUX
     if (r->cache_clean_interval != 0) {
         error_setg(errp, QCOW2_OPT_CACHE_CLEAN_INTERVAL
diff --git a/block/qcow2.h b/block/qcow2.h
index e699a55d02..5e94f7ffc4 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -78,6 +78,7 @@
 
 #define DEFAULT_CLUSTER_SIZE (64 * KiB)
 
+#define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
 
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 0fc438f397..0530d79f5b 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -206,8 +206,8 @@ This example removes all unused cache entries every 15 minutes:
 
    -drive file=hd.qcow2,cache-clean-interval=900
 
-If unset, the default value for this parameter is 0 and it disables
-this feature.
+If unset, the default value for this parameter is 600. Setting it to 0
+disables this feature.
 
 Note that this functionality currently relies on the MADV_DONTNEED
 argument for madvise() to actually free the memory. This is a
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..9a6a708a37 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2830,7 +2830,8 @@
 #
 # @cache-clean-interval:  clean unused entries in the L2 and refcount
 #                         caches. The interval is in seconds. The default value
-#                         is 0 and it disables this feature (since 2.5)
+#                         is 600, and 0 disables this feature. (since 2.5)
+#
 # @encrypt:               Image decryption options. Mandatory for
 #                         encrypted images, except when doing a metadata-only
 #                         probe of the image. (since 2.10)
diff --git a/qemu-options.hx b/qemu-options.hx
index 4c44cdbc23..6abf3631ec 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -767,7 +767,7 @@ it which is not used for the L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-The default value is 0 and it disables this feature.
+The default value is 600. Setting it to 0 disables this feature.
 
 @item pass-discard-request
 Whether discard requests to the qcow2 device should be forwarded to the data
-- 
2.17.1
