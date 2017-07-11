Received: from eggs.gnu.org ([2001:4830:134:3::10]:44377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxio-0006g1-59
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxim-0005NP-T0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:10 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:01 +0200
Message-Id: <20170711160814.20941-13-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 12/85] qcow2: extend specification to cover LUKS
 encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Update the qcow2 specification to describe how the LUKS header is
placed inside a qcow2 file, when using LUKS encryption for the
qcow2 payload instead of the legacy AES-CBC encryption

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-13-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 80cdfd0..886a546 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -45,6 +45,7 @@ The first cluster of a qcow2 image contains the file header:
          32 - 35:   crypt_method
                     0 for no encryption
                     1 for AES encryption
+                    2 for LUKS encryption
 
          36 - 39:   l1_size
                     Number of entries in the active L1 table
@@ -135,6 +136,7 @@ be stored. Each extension has a structure like the following:
                         0xE2792ACA - Backing file format name
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
+                        0x0537be77 - Full disk encryption header pointer
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -207,6 +209,107 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Full disk encryption header pointer ==
+
+The full disk encryption header must be present if, and only if, the
+'crypt_method' header requires metadata. Currently this is only true
+of the 'LUKS' crypt method. The header extension must be absent for
+other methods.
+
+This header provides the offset at which the crypt method can store
+its additional data, as well as the length of such data.
+
+    Byte  0 -  7:   Offset into the image file at which the encryption
+                    header starts in bytes. Must be aligned to a cluster
+                    boundary.
+    Byte  8 - 15:   Length of the written encryption header in bytes.
+                    Note actual space allocated in the qcow2 file may
+                    be larger than this value, since it will be rounded
+                    to the nearest multiple of the cluster size. Any
+                    unused bytes in the allocated space will be initialized
+                    to 0.
+
+For the LUKS crypt method, the encryption header works as follows.
+
+The first 592 bytes of the header clusters will contain the LUKS
+partition header. This is then followed by the key material data areas.
+The size of the key material data areas is determined by the number of
+stripes in the key slot and key size. Refer to the LUKS format
+specification ('docs/on-disk-format.pdf' in the cryptsetup source
+package) for details of the LUKS partition header format.
+
+In the LUKS partition header, the "payload-offset" field will be
+calculated as normal for the LUKS spec. ie the size of the LUKS
+header, plus key material regions, plus padding, relative to the
+start of the LUKS header. This offset value is not required to be
+qcow2 cluster aligned. Its value is currently never used in the
+context of qcow2, since the qcow2 file format itself defines where
+the real payload offset is, but none the less a valid payload offset
+should always be present.
+
+In the LUKS key slots header, the "key-material-offset" is relative
+to the start of the LUKS header clusters in the qcow2 container,
+not the start of the qcow2 file.
+
+Logically the layout looks like
+
+  +-----------------------------+
+  | QCow2 header                |
+  | QCow2 header extension X    |
+  | QCow2 header extension FDE  |
+  | QCow2 header extension ...  |
+  | QCow2 header extension Z    |
+  +-----------------------------+
+  | ....other QCow2 tables....  |
+  .                             .
+  .                             .
+  +-----------------------------+
+  | +-------------------------+ |
+  | | LUKS partition header   | |
+  | +-------------------------+ |
+  | | LUKS key material 1     | |
+  | +-------------------------+ |
+  | | LUKS key material 2     | |
+  | +-------------------------+ |
+  | | LUKS key material ...   | |
+  | +-------------------------+ |
+  | | LUKS key material 8     | |
+  | +-------------------------+ |
+  +-----------------------------+
+  | QCow2 cluster payload       |
+  .                             .
+  .                             .
+  .                             .
+  |                             |
+  +-----------------------------+
+
+== Data encryption ==
+
+When an encryption method is requested in the header, the image payload
+data must be encrypted/decrypted on every write/read. The image headers
+and metadata are never encrypted.
+
+The algorithms used for encryption vary depending on the method
+
+ - AES:
+
+   The AES cipher, in CBC mode, with 256 bit keys.
+
+   Initialization vectors generated using plain64 method, with
+   the virtual disk sector as the input tweak.
+
+   This format is no longer supported in QEMU system emulators, due
+   to a number of design flaws affecting its security. It is only
+   supported in the command line tools for the sake of back compatibility
+   and data liberation.
+
+ - LUKS:
+
+   The algorithms are specified in the LUKS header.
+
+   Initialization vectors generated using the method specified
+   in the LUKS header, with the physical disk sector as the
+   input tweak.
 
 == Host cluster management ==
 
-- 
2.9.4
