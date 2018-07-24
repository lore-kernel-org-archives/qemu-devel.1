Received: from eggs.gnu.org ([2001:4830:134:3::10]:46017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi3Xe-0006wJ-3B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 16:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi3Xa-0007hS-VE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 16:04:18 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 23:03:40 +0300
Message-Id: <20180724200343.13733-3-lbloch@janustech.com>
In-Reply-To: <20180724200343.13733-1-lbloch@janustech.com>
References: <20180724200343.13733-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/5 for-3.0] qcow2: Options' documentation
 fixes
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
 docs/qcow2-cache.txt |  3 +++
 qemu-options.hx      | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..9d261b7da9 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -130,6 +130,9 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+- All three "l2-cache-size", "refcount-cache-size", and "cache-size" options
+  can not be set simultaneously.
+
 Unlike L2 tables, refcount blocks are not used during normal I/O but
 only during allocations and internal snapshots. In most cases they are
 accessed sequentially (even during random guest I/O) so increasing the
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..ef0706c359 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -752,15 +752,22 @@ image file)
 
 @item cache-size
 The maximum total size of the L2 table and refcount block caches in bytes
-(default: 1048576 bytes or 8 clusters, whichever is larger)
 
 @item l2-cache-size
-The maximum size of the L2 table cache in bytes
-(default: 4/5 of the total cache size)
+The maximum size of the L2 table cache.
+(default: if cache-size is not defined - 1048576 bytes or 8 clusters,
+whichever is larger; if cache-size is defined and is large enough to
+accommodate enough L2 cache to cover the entire virtual size of the image plus
+the minimal amount of refcount cache - enough to cover the entire image;
+if cache-size is defined and is not large enough - as much as possible while
+leaving space for the needed refcount cache)
 
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
-(default: 1/5 of the total cache size)
+(default: 4 times the cluster size, or if cache-size is defined and is large
+enough to accommodate enough L2 cache to cover the entire virtual size of the
+image plus the minimal amount of refcount cache - the part of cache-size which
+is left after allocating the full L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-- 
2.14.1
