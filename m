Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3G-0005oH-Ro
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH38-0007Ch-7Z
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55826 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH37-00078w-Ef
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:28 +0200
Message-Id: <1534182832-554-64-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 63/87] mips_malta: Add setting up GT64120
 BARs to the nanoMIPS bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Paul Burton <pburton@wavecomp.com>

Setup the GT64120 BARs in the nanoMIPS bootloader, in the same way that
they are setup in the MIPS32 bootloader. This is necessary for Linux to
be able to access peripherals, including the UART.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Paul Burton <pburton@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 177 +++++++++++++++++++++++++++++++++++++++++++++=
+-----
 1 file changed, 160 insertions(+), 17 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2e851d9..f261dd6 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -609,47 +609,190 @@ static void write_bootloader_nanomips(uint8_t *bas=
e, int64_t run_addr,
=20
 #define NM_HI1(VAL) (((VAL) >> 16) & 0x1f)
 #define NM_HI2(VAL) \
-            (((VAL) & 0xf000) | (((VAL) >> 19) & 0xffc) | (((VAL) >> 31)=
 & 0x1))
+          (((VAL) & 0xf000) | (((VAL) >> 19) & 0xffc) | (((VAL) >> 31) &=
 0x1))
 #define NM_LO(VAL)  ((VAL) & 0xfff)
=20
-    stw_p(p++, 0x2800); stw_p(p++, 0x001c); /* bc to_here */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
-    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x2800); stw_p(p++, 0x001c);
+                                /* bc to_here */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000);
+                                /* nop */
=20
     /* to_here: */
-    stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    stw_p(p++, 0x0080); stw_p(p++, 0x0002);
+                                /* li a0,2                      */
+
     stw_p(p++, 0xe3a0 | NM_HI1(ENVP_ADDR - 64));
+
     stw_p(p++, NM_HI2(ENVP_ADDR - 64));
-                                /* lui sp,%hi(ENVP_ADDR - 64) */
+                                /* lui sp,%hi(ENVP_ADDR - 64)   */
+
     stw_p(p++, 0x83bd); stw_p(p++, NM_LO(ENVP_ADDR - 64));
                                 /* ori sp,sp,%lo(ENVP_ADDR - 64) */
+
     stw_p(p++, 0xe0a0 | NM_HI1(ENVP_ADDR));
+
     stw_p(p++, NM_HI2(ENVP_ADDR));
-                                /* lui a1,%hi(ENVP_ADDR) */
+                                /* lui a1,%hi(ENVP_ADDR)        */
+
     stw_p(p++, 0x80a5); stw_p(p++, NM_LO(ENVP_ADDR));
-                                /* ori a1,a1,%lo(ENVP_ADDR) */
+                                /* ori a1,a1,%lo(ENVP_ADDR)     */
+
     stw_p(p++, 0xe0c0 | NM_HI1(ENVP_ADDR + 8));
+
     stw_p(p++, NM_HI2(ENVP_ADDR + 8));
-                                /* lui a2,%hi(ENVP_ADDR + 8) */
+                                /* lui a2,%hi(ENVP_ADDR + 8)    */
+
     stw_p(p++, 0x80c6); stw_p(p++, NM_LO(ENVP_ADDR + 8));
                                 /* ori a2,a2,%lo(ENVP_ADDR + 8) */
+
     stw_p(p++, 0xe0e0 | NM_HI1(loaderparams.ram_low_size));
+
     stw_p(p++, NM_HI2(loaderparams.ram_low_size));
                                 /* lui a3,%hi(loaderparams.ram_low_size)=
 */
+
     stw_p(p++, 0x80e7); stw_p(p++, NM_LO(loaderparams.ram_low_size));
                                 /* ori a3,a3,%lo(loaderparams.ram_low_si=
ze) */
+
+    /*
+     * Load BAR registers as done by YAMON:
+     *
+     *  - set up PCI0 I/O BARs from 0x18000000 to 0x181fffff
+     *  - set up PCI0 MEM0 at 0x10000000, size 0x8000000
+     *  - set up PCI0 MEM1 at 0x18200000, size 0xbe00000
+     *
+     */
+    stw_p(p++, 0xe040); stw_p(p++, 0x0681);
+                                /* lui t1, %hi(0xb4000000)      */
+
+#ifdef TARGET_WORDS_BIGENDIAN
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0be1);
+                                /* lui t0, %hi(0xdf000000)      */
+
+    /* 0x68 corresponds to GT_ISD (from hw/mips/gt64xxx_pci.c)  */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9068);
+                                /* sw t0, 0x68(t1)              */
+
+    stw_p(p++, 0xe040); stw_p(p++, 0x077d);
+                                /* lui t1, %hi(0xbbe00000)      */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0801);
+                                /* lui t0, %hi(0xc0000000)      */
+
+    /* 0x48 corresponds to GT_PCI0IOLD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9048);
+                                /* sw t0, 0x48(t1)              */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0800);
+                                /* lui t0, %hi(0x40000000)      */
+
+    /* 0x50 corresponds to GT_PCI0IOHD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9050);
+                                /* sw t0, 0x50(t1)              */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0001);
+                                /* lui t0, %hi(0x80000000)      */
+
+    /* 0x58 corresponds to GT_PCI0M0LD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9058);
+                                /* sw t0, 0x58(t1)              */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x07e0);
+                                /* lui t0, %hi(0x3f000000)      */
+
+    /* 0x60 corresponds to GT_PCI0M0HD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9060);
+                                /* sw t0, 0x60(t1)              */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0821);
+                                /* lui t0, %hi(0xc1000000)      */
+
+    /* 0x80 corresponds to GT_PCI0M1LD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9080);
+                                /* sw t0, 0x80(t1)              */
+
+    stw_p(p++, 0xe020); stw_p(p++, 0x0bc0);
+                                /* lui t0, %hi(0x5e000000)      */
+
+#else
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x00df);
+                                /* addiu[32] t0, $0, 0xdf       */
+
+    /* 0x68 corresponds to GT_ISD                               */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9068);
+                                /* sw t0, 0x68(t1)              */
+
+    /* Use kseg2 remapped address 0x1be00000                    */
+    stw_p(p++, 0xe040); stw_p(p++, 0x077d);
+                                /* lui t1, %hi(0xbbe00000)      */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x00c0);
+                                /* addiu[32] t0, $0, 0xc0       */
+
+    /* 0x48 corresponds to GT_PCI0IOLD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9048);
+                                /* sw t0, 0x48(t1)              */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x0040);
+                                /* addiu[32] t0, $0, 0x40       */
+
+    /* 0x50 corresponds to GT_PCI0IOHD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9050);
+                                /* sw t0, 0x50(t1)              */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x0080);
+                                /* addiu[32] t0, $0, 0x80       */
+
+    /* 0x58 corresponds to GT_PCI0M0LD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9058);
+                                /* sw t0, 0x58(t1)              */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x003f);
+                                /* addiu[32] t0, $0, 0x3f       */
+
+    /* 0x60 corresponds to GT_PCI0M0HD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9060);
+                                /* sw t0, 0x60(t1)              */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x00c1);
+                                /* addiu[32] t0, $0, 0xc1       */
+
+    /* 0x80 corresponds to GT_PCI0M1LD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9080);
+                                /* sw t0, 0x80(t1)              */
+
+    stw_p(p++, 0x0020); stw_p(p++, 0x005e);
+                                /* addiu[32] t0, $0, 0x5e       */
+
+#endif
+
+    /* 0x88 corresponds to GT_PCI0M1HD                          */
+    stw_p(p++, 0x8422); stw_p(p++, 0x9088);
+                                /* sw t0, 0x88(t1)              */
+
     stw_p(p++, 0xe320 | NM_HI1(kernel_entry));
+
     stw_p(p++, NM_HI2(kernel_entry));
-                                /* lui t9,%hi(kernel_entry) */
+                                /* lui t9,%hi(kernel_entry)     */
+
     stw_p(p++, 0x8339); stw_p(p++, NM_LO(kernel_entry));
-                                /* ori t9,t9,%lo(kernel_entry) */
+                                /* ori t9,t9,%lo(kernel_entry)  */
+
     stw_p(p++, 0x4bf9); stw_p(p++, 0x0000);
-                                /* jalrc   t8 */
+                                /* jalrc   t8                   */
 }
=20
 /* ROM and pseudo bootloader
--=20
2.7.4
