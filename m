Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020T-8F
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtEz-0000Wu-Ps
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:41 +0300
Message-Id: <20180729212744.23709-4-lbloch@janustech.com>
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/6 for-3.0] qcow2: Options' documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 docs/qcow2-cache.txt |  9 ++++++---
 qapi/block-core.json |  6 +++---
 qemu-options.hx      | 15 +++++++++------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..fd9a6911cc 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -112,9 +112,9 @@ command-line, or the 'blockdev-add' QMP command.
 
 There are three options available, and all of them take bytes:
 
-"l2-cache-size":         maximum size of the L2 table cache
-"refcount-cache-size":   maximum size of the refcount block cache
-"cache-size":            maximum size of both caches combined
+"l2-cache-size":         maximal size of the L2 table cache
+"refcount-cache-size":   maximal size of the refcount block cache
+"cache-size":            maximal size of both caches combined
 
 There are a few things that need to be taken into account:
 
@@ -130,6 +130,9 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+ - At most two of "l2-cache-size", "refcount-cache-size", and "cache-size"
+   can be set simultaneously.
+
 Unlike L2 tables, refcount blocks are not used during normal I/O but
 only during allocations and internal snapshots. In most cases they are
 accessed sequentially (even during random guest I/O) so increasing the
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d40d5ecc3b..22f85687df 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2808,10 +2808,10 @@
 # @overlap-check:         which overlap checks to perform for writes
 #                         to the image, defaults to 'cached' (since 2.2)
 #
-# @cache-size:            the maximum total size of the L2 table and
+# @cache-size:            the maximal total size of the L2 table and
 #                         refcount block caches in bytes (since 2.2)
 #
-# @l2-cache-size:         the maximum size of the L2 table cache in
+# @l2-cache-size:         the maximal size of the L2 table cache in
 #                         bytes (since 2.2)
 #
 # @l2-cache-entry-size:   the size of each entry in the L2 cache in
@@ -2819,7 +2819,7 @@
 #                         and the cluster size. The default value is
 #                         the cluster size (since 2.12)
 #
-# @refcount-cache-size:   the maximum size of the refcount block cache
+# @refcount-cache-size:   the maximal size of the refcount block cache
 #                         in bytes (since 2.2)
 #
 # @cache-clean-interval:  clean unused entries in the L2 and refcount
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..18f3f87da5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -751,16 +751,19 @@ Whether to enable the lazy refcounts feature (on/off; default is taken from the
 image file)
 
 @item cache-size
-The maximum total size of the L2 table and refcount block caches in bytes
-(default: 1048576 bytes or 8 clusters, whichever is larger)
+The maximal total size of the L2 table and refcount block caches in bytes
+(default: the sum of l2-cache-size and refcount-cache-size)
 
 @item l2-cache-size
-The maximum size of the L2 table cache in bytes
-(default: 4/5 of the total cache size)
+The maximal size of the L2 table cache in bytes
+(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
+is larger; otherwise, as large as possible or needed within the cache-size,
+while permitting the requested or the minimal refcount cache size)
 
 @item refcount-cache-size
-The maximum size of the refcount block cache in bytes
-(default: 1/5 of the total cache size)
+The maximal size of the refcount block cache in bytes
+(default: 4 times the cluster size; or if cache-size is specified, the part of
+it which is not used for the L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-- 
2.17.1
