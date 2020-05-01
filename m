Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E7C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDDD20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiYlhR3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDDD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUdmJ-00053W-I0
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 18:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUdk0-0003vg-VH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUdjz-0001aj-0w
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:02:40 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:39330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUdjy-0001Yd-JP; Fri, 01 May 2020 18:02:38 -0400
Received: by mail-lj1-x22b.google.com with SMTP id u6so3900940ljl.6;
 Fri, 01 May 2020 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=wy6xZB++LNt6W8wBF1VNwBrTbJzjanJEFlhrP6z/tZk=;
 b=AiYlhR3HF+91RQ9DNyZt511BkiUpDIecrOBx4yR+AUN80bzqZt+E3hryndvtT7LA+W
 rMd+eD/rr+DjmPhbgZWX118mPX50tctk/P4hwYTW20CXQFbhml+tUOCubjUFRZfQ0GVN
 3CEblePutstvoVj31xjnX0bN7Qbzse17CUfOZMuJ1MomkDCIOaIWoaERNJhM0E7UJjo6
 UDFgL54EzPPN3cAP5KKmuBx/D1bW6UoHyRBudJWOp8GaK0X4PvVJ9uZSmW4AVbpEwRTH
 yfW1U62FYnGHcU5JM6IZGknWZBYey+0sL7muM45wlNIdx4Iv5HSG3bzHIW00Qou7JPtA
 tdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=wy6xZB++LNt6W8wBF1VNwBrTbJzjanJEFlhrP6z/tZk=;
 b=XIAdCoh2UTNOSbNaoqBz0VZ2VCjFEiUbvIzPpJQR1wGTvKuT7U01KWtWR0nWc84vMK
 C10Vl+YV1PU10zRZISRU2y1zXbYDQkFkla1HcFJduEJ5skhePYAEdVZysI0C3bDAVh0M
 6kTsz4UEaT0kSl4LQgXfne0nTvZyIm9mtk48kvgKpaZcGiJOfm4F8c11utTqeF0t+tuy
 pPlzddPcmnaPzLBjpeE6bEojmE6IGtO0+LrNhmaSOtBnKX357TYYii1Lj6pd3zSIQrpi
 91hqjgHNQiESkJnnpvvYHftJeqm8nmM6wE/kSG9wKVWIsaRqZYHoqvS3nEzYNHjH3nIQ
 5OCg==
X-Gm-Message-State: AGi0PubhdpfBCBEv70JmbWt5qrUnH4uKbCdDfIDnUB2IiQSofc5ScF+V
 YRMa19aVuZe6PcqxboqyEjxzXeTCkjpGt4+QeAg=
X-Google-Smtp-Source: APiQypJfh1UhIn18QTC545mihsQiDfiLCOTd6gE2HEMrcMagRkdp4O9hVZ6NO5RQ9KF/UPqaBMZJ9ZQWYZmo+SiKDVM=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr3604649ljg.27.1588370555960; 
 Fri, 01 May 2020 15:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
In-Reply-To: <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 06:02:24 +0800
Message-ID: <CAE2XoE_-US9a_v7VJ=ze+=ojf8_aV=xLNfn1zo3qj6Hj-T8BmA@mail.gmail.com>
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c281c405a49d56b1"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22b
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c281c405a49d56b1
Content-Type: text/plain; charset="UTF-8"

From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 05:59:25 +0800
Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminate
 helper_reset_fpstatus(). I've mentioned this before, that it's possible to
 leave the steady-state of env->fp_status.exception_flags == 0, so there's
no
 need for a separate function call.  I suspect this is worth a decent
speedup
 by itself.

---
 target/ppc/fpu_helper.c            | 53 ++----------------------------
 target/ppc/helper.h                |  1 -
 target/ppc/translate/fp-impl.inc.c | 23 -------------
 3 files changed, 3 insertions(+), 74 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d9a8773ee1..4fc5a7ff1c 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env,
uintptr_t raddr)
                                    env->error_code, raddr);
         }
     }
+    if (status) {
+        set_float_exception_flags(0, &env->fp_status);
+    }
 }

 void helper_float_check_status(CPUPPCState *env)
@@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)
     do_float_check_status(env, GETPC());
 }

-void helper_reset_fpstatus(CPUPPCState *env)
-{
-    set_float_exception_flags(0, &env->fp_status);
-}
-
 static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
                                     uintptr_t retaddr, int classes)
 {
@@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,
                       \
 {
   \
     ppc_vsr_t t = *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i = 0; i < nels; i++) {
  \
         float_status tstat = env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
     ppc_vsr_t t = *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
@@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                       \
 {
   \
     ppc_vsr_t t = *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i = 0; i < nels; i++) {
  \
         float_status tstat = env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
opcode,
     ppc_vsr_t t = *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
     }

-    set_float_exception_flags(0, &tstat);
     t.f128 = float128_mul(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;

@@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                        \
 {
    \
     ppc_vsr_t t = *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i = 0; i < nels; i++) {
   \
         float_status tstat = env->fp_status;
   \
         set_float_exception_flags(0, &tstat);
    \
@@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
     ppc_vsr_t t = *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
@@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)              \
 {
    \
     ppc_vsr_t t = *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i = 0; i < nels; i++) {
   \
         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {
   \
             float_invalid_op_vxsnan(env, GETPC());
   \
@@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)             \
 {
   \
     ppc_vsr_t t = *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i = 0; i < nels; i++) {
  \
         float_status tstat = env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)             \
 {
   \
     ppc_vsr_t t = *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i = 0; i < nels; i++) {
  \
         float_status tstat = env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                        \
 {
    \
     ppc_vsr_t t = *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i = 0; i < nels; i++) {
   \
         float_status tstat = env->fp_status;
   \
         set_float_exception_flags(0, &tstat);
    \
@@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
                   \
 {                                                                        \
     uint32_t cc = 0;                                                     \
     bool vxsnan_flag = false, vxvc_flag = false;                         \
-                                                                         \
-    helper_reset_fpstatus(env);                                          \
-                                                                         \
     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||        \
         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {        \
         vxsnan_flag = true;                                              \
@@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
                  \
 {                                                                       \
     uint32_t cc = 0;                                                    \
     bool vxsnan_flag = false, vxvc_flag = false;                        \
-                                                                        \
-    helper_reset_fpstatus(env);                                         \
-                                                                        \
     if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||         \
         float128_is_signaling_nan(xb->f128, &env->fp_status)) {         \
         vxsnan_flag = true;                                             \
@@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t
xb)
 {
     uint64_t result, sign, exp, frac;

-    float_status tstat = env->fp_status;
-    set_float_exception_flags(0, &tstat);
-
     sign = extract64(xb, 63,  1);
     exp  = extract64(xb, 52, 11);
     frac = extract64(xb,  0, 52) | 0x10000000000000ULL;
@@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),
float_round_to_zero, 0)

 uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
 {
-    helper_reset_fpstatus(env);
-
     uint64_t xt = helper_frsp(env, xb);

     helper_compute_fprf_float64(env, xt);
@@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
     uint8_t rmode = 0;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     if (r == 0 && rmc == 0) {
         rmode = float_round_ties_away;
     } else if (r == 0 && rmc == 0x3) {
@@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
     floatx80 round_res;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     if (r == 0 && rmc == 0) {
         rmode = float_round_ties_away;
     } else if (r == 0 && rmc == 0x3) {
@@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
opcode,
     ppc_vsr_t t = { };
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
@@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
     ppc_vsr_t t = *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         tstat.float_rounding_mode = float_round_to_odd;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 4e192de97b..b486c9991f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)

 DEF_HELPER_1(float_check_status, void, env)
-DEF_HELPER_1(reset_fpstatus, void, env)
 DEF_HELPER_2(compute_fprf_float64, void, env, i64)
 DEF_HELPER_3(store_fpscr, void, env, i64, i32)
 DEF_HELPER_2(fpscr_clrbit, void, env, i32)
diff --git a/target/ppc/translate/fp-impl.inc.c
b/target/ppc/translate/fp-impl.inc.c
index e18e268fe5..5e8cd9970e 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -4,11 +4,6 @@
  * Standard FPU translation
  */

-static inline void gen_reset_fpstatus(void)
-{
-    gen_helper_reset_fpstatus(cpu_env);
-}
-
 static inline void gen_compute_fprf_float64(TCGv_i64 arg)
 {
     gen_helper_compute_fprf_float64(cpu_env, arg);
@@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)
                     \
     t3 = tcg_temp_new_i64();
   \
     /* NIP cannot be restored if the memory exception comes from an helper
*/ \
     gen_update_nip(ctx, ctx->base.pc_next - 4);
    \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rC(ctx->opcode));
    \
     get_fpr(t2, rB(ctx->opcode));
    \
@@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)
                     \
     t2 = tcg_temp_new_i64();
   \
     /* NIP cannot be restored if the memory exception comes from an helper
*/ \
     gen_update_nip(ctx, ctx->base.pc_next - 4);
    \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rB(ctx->opcode));
    \
     gen_helper_f##op(t2, cpu_env, t0, t1);
   \
@@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     t0 = tcg_temp_new_i64();
   \
     t1 = tcg_temp_new_i64();
   \
     t2 = tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rC(ctx->opcode));
    \
     gen_helper_f##op(t2, cpu_env, t0, t1);
   \
@@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     }
    \
     t0 = tcg_temp_new_i64();
   \
     t1 = tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rB(ctx->opcode));
    \
     gen_helper_f##name(t1, cpu_env, t0);
   \
     set_fpr(rD(ctx->opcode), t1);
    \
@@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     }
    \
     t0 = tcg_temp_new_i64();
   \
     t1 = tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rB(ctx->opcode));
    \
     gen_helper_f##name(t1, cpu_env, t0);
   \
     set_fpr(rD(ctx->opcode), t1);
    \
@@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)
     }
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_frsqrte(t1, cpu_env, t0);
     gen_helper_frsp(t1, cpu_env, t1);
@@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)
     }
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_fsqrt(t1, cpu_env, t0);
     set_fpr(rD(ctx->opcode), t1);
@@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)
     }
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_fsqrt(t1, cpu_env, t0);
     gen_helper_frsp(t1, cpu_env, t1);
@@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)
     }
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     crf = tcg_const_i32(crfD(ctx->opcode));
     get_fpr(t0, rA(ctx->opcode));
     get_fpr(t1, rB(ctx->opcode));
@@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)
     }
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     crf = tcg_const_i32(crfD(ctx->opcode));
     get_fpr(t0, rA(ctx->opcode));
     get_fpr(t1, rB(ctx->opcode));
@@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)
         return;
     }
     t0 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     set_fpr(rD(ctx->opcode), t0);
     if (unlikely(Rc(ctx->opcode))) {
@@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)
         return;
     }
     t0 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     /* Mask everything except mode, status, and enables.  */
     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
@@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)

     t0 = tcg_temp_new_i64();

-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     set_fpr(rD(ctx->opcode), t0);

@@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,
TCGv_i64 t1)
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i32 mask = tcg_const_i32(0x0001);

-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
     set_fpr(rD(ctx->opcode), t0);
@@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)
         return;
     }
     crb = 31 - crbD(ctx->opcode);
-    gen_reset_fpstatus();
     if (likely(crb != FPSCR_FEX && crb != FPSCR_VX)) {
         TCGv_i32 t0;
         t0 = tcg_const_i32(crb);
@@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)
         return;
     }
     crb = 31 - crbD(ctx->opcode);
-    gen_reset_fpstatus();
     /* XXX: we pretend we can only do IEEE floating-point computations */
     if (likely(crb != FPSCR_FEX && crb != FPSCR_VX && crb != FPSCR_NI)) {
         TCGv_i32 t0;
@@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
-    gen_reset_fpstatus();
     if (l) {
         t0 = tcg_const_i32((ctx->insns_flags2 & PPC2_ISA205) ? 0xffff :
0xff);
     } else {
@@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)
         return;
     }
     sh = (8 * w) + 7 - bf;
-    gen_reset_fpstatus();
     t0 = tcg_const_i64(((uint64_t)FPIMM(ctx->opcode)) << (4 * sh));
     t1 = tcg_const_i32(1 << sh);
     gen_helper_store_fpscr(cpu_env, t0, t1);
-- 
2.23.0.windows.1

--000000000000c281c405a49d56b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+RnJvbSBiNGQ2Y2ExZDYzNzZmYWIxZjFiZTA2
ZWI0NzJlMTBiOTA4ODg3YzJiIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMTxicj5Gcm9tOiBZb25n
Z2FuZyBMdW8gJmx0OzxhIGhyZWY9Im1haWx0bzpsdW95b25nZ2FuZ0BnbWFpbC5jb20iPmx1b3lv
bmdnYW5nQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPkRhdGU6IFNhdCwgMiBNYXkgMjAyMCAwNTo1OToy
NSArMDgwMDxicj5TdWJqZWN0OiBbUEFUQ0hdIFtwcGMgZnBdIFN0ZXAgMS4gUmVhcnJhbmdlIHRo
ZSBmcCBoZWxwZXJzIHRvIGVsaW1pbmF0ZTxicj7CoGhlbHBlcl9yZXNldF9mcHN0YXR1cygpLiBJ
JiMzOTt2ZSBtZW50aW9uZWQgdGhpcyBiZWZvcmUsIHRoYXQgaXQmIzM5O3MgcG9zc2libGUgdG88
YnI+wqBsZWF2ZSB0aGUgc3RlYWR5LXN0YXRlIG9mIGVudi0mZ3Q7ZnBfc3RhdHVzLmV4Y2VwdGlv
bl9mbGFncyA9PSAwLCBzbyB0aGVyZSYjMzk7cyBubzxicj7CoG5lZWQgZm9yIGEgc2VwYXJhdGUg
ZnVuY3Rpb24gY2FsbC7CoCBJIHN1c3BlY3QgdGhpcyBpcyB3b3J0aCBhIGRlY2VudCBzcGVlZHVw
PGJyPsKgYnkgaXRzZWxmLjxicj48YnI+LS0tPGJyPsKgdGFyZ2V0L3BwYy9mcHVfaGVscGVyLmMg
wqAgwqAgwqAgwqAgwqAgwqB8IDUzICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj7C
oHRhcmdldC9wcGMvaGVscGVyLmggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgMSAtPGJyPsKg
dGFyZ2V0L3BwYy90cmFuc2xhdGUvZnAtaW1wbC5pbmMuYyB8IDIzIC0tLS0tLS0tLS0tLS08YnI+
wqAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNzQgZGVsZXRpb25zKC0pPGJyPjxi
cj5kaWZmIC0tZ2l0IGEvdGFyZ2V0L3BwYy9mcHVfaGVscGVyLmMgYi90YXJnZXQvcHBjL2ZwdV9o
ZWxwZXIuYzxicj5pbmRleCBkOWE4NzczZWUxLi40ZmM1YTdmZjFjIDEwMDY0NDxicj4tLS0gYS90
YXJnZXQvcHBjL2ZwdV9oZWxwZXIuYzxicj4rKysgYi90YXJnZXQvcHBjL2ZwdV9oZWxwZXIuYzxi
cj5AQCAtODIxLDYgKzgyMSw5IEBAIHN0YXRpYyB2b2lkIGRvX2Zsb2F0X2NoZWNrX3N0YXR1cyhD
UFVQUENTdGF0ZSAqZW52LCB1aW50cHRyX3QgcmFkZHIpPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVudi0mZ3Q7ZXJyb3JfY29kZSwgcmFk
ZHIpOzxicj7CoCDCoCDCoCDCoCDCoH08YnI+wqAgwqAgwqB9PGJyPisgwqAgwqBpZiAoc3RhdHVz
KSB7PGJyPisgwqAgwqAgwqAgwqBzZXRfZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7ZW52
LSZndDtmcF9zdGF0dXMpOzxicj4rIMKgIMKgfTxicj7CoH08YnI+wqA8YnI+wqB2b2lkIGhlbHBl
cl9mbG9hdF9jaGVja19zdGF0dXMoQ1BVUFBDU3RhdGUgKmVudik8YnI+QEAgLTgyOCwxMSArODMx
LDYgQEAgdm9pZCBoZWxwZXJfZmxvYXRfY2hlY2tfc3RhdHVzKENQVVBQQ1N0YXRlICplbnYpPGJy
PsKgIMKgIMKgZG9fZmxvYXRfY2hlY2tfc3RhdHVzKGVudiwgR0VUUEMoKSk7PGJyPsKgfTxicj7C
oDxicj4tdm9pZCBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoQ1BVUFBDU3RhdGUgKmVudik8YnI+LXs8
YnI+LSDCoCDCoHNldF9mbG9hdF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDtlbnYtJmd0O2ZwX3N0
YXR1cyk7PGJyPi19PGJyPi08YnI+wqBzdGF0aWMgdm9pZCBmbG9hdF9pbnZhbGlkX29wX2FkZHN1
YihDUFVQUENTdGF0ZSAqZW52LCBib29sIHNldF9mcGNjLDxicj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnRwdHJfdCByZXRhZGRyLCBp
bnQgY2xhc3Nlcyk8YnI+wqB7PGJyPkBAIC0yMTEwLDkgKzIxMDgsNiBAQCB2b2lkIGhlbHBlcl8j
I25hbWUoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90ICp4dCwgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4
dDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGludCBpOyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgaGVscGVy
X3Jlc2V0X2Zwc3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBmb3Ig
KGkgPSAwOyBpICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqBm
bG9hdF9zdGF0dXMgdHN0YXQgPSBlbnYtJmd0O2ZwX3N0YXR1czsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9mbG9h
dF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjE1Miw4ICsyMTQ3LDYgQEAgdm9pZCBo
ZWxwZXJfeHNhZGRxcChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJfdCBvcGNvZGUsPGJyPsKgIMKg
IMKgcHBjX3Zzcl90IHQgPSAqeHQ7PGJyPsKgIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0Ozxicj7C
oDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7PGJyPi08YnI+wqAgwqAgwqB0
c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj7CoCDCoCDCoGlmICh1bmxpa2VseShSYyhvcGNv
ZGUpICE9IDApKSB7PGJyPsKgIMKgIMKgIMKgIMKgdHN0YXQuZmxvYXRfcm91bmRpbmdfbW9kZSA9
IGZsb2F0X3JvdW5kX3RvX29kZDs8YnI+QEAgLTIxODksOSArMjE4Miw2IEBAIHZvaWQgaGVscGVy
XyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90ICp4dCwgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9
ICp4dDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGludCBpOyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgaGVs
cGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBm
b3IgKGkgPSAwOyBpICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAg
wqBmbG9hdF9zdGF0dXMgdHN0YXQgPSBlbnYtJmd0O2ZwX3N0YXR1czsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9m
bG9hdF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjIyOCwxMyArMjIxOCwxMSBAQCB2
b2lkIGhlbHBlcl94c211bHFwKENQVVBQQ1N0YXRlICplbnYsIHVpbnQzMl90IG9wY29kZSw8YnI+
wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDs8YnI+wqAgwqAgwqBmbG9hdF9zdGF0dXMgdHN0YXQ7
PGJyPsKgPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTs8YnI+wqAgwqAgwqB0
c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj7CoCDCoCDCoGlmICh1bmxpa2VseShSYyhvcGNv
ZGUpICE9IDApKSB7PGJyPsKgIMKgIMKgIMKgIMKgdHN0YXQuZmxvYXRfcm91bmRpbmdfbW9kZSA9
IGZsb2F0X3JvdW5kX3RvX29kZDs8YnI+wqAgwqAgwqB9PGJyPsKgPGJyPi0gwqAgwqBzZXRfZmxv
YXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7dHN0YXQpOzxicj7CoCDCoCDCoHQuZjEyOCA9IGZs
b2F0MTI4X211bCh4YS0mZ3Q7ZjEyOCwgeGItJmd0O2YxMjgsICZhbXA7dHN0YXQpOzxicj7CoCDC
oCDCoGVudi0mZ3Q7ZnBfc3RhdHVzLmZsb2F0X2V4Y2VwdGlvbl9mbGFncyB8PSB0c3RhdC5mbG9h
dF9leGNlcHRpb25fZmxhZ3M7PGJyPsKgPGJyPkBAIC0yMjYzLDkgKzIyNTEsNiBAQCB2b2lkIGhl
bHBlcl8jI29wKENQVVBQQ1N0YXRlICplbnYsIHBwY192c3JfdCAqeHQsIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBwcGNfdnNy
X3QgdCA9ICp4dDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgaW50IGk7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+wqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj7CoCDCoCDCoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVz
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
wqAgwqAgwqAgwqAgwqBzZXRfZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7dHN0YXQpOyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPkBAIC0y
MzA1LDcgKzIyOTAsNiBAQCB2b2lkIGhlbHBlcl94c2RpdnFwKENQVVBQQ1N0YXRlICplbnYsIHVp
bnQzMl90IG9wY29kZSw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDs8YnI+wqAgwqAgwqBm
bG9hdF9zdGF0dXMgdHN0YXQ7PGJyPsKgPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMo
ZW52KTs8YnI+wqAgwqAgwqB0c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj7CoCDCoCDCoGlm
ICh1bmxpa2VseShSYyhvcGNvZGUpICE9IDApKSB7PGJyPsKgIMKgIMKgIMKgIMKgdHN0YXQuZmxv
YXRfcm91bmRpbmdfbW9kZSA9IGZsb2F0X3JvdW5kX3RvX29kZDs8YnI+QEAgLTIzNDIsOSArMjMy
Niw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90ICp4dCwg
cHBjX3Zzcl90ICp4YikgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgeyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKg
cHBjX3Zzcl90IHQgPSAqeHQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDC
oGludCBpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPsKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG5lbHM7IGkrKykgeyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+wqAgwqAgwqAgwqAgwqBpZiAodW5saWtlbHkodHAjI19pc19zaWduYWxpbmdf
bmFuKHhiLSZndDtmbGQsICZhbXA7ZW52LSZndDtmcF9zdGF0dXMpKSkgeyDCoCDCoCDCoFw8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqBmbG9hdF9pbnZhbGlkX29wX3Z4c25hbihlbnYsIEdFVFBDKCkp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTIzODIs
OSArMjM2Myw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90
ICp4dCwgcHBjX3Zzcl90ICp4YikgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoHsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKg
IMKgcHBjX3Zzcl90IHQgPSAqeHQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAg
wqBpbnQgaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4t
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPsKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG5lbHM7IGkrKykgeyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPsKgIMKgIMKgIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAg
wqAgwqAgwqAgwqBzZXRfZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7dHN0YXQpOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTI0MzAs
OSArMjQwOCw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90
ICp4dCwgcHBjX3Zzcl90ICp4YikgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoHsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKg
IMKgcHBjX3Zzcl90IHQgPSAqeHQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAg
wqBpbnQgaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4t
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPsKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG5lbHM7IGkrKykgeyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPsKgIMKgIMKgIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAg
wqAgwqAgwqAgwqBzZXRfZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7dHN0YXQpOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTI1OTIs
OSArMjU2Nyw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgcHBjX3Zzcl90
ICp4dCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoHsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj7CoCDCoCDCoHBwY192c3JfdCB0ID0gKnh0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+wqAgwqAgwqBpbnQgaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBuZWxz
OyBpKyspIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0
ID0gZW52LSZndDtmcF9zdGF0dXM7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9mbG9hdF9leGNlcHRpb25fZmxh
Z3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+QEAgLTI3NjUsOSArMjczNyw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BV
UFBDU3RhdGUgKmVudiwgdWludDMyX3Qgb3Bjb2RlLCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj7CoCDCoCDCoHVpbnQzMl90IGNjID0gMDsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj7CoCDCoCDCoGJvb2wgdnhzbmFuX2ZsYWcgPSBmYWxzZSwgdnh2Y19mbGFnID0gZmFs
c2U7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+LSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqBoZWxw
ZXJfcmVzZXRfZnBzdGF0dXMoZW52KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGlmIChmbG9hdDY0X2lz
X3NpZ25hbGluZ19uYW4oeGEtJmd0O1ZzckQoMCksICZhbXA7ZW52LSZndDtmcF9zdGF0dXMpIHx8
IMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoCDCoCDCoGZsb2F0NjRfaXNfc2lnbmFsaW5nX25hbih4
Yi0mZ3Q7VnNyRCgwKSwgJmFtcDtlbnYtJmd0O2ZwX3N0YXR1cykpIHsgwqAgwqAgwqAgwqBcPGJy
PsKgIMKgIMKgIMKgIMKgdnhzbmFuX2ZsYWcgPSB0cnVlOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTI4
MTMsOSArMjc4Miw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwgdWludDMy
X3Qgb3Bjb2RlLCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgeyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgdWlu
dDMyX3QgY2MgPSAwOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBib29sIHZ4c25h
bl9mbGFnID0gZmFsc2UsIHZ4dmNfZmxhZyA9IGZhbHNlOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFw8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPsKgIMKgIMKgaWYgKGZsb2F0MTI4X2lzX3NpZ25hbGluZ19uYW4oeGEtJmd0O2YxMjgsICZh
bXA7ZW52LSZndDtmcF9zdGF0dXMpIHx8IMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqBm
bG9hdDEyOF9pc19zaWduYWxpbmdfbmFuKHhiLSZndDtmMTI4LCAmYW1wO2Vudi0mZ3Q7ZnBfc3Rh
dHVzKSkgeyDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgIMKgIMKgdnhzbmFuX2ZsYWcgPSB0cnVl
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPkBAIC0zMTc3LDkgKzMxNDMsNiBAQCB1aW50NjRfdCBoZWxwZXJfeHNj
dmRwc3BuKENQVVBQQ1N0YXRlICplbnYsIHVpbnQ2NF90IHhiKTxicj7CoHs8YnI+wqAgwqAgwqB1
aW50NjRfdCByZXN1bHQsIHNpZ24sIGV4cCwgZnJhYzs8YnI+wqA8YnI+LSDCoCDCoGZsb2F0X3N0
YXR1cyB0c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj4tIMKgIMKgc2V0X2Zsb2F0X2V4Y2Vw
dGlvbl9mbGFncygwLCAmYW1wO3RzdGF0KTs8YnI+LTxicj7CoCDCoCDCoHNpZ24gPSBleHRyYWN0
NjQoeGIsIDYzLCDCoDEpOzxicj7CoCDCoCDCoGV4cCDCoD0gZXh0cmFjdDY0KHhiLCA1MiwgMTEp
Ozxicj7CoCDCoCDCoGZyYWMgPSBleHRyYWN0NjQoeGIsIMKgMCwgNTIpIHwgMHgxMDAwMDAwMDAw
MDAwMFVMTDs8YnI+QEAgLTM0NDYsOCArMzQwOSw2IEBAIFZTWF9ST1VORCh4dnJzcGl6LCA0LCBm
bG9hdDMyLCBWc3JXKGkpLCBmbG9hdF9yb3VuZF90b196ZXJvLCAwKTxicj7CoDxicj7CoHVpbnQ2
NF90IGhlbHBlcl94c3JzcChDUFVQUENTdGF0ZSAqZW52LCB1aW50NjRfdCB4Yik8YnI+wqB7PGJy
Pi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTs8YnI+LTxicj7CoCDCoCDCoHVpbnQ2
NF90IHh0ID0gaGVscGVyX2Zyc3AoZW52LCB4Yik7PGJyPsKgPGJyPsKgIMKgIMKgaGVscGVyX2Nv
bXB1dGVfZnByZl9mbG9hdDY0KGVudiwgeHQpOzxicj5AQCAtMzU5Myw4ICszNTU0LDYgQEAgdm9p
ZCBoZWxwZXJfeHNycXBpKENQVVBQQ1N0YXRlICplbnYsIHVpbnQzMl90IG9wY29kZSw8YnI+wqAg
wqAgwqB1aW50OF90IHJtb2RlID0gMDs8YnI+wqAgwqAgwqBmbG9hdF9zdGF0dXMgdHN0YXQ7PGJy
PsKgPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTs8YnI+LTxicj7CoCDCoCDC
oGlmIChyID09IDAgJmFtcDsmYW1wOyBybWMgPT0gMCkgezxicj7CoCDCoCDCoCDCoCDCoHJtb2Rl
ID0gZmxvYXRfcm91bmRfdGllc19hd2F5Ozxicj7CoCDCoCDCoH0gZWxzZSBpZiAociA9PSAwICZh
bXA7JmFtcDsgcm1jID09IDB4Mykgezxicj5AQCAtMzY1MCw4ICszNjA5LDYgQEAgdm9pZCBoZWxw
ZXJfeHNycXB4cChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJfdCBvcGNvZGUsPGJyPsKgIMKgIMKg
ZmxvYXR4ODAgcm91bmRfcmVzOzxicj7CoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdDs8YnI+wqA8
YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOzxicj4tPGJyPsKgIMKgIMKgaWYg
KHIgPT0gMCAmYW1wOyZhbXA7IHJtYyA9PSAwKSB7PGJyPsKgIMKgIMKgIMKgIMKgcm1vZGUgPSBm
bG9hdF9yb3VuZF90aWVzX2F3YXk7PGJyPsKgIMKgIMKgfSBlbHNlIGlmIChyID09IDAgJmFtcDsm
YW1wOyBybWMgPT0gMHgzKSB7PGJyPkBAIC0zNzAwLDggKzM2NTcsNiBAQCB2b2lkIGhlbHBlcl94
c3NxcnRxcChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJfdCBvcGNvZGUsPGJyPsKgIMKgIMKgcHBj
X3Zzcl90IHQgPSB7IH07PGJyPsKgIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0Ozxicj7CoDxicj4t
IMKgIMKgaGVscGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7PGJyPi08YnI+wqAgwqAgwqB0c3RhdCA9
IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj7CoCDCoCDCoGlmICh1bmxpa2VseShSYyhvcGNvZGUpICE9
IDApKSB7PGJyPsKgIMKgIMKgIMKgIMKgdHN0YXQuZmxvYXRfcm91bmRpbmdfbW9kZSA9IGZsb2F0
X3JvdW5kX3RvX29kZDs8YnI+QEAgLTM3MzQsOCArMzY4OSw2IEBAIHZvaWQgaGVscGVyX3hzc3Vi
cXAoQ1BVUFBDU3RhdGUgKmVudiwgdWludDMyX3Qgb3Bjb2RlLDxicj7CoCDCoCDCoHBwY192c3Jf
dCB0ID0gKnh0Ozxicj7CoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdDs8YnI+wqA8YnI+LSDCoCDC
oGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOzxicj4tPGJyPsKgIMKgIMKgdHN0YXQgPSBlbnYt
Jmd0O2ZwX3N0YXR1czs8YnI+wqAgwqAgwqBpZiAodW5saWtlbHkoUmMob3Bjb2RlKSAhPSAwKSkg
ezxicj7CoCDCoCDCoCDCoCDCoHRzdGF0LmZsb2F0X3JvdW5kaW5nX21vZGUgPSBmbG9hdF9yb3Vu
ZF90b19vZGQ7PGJyPmRpZmYgLS1naXQgYS90YXJnZXQvcHBjL2hlbHBlci5oIGIvdGFyZ2V0L3Bw
Yy9oZWxwZXIuaDxicj5pbmRleCA0ZTE5MmRlOTdiLi5iNDg2Yzk5OTFmIDEwMDY0NDxicj4tLS0g
YS90YXJnZXQvcHBjL2hlbHBlci5oPGJyPisrKyBiL3RhcmdldC9wcGMvaGVscGVyLmg8YnI+QEAg
LTU4LDcgKzU4LDYgQEAgREVGX0hFTFBFUl9GTEFHU18xKGNudGx6dzMyLCBUQ0dfQ0FMTF9OT19S
V0dfU0UsIGkzMiwgaTMyKTxicj7CoERFRl9IRUxQRVJfRkxBR1NfMihicmluYywgVENHX0NBTExf
Tk9fUldHX1NFLCB0bCwgdGwsIHRsKTxicj7CoDxicj7CoERFRl9IRUxQRVJfMShmbG9hdF9jaGVj
a19zdGF0dXMsIHZvaWQsIGVudik8YnI+LURFRl9IRUxQRVJfMShyZXNldF9mcHN0YXR1cywgdm9p
ZCwgZW52KTxicj7CoERFRl9IRUxQRVJfMihjb21wdXRlX2ZwcmZfZmxvYXQ2NCwgdm9pZCwgZW52
LCBpNjQpPGJyPsKgREVGX0hFTFBFUl8zKHN0b3JlX2Zwc2NyLCB2b2lkLCBlbnYsIGk2NCwgaTMy
KTxicj7CoERFRl9IRUxQRVJfMihmcHNjcl9jbHJiaXQsIHZvaWQsIGVudiwgaTMyKTxicj5kaWZm
IC0tZ2l0IGEvdGFyZ2V0L3BwYy90cmFuc2xhdGUvZnAtaW1wbC5pbmMuYyBiL3RhcmdldC9wcGMv
dHJhbnNsYXRlL2ZwLWltcGwuaW5jLmM8YnI+aW5kZXggZTE4ZTI2OGZlNS4uNWU4Y2Q5OTcwZSAx
MDA2NDQ8YnI+LS0tIGEvdGFyZ2V0L3BwYy90cmFuc2xhdGUvZnAtaW1wbC5pbmMuYzxicj4rKysg
Yi90YXJnZXQvcHBjL3RyYW5zbGF0ZS9mcC1pbXBsLmluYy5jPGJyPkBAIC00LDExICs0LDYgQEA8
YnI+wqAgKiBTdGFuZGFyZCBGUFUgdHJhbnNsYXRpb248YnI+wqAgKi88YnI+wqA8YnI+LXN0YXRp
YyBpbmxpbmUgdm9pZCBnZW5fcmVzZXRfZnBzdGF0dXModm9pZCk8YnI+LXs8YnI+LSDCoCDCoGdl
bl9oZWxwZXJfcmVzZXRfZnBzdGF0dXMoY3B1X2Vudik7PGJyPi19PGJyPi08YnI+wqBzdGF0aWMg
aW5saW5lIHZvaWQgZ2VuX2NvbXB1dGVfZnByZl9mbG9hdDY0KFRDR3ZfaTY0IGFyZyk8YnI+wqB7
PGJyPsKgIMKgIMKgZ2VuX2hlbHBlcl9jb21wdXRlX2ZwcmZfZmxvYXQ2NChjcHVfZW52LCBhcmcp
Ozxicj5AQCAtNDgsNyArNDMsNiBAQCBzdGF0aWMgdm9pZCBnZW5fZiMjbmFtZShEaXNhc0NvbnRl
eHQgKmN0eCkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPsKgIMKgIMKgdDMgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj7CoCDCoCDCoC8qIE5JUCBjYW5ub3QgYmUgcmVzdG9yZWQgaWYgdGhlIG1lbW9yeSBl
eGNlcHRpb24gY29tZXMgZnJvbSBhbiBoZWxwZXIgKi8gXDxicj7CoCDCoCDCoGdlbl91cGRhdGVf
bmlwKGN0eCwgY3R4LSZndDtiYXNlLnBjX25leHQgLSA0KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZXRfZnByKHQwLCByQShjdHgtJmd0
O29wY29kZSkpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgZ2V0X2Zwcih0MSwgckMoY3R4LSZndDtv
cGNvZGUpKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGdldF9mcHIodDIsIHJCKGN0eC0mZ3Q7b3Bj
b2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+QEAgLTg4LDcgKzgyLDYgQEAgc3RhdGljIHZvaWQgZ2VuX2Yj
I25hbWUoRGlzYXNDb250ZXh0ICpjdHgpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoHQyID0gdGNnX3RlbXBfbmV3X2k2NCgp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqAvKiBOSVAgY2Fubm90IGJlIHJlc3RvcmVk
IGlmIHRoZSBtZW1vcnkgZXhjZXB0aW9uIGNvbWVzIGZyb20gYW4gaGVscGVyICovIFw8YnI+wqAg
wqAgwqBnZW5fdXBkYXRlX25pcChjdHgsIGN0eC0mZ3Q7YmFzZS5wY19uZXh0IC0gNCk7IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+LSDCoCDCoGdlbl9y
ZXNldF9mcHN0YXR1cygpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgZ2V0X2Zw
cih0MCwgckEoY3R4LSZndDtvcGNvZGUpKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGdldF9mcHIo
dDEsIHJCKGN0eC0mZ3Q7b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZW5faGVscGVy
X2YjI29wKHQyLCBjcHVfZW52LCB0MCwgdDEpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTEyMyw3ICsxMTYsNiBAQCBzdGF0aWMg
dm9pZCBnZW5fZiMjbmFtZShEaXNhc0NvbnRleHQgKmN0eCkgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVt
cF9uZXdfaTY0KCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoHQxID0gdGNnX3RlbXBf
bmV3X2k2NCgpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqB0MiA9IHRjZ190ZW1wX25l
d19pNjQoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMo
KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGdldF9mcHIodDAsIHJBKGN0eC0m
Z3Q7b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZXRfZnByKHQxLCByQyhjdHgtJmd0
O29wY29kZSkpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgZ2VuX2hlbHBlcl9mIyNvcCh0MiwgY3B1
X2VudiwgdDAsIHQxKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPkBAIC0xNTYsNyArMTQ4LDYgQEAgc3RhdGljIHZvaWQgZ2VuX2YjI25h
bWUoRGlzYXNDb250ZXh0ICpjdHgpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3
X2k2NCgpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqB0MSA9IHRjZ190ZW1wX25ld19p
NjQoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGdldF9mcHIodDAsIHJCKGN0eC0mZ3Q7
b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZW5faGVscGVyX2YjI25hbWUodDEsIGNw
dV9lbnYsIHQwKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgc2V0X2ZwcihyRChjdHgtJmd0O29wY29kZSksIHQxKTsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj5AQCAtMTgxLDcgKzE3Miw2IEBAIHN0YXRpYyB2b2lkIGdlbl9mIyNuYW1l
KERpc2FzQ29udGV4dCAqY3R4KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqB9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqB0MCA9IHRjZ190ZW1wX25ld19p
NjQoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgdDEgPSB0Y2dfdGVtcF9uZXdfaTY0
KCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZXRfZnByKHQwLCByQihjdHgtJmd0O29w
Y29kZSkpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgZ2VuX2hlbHBlcl9mIyNuYW1lKHQxLCBjcHVf
ZW52LCB0MCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj7CoCDCoCDCoHNldF9mcHIockQoY3R4LSZndDtvcGNvZGUpLCB0MSk7IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+QEAgLTIyMiw3ICsyMTIsNiBAQCBzdGF0aWMgdm9pZCBnZW5fZnJzcXJ0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpPGJyPsKgIMKgIMKgfTxicj7CoCDCoCDCoHQwID0gdGNnX3RlbXBf
bmV3X2k2NCgpOzxicj7CoCDCoCDCoHQxID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj4tIMKgIMKg
Z2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJyPsKgIMKgIMKgZ2V0X2Zwcih0MCwgckIoY3R4LSZndDtv
cGNvZGUpKTs8YnI+wqAgwqAgwqBnZW5faGVscGVyX2Zyc3FydGUodDEsIGNwdV9lbnYsIHQwKTs8
YnI+wqAgwqAgwqBnZW5faGVscGVyX2Zyc3AodDEsIGNwdV9lbnYsIHQxKTs8YnI+QEAgLTI1Miw3
ICsyNDEsNiBAQCBzdGF0aWMgdm9pZCBnZW5fZnNxcnQoRGlzYXNDb250ZXh0ICpjdHgpPGJyPsKg
IMKgIMKgfTxicj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj7CoCDCoCDCoHQx
ID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJy
PsKgIMKgIMKgZ2V0X2Zwcih0MCwgckIoY3R4LSZndDtvcGNvZGUpKTs8YnI+wqAgwqAgwqBnZW5f
aGVscGVyX2ZzcXJ0KHQxLCBjcHVfZW52LCB0MCk7PGJyPsKgIMKgIMKgc2V0X2ZwcihyRChjdHgt
Jmd0O29wY29kZSksIHQxKTs8YnI+QEAgLTI3NCw3ICsyNjIsNiBAQCBzdGF0aWMgdm9pZCBnZW5f
ZnNxcnRzKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDCoH08YnI+wqAgwqAgwqB0MCA9IHRj
Z190ZW1wX25ld19pNjQoKTs8YnI+wqAgwqAgwqB0MSA9IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+
LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygpOzxicj7CoCDCoCDCoGdldF9mcHIodDAsIHJCKGN0
eC0mZ3Q7b3Bjb2RlKSk7PGJyPsKgIMKgIMKgZ2VuX2hlbHBlcl9mc3FydCh0MSwgY3B1X2Vudiwg
dDApOzxicj7CoCDCoCDCoGdlbl9oZWxwZXJfZnJzcCh0MSwgY3B1X2VudiwgdDEpOzxicj5AQCAt
MzgwLDcgKzM2Nyw2IEBAIHN0YXRpYyB2b2lkIGdlbl9mY21wbyhEaXNhc0NvbnRleHQgKmN0eCk8
YnI+wqAgwqAgwqB9PGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPsKgIMKg
IMKgdDEgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMo
KTs8YnI+wqAgwqAgwqBjcmYgPSB0Y2dfY29uc3RfaTMyKGNyZkQoY3R4LSZndDtvcGNvZGUpKTs8
YnI+wqAgwqAgwqBnZXRfZnByKHQwLCByQShjdHgtJmd0O29wY29kZSkpOzxicj7CoCDCoCDCoGdl
dF9mcHIodDEsIHJCKGN0eC0mZ3Q7b3Bjb2RlKSk7PGJyPkBAIC00MDMsNyArMzg5LDYgQEAgc3Rh
dGljIHZvaWQgZ2VuX2ZjbXB1KERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDCoH08YnI+wqAg
wqAgwqB0MCA9IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+wqAgwqAgwqB0MSA9IHRjZ190ZW1wX25l
d19pNjQoKTs8YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygpOzxicj7CoCDCoCDCoGNyZiA9
IHRjZ19jb25zdF9pMzIoY3JmRChjdHgtJmd0O29wY29kZSkpOzxicj7CoCDCoCDCoGdldF9mcHIo
dDAsIHJBKGN0eC0mZ3Q7b3Bjb2RlKSk7PGJyPsKgIMKgIMKgZ2V0X2Zwcih0MSwgckIoY3R4LSZn
dDtvcGNvZGUpKTs8YnI+QEAgLTYxMiw3ICs1OTcsNiBAQCBzdGF0aWMgdm9pZCBnZW5fbWZmcyhE
aXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPsKgIMKgIMKgfTxi
cj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zw
c3RhdHVzKCk7PGJyPsKgIMKgIMKgdGNnX2dlbl9leHR1X3RsX2k2NCh0MCwgY3B1X2Zwc2NyKTs8
YnI+wqAgwqAgwqBzZXRfZnByKHJEKGN0eC0mZ3Q7b3Bjb2RlKSwgdDApOzxicj7CoCDCoCDCoGlm
ICh1bmxpa2VseShSYyhjdHgtJmd0O29wY29kZSkpKSB7PGJyPkBAIC02MzUsNyArNjE5LDYgQEAg
c3RhdGljIHZvaWQgZ2VuX21mZnNsKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDCoCDCoCDC
oHJldHVybjs8YnI+wqAgwqAgwqB9PGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7
PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqB0Y2dfZ2VuX2V4dHVf
dGxfaTY0KHQwLCBjcHVfZnBzY3IpOzxicj7CoCDCoCDCoC8qIE1hc2sgZXZlcnl0aGluZyBleGNl
cHQgbW9kZSwgc3RhdHVzLCBhbmQgZW5hYmxlcy4gwqAqLzxicj7CoCDCoCDCoHRjZ19nZW5fYW5k
aV9pNjQodDAsIHQwLCBGUF9EUk4gfCBGUF9TVEFUVVMgfCBGUF9FTkFCTEVTIHwgRlBfUk4pOzxi
cj5AQCAtNjYwLDcgKzY0Myw2IEBAIHN0YXRpYyB2b2lkIGdlbl9tZmZzY2UoRGlzYXNDb250ZXh0
ICpjdHgpPGJyPsKgPGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPsKgPGJy
Pi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqB0Y2dfZ2VuX2V4dHVfdGxf
aTY0KHQwLCBjcHVfZnBzY3IpOzxicj7CoCDCoCDCoHNldF9mcHIockQoY3R4LSZndDtvcGNvZGUp
LCB0MCk7PGJyPsKgPGJyPkBAIC02NzgsNyArNjYwLDYgQEAgc3RhdGljIHZvaWQgZ2VuX2hlbHBl
cl9tZmZzY3JuKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2X2k2NCB0MSk8YnI+wqAgwqAgwqBUQ0d2
X2k2NCB0MCA9IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+wqAgwqAgwqBUQ0d2X2kzMiBtYXNrID0g
dGNnX2NvbnN0X2kzMigweDAwMDEpOzxicj7CoDxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVz
KCk7PGJyPsKgIMKgIMKgdGNnX2dlbl9leHR1X3RsX2k2NCh0MCwgY3B1X2Zwc2NyKTs8YnI+wqAg
wqAgwqB0Y2dfZ2VuX2FuZGlfaTY0KHQwLCB0MCwgRlBfRFJOIHwgRlBfRU5BQkxFUyB8IEZQX1JO
KTs8YnI+wqAgwqAgwqBzZXRfZnByKHJEKGN0eC0mZ3Q7b3Bjb2RlKSwgdDApOzxicj5AQCAtNzUw
LDcgKzczMSw2IEBAIHN0YXRpYyB2b2lkIGdlbl9tdGZzYjAoRGlzYXNDb250ZXh0ICpjdHgpPGJy
PsKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj7CoCDCoCDCoH08YnI+wqAgwqAgwqBjcmIgPSAzMSAt
IGNyYkQoY3R4LSZndDtvcGNvZGUpOzxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJy
PsKgIMKgIMKgaWYgKGxpa2VseShjcmIgIT0gRlBTQ1JfRkVYICZhbXA7JmFtcDsgY3JiICE9IEZQ
U0NSX1ZYKSkgezxicj7CoCDCoCDCoCDCoCDCoFRDR3ZfaTMyIHQwOzxicj7CoCDCoCDCoCDCoCDC
oHQwID0gdGNnX2NvbnN0X2kzMihjcmIpOzxicj5AQCAtNzczLDcgKzc1Myw2IEBAIHN0YXRpYyB2
b2lkIGdlbl9tdGZzYjEoRGlzYXNDb250ZXh0ICpjdHgpPGJyPsKgIMKgIMKgIMKgIMKgcmV0dXJu
Ozxicj7CoCDCoCDCoH08YnI+wqAgwqAgwqBjcmIgPSAzMSAtIGNyYkQoY3R4LSZndDtvcGNvZGUp
Ozxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJyPsKgIMKgIMKgLyogWFhYOiB3ZSBw
cmV0ZW5kIHdlIGNhbiBvbmx5IGRvIElFRUUgZmxvYXRpbmctcG9pbnQgY29tcHV0YXRpb25zICov
PGJyPsKgIMKgIMKgaWYgKGxpa2VseShjcmIgIT0gRlBTQ1JfRkVYICZhbXA7JmFtcDsgY3JiICE9
IEZQU0NSX1ZYICZhbXA7JmFtcDsgY3JiICE9IEZQU0NSX05JKSkgezxicj7CoCDCoCDCoCDCoCDC
oFRDR3ZfaTMyIHQwOzxicj5AQCAtODA3LDcgKzc4Niw2IEBAIHN0YXRpYyB2b2lkIGdlbl9tdGZz
ZihEaXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAgwqAgwqAgwqBnZW5faW52YWxfZXhjZXB0aW9u
KGN0eCwgUE9XRVJQQ19FWENQX0lOVkFMX0lOVkFMKTs8YnI+wqAgwqAgwqAgwqAgwqByZXR1cm47
PGJyPsKgIMKgIMKgfTxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJyPsKgIMKgIMKg
aWYgKGwpIHs8YnI+wqAgwqAgwqAgwqAgwqB0MCA9IHRjZ19jb25zdF9pMzIoKGN0eC0mZ3Q7aW5z
bnNfZmxhZ3MyICZhbXA7IFBQQzJfSVNBMjA1KSA/IDB4ZmZmZiA6IDB4ZmYpOzxicj7CoCDCoCDC
oH0gZWxzZSB7PGJyPkBAIC04NDQsNyArODIyLDYgQEAgc3RhdGljIHZvaWQgZ2VuX210ZnNmaShE
aXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPsKgIMKgIMKgfTxi
cj7CoCDCoCDCoHNoID0gKDggKiB3KSArIDcgLSBiZjs8YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0
YXR1cygpOzxicj7CoCDCoCDCoHQwID0gdGNnX2NvbnN0X2k2NCgoKHVpbnQ2NF90KUZQSU1NKGN0
eC0mZ3Q7b3Bjb2RlKSkgJmx0OyZsdDsgKDQgKiBzaCkpOzxicj7CoCDCoCDCoHQxID0gdGNnX2Nv
bnN0X2kzMigxICZsdDsmbHQ7IHNoKTs8YnI+wqAgwqAgwqBnZW5faGVscGVyX3N0b3JlX2Zwc2Ny
KGNwdV9lbnYsIHQwLCB0MSk7PGJyPi0tIDxicj4yLjIzLjAud2luZG93cy4xPGJyPjxicj48L2Rp
dj48L2Rpdj4NCg==
--000000000000c281c405a49d56b1--

