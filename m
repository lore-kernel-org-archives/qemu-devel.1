Received: from eggs.gnu.org ([2001:4830:134:3::10]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dHooS-0007Rk-V2
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dHooP-0005tl-TA
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:00:41 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dHooP-0005rI-Ed
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:00:37 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  5 Jun 2017 12:00:14 +0200
Message-Id: <20170605100014.22981-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: implement rtd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Add "Return and Deallocate" (rtd) instruction.

  RTD #d

    (SP) -> PC
    SP + 4 + d -> SP

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c       |  2 ++
 target/m68k/cpu.h       |  1 +
 target/m68k/translate.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fa10b6e..f068922 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -130,6 +130,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_FPU);
     m68k_set_feature(env, M68K_FEATURE_CAS);
     m68k_set_feature(env, M68K_FEATURE_BKPT);
+    m68k_set_feature(env, M68K_FEATURE_RTD);
 }
 #define m68030_cpu_initfn m68020_cpu_initfn
 #define m68040_cpu_initfn m68020_cpu_initfn
@@ -151,6 +152,7 @@ static void m68060_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_FPU);
     m68k_set_feature(env, M68K_FEATURE_CAS);
     m68k_set_feature(env, M68K_FEATURE_BKPT);
+    m68k_set_feature(env, M68K_FEATURE_RTD);
 }
 
 static void m5208_cpu_initfn(Object *obj)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 8095822..384ec5d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -251,6 +251,7 @@ enum m68k_features {
     M68K_FEATURE_FPU,
     M68K_FEATURE_CAS,
     M68K_FEATURE_BKPT,
+    M68K_FEATURE_RTD,
 };
 
 static inline int m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9f60fbc..ad4d4ef 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2483,6 +2483,16 @@ DISAS_INSN(nop)
 {
 }
 
+DISAS_INSN(rtd)
+{
+    TCGv tmp;
+    int16_t offset = read_im16(env, s);
+
+    tmp = gen_load(s, OS_LONG, QREG_SP, 0);
+    tcg_gen_addi_i32(QREG_SP, QREG_SP, offset + 4);
+    gen_jmp(s, tmp);
+}
+
 DISAS_INSN(rts)
 {
     TCGv tmp;
@@ -4904,6 +4914,7 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(nop,       4e71, ffff);
     BASE(stop,      4e72, ffff);
     BASE(rte,       4e73, ffff);
+    INSN(rtd,       4e74, ffff, RTD);
     BASE(rts,       4e75, ffff);
     INSN(movec,     4e7b, ffff, CF_ISA_A);
     BASE(jump,      4e80, ffc0);
-- 
2.9.4
