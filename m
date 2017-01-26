Received: from eggs.gnu.org ([2001:4830:134:3::10]:45641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh99-0001mr-24
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh97-0006Bw-SB
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:15 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:21 +0000
Message-Id: <20170126101827.22378-13-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/18] qcow2: extend specification to cover
 LUKS encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Update the qcow2 specification to describe how the LUKS header is
placed inside a qcow2 file, when using LUKS encryption for the
qcow2 payload instead of the legacy AES-CBC encryption

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 docs/specs/qcow2.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
index 80cdfd0..ab07e99 100644
--- a/docs/specs/qcow2.txt
+++ b/docs/specs/qcow2.txt
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
 
@@ -207,6 +209,100 @@ The fields of the bitmaps extension are:
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
+		    boundary.
+    Byte  8 - 15:   Length of the written encryption header in bytes.
+                    Note actual space allocated in the qcow2 file may
+		    be larger than this value, since it will be rounded
+		    to the nearest multiple of the cluster size. Any
+		    unused bytes in the allocated space will be initialized
+		    to 0.
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
+header, plus key material regions, plus padding. Its value is not
+used, however, since the qcow2 file format itself defines where
+the real payload offset is.
+
+In the LUKS key slots header, the "key-material-offset" is relative
+to the start of the LUKS header clusters in the qcow2 container,
+not the start of the qcow2 file.
+
+Logically the layout looks like
+
+  +-----------------------------+
+  | QCow2 header                |
+  +-----------------------------+
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
+and metadata is never encrypted.
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
+ - LUKS:
+
+   The algorithms are specified in the LUKS header.
+
+   Initialization vectors generated using the method specified
+   in the LUKS header, with the physical disk sector as the
+   input tweak.
 
 == Host cluster management ==
 
-- 
2.9.3
