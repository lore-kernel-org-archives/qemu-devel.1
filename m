Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C58C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0820709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhnW-0003i4-Py
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZhlx-0001z7-22
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:21:37 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:64959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZhlt-0007TK-RX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 17:21:36 -0400
IronPort-SDR: kvM2Yau0GnB6gjlQieUKERVk8RwK3OfaGO51fQ/OLhkqJc48oj1AZU+FSkyc6yXEYWiU3CSdKw
 WYmSuxuKtou4qsloBXgGrpaY48OTw7AJbuSRqWa0X8Tymw0DWXSqZ+upARPOXpp5l/xOtHMWNJ
 J/SOIEaht0zC6tEk757Xlf604LS5iiFbinJUJXvv+8xS9Vpk3q1hWuZLFVRsICTleBWGF5FCOt
 +Rggml9S8qcDvqhMRV7qG5NCkO4bRd0l2MJPGYSbpXdHm6qmFsQgBbptWxu1cNT/CwlnFLitRX
 KoI=
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; d="scan'208";a="48835731"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 15 May 2020 13:21:31 -0800
IronPort-SDR: eO7lMOjnbWy7Ekft0C4ajwYw2dYWJOYVQfils4tzUZbYguHc6vx80qUwQNiWv/DbH8bEGdreCu
 QocuaZFWSTWDMjPfQJ9GnuUrH+vuh74xOHbwt+z1LYNgbRaNR+tGKkhyWMpN8rLhaBBS6IYIGl
 FFnLMV1leTIRtCn+y50YU6r1S4Bm3paKQrRJY14cfr+4MdyuPyPiM4YUyFisICStmlauG6/eV+
 H0q6PutFobvBXBHK2eNmZL2GFDBjPlWlLUIpIF2Bk6/7L6CAw+/7g6KGz9yRBLa8fx6g7sYz1L
 hfk=
Date: Fri, 15 May 2020 21:21:24 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 2/2] target/i386: fix IEEE x87 floating-point exception raising
In-Reply-To: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:21:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most x87 instruction implementations fail to raise the expected IEEE
floating-point exceptions because they do nothing to convert the
exception state from the softfloat machinery into the exception flags
in the x87 status word.  There is special-case handling of division to
raise the divide-by-zero exception, but that handling is itself buggy:
it raises the exception in inappropriate cases (inf / 0 and nan / 0,
which should not raise any exceptions, and 0 / 0, which should raise
"invalid" instead).

Fix this by converting the floating-point exceptions raised during an
operation by the softfloat machinery into exceptions in the x87 status
word (passing through the existing fpu_set_exception function for
handling related to trapping exceptions).  There are special cases
where some functions convert to integer internally but exceptions from
that conversion are not always correct exceptions for the instruction
to raise.

There might be scope for some simplification if the softfloat
exception state either could always be assumed to be in sync with the
state in the status word, or could always be ignored at the start of
each instruction and just set to 0 then; I haven't looked into that in
detail, and it might run into interactions with the various ways the
emulation does not yet handle trapping exceptions properly.  I think
the approach taken here, of saving the softfloat state, setting
exceptions there to 0 and then merging the old exceptions back in
after carrying out the operation, is conservatively safe.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c                 | 126 +++-
 tests/tcg/i386/test-i386-fp-exceptions.c | 831 +++++++++++++++++++++++
 2 files changed, 926 insertions(+), 31 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fp-exceptions.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 8dcc9ddf68..c19cad466e 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -161,12 +161,32 @@ static void fpu_set_exception(CPUX86State *env, int mask)
     }
 }
 
+static inline uint8_t save_exception_flags(CPUX86State *env)
+{
+    uint8_t old_flags = get_float_exception_flags(&env->fp_status);
+    set_float_exception_flags(0, &env->fp_status);
+    return old_flags;
+}
+
+static void merge_exception_flags(CPUX86State *env, uint8_t old_flags)
+{
+    uint8_t new_flags = get_float_exception_flags(&env->fp_status);
+    float_raise(old_flags, &env->fp_status);
+    fpu_set_exception(env,
+                      ((new_flags & float_flag_invalid ? FPUS_IE : 0) |
+                       (new_flags & float_flag_divbyzero ? FPUS_ZE : 0) |
+                       (new_flags & float_flag_overflow ? FPUS_OE : 0) |
+                       (new_flags & float_flag_underflow ? FPUS_UE : 0) |
+                       (new_flags & float_flag_inexact ? FPUS_PE : 0) |
+                       (new_flags & float_flag_input_denormal ? FPUS_DE : 0)));
+}
+
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
 {
-    if (floatx80_is_zero(b)) {
-        fpu_set_exception(env, FPUS_ZE);
-    }
-    return floatx80_div(a, b, &env->fp_status);
+    uint8_t old_flags = save_exception_flags(env);
+    floatx80 ret = floatx80_div(a, b, &env->fp_status);
+    merge_exception_flags(env, old_flags);
+    return ret;
 }
 
 static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
@@ -183,6 +203,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
 
 void helper_flds_FT0(CPUX86State *env, uint32_t val)
 {
+    uint8_t old_flags = save_exception_flags(env);
     union {
         float32 f;
         uint32_t i;
@@ -190,10 +211,12 @@ void helper_flds_FT0(CPUX86State *env, uint32_t val)
 
     u.i = val;
     FT0 = float32_to_floatx80(u.f, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fldl_FT0(CPUX86State *env, uint64_t val)
 {
+    uint8_t old_flags = save_exception_flags(env);
     union {
         float64 f;
         uint64_t i;
@@ -201,6 +224,7 @@ void helper_fldl_FT0(CPUX86State *env, uint64_t val)
 
     u.i = val;
     FT0 = float64_to_floatx80(u.f, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fildl_FT0(CPUX86State *env, int32_t val)
@@ -210,6 +234,7 @@ void helper_fildl_FT0(CPUX86State *env, int32_t val)
 
 void helper_flds_ST0(CPUX86State *env, uint32_t val)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int new_fpstt;
     union {
         float32 f;
@@ -221,10 +246,12 @@ void helper_flds_ST0(CPUX86State *env, uint32_t val)
     env->fpregs[new_fpstt].d = float32_to_floatx80(u.f, &env->fp_status);
     env->fpstt = new_fpstt;
     env->fptags[new_fpstt] = 0; /* validate stack entry */
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fldl_ST0(CPUX86State *env, uint64_t val)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int new_fpstt;
     union {
         float64 f;
@@ -236,6 +263,7 @@ void helper_fldl_ST0(CPUX86State *env, uint64_t val)
     env->fpregs[new_fpstt].d = float64_to_floatx80(u.f, &env->fp_status);
     env->fpstt = new_fpstt;
     env->fptags[new_fpstt] = 0; /* validate stack entry */
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fildl_ST0(CPUX86State *env, int32_t val)
@@ -260,113 +288,107 @@ void helper_fildll_ST0(CPUX86State *env, int64_t val)
 
 uint32_t helper_fsts_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     union {
         float32 f;
         uint32_t i;
     } u;
 
     u.f = floatx80_to_float32(ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return u.i;
 }
 
 uint64_t helper_fstl_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     union {
         float64 f;
         uint64_t i;
     } u;
 
     u.f = floatx80_to_float64(ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return u.i;
 }
 
 int32_t helper_fist_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32(ST0, &env->fp_status);
     if (val != (int16_t)val) {
+        set_float_exception_flags(float_flag_invalid, &env->fp_status);
         val = -32768;
     }
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
 int32_t helper_fistl_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int32_t val;
-    signed char old_exp_flags;
-
-    old_exp_flags = get_float_exception_flags(&env->fp_status);
-    set_float_exception_flags(0, &env->fp_status);
 
     val = floatx80_to_int32(ST0, &env->fp_status);
     if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
         val = 0x80000000;
     }
-    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
-                                | old_exp_flags, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
 int64_t helper_fistll_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int64_t val;
-    signed char old_exp_flags;
-
-    old_exp_flags = get_float_exception_flags(&env->fp_status);
-    set_float_exception_flags(0, &env->fp_status);
 
     val = floatx80_to_int64(ST0, &env->fp_status);
     if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
         val = 0x8000000000000000ULL;
     }
-    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
-                                | old_exp_flags, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
 int32_t helper_fistt_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int32_t val;
 
     val = floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
     if (val != (int16_t)val) {
+        set_float_exception_flags(float_flag_invalid, &env->fp_status);
         val = -32768;
     }
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
 int32_t helper_fisttl_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int32_t val;
-    signed char old_exp_flags;
-
-    old_exp_flags = get_float_exception_flags(&env->fp_status);
-    set_float_exception_flags(0, &env->fp_status);
 
     val = floatx80_to_int32_round_to_zero(ST0, &env->fp_status);
     if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
         val = 0x80000000;
     }
-    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
-                                | old_exp_flags, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
 int64_t helper_fisttll_ST0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int64_t val;
-    signed char old_exp_flags;
-
-    old_exp_flags = get_float_exception_flags(&env->fp_status);
-    set_float_exception_flags(0, &env->fp_status);
 
     val = floatx80_to_int64_round_to_zero(ST0, &env->fp_status);
     if (get_float_exception_flags(&env->fp_status) & float_flag_invalid) {
         val = 0x8000000000000000ULL;
     }
-    set_float_exception_flags(get_float_exception_flags(&env->fp_status)
-                                | old_exp_flags, &env->fp_status);
+    merge_exception_flags(env, old_flags);
     return val;
 }
 
@@ -449,24 +471,29 @@ static const int fcom_ccval[4] = {0x0100, 0x4000, 0x0000, 0x4500};
 
 void helper_fcom_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fucom_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    merge_exception_flags(env, old_flags);
 }
 
 static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int eflags;
     int ret;
 
@@ -474,10 +501,12 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     eflags = cpu_cc_compute_all(env, CC_OP);
     eflags = (eflags & ~(CC_Z | CC_P | CC_C)) | fcomi_ccval[ret + 1];
     CC_SRC = eflags;
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int eflags;
     int ret;
 
@@ -485,26 +514,35 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     eflags = cpu_cc_compute_all(env, CC_OP);
     eflags = (eflags & ~(CC_Z | CC_P | CC_C)) | fcomi_ccval[ret + 1];
     CC_SRC = eflags;
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fadd_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST0 = floatx80_add(ST0, FT0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fmul_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST0 = floatx80_mul(ST0, FT0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsub_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(ST0, FT0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsubr_ST0_FT0(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(FT0, ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fdiv_ST0_FT0(CPUX86State *env)
@@ -521,22 +559,30 @@ void helper_fdivr_ST0_FT0(CPUX86State *env)
 
 void helper_fadd_STN_ST0(CPUX86State *env, int st_index)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_add(ST(st_index), ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fmul_STN_ST0(CPUX86State *env, int st_index)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_mul(ST(st_index), ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsub_STN_ST0(CPUX86State *env, int st_index)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST(st_index), ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsubr_STN_ST0(CPUX86State *env, int st_index)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST0, ST(st_index), &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fdiv_STN_ST0(CPUX86State *env, int st_index)
@@ -747,6 +793,7 @@ void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
 
 void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
 {
+    uint8_t old_flags = save_exception_flags(env);
     int v;
     target_ulong mem_ref, mem_end;
     int64_t val;
@@ -757,13 +804,14 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     val = floatx80_to_int64(ST0, &env->fp_status);
     mem_ref = ptr;
     if (val >= 1000000000000000000LL || val <= -1000000000000000000LL) {
-        float_raise(float_flag_invalid, &env->fp_status);
+        set_float_exception_flags(float_flag_invalid, &env->fp_status);
         while (mem_ref < ptr + 7) {
             cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
         }
         cpu_stb_data_ra(env, mem_ref++, 0xc0, GETPC());
         cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
         cpu_stb_data_ra(env, mem_ref++, 0xff, GETPC());
+        merge_exception_flags(env, old_flags);
         return;
     }
     mem_end = mem_ref + 9;
@@ -785,6 +833,7 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
     while (mem_ref < mem_end) {
         cpu_stb_data_ra(env, mem_ref++, 0, GETPC());
     }
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_f2xm1(CPUX86State *env)
@@ -838,6 +887,7 @@ void helper_fpatan(CPUX86State *env)
 
 void helper_fxtract(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     CPU_LDoubleU temp;
 
     temp.d = ST0;
@@ -881,6 +931,7 @@ void helper_fxtract(CPUX86State *env)
         BIASEXPONENT(temp);
         ST0 = temp.d;
     }
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fprem1(CPUX86State *env)
@@ -1020,11 +1071,13 @@ void helper_fyl2xp1(CPUX86State *env)
 
 void helper_fsqrt(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     if (floatx80_is_neg(ST0)) {
         env->fpus &= ~0x4700;  /* (C3,C2,C1,C0) <-- 0000 */
         env->fpus |= 0x400;
     }
     ST0 = floatx80_sqrt(ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsincos(CPUX86State *env)
@@ -1044,15 +1097,21 @@ void helper_fsincos(CPUX86State *env)
 
 void helper_frndint(CPUX86State *env)
 {
+    uint8_t old_flags = save_exception_flags(env);
     ST0 = floatx80_round_to_int(ST0, &env->fp_status);
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fscale(CPUX86State *env)
 {
-    if (floatx80_invalid_encoding(ST1)) {
+    uint8_t old_flags = save_exception_flags(env);
+    if (floatx80_invalid_encoding(ST1) || floatx80_invalid_encoding(ST0)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST1)) {
+        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+            float_raise(float_flag_invalid, &env->fp_status);
+        }
         ST0 = ST1;
         if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
             float_raise(float_flag_invalid, &env->fp_status);
@@ -1081,12 +1140,17 @@ void helper_fscale(CPUX86State *env)
             }
         }
     } else {
-        int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
+        int n;
         signed char save = env->fp_status.floatx80_rounding_precision;
+        uint8_t save_flags = get_float_exception_flags(&env->fp_status);
+        set_float_exception_flags(0, &env->fp_status);
+        n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
+        set_float_exception_flags(save_flags, &env->fp_status);
         env->fp_status.floatx80_rounding_precision = 80;
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
         env->fp_status.floatx80_rounding_precision = save;
     }
+    merge_exception_flags(env, old_flags);
 }
 
 void helper_fsin(CPUX86State *env)
diff --git a/tests/tcg/i386/test-i386-fp-exceptions.c b/tests/tcg/i386/test-i386-fp-exceptions.c
new file mode 100644
index 0000000000..dfb7117c17
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fp-exceptions.c
@@ -0,0 +1,831 @@
+/* Test floating-point exceptions.  */
+
+#include <float.h>
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile float f_res;
+volatile double d_res;
+volatile long double ld_res;
+volatile long double ld_res2;
+
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile float f_snan = __builtin_nansf("");
+volatile double d_snan = __builtin_nans("");
+volatile long double ld_third = 1.0L / 3.0L;
+volatile long double ld_snan = __builtin_nansl("");
+volatile long double ld_nan = __builtin_nanl("");
+volatile long double ld_inf = __builtin_infl();
+volatile long double ld_ninf = -__builtin_infl();
+volatile long double ld_one = 1.0L;
+volatile long double ld_zero = 0.0L;
+volatile long double ld_nzero = -0.0L;
+volatile long double ld_min = LDBL_MIN;
+volatile long double ld_max = LDBL_MAX;
+volatile long double ld_nmax = -LDBL_MAX;
+
+#define IE (1 << 0)
+#define ZE (1 << 2)
+#define OE (1 << 3)
+#define UE (1 << 4)
+#define PE (1 << 5)
+#define EXC (IE | ZE | OE | UE | PE)
+
+int main(void)
+{
+    short sw;
+    unsigned char out[10];
+    int ret = 0;
+    int16_t res_16;
+    int32_t res_32;
+    int64_t res_64;
+
+    __asm__ volatile ("fnclex");
+    ld_res = f_snan;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: widen float snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = d_snan;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: widen double snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    f_res = ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (UE | PE)) {
+        printf("FAIL: narrow float underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    d_res = ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (UE | PE)) {
+        printf("FAIL: narrow double underflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    f_res = ld_max;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: narrow float overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    d_res = ld_max;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: narrow double overflow\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    f_res = ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: narrow float inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    d_res = ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: narrow double inexact\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    f_res = ld_snan;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: narrow float snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    d_res = ld_snan;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: narrow double snan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    f_res = ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: narrow float invalid\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    d_res = ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: narrow double invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("frndint" : "=t" (ld_res) : "0" (ld_min));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: frndint min\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("frndint" : "=t" (ld_res) : "0" (ld_snan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: frndint snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("frndint" : "=t" (ld_res) : "0" (ld_invalid_1.ld));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: frndint invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fcom" : : "t" (ld_nan), "u" (ld_zero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fcom nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fucom" : : "t" (ld_nan), "u" (ld_zero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: fucom nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fucom" : : "t" (ld_snan), "u" (ld_zero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fucom snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fucom" : : "t" (1.0L), "u" (ld_invalid_1.ld));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fucom invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max + ld_max;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: add overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max + ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: add inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_inf + ld_ninf;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: add inf -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_snan + ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: add snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_third + ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: add invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max - ld_nmax;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: sub overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max - ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: sub inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_inf - ld_inf;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: sub inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_snan - ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: sub snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_third - ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: sub invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max * ld_max;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: mul overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_third * ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: mul inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_min * ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (UE | PE)) {
+        printf("FAIL: mul underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_inf * ld_zero;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: mul inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_snan * ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: mul snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_third * ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: mul invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    ld_res = ld_max / ld_min;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: div overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_one / ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: div inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_min / ld_max;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (UE | PE)) {
+        printf("FAIL: div underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_one / ld_zero;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != ZE) {
+        printf("FAIL: div 1 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_inf / ld_zero;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: div inf 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_nan / ld_zero;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: div nan 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_zero / ld_zero;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: div 0 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_inf / ld_inf;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: div inf inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_snan / ld_third;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: div snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    ld_res = ld_third / ld_invalid_1.ld;
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: div invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_max));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fsqrt inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_nmax));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fsqrt -max\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_ninf));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fsqrt -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_snan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fsqrt snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_invalid_1.ld));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fsqrt invalid\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (ld_nzero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: fsqrt -0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fsqrt" : "=t" (ld_res) : "0" (-__builtin_nanl("")));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: fsqrt -nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistp %0" : "=m" (res_16) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fistp inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistp %0" : "=m" (res_16) : "t" (32767.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistp 32767.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistp %0" : "=m" (res_16) : "t" (-32768.51L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistp -32768.51\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistp %0" : "=m" (res_16) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistp nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistp %0" : "=m" (res_16) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistp invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpl %0" : "=m" (res_32) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fistpl inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpl %0" : "=m" (res_32) : "t" (2147483647.5L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpl 2147483647.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpl %0" : "=m" (res_32) : "t" (-2147483648.51L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpl -2147483648.51\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpl %0" : "=m" (res_32) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpl nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpl %0" : "=m" (res_32) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpl invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpll %0" : "=m" (res_64) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fistpll inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpll %0" : "=m" (res_64) : "t" (0x1p63) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpll 0x1p63\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpll %0" : "=m" (res_64) : "t" (-0x1.1p63L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpll -0x1.1p63\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpll %0" : "=m" (res_64) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpll nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fistpll %0" : "=m" (res_64) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fistpll invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fisttp inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (32768.0L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp 32768\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (32768.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp 32768.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (-32769.0L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp -32769\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (-32769.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp -32769.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttp %0" : "=m" (res_16) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttp invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fisttpl inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (2147483648.0L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpl 2147483648\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (-2147483649.0L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpl -2147483649\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpl nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpl %0" : "=m" (res_32) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpl invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (1.5L) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fisttpll inexact\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (0x1p63) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpll 0x1p63\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (-0x1.1p63L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpll -0x1.1p63\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpll nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fisttpll %0" : "=m" (res_64) : "t" (ld_invalid_1.ld) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fisttpll invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_zero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != ZE) {
+        printf("FAIL: fxtract 0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_nzero));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != ZE) {
+        printf("FAIL: fxtract -0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_inf));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: fxtract inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_nan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != 0) {
+        printf("FAIL: fxtract nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_snan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fxtract snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fxtract" : "=t" (ld_res), "=u" (ld_res2) :
+                      "0" (ld_invalid_1.ld));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fxtract invalid\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_min), "u" (ld_max));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (OE | PE)) {
+        printf("FAIL: fscale overflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_max), "u" (ld_nmax));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != (UE | PE)) {
+        printf("FAIL: fscale underflow\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_zero), "u" (ld_inf));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale 0 inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_inf), "u" (ld_ninf));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale inf -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_one), "u" (ld_snan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale 1 snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) : "0" (ld_snan), "u" (ld_nan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale snan nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (ld_invalid_1.ld), "u" (ld_one));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (ld_invalid_1.ld), "u" (ld_nan));
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fscale invalid nan\n");
+        ret = 1;
+    }
+
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (1.5L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != PE) {
+        printf("FAIL: fbstp 1.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (999999999999999999.5L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp 999999999999999999.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (-1000000000000000000.0L) :
+                      "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp -1000000000000000000\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_inf) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_nan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp nan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_snan) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fnclex");
+    __asm__ volatile ("fbstp %0" : "=m" (out) : "t" (ld_invalid_1.ld) : "st");
+    __asm__ volatile ("fnstsw" : "=a" (sw));
+    if ((sw & EXC) != IE) {
+        printf("FAIL: fbstp invalid\n");
+        ret = 1;
+    }
+
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

