Received: from eggs.gnu.org ([2001:4830:134:3::10]:52964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqY-0001gv-Hf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqX-00037R-0Q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:36 +0100
Message-Id: <20180302185448.6314-26-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/37] docs: document how to use the
 l2-cache-entry-size parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This patch updates docs/qcow2-cache.txt explaining how to use the new
l2-cache-entry-size parameter.

Here's a more detailed technical description of this feature:

   https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html

And here are some performance numbers:

   https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qcow2-cache.txt | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index b0571de4b8..170191a242 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -1,6 +1,6 @@
 qcow2 L2/refcount cache configuration
 =====================================
-Copyright (C) 2015 Igalia, S.L.
+Copyright (C) 2015, 2018 Igalia, S.L.
 Author: Alberto Garcia <berto@igalia.com>
 
 This work is licensed under the terms of the GNU GPL, version 2 or
@@ -118,8 +118,8 @@ There are three options available, and all of them take bytes:
 
 There are two things that need to be taken into account:
 
- - Both caches must have a size that is a multiple of the cluster
-   size.
+ - Both caches must have a size that is a multiple of the cluster size
+   (or the cache entry size: see "Using smaller cache sizes" below).
 
  - If you only set one of the options above, QEMU will automatically
    adjust the others so that the L2 cache is 4 times bigger than the
@@ -143,6 +143,46 @@ much less often than the L2 cache, so it's perfectly reasonable to
 keep it small.
 
 
+Using smaller cache entries
+---------------------------
+The qcow2 L2 cache stores complete tables by default. This means that
+if QEMU needs an entry from an L2 table then the whole table is read
+from disk and is kept in the cache. If the cache is full then a
+complete table needs to be evicted first.
+
+This can be inefficient with large cluster sizes since it results in
+more disk I/O and wastes more cache memory.
+
+Since QEMU 2.12 you can change the size of the L2 cache entry and make
+it smaller than the cluster size. This can be configured using the
+"l2-cache-entry-size" parameter:
+
+   -drive file=hd.qcow2,l2-cache-size=2097152,l2-cache-entry-size=4096
+
+Some things to take into account:
+
+ - The L2 cache entry size has the same restrictions as the cluster
+   size (power of two, at least 512 bytes).
+
+ - Smaller entry sizes generally improve the cache efficiency and make
+   disk I/O faster. This is particularly true with solid state drives
+   so it's a good idea to reduce the entry size in those cases. With
+   rotating hard drives the situation is a bit more complicated so you
+   should test it first and stay with the default size if unsure.
+
+ - Try different entry sizes to see which one gives faster performance
+   in your case. The block size of the host filesystem is generally a
+   good default (usually 4096 bytes in the case of ext4).
+
+ - Only the L2 cache can be configured this way. The refcount cache
+   always uses the cluster size as the entry size.
+
+ - If the L2 cache is big enough to hold all of the image's L2 tables
+   (as explained in the "Choosing the right cache sizes" section
+   earlier in this document) then none of this is necessary and you
+   can omit the "l2-cache-entry-size" parameter altogether.
+
+
 Reducing the memory usage
 -------------------------
 It is possible to clean unused cache entries in order to reduce the
-- 
2.13.6
