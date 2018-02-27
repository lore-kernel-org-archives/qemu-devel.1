Received: from eggs.gnu.org ([2001:4830:134:3::10]:58940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqi8Y-00036h-BU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqi8W-0005lA-82
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:29:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Feb 2018 10:29:41 -0600
Message-Id: <20180227162944.17343-2-eblake@redhat.com>
In-Reply-To: <20180227155514.16721-1-eblake@redhat.com>
References: <20180227155514.16721-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/5] qcow2: Document some maximum size
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
Cc: berto@igalia.com, qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

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
55 into the reserved bits at that time.

However, there is one limit that reserved bits don't help with: for
compressed clusters, the L2 layout requires an ever-smaller maximum
host offset as cluster size gets larger, down to a 512 TB maximum
with 2M clusters.

Signed-off-by: Eric Blake <eblake@redhat.com>

--
v4: more wording tweaks
v3: new patch
---
 docs/interop/qcow2.txt | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index feb711fb6a8..e32d391e66b 100644
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
+                    PB of populated clusters (and an image may hit
+                    other sizing limitations as well, such as
+                    underlying protocol limits).  With a 512 byte
+                    cluster size, the maximum virtual size drops to
+                    128 GB (37 bits).

          32 - 35:   crypt_method
                     0 for no encryption
@@ -318,6 +328,13 @@ for each host cluster. A refcount of 0 means that the cluster is free, 1 means
 that it is used, and >= 2 means that it is used and any write access must
 perform a COW (copy on write) operation.

+The refcount table has implications on the maximum host file size; a
+larger cluster size is required for the refcount table to cover larger
+offsets.  Furthermore, all qcow2 metadata must currently reside at
+offsets below 64 PB (56 bits) (this limit could be enlarged by putting
+reserved bits into use, but only if a similar limit on L1/L2 tables is
+revisited at the same time).
+
 The refcounts are managed in a two-level table. The first level is called
 refcount table and has a variable size (which is stored in the header). The
 refcount table can cover multiple clusters, however it needs to be contiguous
@@ -341,7 +358,7 @@ Refcount table entry:

     Bit  0 -  8:    Reserved (set to 0)

-         9 - 63:    Bits 9-63 of the offset into the image file at which the
+         9 - 55:    Bits 9-55 of the offset into the image file at which the
                     refcount block starts. Must be aligned to a cluster
                     boundary.

@@ -349,6 +366,8 @@ Refcount table entry:
                     been allocated. All refcounts managed by this refcount block
                     are 0.

+        56 - 63:    Reserved (set to 0)
+
 Refcount block entry (x = refcount_bits - 1):

     Bit  0 -  x:    Reference count of the cluster. If refcount_bits implies a
@@ -365,6 +384,17 @@ The L1 table has a variable size (stored in the header) and may use multiple
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

@@ -427,7 +457,9 @@ Standard Cluster Descriptor:
 Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):

     Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
-                    cluster or sector boundary!
+                    cluster or sector boundary!  If cluster_bits is
+                    small enough that this field includes bits beyond
+                    55, those upper bits must be set to 0.

          x - 61:    Number of additional 512-byte sectors used for the
                     compressed data, beyond the sector containing the offset
-- 
2.14.3
