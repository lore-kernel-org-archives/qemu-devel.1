Received: from eggs.gnu.org ([2001:4830:134:3::10]:51640)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8d-00071m-Kg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8W-0007vR-Hq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:28 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:42868 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8W-0007r3-8N
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:24 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:04 +0200
Message-Id: <1498733831-15254-2-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 1/8] docs: add compress format extension to
 qcow2 spec
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
index 80cdfd0..c01daf3 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -85,7 +85,12 @@ in the description of a field.
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
@@ -135,6 +140,7 @@ be stored. Each extension has a structure like the following:
                         0xE2792ACA - Backing file format name
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
+                        0xC03183A3 - Compress format extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -208,6 +214,41 @@ The fields of the bitmaps extension are:
                    starts. Must be aligned to a cluster boundary.
 
 
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
+                   necessarily null terminated if it has full length)
+
+              16:  compress_level (uint8_t)
+                   0 = default compress level
+                   1 = lowest compress level
+                   x = highest compress level (the highest compress
+                       level may vary for different compress formats)
+
+         17 - 19:  Reserved for future use, must be zero.
+
+         20 - 23:  extra_data_size
+                   Size of compress format specific extra data.
+                   For now, as no format specifies extra data,
+                   extra_data_size is reserved and should be zero.
+
+        variable:  extra_data
+                   Extra data with additional parameters for the compress
+                   format, occupying extra_data_size bytes.
+
+        variable:  Padding to round up the size of compress format extension
+                   to the next multiple of 8. All bytes of the padding must be
+                   zero.
+
+
 == Host cluster management ==
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
-- 
1.9.1
