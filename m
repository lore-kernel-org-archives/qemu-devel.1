Received: from eggs.gnu.org ([2001:4830:134:3::10]:50196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHf-00040y-VB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHe-0001gv-Tf
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 22 Feb 2018 09:59:20 -0600
Message-Id: <20180222155922.9833-3-eblake@redhat.com>
In-Reply-To: <20180222155922.9833-1-eblake@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

Although off_t permits up to 63 bits (8EB) of file offsets, in
practice, we're going to hit other limits first.  Document some
of those limits in the qcow2 spec, and how choice of cluster size
can influence some of the limits.

While at it, notice that since we cannot map any virtual cluster
to any address higher than 64 PB (56 bits) (due to the L1/L2 field
encoding), it makes little sense to require the refcount table to
access host offsets beyond that point.  Mark the upper bits of
the refcount table entries as reserved, with no ill effects, since
it is unlikely that there are any existing images larger than 64PB
in the first place, and thus all existing images already have those
bits as 0.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qcow2.txt | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index feb711fb6a8..2417522ca9b 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -40,7 +40,16 @@ The first cluster of a qcow2 image contains the file header:
                     with larger cluster sizes.

          24 - 31:   size
-                    Virtual disk size in bytes
+                    Virtual disk size in bytes.
+
+                    Note: with a 2 MB cluster size, the maximum
+                    virtual size is 2 EB (61 bits) for a sparse file,
+                    but other sizing limitations mean that an image
+                    cannot have more than 64 PB of populated clusters
+                    (and may hit other sizing limitations as well,
+                    such as underlying protocol limits).  With a 512
+                    byte cluster size, the maximum virtual size drops
+                    to 128 GB (37 bits).

          32 - 35:   crypt_method
                     0 for no encryption
@@ -318,6 +327,11 @@ for each host cluster. A refcount of 0 means that the cluster is free, 1 means
 that it is used, and >= 2 means that it is used and any write access must
 perform a COW (copy on write) operation.

+The refcount table has implications on the maximum host file size; a
+larger cluster size is required for the refcount table to cover larger
+offsets.  Furthermore, all qcow2 metadata must reside at offsets below
+64 PB (56 bits).
+
 The refcounts are managed in a two-level table. The first level is called
 refcount table and has a variable size (which is stored in the header). The
 refcount table can cover multiple clusters, however it needs to be contiguous
@@ -341,7 +355,7 @@ Refcount table entry:

     Bit  0 -  8:    Reserved (set to 0)

-         9 - 63:    Bits 9-63 of the offset into the image file at which the
+         9 - 55:    Bits 9-55 of the offset into the image file at which the
                     refcount block starts. Must be aligned to a cluster
                     boundary.

@@ -349,6 +363,8 @@ Refcount table entry:
                     been allocated. All refcounts managed by this refcount block
                     are 0.

+        56 - 63:    Reserved (set to 0)
+
 Refcount block entry (x = refcount_bits - 1):

     Bit  0 -  x:    Reference count of the cluster. If refcount_bits implies a
@@ -365,6 +381,11 @@ The L1 table has a variable size (stored in the header) and may use multiple
 clusters, however it must be contiguous in the image file. L2 tables are
 exactly one cluster in size.

+The L1 and L2 tables have implications on the maximum virtual file
+size; a larger cluster size is required for guest to have access to a
+larger size.  Furthermore, a virtual cluster must map to a host offset
+below 64 PB (56 bits).
+
 Given a offset into the virtual disk, the offset into the image file can be
 obtained as follows:

@@ -427,7 +448,9 @@ Standard Cluster Descriptor:
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
