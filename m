Received: from eggs.gnu.org ([2001:4830:134:3::10]:55566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eSaKS-0002K8-Vi
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 22:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eSaKS-0001P0-3i
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 22:18:28 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eSaKR-0001OG-Rc
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 22:18:28 -0500
Received: by mail-lf0-x244.google.com with SMTP id w196so15367096lff.5
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 19:18:27 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 22 Dec 2017 19:18:04 -0800
Message-Id: <1513999084-19087-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/xtensa/xtfpga: rewrite mini bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Don't load jump target into the CPU config, instead put it and initial
a2 as literals into the mini bootloader and use l32r to load them
natively. With these changes it should be possible to do warm reboot of
the guest.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 1971ecfdc5a3..ba681683d608 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -372,15 +372,33 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
             }
         }
         if (entry_point != env->pc) {
-            static const uint8_t jx_a0[] = {
+            uint8_t boot[] = {
 #ifdef TARGET_WORDS_BIGENDIAN
-                0x0a, 0, 0,
+                0x60, 0x00, 0x08,       /* j    1f */
+                0x00,                   /* .literal_position */
+                0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
+                0x00, 0x00, 0x00, 0x00, /* .literal entry_a2 */
+                                        /* 1: */
+                0x10, 0xff, 0xfe,       /* l32r a0, entry_pc */
+                0x12, 0xff, 0xfe,       /* l32r a2, entry_a2 */
+                0x0a, 0x00, 0x00,       /* jx   a0 */
 #else
-                0xa0, 0, 0,
+                0x06, 0x02, 0x00,       /* j    1f */
+                0x00,                   /* .literal_position */
+                0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
+                0x00, 0x00, 0x00, 0x00, /* .literal entry_a2 */
+                                        /* 1: */
+                0x01, 0xfe, 0xff,       /* l32r a0, entry_pc */
+                0x21, 0xfe, 0xff,       /* l32r a2, entry_a2 */
+                0xa0, 0x00, 0x00,       /* jx   a0 */
 #endif
             };
-            env->regs[0] = entry_point;
-            cpu_physical_memory_write(env->pc, jx_a0, sizeof(jx_a0));
+            uint32_t entry_pc = tswap32(entry_point);
+            uint32_t entry_a2 = tswap32(tagptr);
+
+            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
+            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
+            cpu_physical_memory_write(env->pc, boot, sizeof(boot));
         }
     } else {
         if (flash) {
-- 
2.1.4
