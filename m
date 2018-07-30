Received: from eggs.gnu.org ([2001:4830:134:3::10]:38657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB2d-0004tT-19
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB2Y-00036J-Np
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:29:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47579 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkB2Y-00034a-CR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:28:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:30 +0200
Message-Id: <1532967169-22265-58-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 57/76] mips_malta: Setup GT64120 BARs in
 nanoMIPS bootloader
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

From: Paul Burton <pburton@wavecomp.com>

Setup the GT64120 BARs in the nanoMIPS bootloader, in the same way that
they are setup in the MIPS32 bootloader. This is necessary for Linux to
be able to access peripherals, including the UART.

Signed-off-by: Paul Burton <pburton@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4bc9036..d1a7c1f 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -664,6 +664,79 @@ static void write_bootloader_nanomips(uint8_t *base, int64_t run_addr,
                                 /* lui a3,%hi(loaderparams.ram_low_size) */
     stw_p(p++, 0x80e7); stw_p(p++, NM_LO(loaderparams.ram_low_size));
                                 /* ori a3,a3,%lo(loaderparams.ram_low_size) */
+
+    /* Load BAR registers as done by YAMON */
+    stw_p(p++, 0xe040); stw_p(p++, 0x0681);
+                                /* lui t1, %hi(0xb4000000) */
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0be1);
+                                /* lui t0, %hi(0xdf000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x00df);
+                                /* addiu[32] t0, $0, 0xdf */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9068);
+                                /* sw t0, 0x68(t1) */
+
+    stw_p(p++, 0xe040); stw_p(p++, 0x077d);
+                                /* lui t1, %hi(0xbbe00000) */
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0801);
+                                /* lui t0, %hi(0xc0000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x00c0);
+                                /* addiu[32] t0, $0, 0xc0 */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9048);
+                                /* sw t0, 0x48(t1) */
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0800);
+                                /* lui t0, %hi(0x40000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x0040);
+                                /* addiu[32] t0, $0, 0x40 */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9050);
+                                /* sw t0, 0x50(t1) */
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0001);
+                                /* lui t0, %hi(0x80000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x0080);
+                                /* addiu[32] t0, $0, 0x80 */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9058);
+                                /* sw t0, 0x58(t1) */
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x07e0);
+                                /* lui t0, %hi(0x3f000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x003f);
+                                /* addiu[32] t0, $0, 0x3f */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9060);
+                                /* sw t0, 0x60(t1) */
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0821);
+                                /* lui t0, %hi(0xc1000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x00c1);
+                                /* addiu[32] t0, $0, 0xc1 */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9080);
+                                /* sw t0, 0x80(t1) */
+#ifdef TARGET_WORDS_BIGENDIAN
+    stw_p(p++, 0xe020); stw_p(p++, 0x0bc0);
+                                /* lui t0, %hi(0x5e000000) */
+#else
+    stw_p(p++, 0x0020); stw_p(p++, 0x005e);
+                                /* addiu[32] t0, $0, 0x5e */
+#endif
+    stw_p(p++, 0x8422); stw_p(p++, 0x9088);
+                                /* sw t0, 0x88(t1) */
+
     stw_p(p++, 0xe320 | NM_HI1(kernel_entry));
     stw_p(p++, NM_HI2(kernel_entry));
                                 /* lui t9,%hi(kernel_entry) */
-- 
2.7.4
