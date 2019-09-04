Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80033C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADFC208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+SNo1wQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d01-0006C0-Em
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9a-0006Ec-Kr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9Y-0006nK-RQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:22 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:39602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9Y-0006m5-IX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id bd8so95431plb.6
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2GGld3+nyB6RGdDPwst4M2bW/fcpfjsi762a3svN9NQ=;
 b=Z+SNo1wQyA7Jh9KTwQTDa0Yn97hxRYfVBnO2a2HeEa9+B0baYabNxPUDzs/hXdRL+h
 W9H7qrvdyOfy0fB+gRKIL92Gh3jk+X0SE7p/nxEhjZlNHjVhPJpw2kSm3em8LqGalscP
 hv/Nl7gisyCf+2TRufDdiKM7ly3f9srfFm2Qbv6xRPoWlyr+P9F6Z3mp9GuzVHJqPV8j
 QrAjtYRNzQWUreGTLBsTnONNdBRA6r659ohCjBLdFVJP6yp5Hy1X6gB8RWxetptBXjSC
 uZ2/CvAt2PPtuclOck0C+tz+3imOQC2MhPS9JsFEHYqBYxLa6/xvZTTv1Ur3cLQSFWrt
 G5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2GGld3+nyB6RGdDPwst4M2bW/fcpfjsi762a3svN9NQ=;
 b=pwAHwZMsmt3FUx+onxGxinB+o2BStTdBlqpLRlCH1Mn2aZZYDWEW2vJoqXcbhpykJc
 uLSk7dB+4p1tvEly/bYLGVmSaeHvzV4UlVlC/z/hycOc5rhguy9C53AJl+UZUjkoSh94
 et2w/gf4Le14OnOAo6cHP1/415Va9WfhoY3PxY8/yeuaDlxE2fzQbpOmVl+geMI8ae+e
 IbPdhxU6EVfR36dfg5Dz1Zdo5HIz6fhadHMjPRjq7YCX7xX4E2z3ItDvwAtP4XJL/Ha0
 5A1qtem7CXz4gqW0RD4swr9b5DRcm7WcdKzDIUccD+1VLCWGggqiabVeCfbwhR6wG34B
 GipQ==
X-Gm-Message-State: APjAAAXgZ+2cExkBwI+0mW51lLu+UPtbVhu0zqC1IPJ9L7hDZdXx5WvM
 H9zOWJL+Jig5U++toE1OClyaiT3AFrs=
X-Google-Smtp-Source: APXvYqyOfhts/Q6lFkYINDoNBbvgXEvqOv+hDoryAFpeQZoi1j8mp0qZD9wkZiWM6r7vTUM5Xevn2A==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr7611218plp.0.1567629919179; 
 Wed, 04 Sep 2019 13:45:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:02 -0700
Message-Id: <20190904204507.32457-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PULL 08/13] target/openrisc: Check CPUCFG_OF32S for
 float insns
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

Make sure the OF32S insns are enabled before allowing execution.
Include the missing bit for cpu "any".

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.c       |  2 +-
 target/openrisc/translate.c | 84 ++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 50 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 9f566ad883..f3c8134531 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -131,7 +131,7 @@ static void openrisc_any_initfn(Object *obj)
     cpu->env.avr = 0x01010000;  /* Architecture v1.1 */
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
-    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S |
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
                        CPUCFGR_AVRP | CPUCFGR_EVBARP;
 
     /* 1Way, TLB_SIZE entries.  */
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 341f923864..2f5c969f21 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -45,6 +45,7 @@ typedef struct DisasContext {
     uint32_t mem_idx;
     uint32_t tb_flags;
     uint32_t delayed_branch;
+    uint32_t cpucfgr;
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
     target_ulong jmp_pc_imm;
@@ -140,30 +141,11 @@ static void gen_illegal_exception(DisasContext *dc)
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
-/* not used yet, open it when we need or64.  */
-/*#ifdef TARGET_OPENRISC64
-static void check_ob64s(DisasContext *dc)
+static bool check_of32s(DisasContext *dc)
 {
-    if (!(dc->flags & CPUCFGR_OB64S)) {
-        gen_illegal_exception(dc);
-    }
+    return dc->cpucfgr & CPUCFGR_OF32S;
 }
 
-static void check_of64s(DisasContext *dc)
-{
-    if (!(dc->flags & CPUCFGR_OF64S)) {
-        gen_illegal_exception(dc);
-    }
-}
-
-static void check_ov64s(DisasContext *dc)
-{
-    if (!(dc->flags & CPUCFGR_OV64S)) {
-        gen_illegal_exception(dc);
-    }
-}
-#endif*/
-
 static TCGv cpu_R(DisasContext *dc, int reg)
 {
     if (reg == 0) {
@@ -1157,26 +1139,37 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
     return true;
 }
 
-static void do_fp2(DisasContext *dc, arg_da *a,
+static bool do_fp2(DisasContext *dc, arg_da *a,
                    void (*fn)(TCGv, TCGv_env, TCGv))
 {
+    if (!check_of32s(dc)) {
+        return false;
+    }
     check_r0_write(dc, a->d);
     fn(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->a));
     gen_helper_update_fpcsr(cpu_env);
+    return true;
 }
 
-static void do_fp3(DisasContext *dc, arg_dab *a,
+static bool do_fp3(DisasContext *dc, arg_dab *a,
                    void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
 {
+    if (!check_of32s(dc)) {
+        return false;
+    }
     check_r0_write(dc, a->d);
     fn(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->a), cpu_R(dc, a->b));
     gen_helper_update_fpcsr(cpu_env);
+    return true;
 }
 
-static void do_fpcmp(DisasContext *dc, arg_ab *a,
+static bool do_fpcmp(DisasContext *dc, arg_ab *a,
                      void (*fn)(TCGv, TCGv_env, TCGv, TCGv),
                      bool inv, bool swap)
 {
+    if (!check_of32s(dc)) {
+        return false;
+    }
     if (swap) {
         fn(cpu_sr_f, cpu_env, cpu_R(dc, a->b), cpu_R(dc, a->a));
     } else {
@@ -1186,52 +1179,50 @@ static void do_fpcmp(DisasContext *dc, arg_ab *a,
         tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
     }
     gen_helper_update_fpcsr(cpu_env);
+    return true;
 }
 
 static bool trans_lf_add_s(DisasContext *dc, arg_dab *a)
 {
-    do_fp3(dc, a, gen_helper_float_add_s);
-    return true;
+    return do_fp3(dc, a, gen_helper_float_add_s);
 }
 
 static bool trans_lf_sub_s(DisasContext *dc, arg_dab *a)
 {
-    do_fp3(dc, a, gen_helper_float_sub_s);
-    return true;
+    return do_fp3(dc, a, gen_helper_float_sub_s);
 }
 
 static bool trans_lf_mul_s(DisasContext *dc, arg_dab *a)
 {
-    do_fp3(dc, a, gen_helper_float_mul_s);
-    return true;
+    return do_fp3(dc, a, gen_helper_float_mul_s);
 }
 
 static bool trans_lf_div_s(DisasContext *dc, arg_dab *a)
 {
-    do_fp3(dc, a, gen_helper_float_div_s);
-    return true;
+    return do_fp3(dc, a, gen_helper_float_div_s);
 }
 
 static bool trans_lf_rem_s(DisasContext *dc, arg_dab *a)
 {
-    do_fp3(dc, a, gen_helper_float_rem_s);
+    return do_fp3(dc, a, gen_helper_float_rem_s);
     return true;
 }
 
 static bool trans_lf_itof_s(DisasContext *dc, arg_da *a)
 {
-    do_fp2(dc, a, gen_helper_itofs);
-    return true;
+    return do_fp2(dc, a, gen_helper_itofs);
 }
 
 static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a)
 {
-    do_fp2(dc, a, gen_helper_ftois);
-    return true;
+    return do_fp2(dc, a, gen_helper_ftois);
 }
 
 static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a)
 {
+    if (!check_of32s(dc)) {
+        return false;
+    }
     check_r0_write(dc, a->d);
     gen_helper_float_madd_s(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d),
                             cpu_R(dc, a->a), cpu_R(dc, a->b));
@@ -1241,38 +1232,32 @@ static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a)
 
 static bool trans_lf_sfeq_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_eq_s, false, false);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_eq_s, false, false);
 }
 
 static bool trans_lf_sfne_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_eq_s, true, false);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_eq_s, true, false);
 }
 
 static bool trans_lf_sfgt_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_lt_s, false, true);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_lt_s, false, true);
 }
 
 static bool trans_lf_sfge_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_le_s, false, true);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_le_s, false, true);
 }
 
 static bool trans_lf_sflt_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_lt_s, false, false);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_lt_s, false, false);
 }
 
 static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a)
 {
-    do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
-    return true;
+    return do_fpcmp(dc, a, gen_helper_float_le_s, false, false);
 }
 
 static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
@@ -1284,6 +1269,7 @@ static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->mem_idx = cpu_mmu_index(env, false);
     dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
+    dc->cpucfgr = env->cpucfgr;
     dc->jmp_pc_imm = -1;
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
-- 
2.17.1


