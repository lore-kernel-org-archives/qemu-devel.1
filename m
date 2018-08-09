Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnlod-0004Pf-FI
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnloa-0004f2-2l
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:21:27 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu,  9 Aug 2018 17:20:45 +0300
Message-Id: <20180809142046.12311-5-lbloch@janustech.com>
In-Reply-To: <20180809142046.12311-1-lbloch@janustech.com>
References: <20180809142046.12311-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/5] qcow2: Set the default
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
index 36113d199e..13715bbf2c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -942,7 +942,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     /* New interval for cache cleanup timer */
     r->cache_clean_interval =
         qemu_opt_get_number(opts, QCOW2_OPT_CACHE_CLEAN_INTERVAL,
-                            s->cache_clean_interval);
+                            DEFAULT_CACHE_CLEAN_INTERVAL);
 #ifndef CONFIG_LINUX
     if (r->cache_clean_interval != 0) {
         error_setg(errp, QCOW2_OPT_CACHE_CLEAN_INTERVAL
diff --git a/block/qcow2.h b/block/qcow2.h
index d77a31d932..587b053453 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -77,6 +77,7 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
 
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 6ad1081d1a..684147ad45 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -204,8 +204,8 @@ This example removes all unused cache entries every 15 minutes:
 
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
