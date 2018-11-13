Received: from eggs.gnu.org ([2001:4830:134:3::10]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMhu6-0005Tr-H2
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMhij-0003wo-0W
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:03:53 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Nov 2018 17:03:17 -0600
Message-Id: <20181113230319.1008531-2-eblake@redhat.com>
In-Reply-To: <20181113230319.1008531-1-eblake@redhat.com>
References: <20181113230319.1008531-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berto@igalia.com, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Although off_t permits up to 63 bits (8EB) of file offsets, in
practice, we're going to hit other limits first.  Document some
of those limits in the qcow2 spec, and how choice of cluster size
can influence some of the limits.

While we cannot map any virtual cluster to any address higher than
64 PB (56 bits) (due to the current L1/L2 field encoding stopping
at bit 55), the refcount table can currently be sized larger.  For
comparison, ext4 with 4k blocks caps files at 16PB.

Another interesting limit: for compressed clusters, the L2 layout
requires an ever-smaller maximum host offset as cluster size gets
larger, down to a 512 TB maximum with 2M clusters.

Signed-off-by: Eric Blake <eblake@redhat.com>

--
v8: don't try and limit refcount (R-b dropped)
v5: even more wording tweaks
v4: more wording tweaks
v3: new patch
---
 docs/interop/qcow2.txt | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 845d40a086d..89faf7b99f3 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -40,7 +40,16 @@ The first cluster of a qcow2 image contains the file header:
                     with larger cluster sizes.

          24 - 31:   size
-                    Virtual disk size in bytes
+                    Virtual disk size in bytes.
+
+                    Note: with a 2 MB cluster size, the maximum
+                    virtual size is 2 EB (61 bits) for a fully sparse
+                    file; however, L1/L2 table layouts limit an image
+                    to no more than 64 PB (56 bits) of populated
+                    clusters, and an image may hit other limits first
+                    (such as a file system's maximum size).  With a
+                    512 byte cluster size, the maximum virtual size
+                    drops to 128 GB (37 bits).

          32 - 35:   crypt_method
                     0 for no encryption
@@ -326,6 +335,11 @@ in the image file.
 It contains pointers to the second level structures which are called refcount
 blocks and are exactly one cluster in size.

+Although the refcount table can reserve clusters past 64 PB (56 bits)
+(assuming the underlying protocol can even be sized that large), note
+that some qcow2 metadata such as L1/L2 tables must point to clusters
+prior to that point.
+
 Given an offset into the image file, the refcount of its cluster can be
 obtained as follows:

@@ -365,6 +379,16 @@ The L1 table has a variable size (stored in the header) and may use multiple
 clusters, however it must be contiguous in the image file. L2 tables are
 exactly one cluster in size.

+The L1 and L2 tables have implications on the maximum virtual file
+size; a larger cluster size is required for the guest to have access
+to more space.  Furthermore, a virtual cluster must currently map to a
+host offset below 64 PB (56 bits) (although this limit could be
+relaxed by putting reserved bits into use).  Additionally, as cluster
+size increases, the maximum host offset for a compressed cluster is
+reduced (a 2M cluster size requires compressed clusters to reside
+below 512 TB (49 bits), and this limit cannot be relaxed without an
+incompatible layout change).
+
 Given an offset into the virtual disk, the offset into the image file can be
 obtained as follows:

@@ -427,7 +451,9 @@ Standard Cluster Descriptor:
 Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):

     Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
-                    cluster or sector boundary!
+                    cluster or sector boundary!  If cluster_bits is
+                    small enough that this field includes bits beyond
+                    55, those upper bits must be set to 0.

          x - 61:    Number of additional 512-byte sectors used for the
                     compressed data, beyond the sector containing the offset
-- 
2.17.2
