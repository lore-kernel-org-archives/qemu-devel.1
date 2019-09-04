Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4029C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED9320828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3oH9TLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED9320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5chi-00018K-AM
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9c-0006Ht-QG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9a-0006qh-7L
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:46606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9Z-0006ou-Ua
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id t1so71357plq.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IWUivciiEyIw5h23RCVrBi2UZhIQIIAcE0cBZIKJOZg=;
 b=d3oH9TLaCZO/zio1uZr+YOyY8auAfEZwBJFDmZbEn/XqQCppVuwzO0HQwzfkXoS8ki
 iOZAkhWMVCdZX7UH1IhJtMBHPwUm5QEx10l83erw1zY9z7LpV0UGAgsNfFbzM7zYWzy1
 ASRIXZtcGNQTZxCxIvFMyludOIuOZVW/CJj6mKrsUVYLDv/6ys14oqI8KME8kERBK2kd
 v+4uVLA+i9orjQqFBu5mCftu7EiFDYzg4PNJJSbqAJANHkzytSlFZ7SBouY/cT1F4Xqu
 zs9xIo8h35geD3yerWIoUiuPBCbQWw4wb2FgFNSuIHAHIOaKVt+g9CaQapZf8SNbokjJ
 Cwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IWUivciiEyIw5h23RCVrBi2UZhIQIIAcE0cBZIKJOZg=;
 b=bJcCw9J2KMCVcjOjx2rTReRe0LB5uoNT1AJEz09B9aDRwZCvpAsXq+j1E2BWKXZKKa
 /7Dl1EAy+FUItqUnszQ70/sIjFgrbebx0e/RmSx3Ya9hcEP/qnYWosZv6iwsl7//QbR5
 ltBwnS06NXXtvqFYtUHCU06v/c4GQsp4l+Ztv6Icu6Ivn5LB3XpdMoHMP4mZFnqgPkjt
 AaD2rly+3DyEo3CsR4rNl0wnRuIPbQicqjzSUjPEMqFFh2CtTxg6bNIjIAB5zFZXP/b+
 X+GBBj2Mxr+LrBfGehHMD62vzuT1uR6Be7zykKzdaV4yg3eAi+iE9TJumV/L0+hDzt/y
 Iakg==
X-Gm-Message-State: APjAAAUiEF7exTda+L75XFAdGr1GDDG4G9ykH9B2YfQCA/N+No2V2fTu
 qRvK8whXB8Pi5o8OYddcBoYP6UGvrf4=
X-Google-Smtp-Source: APXvYqz9jFlhcYuXuqx0S0DiU3lwJtwwvFcpuRw8InD6Z3Sq/7p7s1OBEUFqxXqT9dFdkZgRgNw8DQ==
X-Received: by 2002:a17:902:788b:: with SMTP id
 q11mr42609133pll.308.1567629920532; 
 Wed, 04 Sep 2019 13:45:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:03 -0700
Message-Id: <20190904204507.32457-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PULL 09/13] target/openrisc: Add support for
 ORFPX64A32
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is hardware support for double-precision floating-point using
pairs of 32-bit registers.  Fix latent bugs in the heretofore unused
helper_itofd and helper_ftoid.  Include the bit for cpu "any".
Change the default cpu for linux-user to "any".

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h |   2 +-
 target/openrisc/helper.h         |   2 +
 target/openrisc/cpu.c            |   2 +-
 target/openrisc/disas.c          |  56 ++++++++
 target/openrisc/fpu_helper.c     |  14 +-
 target/openrisc/translate.c      | 230 +++++++++++++++++++++++++++++++
 target/openrisc/insns.decode     |  31 +++++
 7 files changed, 333 insertions(+), 4 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index 40ceb025c9..265ecd3079 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -9,6 +9,6 @@
 #define OPENRISC_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "or1200";
+    return "any";
 }
 #endif
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 96d79a8113..94b823580e 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -30,6 +30,8 @@ DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(stod, TCG_CALL_NO_RWG, i64, env, i32)
+DEF_HELPER_FLAGS_2(dtos, TCG_CALL_NO_RWG, i32, env, i64)
 
 DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
 DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f3c8134531..b931605e62 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -132,7 +132,7 @@ static void openrisc_any_initfn(Object *obj)
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
-                       CPUCFGR_AVRP | CPUCFGR_EVBARP;
+                       CPUCFGR_AVRP | CPUCFGR_EVBARP | CPUCFGR_OF64A32S;
 
     /* 1Way, TLB_SIZE entries.  */
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 7091832347..4de5c632de 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -166,3 +166,59 @@ FP_INSN(sfgt, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sfge, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sflt, s, "r%d, r%d", a->a, a->b)
 FP_INSN(sfle, s, "r%d, r%d", a->a, a->b)
+
+FP_INSN(add, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sub, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(mul, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(div, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(rem, d,  "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(madd, d, "r%d,r%d, r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+
+FP_INSN(itof, d, "r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1)
+FP_INSN(ftoi, d, "r%d,r%d, r%d,r%d",
+        a->d, a->d + a->dp + 1,
+        a->a, a->a + a->ap + 1)
+
+FP_INSN(stod, d, "r%d,r%d, r%d",
+        a->d, a->d + a->dp + 1, a->a)
+FP_INSN(dtos, d, "r%d r%d,r%d",
+        a->d, a->a, a->a + a->ap + 1)
+
+FP_INSN(sfeq, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfne, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfgt, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfge, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sflt, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
+FP_INSN(sfle, d, "r%d,r%d, r%d,r%d",
+        a->a, a->a + a->ap + 1,
+        a->b, a->b + a->bp + 1)
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 4cc5b297c5..9d7dfc0fb9 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -63,7 +63,7 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
 
 uint64_t HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
 {
-    return int32_to_float64(val, &env->fp_status);
+    return int64_to_float64(val, &env->fp_status);
 }
 
 uint32_t HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
@@ -73,7 +73,7 @@ uint32_t HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
 
 uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
 {
-    return float32_to_int64(val, &env->fp_status);
+    return float64_to_int64_round_to_zero(val, &env->fp_status);
 }
 
 uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
@@ -81,6 +81,16 @@ uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
     return float32_to_int32_round_to_zero(val, &env->fp_status);
 }
 
+uint64_t HELPER(stod)(CPUOpenRISCState *env, uint32_t val)
+{
+    return float32_to_float64(val, &env->fp_status);
+}
+
+uint32_t HELPER(dtos)(CPUOpenRISCState *env, uint64_t val)
+{
+    return float64_to_float32(val, &env->fp_status);
+}
+
 #define FLOAT_CALC(name)                                                  \
 uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                      uint64_t fdt0, uint64_t fdt1)        \
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 2f5c969f21..b8ef485903 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -146,6 +146,11 @@ static bool check_of32s(DisasContext *dc)
     return dc->cpucfgr & CPUCFGR_OF32S;
 }
 
+static bool check_of64a32s(DisasContext *dc)
+{
+    return dc->cpucfgr & CPUCFGR_OF64A32S;
+}
+
 static TCGv cpu_R(DisasContext *dc, int reg)
 {
     if (reg == 0) {
@@ -1260,6 +1265,231 @@ static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a)
     return do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
 }
 
+static bool check_pair(DisasContext *dc, int r, int p)
+{
+    return r + 1 + p < 32;
+}
+
+static void load_pair(DisasContext *dc, TCGv_i64 t, int r, int p)
+{
+    tcg_gen_concat_i32_i64(t, cpu_R(dc, r + 1 + p), cpu_R(dc, r));
+}
+
+static void save_pair(DisasContext *dc, TCGv_i64 t, int r, int p)
+{
+    tcg_gen_extr_i64_i32(cpu_R(dc, r + 1 + p), cpu_R(dc, r), t);
+}
+
+static bool do_dp3(DisasContext *dc, arg_dab_pair *a,
+                   void (*fn)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0, t1;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->a, a->ap) ||
+        !check_pair(dc, a->b, a->bp) ||
+        !check_pair(dc, a->d, a->dp)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    load_pair(dc, t0, a->a, a->ap);
+    load_pair(dc, t1, a->b, a->bp);
+    fn(t0, cpu_env, t0, t1);
+    save_pair(dc, t0, a->d, a->dp);
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool do_dp2(DisasContext *dc, arg_da_pair *a,
+                   void (*fn)(TCGv_i64, TCGv_env, TCGv_i64))
+{
+    TCGv_i64 t0;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->a, a->ap) ||
+        !check_pair(dc, a->d, a->dp)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    t0 = tcg_temp_new_i64();
+    load_pair(dc, t0, a->a, a->ap);
+    fn(t0, cpu_env, t0);
+    save_pair(dc, t0, a->d, a->dp);
+    tcg_temp_free_i64(t0);
+
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool do_dpcmp(DisasContext *dc, arg_ab_pair *a,
+                     void (*fn)(TCGv, TCGv_env, TCGv_i64, TCGv_i64),
+                     bool inv, bool swap)
+{
+    TCGv_i64 t0, t1;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->a, a->ap) ||
+        !check_pair(dc, a->b, a->bp)) {
+        return false;
+    }
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    load_pair(dc, t0, a->a, a->ap);
+    load_pair(dc, t1, a->b, a->bp);
+    if (swap) {
+        fn(cpu_sr_f, cpu_env, t1, t0);
+    } else {
+        fn(cpu_sr_f, cpu_env, t0, t1);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+
+    if (inv) {
+        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+    }
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool trans_lf_add_d(DisasContext *dc, arg_dab_pair *a)
+{
+    return do_dp3(dc, a, gen_helper_float_add_d);
+}
+
+static bool trans_lf_sub_d(DisasContext *dc, arg_dab_pair *a)
+{
+    return do_dp3(dc, a, gen_helper_float_sub_d);
+}
+
+static bool trans_lf_mul_d(DisasContext *dc, arg_dab_pair *a)
+{
+    return do_dp3(dc, a, gen_helper_float_mul_d);
+}
+
+static bool trans_lf_div_d(DisasContext *dc, arg_dab_pair *a)
+{
+    return do_dp3(dc, a, gen_helper_float_div_d);
+}
+
+static bool trans_lf_rem_d(DisasContext *dc, arg_dab_pair *a)
+{
+    return do_dp3(dc, a, gen_helper_float_rem_d);
+}
+
+static bool trans_lf_itof_d(DisasContext *dc, arg_da_pair *a)
+{
+    return do_dp2(dc, a, gen_helper_itofd);
+}
+
+static bool trans_lf_ftoi_d(DisasContext *dc, arg_da_pair *a)
+{
+    return do_dp2(dc, a, gen_helper_ftoid);
+}
+
+static bool trans_lf_stod_d(DisasContext *dc, arg_lf_stod_d *a)
+{
+    TCGv_i64 t0;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->d, a->dp)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    t0 = tcg_temp_new_i64();
+    gen_helper_stod(t0, cpu_env, cpu_R(dc, a->a));
+    save_pair(dc, t0, a->d, a->dp);
+    tcg_temp_free_i64(t0);
+
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool trans_lf_dtos_d(DisasContext *dc, arg_lf_dtos_d *a)
+{
+    TCGv_i64 t0;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->a, a->ap)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    t0 = tcg_temp_new_i64();
+    load_pair(dc, t0, a->a, a->ap);
+    gen_helper_dtos(cpu_R(dc, a->d), cpu_env, t0);
+    tcg_temp_free_i64(t0);
+
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool trans_lf_madd_d(DisasContext *dc, arg_dab_pair *a)
+{
+    TCGv_i64 t0, t1, t2;
+
+    if (!check_of64a32s(dc) ||
+        !check_pair(dc, a->a, a->ap) ||
+        !check_pair(dc, a->b, a->bp) ||
+        !check_pair(dc, a->d, a->dp)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    load_pair(dc, t0, a->d, a->dp);
+    load_pair(dc, t1, a->a, a->ap);
+    load_pair(dc, t2, a->b, a->bp);
+    gen_helper_float_madd_d(t0, cpu_env, t0, t1, t2);
+    save_pair(dc, t0, a->d, a->dp);
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+
+    gen_helper_update_fpcsr(cpu_env);
+    return true;
+}
+
+static bool trans_lf_sfeq_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_eq_d, false, false);
+}
+
+static bool trans_lf_sfne_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_eq_d, true, false);
+}
+
+static bool trans_lf_sfgt_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_lt_d, false, true);
+}
+
+static bool trans_lf_sfge_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_le_d, false, true);
+}
+
+static bool trans_lf_sflt_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_lt_d, false, false);
+}
+
+static bool trans_lf_sfle_d(DisasContext *dc, arg_ab_pair *a)
+{
+    return do_dpcmp(dc, a, gen_helper_float_le_d, false, false);
+}
+
 static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 7df81c1f22..334d4e9668 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -22,6 +22,9 @@
 &ab             a b
 &dal            d a l
 &ai             a i
+&dab_pair       d a b dp ap bp
+&ab_pair        a b ap bp
+&da_pair        d a dp ap
 
 ####
 # System Instructions
@@ -187,3 +190,31 @@ lf_sfgt_s       110010 ----- a:5 b:5 --- 00001010
 lf_sfge_s       110010 ----- a:5 b:5 --- 00001011
 lf_sflt_s       110010 ----- a:5 b:5 --- 00001100
 lf_sfle_s       110010 ----- a:5 b:5 --- 00001101
+
+####
+# DP Instructions
+####
+
+@dab_pair       ...... d:5   a:5 b:5   dp:1 ap:1 bp:1 ........  &dab_pair
+@ab_pair        ...... ..... a:5 b:5   .    ap:1 bp:1 ........  &ab_pair
+@da_pair        ...... d:5   a:5 ..... dp:1 ap:1 .    ........  &da_pair
+
+lf_add_d        110010 ..... ..... ..... ... 00010000  @dab_pair
+lf_sub_d        110010 ..... ..... ..... ... 00010001  @dab_pair
+lf_mul_d        110010 ..... ..... ..... ... 00010010  @dab_pair
+lf_div_d        110010 ..... ..... ..... ... 00010011  @dab_pair
+lf_rem_d        110010 ..... ..... ..... ... 00010110  @dab_pair
+lf_madd_d       110010 ..... ..... ..... ... 00010111  @dab_pair
+
+lf_itof_d       110010 ..... ..... 00000 ..0 00010100  @da_pair
+lf_ftoi_d       110010 ..... ..... 00000 ..0 00010101  @da_pair
+
+lf_stod_d       110010 d:5 a:5 00000 dp:1 0 0 00110100
+lf_dtos_d       110010 d:5 a:5 00000 0 ap:1 0 00110101
+
+lf_sfeq_d       110010 00000 ..... ..... 0.. 00011000  @ab_pair
+lf_sfne_d       110010 00000 ..... ..... 0.. 00011001  @ab_pair
+lf_sfgt_d       110010 00000 ..... ..... 0.. 00011010  @ab_pair
+lf_sfge_d       110010 00000 ..... ..... 0.. 00011011  @ab_pair
+lf_sflt_d       110010 00000 ..... ..... 0.. 00011100  @ab_pair
+lf_sfle_d       110010 00000 ..... ..... 0.. 00011101  @ab_pair
-- 
2.17.1


