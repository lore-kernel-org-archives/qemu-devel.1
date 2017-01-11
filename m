Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uz-0006LJ-Tk
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uz-0003KO-4k
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:49 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uy-0003K6-V8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:49 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so12525434pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:48 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:46 -0800
Message-Id: <20170111021820.24416-32-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 31/65] target-openrisc: Use clz and ctz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/helper.h     |  2 --
 target/openrisc/int_helper.c | 19 -------------------
 target/openrisc/translate.c  |  6 ++++--
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index f53fa21..bcc7245 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -54,8 +54,6 @@ FOP_CMP(ge)
 #undef FOP_CMP
 
 /* int */
-DEF_HELPER_FLAGS_1(ff1, 0, tl, tl)
-DEF_HELPER_FLAGS_1(fl1, 0, tl, tl)
 DEF_HELPER_FLAGS_3(mul32, 0, i32, env, i32, i32)
 
 /* interrupt */
diff --git a/target/openrisc/int_helper.c b/target/openrisc/int_helper.c
index 4d1f958..ba0fd27 100644
--- a/target/openrisc/int_helper.c
+++ b/target/openrisc/int_helper.c
@@ -24,25 +24,6 @@
 #include "exception.h"
 #include "qemu/host-utils.h"
 
-target_ulong HELPER(ff1)(target_ulong x)
-{
-/*#ifdef TARGET_OPENRISC64
-    return x ? ctz64(x) + 1 : 0;
-#else*/
-    return x ? ctz32(x) + 1 : 0;
-/*#endif*/
-}
-
-target_ulong HELPER(fl1)(target_ulong x)
-{
-/* not used yet, open it when we need or64.  */
-/*#ifdef TARGET_OPENRISC64
-    return 64 - clz64(x);
-#else*/
-    return 32 - clz32(x);
-/*#endif*/
-}
-
 uint32_t HELPER(mul32)(CPUOpenRISCState *env,
                        uint32_t ra, uint32_t rb)
 {
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 229361a..03fa7db 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -602,11 +602,13 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
         switch (op1) {
         case 0x00:    /* l.ff1 */
             LOG_DIS("l.ff1 r%d, r%d, r%d\n", rd, ra, rb);
-            gen_helper_ff1(cpu_R[rd], cpu_R[ra]);
+            tcg_gen_ctzi_tl(cpu_R[rd], cpu_R[ra], -1);
+            tcg_gen_addi_tl(cpu_R[rd], cpu_R[rd], 1);
             break;
         case 0x01:    /* l.fl1 */
             LOG_DIS("l.fl1 r%d, r%d, r%d\n", rd, ra, rb);
-            gen_helper_fl1(cpu_R[rd], cpu_R[ra]);
+            tcg_gen_clzi_tl(cpu_R[rd], cpu_R[ra], TARGET_LONG_BITS);
+            tcg_gen_subfi_tl(cpu_R[rd], TARGET_LONG_BITS, cpu_R[rd]);
             break;
 
         default:
-- 
2.9.3
