Received: from eggs.gnu.org ([2001:4830:134:3::10]:57931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rE-0002Xs-1N
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007Jq-TM
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:56 +0200
Message-Id: <20181001171901.11004-19-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/23] qcow2: Set the default
 cache-clean-interval to 10 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

The default cache-clean-interval is set to 10 minutes, in order to lower
the overhead of the qcow2 caches (before the default was 0, i.e.
disabled).

* For non-Linux platforms the default is kept at 0, because
  cache-clean-interval is not supported there yet.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 3 ++-
 docs/qcow2-cache.txt | 4 ++--
 block/qcow2.h        | 4 +++-
 block/qcow2.c        | 2 +-
 qemu-options.hx      | 2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ac3b48ee54..46dac23d2f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2895,7 +2895,8 @@
 #
 # @cache-clean-interval:  clean unused entries in the L2 and refcount
 #                         caches. The interval is in seconds. The default value
-#                         is 0 and it disables this feature (since 2.5)
+#                         is 600, and 0 disables this feature. (since 2.5)
+#
 # @encrypt:               Image decryption options. Mandatory for
 #                         encrypted images, except when doing a metadata-only
 #                         probe of the image. (since 2.10)
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 1fcc0658b2..59358b816f 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -210,8 +210,8 @@ This example removes all unused cache entries every 15 minutes:
 
    -drive file=hd.qcow2,cache-clean-interval=900
 
-If unset, the default value for this parameter is 0 and it disables
-this feature.
+If unset, the default value for this parameter is 600. Setting it to 0
+disables this feature.
 
 Note that this functionality currently relies on the MADV_DONTNEED
 argument for madvise() to actually free the memory. This is a
diff --git a/block/qcow2.h b/block/qcow2.h
index 0f0e3534bf..ba430316b9 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -76,13 +76,15 @@
 
 #ifdef CONFIG_LINUX
 #define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
+#define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
 #else
 #define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
+/* Cache clean interval is currently available only on Linux, so must be 0 */
+#define DEFAULT_CACHE_CLEAN_INTERVAL 0
 #endif
 
 #define DEFAULT_CLUSTER_SIZE S_64KiB
 
-
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
 #define QCOW2_OPT_DISCARD_SNAPSHOT "pass-discard-snapshot"
diff --git a/block/qcow2.c b/block/qcow2.c
index 20b5093269..95e1c98daa 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 14aee78c6c..52d9d9f06d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -747,7 +747,7 @@ it which is not used for the L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-The default value is 0 and it disables this feature.
+The default value is 600. Setting it to 0 disables this feature.
 
 @item pass-discard-request
 Whether discard requests to the qcow2 device should be forwarded to the data
-- 
2.13.6
