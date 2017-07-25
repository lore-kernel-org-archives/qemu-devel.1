Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da121-0001n9-Et
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da11x-0000qb-2B
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:53 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:33044 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da11w-0000ow-Pg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:49 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:30 +0200
Message-Id: <1500993699-19299-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 docs/interop/qcow2.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 roms/ipxe              |  2 +-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1f..d0d2a8f 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -86,7 +86,12 @@ in the description of a field.
                                 be written to (unless for regaining
                                 consistency).
 
-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      Compress format bit.  If and only if this bit
+                                is set then the compress format extension
+                                MUST be present and MUST be parsed and checked
+                                for compatibility.
+
+                    Bits 3-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -137,6 +142,7 @@ be stored. Each extension has a structure like the following:
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
+                        0xC03183A3 - Compress format extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -311,6 +317,49 @@ The algorithms used for encryption vary depending on the method
    in the LUKS header, with the physical disk sector as the
    input tweak.
 
+
+== Compress format extension ==
+
+The compress format extension is an optional header extension. It provides
+the ability to specify the compress algorithm and compress parameters
+that are used for compressed clusters. This new header MUST be present if
+the incompatible-feature bit "compress format bit" is set and MUST be absent
+otherwise.
+
+The fields of the compress format extension are:
+
+    Byte  0 - 13:  compress_format_name (padded with zeros, but not
+                   necessarily null terminated if it has full length).
+                   Valid compression format names currently are:
+
+                   deflate: Standard zlib deflate compression without
+                            compression header
+
+              14:  compress_level (uint8_t)
+
+                   0 = default compress level (valid for all formats, default)
+
+                   Additional valid compression levels for deflate compression:
+
+                   All values between 1 and 9. 1 gives best speed, 9 gives best
+                   compression. The default compression level is defined by zlib
+                   and currently defaults to 6.
+
+              15:  compress_window_size (uint8_t)
+
+                   Window or dictionary size used by the compression format.
+                   Currently only used by the deflate compression algorithm.
+
+                   Valid window sizes for deflate compression range from 8 to
+                   15 inclusively.
+
+Note: Omitting the incompatible "Compress format bit" results in the usage
+of deflate compression with default compression level and a window size of 12
+(which was default before QEMU 2.11). If exactly these parameters are choosen
+it is free to the implementation to omit the "Compress format bit" and the
+compress format extension when updating the QCOW2 header.
+
+
 == Host cluster management ==
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
diff --git a/roms/ipxe b/roms/ipxe
index 0600d3a..b991c67 160000
--- a/roms/ipxe
+++ b/roms/ipxe
@@ -1 +1 @@
-Subproject commit 0600d3ae94f93efd10fc6b3c7420a9557a3a1670
+Subproject commit b991c67c1d91574ef22336cc3a5944d1e63230c9
-- 
1.9.1
