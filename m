Received: from eggs.gnu.org ([209.51.188.92]:51246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZL-0005ku-7Z
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZK-00055X-2E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:39 +0100
Message-Id: <20190131175549.11691-2-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 01/11] qcow2: Extend spec for external data
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
 docs/interop/qcow2.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index fb5cb47245..90af0d02e5 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -97,7 +97,17 @@ in the description of a field.
                                 be written to (unless for regaining
                                 consistency).
=20
-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      External data file. If this bit is set, =
an
+                                external data file name header extension=
 must
+                                be present as well. Guest clusters are t=
hen
+                                stored in the external data file. For su=
ch
+                                images, clusters in the external data fi=
le are
+                                not refcounted. The offset field in the
+                                Standard Cluster Descriptor must match t=
he
+                                guest offset and neither compressed clus=
ters
+                                nor internal snapshots are supported.
+
+                    Bits 3-63:  Reserved (set to 0)
=20
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation ca=
n
@@ -148,6 +158,7 @@ be stored. Each extension has a structure like the fo=
llowing:
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
+                        0x44415441 - External data file name
                         other      - Unknown header extension, can be sa=
fely
                                      ignored
=20
@@ -450,8 +461,10 @@ Standard Cluster Descriptor:
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
