Received: from eggs.gnu.org ([2001:4830:134:3::10]:42594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNMTP-0000Nh-La
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNMTE-0006iW-9u
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:34:35 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Nov 2018 12:34:08 -0600
Message-Id: <20181115183408.1240762-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 v9] qcow2: Document some maximum size
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Although off_t permits up to 63 bits (8EB) of file offsets, in
practice, we're going to hit other limits first.  Document some
of those limits in the qcow2 spec (some are inherent, others are
implementation choices of qemu), and how choice of cluster size
can influence some of the limits.

While we cannot map any uncompressed virtual cluster to any
address higher than 64 PB (56 bits) (due to the current L1/L2
field encoding stopping at bit 55), qemu's cap of 8M for the
refcount table can still access larger host addresses for some
combinations of large clusters and small refcount_order.  For
comparison, ext4 with 4k blocks caps files at 16PB.

Another interesting limit: for compressed clusters, the L2 layout
requires an ever-smaller maximum host offset as cluster size gets
larger, down to a 512 TB maximum with 2M clusters.  In particular,
note that with a cluster size of 8k or smaller, the L2 entry for
a compressed cluster could technically point beyond the 64PB mark,
but when you consider that with 8k clusters and refcount_order = 0,
you cannot access beyond 512T without exceeding qemu's limit of an
8M cap on the refcount table, it is unlikely that any image in the
wild has attempted to do so.  To be safe, let's document that bits
beyond 55 in a compressed cluster must be 0.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9: Yet more wording tweaks, to call out the difference between
inherent (L2 reserved bit) and implementation (qemu's 32M L1 and
8M refcount) limits.

Designed to replace commit 1da4dc02 on Kevin's block branch.
---
 docs/interop/qcow2.txt | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 845d40a086d..fb5cb47245c 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -40,7 +40,18 @@ The first cluster of a qcow2 image contains the file header:
                     with larger cluster sizes.

          24 - 31:   size
-                    Virtual disk size in bytes
+                    Virtual disk size in bytes.
+
+                    Note: qemu has an implementation limit of 32 MB as
+                    the maximum L1 table size.  With a 2 MB cluster
+                    size, it is unable to populate a virtual cluster
+                    beyond 2 EB (61 bits); with a 512 byte cluster
+                    size, it is unable to populate a virtual size
+                    larger than 128 GB (37 bits).  Meanwhile, L1/L2
+                    table layouts limit an image to no more than 64 PB
+                    (56 bits) of populated clusters, and an image may
+                    hit other limits first (such as a file system's
+                    maximum size).

          32 - 35:   crypt_method
                     0 for no encryption
@@ -326,6 +337,17 @@ in the image file.
 It contains pointers to the second level structures which are called refcount
 blocks and are exactly one cluster in size.

+Although a large enough refcount table can reserve clusters past 64 PB
+(56 bits) (assuming the underlying protocol can even be sized that
+large), note that some qcow2 metadata such as L1/L2 tables must point
+to clusters prior to that point.
+
+Note: qemu has an implementation limit of 8 MB as the maximum refcount
+table size.  With a 2 MB cluster size and a default refcount_order of
+4, it is unable to reference host resources beyond 2 EB (61 bits); in
+the worst case, with a 512 cluster size and refcount_order of 6, it is
+unable to access beyond 32 GB (35 bits).
+
 Given an offset into the image file, the refcount of its cluster can be
 obtained as follows:

@@ -365,6 +387,16 @@ The L1 table has a variable size (stored in the header) and may use multiple
 clusters, however it must be contiguous in the image file. L2 tables are
 exactly one cluster in size.

+The L1 and L2 tables have implications on the maximum virtual file
+size; for a given L1 table size, a larger cluster size is required for
+the guest to have access to more space.  Furthermore, a virtual
+cluster must currently map to a host offset below 64 PB (56 bits)
+(although this limit could be relaxed by putting reserved bits into
+use).  Additionally, as cluster size increases, the maximum host
+offset for a compressed cluster is reduced (a 2M cluster size requires
+compressed clusters to reside below 512 TB (49 bits), and this limit
+cannot be relaxed without an incompatible layout change).
+
 Given an offset into the virtual disk, the offset into the image file can be
 obtained as follows:

@@ -427,7 +459,9 @@ Standard Cluster Descriptor:
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
