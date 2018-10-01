Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rE-0002YH-EG
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0007Ki-Ao
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:59 +0200
Message-Id: <20181001171901.11004-22-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/23] qcow2: Fix cache-clean-interval
 documentation
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

Fixing cache-clean-interval documentation following the recent change to
a default of 600 seconds on supported plarforms (only Linux currently).

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  3 ++-
 docs/qcow2-cache.txt | 20 ++++++++++----------
 qemu-options.hx      |  3 ++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 46dac23d2f..25b8a0e744 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2895,7 +2895,8 @@
 #
 # @cache-clean-interval:  clean unused entries in the L2 and refcount
 #                         caches. The interval is in seconds. The default value
-#                         is 600, and 0 disables this feature. (since 2.5)
+#                         is 600 on supporting platforms, and 0 on other
+#                         platforms. 0 disables this feature. (since 2.5)
 #
 # @encrypt:               Image decryption options. Mandatory for
 #                         encrypted images, except when doing a metadata-only
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 59358b816f..c459bf5dd3 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -202,18 +202,18 @@ Reducing the memory usage
 It is possible to clean unused cache entries in order to reduce the
 memory usage during periods of low I/O activity.
 
-The parameter "cache-clean-interval" defines an interval (in seconds).
-All cache entries that haven't been accessed during that interval are
-removed from memory.
+The parameter "cache-clean-interval" defines an interval (in seconds),
+after which all the cache entries that haven't been accessed during the
+interval are removed from memory. Setting this parameter to 0 disables this
+feature.
 
-This example removes all unused cache entries every 15 minutes:
+The following example removes all unused cache entries every 15 minutes:
 
    -drive file=hd.qcow2,cache-clean-interval=900
 
-If unset, the default value for this parameter is 600. Setting it to 0
-disables this feature.
+If unset, the default value for this parameter is 600 on platforms which
+support this functionality, and is 0 (disabled) on other platforms.
 
-Note that this functionality currently relies on the MADV_DONTNEED
-argument for madvise() to actually free the memory. This is a
-Linux-specific feature, so cache-clean-interval is not supported in
-other systems.
+This functionality currently relies on the MADV_DONTNEED argument for
+madvise() to actually free the memory. This is a Linux-specific feature,
+so cache-clean-interval is not supported on other systems.
diff --git a/qemu-options.hx b/qemu-options.hx
index 52d9d9f06d..f139459e80 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -747,7 +747,8 @@ it which is not used for the L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-The default value is 600. Setting it to 0 disables this feature.
+The default value is 600 on supporting platforms, and 0 on other platforms.
+Setting it to 0 disables this feature.
 
 @item pass-discard-request
 Whether discard requests to the qcow2 device should be forwarded to the data
-- 
2.13.6
