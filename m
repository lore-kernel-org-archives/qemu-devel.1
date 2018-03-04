Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVO-0003FB-7u
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVK-0006Oo-AH
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:02 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1esXVK-0006NU-10
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:32:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun,  4 Mar 2018 18:32:28 +0100
Message-Id: <20180304173232.22814-2-laurent@vivier.eu>
In-Reply-To: <20180304173232.22814-1-laurent@vivier.eu>
References: <20180304173232.22814-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/5] target/m68k: TCGv returned by gen_load()
 must be freed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180217235920.2254-1-laurent@vivier.eu>
---
 target/m68k/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 93cd38950e..a22993c7ce 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2871,6 +2871,7 @@ DISAS_INSN(unlk)
     tcg_gen_mov_i32(reg, tmp);
     tcg_gen_addi_i32(QREG_SP, src, 4);
     tcg_temp_free(src);
+    tcg_temp_free(tmp);
 }
 
 #if defined(CONFIG_SOFTMMU)
@@ -3148,6 +3149,9 @@ DISAS_INSN(subx_mem)
     gen_subx(s, src, dest, opsize);
 
     gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
+
+    tcg_temp_free(dest);
+    tcg_temp_free(src);
 }
 
 DISAS_INSN(mov3q)
@@ -3354,6 +3358,9 @@ DISAS_INSN(addx_mem)
     gen_addx(s, src, dest, opsize);
 
     gen_store(s, opsize, addr_dest, QREG_CC_N, IS_USER(s));
+
+    tcg_temp_free(dest);
+    tcg_temp_free(src);
 }
 
 static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
@@ -4398,6 +4405,8 @@ DISAS_INSN(chk2)
     gen_flush_flags(s);
     gen_helper_chk2(cpu_env, reg, bound1, bound2);
     tcg_temp_free(reg);
+    tcg_temp_free(bound1);
+    tcg_temp_free(bound2);
 }
 
 static void m68k_copy_line(TCGv dst, TCGv src, int index)
@@ -4547,6 +4556,7 @@ DISAS_INSN(moves)
         } else {
             gen_partset_reg(opsize, reg, tmp);
         }
+        tcg_temp_free(tmp);
     }
     switch (extract32(insn, 3, 3)) {
     case 3: /* Indirect postincrement.  */
@@ -5537,6 +5547,7 @@ DISAS_INSN(mac)
         case 4: /* Pre-decrement.  */
             tcg_gen_mov_i32(AREG(insn, 0), addr);
         }
+        tcg_temp_free(loadval);
     }
 }
 
-- 
2.14.3
