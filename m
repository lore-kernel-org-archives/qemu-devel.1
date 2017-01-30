Received: from eggs.gnu.org ([2001:4830:134:3::10]:51376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWa-0003PH-C8
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGWV-0002Ou-Hz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:56 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGWU-0002Lq-Dc
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:29 +0100
Message-Id: <20170130181634.13934-12-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 11/16] target-m68k: add fmovecr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

fmovecr moves a floating point constant from the
FPU ROM to a floating point register.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 31 +++++++++++++++++++++++++++++++
 target/m68k/helper.h     |  1 +
 target/m68k/translate.c  | 12 +++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index aadfc82..d8145e0 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -24,6 +24,31 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 
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
 static floatx80 FP0_to_floatx80(CPUM68KState *env)
 {
     return (floatx80){ .low = env->fp0l, .high = env->fp0h };
@@ -427,3 +452,9 @@ void HELPER(fmovem)(CPUM68KState *env, uint32_t opsize,
 {
     fprintf(stderr, "MISSING HELPER fmovem\n");
 }
+
+void HELPER(const_FP0)(CPUM68KState *env, uint32_t offset)
+{
+    env->fp0l = fpu_rom[offset].low;
+    env->fp0h = fpu_rom[offset].high;
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 58bc273..4927324 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -32,6 +32,7 @@ DEF_HELPER_2(set_fpcr, void, env, i32)
 DEF_HELPER_1(tst_FP0, void, env)
 DEF_HELPER_1(update_fpstatus, void, env)
 DEF_HELPER_4(fmovem, void, env, i32, i32, i32)
+DEF_HELPER_2(const_FP0, void, env, i32)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3fc744d..26160a3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4555,16 +4555,26 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
 DISAS_INSN(fpu)
 {
     uint16_t ext;
+    uint8_t rom_offset;
     int opmode;
     int opsize;
 
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
+            rom_offset = ext & 0x7f;
+            gen_helper_const_FP0(cpu_env, tcg_const_i32(rom_offset));
+            gen_op_store_fpr_FP0(REG(ext, 7));
+            return;
+        }
+        break;
     case 3: /* fmove out */
         gen_op_load_fpr_FP0(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-- 
2.9.3
