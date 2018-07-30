Received: from eggs.gnu.org ([2001:4830:134:3::10]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB2h-0004xS-IY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB2g-0003I4-Rw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:29:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47824 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkB2g-0003HH-KO
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:29:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:31 +0200
Message-Id: <1532967169-22265-59-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 58/76] mips_malta: Fix semihosting argument
 passing for nanoMIPS bare metal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d1a7c1f..8bb1686 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -643,7 +643,12 @@ static void write_bootloader_nanomips(uint8_t *base, int64_t run_addr,
     stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
 
     /* to_here: */
-    stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    if (semihosting_get_argc()) {
+        /* Preserve a0 content as arguments have been passed */
+        stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    } else {
+        stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    }
     stw_p(p++, 0xe3a0 | NM_HI1(ENVP_ADDR - 64));
     stw_p(p++, NM_HI2(ENVP_ADDR - 64));
                                 /* lui sp,%hi(ENVP_ADDR - 64) */
-- 
2.7.4
