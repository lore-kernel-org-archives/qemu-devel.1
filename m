Received: from eggs.gnu.org ([2001:4830:134:3::10]:49645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdL-0001Bm-D9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdK-00024n-6F
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:07 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAdJ-00024A-TM
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:06 -0500
Received: by mail-wr0-x241.google.com with SMTP id g17so7782315wrd.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:40:05 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:50 -0800
Message-Id: <1513661932-6849-15-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 14/16] target/xtensa: implement GPIO32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

GPIO32 is not in the core ISA, but it was widely used in Diamond Cores.
This implementation doesn't do actual I/O and doesn't handle the case of
GPIO32 state being a part of coprocessor.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  1 +
 target/xtensa/translate.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 80e9b47e84e9..d9404aa50ab5 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -108,6 +108,7 @@ enum {
 };
 
 enum {
+    EXPSTATE = 230,
     THREADPTR = 231,
     FCR = 232,
     FSR = 233,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index da1f712badc7..a84bbf3bedc3 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -204,6 +204,7 @@ static const XtensaReg sregnames[256] = {
 };
 
 static const XtensaReg uregnames[256] = {
+    [EXPSTATE] = XTENSA_REG_BITS("EXPSTATE", XTENSA_OPTION_ALL),
     [THREADPTR] = XTENSA_REG("THREADPTR", XTENSA_OPTION_THREAD_POINTER),
     [FCR] = XTENSA_REG("FCR", XTENSA_OPTION_FP_COPROCESSOR),
     [FSR] = XTENSA_REG("FSR", XTENSA_OPTION_FP_COPROCESSOR),
@@ -1518,6 +1519,13 @@ static void translate_clamps(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
+                                    const uint32_t par[])
+{
+    /* TODO: GPIO32 may be a part of coprocessor */
+    tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0]));
+}
+
 /* par[0]: privileged, par[1]: check memory access */
 static void translate_dcache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
@@ -2013,6 +2021,15 @@ static void translate_quou(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_read_impwire(DisasContext *dc, const uint32_t arg[],
+                                   const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        /* TODO: GPIO32 may be a part of coprocessor */
+        tcg_gen_movi_i32(cpu_R[arg[0]], 0);
+    }
+}
+
 static void translate_rer(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
@@ -2157,6 +2174,13 @@ static void translate_rur(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_setb_expstate(DisasContext *dc, const uint32_t arg[],
+                                    const uint32_t par[])
+{
+    /* TODO: GPIO32 may be a part of coprocessor */
+    tcg_gen_ori_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], 1u << arg[0]);
+}
+
 static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
 {
@@ -2445,6 +2469,15 @@ static void translate_wer(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_wrmsk_expstate(DisasContext *dc, const uint32_t arg[],
+                                     const uint32_t par[])
+{
+    if (gen_window_check2(dc, arg[0], arg[1])) {
+        /* TODO: GPIO32 may be a part of coprocessor */
+        tcg_gen_and_i32(cpu_UR[EXPSTATE], cpu_R[arg[0]], cpu_R[arg[1]]);
+    }
+}
+
 static void translate_wsr(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
@@ -2706,6 +2739,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "clamps",
         .translate = translate_clamps,
     }, {
+        .name = "clrb_expstate",
+        .translate = translate_clrb_expstate,
+    }, {
         .name = "depbits",
         .translate = translate_depbits,
     }, {
@@ -3268,6 +3304,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rtlb,
         .par = (const uint32_t[]){true, 1},
     }, {
+        .name = "read_impwire",
+        .translate = translate_read_impwire,
+    }, {
         .name = "rems",
         .translate = translate_quos,
         .par = (const uint32_t[]){false},
@@ -3635,6 +3674,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "rsync",
         .translate = translate_nop,
     }, {
+        .name = "rur.expstate",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){EXPSTATE},
+    }, {
         .name = "rur.fcr",
         .translate = translate_rur,
         .par = (const uint32_t[]){FCR},
@@ -3685,6 +3728,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_salt,
         .par = (const uint32_t[]){TCG_COND_LTU},
     }, {
+        .name = "setb_expstate",
+        .translate = translate_setb_expstate,
+    }, {
         .name = "sext",
         .translate = translate_sext,
     }, {
@@ -3775,6 +3821,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wtlb,
         .par = (const uint32_t[]){false},
     }, {
+        .name = "wrmsk_expstate",
+        .translate = translate_wrmsk_expstate,
+    }, {
         .name = "wsr.176",
         .translate = translate_wsr,
         .par = (const uint32_t[]){176},
@@ -4083,6 +4132,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wsr,
         .par = (const uint32_t[]){WINDOW_START},
     }, {
+        .name = "wur.expstate",
+        .translate = translate_wur,
+        .par = (const uint32_t[]){EXPSTATE},
+    }, {
         .name = "wur.fcr",
         .translate = translate_wur,
         .par = (const uint32_t[]){FCR},
-- 
2.1.4
