Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYCK0-0008BY-Kn
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYCJw-0007t8-8v
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:56 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34363 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYCJv-0007rs-Vo
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:52 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 20 Jul 2017 16:20:32 +0200
Message-Id: <1500560441-5670-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-1-git-send-email-pl@kamp.de>
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V4 01/10] specs/qcow2: add compress format
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
 docs/interop/qcow2.txt | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1f..ef5abb2 100644
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
 
@@ -311,6 +317,41 @@ The algorithms used for encryption vary depending on the method
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
+Note: Ommitting the incompatible "Compress format bit" results in the usage
+of zlib compression with default compression level (default before QEMU 2.10).
+However, this old default has a smaller compression window size which results in
+lower compression ratio and slightly worse compression speed compared to
+explicity specifying zlib compression with default compression level in the
+compress format extension.
+
+The fields of the compress format extension are:
+
+    Byte  0 - 14:  compress_format_name (padded with zeros, but not
+                   necessarily null terminated if it has full length).
+                   Valid compression format names currently are:
+
+                   zlib: Standard zlib deflate compression
+
+              15:  compress_level (uint8_t)
+
+                   0 = default compress level (valid for all formats, default)
+
+                   Additional valid compression levels for zlib compression:
+
+                   All values between 1 and 9. 1 gives best speed, 9 gives best
+                   compression. The default compression level is defined by zlib
+                   and currently defaults to 6.
+
+
 == Host cluster management ==
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
-- 
1.9.1
