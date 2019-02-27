Received: from eggs.gnu.org ([209.51.188.92]:51249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2vq-00034K-4V
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gz2vp-0003Ir-6W
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:23:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 27 Feb 2019 18:22:39 +0100
Message-Id: <20190227172256.30368-4-kwolf@redhat.com>
In-Reply-To: <20190227172256.30368-1-kwolf@redhat.com>
References: <20190227172256.30368-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/20] qcow2: Extend spec for external data
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This adds external data file to the qcow2 spec as a new incompatible
feature.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/interop/qcow2.txt | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index fb5cb47245..1c1849dc26 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -97,7 +97,19 @@ in the description of a field.
                                 be written to (unless for regaining
                                 consistency).
=20
-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      External data file bit.  If this bit is =
set, an
+                                external data file is used. Guest cluste=
rs are
+                                then stored in the external data file. F=
or such
+                                images, clusters in the external data fi=
le are
+                                not refcounted. The offset field in the
+                                Standard Cluster Descriptor must match t=
he
+                                guest offset and neither compressed clus=
ters
+                                nor internal snapshots are supported.
+
+                                An external data file name header extens=
ion may
+                                be present if this bit is set.
+
+                    Bits 3-63:  Reserved (set to 0)
=20
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation ca=
n
@@ -126,7 +138,17 @@ in the description of a field.
                                 bit is unset, the bitmaps extension data=
 must be
                                 considered inconsistent.
=20
-                    Bits 1-63:  Reserved (set to 0)
+                    Bit 1:      If this bit is set, the external data fi=
le can
+                                be read as a consistent standalone raw i=
mage
+                                without looking at the qcow2 metadata.
+
+                                Setting this bit has a performance impac=
t for
+                                some operations on the image (e.g. writi=
ng
+                                zeros requires writing to the data file =
instead
+                                of only setting the zero flag in the L2 =
table
+                                entry) and conflicts with backing files.
+
+                    Bits 2-63:  Reserved (set to 0)
=20
          96 -  99:  refcount_order
                     Describes the width of a reference count block entry=
 (width
@@ -148,6 +170,7 @@ be stored. Each extension has a structure like the fo=
llowing:
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
+                        0x44415441 - External data file name
                         other      - Unknown header extension, can be sa=
fely
                                      ignored
=20
@@ -437,6 +460,11 @@ L2 table entry:
                     This information is only accurate in L2 tables
                     that are reachable from the active L1 table.
=20
+                    With external data files, all guest clusters have an
+                    implicit refcount of 1 (because of the fixed host =3D=
 guest
+                    mapping for guest cluster offsets), so this bit shou=
ld be 1
+                    for all allocated clusters.
+
 Standard Cluster Descriptor:
=20
     Bit       0:    If set to 1, the cluster reads as all zeros. The hos=
t
@@ -450,8 +478,10 @@ Standard Cluster Descriptor:
          1 -  8:    Reserved (set to 0)
=20
          9 - 55:    Bits 9-55 of host cluster offset. Must be aligned to=
 a
-                    cluster boundary. If the offset is 0, the cluster is
-                    unallocated.
+                    cluster boundary. If the offset is 0 and bit 63 is c=
lear,
+                    the cluster is unallocated. The offset may only be 0=
 with
+                    bit 63 set (indicating a host cluster offset of 0) w=
hen an
+                    external data file is used.
=20
         56 - 61:    Reserved (set to 0)
=20
--=20
2.20.1
