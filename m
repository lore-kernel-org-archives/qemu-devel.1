Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hL-0000rz-0W
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hJ-00081s-VJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:43 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:44 -0500
Message-Id: <20180619014319.28272-19-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 018/113] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

From: Alberto Garcia <berto@igalia.com>

This patch fixes several mistakes in the documentation of the
compressed cluster descriptor:

1) the documentation claims that the cluster descriptor contains the
   number of sectors used to store the compressed data, but what it
   actually contains is the number of sectors *minus one* or, in other
   words, the number of additional sectors after the first one.

2) the width of the fields is incorrectly specified. The number of bits
   used by each field is

      x = 62 - (cluster_bits - 8)   for the offset field
      y = (cluster_bits - 8)        for the size field

   So the offset field's location is [0, x-1], not [0, x] as stated.

3) the size field does not contain the size of the compressed data,
   but rather the number of sectors where that data is stored. The
   compressed data starts at the exact point specified in the offset
   field and ends when there's enough data to produce a cluster of
   decompressed data. Both points can be in the middle of a sector,
   allowing several compressed clusters to be stored next to one
   another, sharing sectors if necessary.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 156b46ded3853dfc6b34c5afae019ff61798491b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/interop/qcow2.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1fee3..feb711fb6a 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -426,10 +426,20 @@ Standard Cluster Descriptor:
 
 Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
 
-    Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
-                    cluster boundary!
+    Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
+                    cluster or sector boundary!
 
-       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
+         x - 61:    Number of additional 512-byte sectors used for the
+                    compressed data, beyond the sector containing the offset
+                    in the previous field. Some of these sectors may reside
+                    in the next contiguous host cluster.
+
+                    Note that the compressed data does not necessarily occupy
+                    all of the bytes in the final sector; rather, decompression
+                    stops when it has produced a cluster of data.
+
+                    Another compressed cluster may map to the tail of the final
+                    sector used by this compressed cluster.
 
 If a cluster is unallocated, read requests shall read the data from the backing
 file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
-- 
2.11.0
