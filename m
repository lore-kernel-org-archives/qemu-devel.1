Received: from eggs.gnu.org ([2001:4830:134:3::10]:54118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eo8iB-0002Ap-On
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eo8i6-0005Cr-57
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:16:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 20 Feb 2018 16:15:31 +0200
Message-Id: <20180220141531.11770-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] specs/qcow2: Fix documentation of the
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The documentation claims that the cluster descriptor contains the
number of sectors used to store the compressed data, but what it
actually contains is the number of sectors *minus one*.

That can be easily seen in qcow2_decompress_cluster(), that adds one
to the value stored in that field:

  nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 docs/interop/qcow2.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1fee3..b12972be82 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -429,7 +429,8 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
     Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
                     cluster boundary!
 
-       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
+       x+1 - 61:    Size of the compressed data in sectors of 512 bytes,
+                    minus one (that is, a value of n here means n+1 sectors).
 
 If a cluster is unallocated, read requests shall read the data from the backing
 file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
-- 
2.11.0
