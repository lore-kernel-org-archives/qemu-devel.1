Received: from eggs.gnu.org ([2001:4830:134:3::10]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgc-0005m2-S1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgc-0000KM-3l
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpgb-0000Jj-TQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:06 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:31 +0000
Message-Id: <1488556233-31246-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 4/6] disas/microblaze: Avoid unintended
 sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

In read_insn_microblaze() we assemble 4 bytes into an 'unsigned
long'.  If 'unsigned long' is 64 bits and the high byte has its top
bit set, then C's implicit conversion from 'unsigned char' to 'int'
for the shift will result in an unintended sign extension which sets
the top 32 bits in 'inst'.  Add casts to prevent this.  (Spotted by
Coverity, CID 1005401.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/microblaze.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 91b30ac..407c0a3 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -748,9 +748,11 @@ read_insn_microblaze (bfd_vma memaddr,
     }
 
   if (info->endian == BFD_ENDIAN_BIG)
-    inst = (ibytes[0] << 24) | (ibytes[1] << 16) | (ibytes[2] << 8) | ibytes[3];
+    inst = ((unsigned)ibytes[0] << 24) | (ibytes[1] << 16)
+      | (ibytes[2] << 8) | ibytes[3];
   else if (info->endian == BFD_ENDIAN_LITTLE)
-    inst = (ibytes[3] << 24) | (ibytes[2] << 16) | (ibytes[1] << 8) | ibytes[0];
+    inst = ((unsigned)ibytes[3] << 24) | (ibytes[2] << 16)
+      | (ibytes[1] << 8) | ibytes[0];
   else
     abort ();
 
-- 
2.7.4
