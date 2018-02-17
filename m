Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enCPs-0000nI-Bv
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 19:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enCPn-0003qi-Hu
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 19:01:16 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1enCPn-0003o3-8P
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 19:01:11 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 18 Feb 2018 00:59:20 +0100
Message-Id: <20180217235920.2254-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: TCGv returned by gen_load() must
 be freed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 70c7583621..cb795ed25b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2869,6 +2869,7 @@ DISAS_INSN(unlk)
     tcg_gen_mov_i32(reg, tmp);
     tcg_gen_addi_i32(QREG_SP, src, 4);
     tcg_temp_free(src);
+    tcg_temp_free(tmp);
 }
 
 #if defined(CONFIG_SOFTMMU)
@@ -3146,6 +3147,9 @@ DISAS_INSN(subx_mem)
     gen_subx(s, src, dest, opsize);
 
     gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
+
+    tcg_temp_free(dest);
+    tcg_temp_free(src);
 }
 
 DISAS_INSN(mov3q)
@@ -3352,6 +3356,9 @@ DISAS_INSN(addx_mem)
     gen_addx(s, src, dest, opsize);
 
     gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
+
+    tcg_temp_free(dest);
+    tcg_temp_free(src);
 }
 
 static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
@@ -4396,6 +4403,8 @@ DISAS_INSN(chk2)
     gen_flush_flags(s);
     gen_helper_chk2(cpu_env, reg, bound1, bound2);
     tcg_temp_free(reg);
+    tcg_temp_free(bound1);
+    tcg_temp_free(bound2);
 }
 
 static void m68k_copy_line(TCGv dst, TCGv src, int index)
@@ -4545,6 +4554,7 @@ DISAS_INSN(moves)
         } else {
             gen_partset_reg(opsize, reg, tmp);
         }
+        tcg_temp_free(tmp);
     }
     switch (extract32(insn, 3, 3)) {
     case 3: /* Indirect postincrement.  */
@@ -5535,6 +5545,7 @@ DISAS_INSN(mac)
         case 4: /* Pre-decrement.  */
             tcg_gen_mov_i32(AREG(insn, 0), addr);
         }
+        tcg_temp_free(loadval);
     }
 }
 
-- 
2.14.3
