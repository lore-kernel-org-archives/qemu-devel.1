Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoBJP-0001B6-3j
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoBJJ-0000R3-VK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:02:39 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 20 Feb 2018 19:01:35 +0200
Message-Id: <20180220170135.5299-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2] specs/qcow2: Fix documentation of the
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

The documentation claims that the cluster descriptor contains the
number of sectors used to store the compressed data, but what it
actually contains is the number of sectors *minus one*.

That can be easily seen in qcow2_decompress_cluster(), that adds one
to the value stored in that field:

  nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;

In addition to that this patch clarifies where the actual compressed
data is located.

Although the size of the data is specified in sectors, the offset is
not necessarily aligned to a sector boundary, so the actual data goes
from the specified offset until the end of the last sector, leaving
the initial bytes of the first sector (if any) unused.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---

v2: I realized that the documentation is not completely clear about
    the exact location and size of the compressed data, so I updated
    the patch to clarify this.

---
 docs/interop/qcow2.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1fee3..dc2b9cefb2 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -427,9 +427,17 @@ Standard Cluster Descriptor:
 Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
 
     Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
-                    cluster boundary!
+                    cluster or sector boundary!
 
-       x+1 - 61:    Compressed size of the images in sectors of 512 bytes
+       x+1 - 61:    Number of 512-byte sectors used for the compressed data,
+                    minus one (that is, a value of n here means n+1 sectors).
+
+                    The actual compressed data is located at the end of this
+                    region, from the offset indicated in the previous field
+                    until the end of the last sector.
+
+                    The initial bytes of this region are therefore unused if
+                    the offset is not aligned to a sector boundary.
 
 If a cluster is unallocated, read requests shall read the data from the backing
 file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
-- 
2.11.0
