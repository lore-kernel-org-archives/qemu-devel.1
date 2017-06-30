Received: from eggs.gnu.org ([2001:4830:134:3::10]:33317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4n-0008Hc-Qy
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4a-0005tv-HD
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQv4a-0005rO-5w
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 30 Jun 2017 14:30:45 +0200
Message-Id: <20170630123050.19834-3-laurent@vivier.eu>
In-Reply-To: <20170630123050.19834-1-laurent@vivier.eu>
References: <20170630123050.19834-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] target/m68k: add fmovecr
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

fmovecr moves a floating point constant from the
FPU ROM to a floating point register.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170628204241.32106-3-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 34 ++++++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  1 +
 target/m68k/translate.c  | 13 ++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index a9e17f5..4c14a1f 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -23,6 +23,35 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 
+/* Undefined offsets may be different on various FPU.
+ * On 68040 they return 0.0 (floatx80_zero)
+ */
+
+static const floatx80 fpu_rom[128] = {
+    [0x00] = floatx80_pi,                                   /* Pi */
+    [0x0b] = make_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
+    [0x0c] = make_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
+    [0x0d] = make_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
+    [0x0e] = make_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
+    [0x0f] = floatx80_zero,                                 /* Zero     */
+    [0x30] = floatx80_ln2,                                  /* ln(2)    */
+    [0x31] = make_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
+    [0x32] = floatx80_one,                                  /* 10^0     */
+    [0x33] = make_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1     */
+    [0x34] = make_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2     */
+    [0x35] = make_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
+    [0x36] = make_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
+    [0x37] = make_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
+    [0x38] = make_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
+    [0x39] = make_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
+    [0x3a] = make_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
+    [0x3b] = make_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
+    [0x3c] = make_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
+    [0x3d] = make_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
+    [0x3e] = make_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
+    [0x3f] = make_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
+};
+
 int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
 {
     return floatx80_to_int32(val->d, &env->fp_status);
@@ -204,3 +233,8 @@ void HELPER(ftst)(CPUM68KState *env, FPReg *val)
     }
     env->fpsr = (env->fpsr & ~FPSR_CC_MASK) | cc;
 }
+
+void HELPER(fconst)(CPUM68KState *env, FPReg *val, uint32_t offset)
+{
+    val->d = fpu_rom[offset];
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 98cbf18..d6e80e4 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -35,6 +35,7 @@ DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
+DEF_HELPER_3(fconst, void, env, fp, i32)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5f4bedc..5b93d3f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4518,10 +4518,21 @@ DISAS_INSN(fpu)
     ext = read_im16(env, s);
     opmode = ext & 0x7f;
     switch ((ext >> 13) & 7) {
-    case 0: case 2:
+    case 0:
         break;
     case 1:
         goto undef;
+    case 2:
+        if (insn == 0xf200 && (ext & 0xfc00) == 0x5c00) {
+            /* fmovecr */
+            TCGv rom_offset = tcg_const_i32(opmode);
+            cpu_dest = gen_fp_ptr(REG(ext, 7));
+            gen_helper_fconst(cpu_env, cpu_dest, rom_offset);
+            tcg_temp_free_ptr(cpu_dest);
+            tcg_temp_free(rom_offset);
+            return;
+        }
+        break;
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-- 
2.9.4
