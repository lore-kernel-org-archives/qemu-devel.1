Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLU-0003fC-Hj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLR-0007zv-GS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:12 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45011 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLR-0007yK-73
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:09 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:37 +0200
Message-Id: <1500026205-15542-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 1/9] specs/qcow2: add compress format
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
 docs/interop/qcow2.txt | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1f..c2d3dab 100644
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
 
@@ -311,6 +317,33 @@ The algorithms used for encryption vary depending on the method
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
+    Byte  0 - 15:  compress_format_name (padded with zeros, but not
+                   necessarily null terminated if it has full length).
+                   Valid compression format names currently are:
+
+                   zlib: Standard zlib deflate compression
+
+              16:  compress_level (uint8_t)
+
+                   0 = default compress level (valid for all formats, default)
+
+                   Additional valid compression levels for zlib compression:
+
+                   All values between 1 and 9. 1 gives best speed, 9 gives best
+                   compression.
+
+
 == Host cluster management ==
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
-- 
1.9.1
