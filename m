Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGr-0001pM-HL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGi-0001aH-2U
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:07:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 14:07:19 -0500
Message-Id: <20180628190723.276458-3-eblake@redhat.com>
In-Reply-To: <20180628190723.276458-1-eblake@redhat.com>
References: <20180628190723.276458-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 2/6] qcow2: Document some maximum size
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
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

Although off_t permits up to 63 bits (8EB) of file offsets, in
practice, we're going to hit other limits first.  Document some
of those limits in the qcow2 spec, and how choice of cluster size
can influence some of the limits.

While at it, notice that since we cannot map any virtual cluster
to any address higher than 64 PB (56 bits) (due to the current L1/L2
field encoding stopping at bit 55), it makes little sense to require
the refcount table to access host offsets beyond that point.  Mark
the upper bits of the refcount table entries as reserved to match
the L1/L2 table, with no ill effects, since it is unlikely that there
are any existing images larger than 64PB in the first place, and thus
all existing images already have those bits as 0.  If 64PB proves to
be too small in the future, we could enlarge all three uses of bit
55 into the reserved bits at that time.  (For reference, ext4 with
4k blocks caps files at 16PB.)

However, there is one limit that reserved bits don't help with: for
compressed clusters, the L2 layout requires an ever-smaller maximum
host offset as cluster size gets larger, down to a 512 TB maximum
with 2M clusters.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>

--
v5: even more wording tweaks
v4: more wording tweaks
v3: new patch
---
 docs/interop/qcow2.txt | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 8e1547ded27..bb4898e60bf 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -40,7 +40,17 @@ The first cluster of a qcow2 image contains the file header:
                     with larger cluster sizes.

          24 - 31:   size
-                    Virtual disk size in bytes
+                    Virtual disk size in bytes.
+
+                    Note: with a 2 MB cluster size, the maximum
+                    virtual size is 2 EB (61 bits) for a sparse file,
+                    but other sizing limitations in refcount and L1/L2
+                    tables mean that an image cannot have more than 64
+                    PB (56 bits) of populated clusters (assuming the
+                    image does not first hit other limits such as a
+                    file system's maximum size).  With a 512 byte
+                    cluster size, the maximum virtual size drops to
+                    128 GB (37 bits).

          32 - 35:   crypt_method
                     0 for no encryption
@@ -326,6 +336,15 @@ in the image file.
 It contains pointers to the second level structures which are called refcount
 blocks and are exactly one cluster in size.

+All qcow2 metadata, including the refcount table and refcount blocks,
+must currently reside at host offsets below 64 PB (56 bits) (if the
+underlying protocol can even be sized that large); this limit could be
+enlarged by putting reserved bits into use, but only if a similar
+limit on L1/L2 tables is revisited at the same time.  While a larger
+cluster size theoretically allows the refcount table to cover more
+host offsets, in practice, other inherent limits will constrain the
+maximum image size before the refcount table is full.
+
 Given a offset into the image file, the refcount of its cluster can be obtained
 as follows:

@@ -341,7 +360,7 @@ Refcount table entry:

     Bit  0 -  8:    Reserved (set to 0)

-         9 - 63:    Bits 9-63 of the offset into the image file at which the
+         9 - 55:    Bits 9-55 of the offset into the image file at which the
                     refcount block starts. Must be aligned to a cluster
                     boundary.

@@ -349,6 +368,8 @@ Refcount table entry:
                     been allocated. All refcounts managed by this refcount block
                     are 0.

+        56 - 63:    Reserved (set to 0)
+
 Refcount block entry (x = refcount_bits - 1):

     Bit  0 -  x:    Reference count of the cluster. If refcount_bits implies a
@@ -365,6 +386,17 @@ The L1 table has a variable size (stored in the header) and may use multiple
 clusters, however it must be contiguous in the image file. L2 tables are
 exactly one cluster in size.

+The L1 and L2 tables have implications on the maximum virtual file
+size; a larger cluster size is required for the guest to have access
+to more space.  Furthermore, a virtual cluster must currently map to a
+host offset below 64 PB (56 bits) (this limit could be enlarged by
+putting reserved bits into use, but only if a similar limit on
+refcount tables is revisited at the same time).  Additionally, with
+larger cluster sizes, compressed clusters have a smaller limit on host
+cluster mappings (a 2M cluster size requires compressed clusters to
+reside below 512 TB (49 bits), where enlarging this would require an
+incompatible layout change).
+
 Given a offset into the virtual disk, the offset into the image file can be
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
2.14.4
