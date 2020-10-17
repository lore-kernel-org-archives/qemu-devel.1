Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D22C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE4E206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SomVDVXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE4E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTbz4-0008PD-W4
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 22:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby2-0006nm-Ip
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby0-0007uW-0l
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id p11so2215363pld.5
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iu8QEUTMk7QdqWKe4PiXTbPYVEKOLM/zzjRIHVs9ZJg=;
 b=SomVDVXet+nW4ioe2qqDObI6t8qkqzLY7WwwYwvr9Gt6ggEvqw/Q+DpopdmvMlq16a
 Ii0Cvy8gNmFOCFdMiIdTuKjeEXAsi+VBJTV/MK+uNpDWuHuRPip8sbvZQsd9dL6W2pfz
 o45Uk6Z2qZUYaVNpUSG5t3REmWqYg/k5+I0LawEXLuYA276oFS4Ohuke0G0iUe6OeNKD
 Us7JcMUmWXHOL/OMas4/OWP8UPGwQj6t0n16UgJqp0SoXb2wzAD8eFX5zKILGOirLZsI
 XXl03LBrHK5+hSZB0bJVC8bnPN3oOYq0MP7WjcoM6Zo1Ar5cxxI2PF6Fzbx/A5LfwBbc
 sbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iu8QEUTMk7QdqWKe4PiXTbPYVEKOLM/zzjRIHVs9ZJg=;
 b=JXFPhmwG0JZvEAFHEMS5D4zTuo5VVmoz2qbsJI+e8Lb+CC81+ffR/leyZdSv9rhZ/B
 aHeJVYlua8HvxDyNv0eVh8ogNQPAT/+jTuHpRSlidbFfdvgkOnXvxIJ/kz1ImUqUdN8n
 vbOMVbxvfKg/etxtHt4hX+DfT4b/yKvUyT/hMQyXXx+FHs20KbrVNM3Ed/mingq7UpFp
 RMbHuE07ELlWLjW/RcVtGmjIbw8SVNVHpPMNl54OKrS5ftP11/gbGQshmOGhYP8yiN1u
 z4Z6YrJqmP6f0baA/fp/L/qTIbfciYP5Hwk99ali/MJaBPprbwPtLKfynHZG79Be5jRv
 AxpQ==
X-Gm-Message-State: AOAM530QF2nw4poqEqAhv/2xrG0frYY1dhj9hmtVPnHce4S9wguWd8GI
 8NJO4lW7EZBoFGJr3370dFHSNqMMQFCPtA==
X-Google-Smtp-Source: ABdhPJyAhVO0ffYRtr+9uksCNWk/ZLZXTxC5L6SmcECb5e6unwKU4JEzyNxKuJ9AoJohsLmdk6iKRQ==
X-Received: by 2002:a17:90a:e453:: with SMTP id
 jp19mr7214136pjb.34.1602901746203; 
 Fri, 16 Oct 2020 19:29:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k9sm4150818pgt.72.2020.10.16.19.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 19:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/s390x: Improve ADD LOGICAL WITH CARRY
Date: Fri, 16 Oct 2020 19:28:59 -0700
Message-Id: <20201017022901.78425-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201017022901.78425-1-richard.henderson@linaro.org>
References: <20201017022901.78425-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that ADD LOGICAL outputs carry, we can use that as input directly.
It also means we can re-use CC_OP_ZC and produce an output carry
directly from ADD LOGICAL WITH CARRY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  2 --
 target/s390x/cc_helper.c   | 26 ---------------
 target/s390x/helper.c      |  2 --
 target/s390x/translate.c   | 66 ++++++++++++++++++--------------------
 target/s390x/insn-data.def |  8 ++---
 5 files changed, 35 insertions(+), 69 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 55c5442102..f5f3ae063e 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -170,7 +170,6 @@ enum cc_op {
     CC_OP_LTGT0_64,             /* signed less/greater than 0 (64bit) */
 
     CC_OP_ADD_64,               /* overflow on add (64bit) */
-    CC_OP_ADDC_64,              /* overflow on unsigned add-carry (64bit) */
     CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
     CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
     CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
@@ -179,7 +178,6 @@ enum cc_op {
     CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
 
     CC_OP_ADD_32,               /* overflow on add (32bit) */
-    CC_OP_ADDC_32,              /* overflow on unsigned add-carry (32bit) */
     CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
     CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
     CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 59da4d1cc2..cd2c5c4b39 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -144,16 +144,6 @@ static uint32_t cc_calc_add_64(int64_t a1, int64_t a2, int64_t ar)
     }
 }
 
-static uint32_t cc_calc_addc_64(uint64_t a1, uint64_t a2, uint64_t ar)
-{
-    /* Recover a2 + carry_in.  */
-    uint64_t a2c = ar - a1;
-    /* Check for a2+carry_in overflow, then a1+a2c overflow.  */
-    int carry_out = (a2c < a2) || (ar < a1);
-
-    return (ar != 0) + 2 * carry_out;
-}
-
 static uint32_t cc_calc_sub_64(int64_t a1, int64_t a2, int64_t ar)
 {
     if ((a1 > 0 && a2 < 0 && ar < 0) || (a1 < 0 && a2 > 0 && ar > 0)) {
@@ -240,16 +230,6 @@ static uint32_t cc_calc_add_32(int32_t a1, int32_t a2, int32_t ar)
     }
 }
 
-static uint32_t cc_calc_addc_32(uint32_t a1, uint32_t a2, uint32_t ar)
-{
-    /* Recover a2 + carry_in.  */
-    uint32_t a2c = ar - a1;
-    /* Check for a2+carry_in overflow, then a1+a2c overflow.  */
-    int carry_out = (a2c < a2) || (ar < a1);
-
-    return (ar != 0) + 2 * carry_out;
-}
-
 static uint32_t cc_calc_sub_32(int32_t a1, int32_t a2, int32_t ar)
 {
     if ((a1 > 0 && a2 < 0 && ar < 0) || (a1 < 0 && a2 > 0 && ar > 0)) {
@@ -485,9 +465,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_ADD_64:
         r =  cc_calc_add_64(src, dst, vr);
         break;
-    case CC_OP_ADDC_64:
-        r =  cc_calc_addc_64(src, dst, vr);
-        break;
     case CC_OP_SUB_64:
         r =  cc_calc_sub_64(src, dst, vr);
         break;
@@ -513,9 +490,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_ADD_32:
         r =  cc_calc_add_32(src, dst, vr);
         break;
-    case CC_OP_ADDC_32:
-        r =  cc_calc_addc_32(src, dst, vr);
-        break;
     case CC_OP_SUB_32:
         r =  cc_calc_sub_32(src, dst, vr);
         break;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index db87a62a57..4f4561bc64 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -403,14 +403,12 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
         [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
         [CC_OP_ADD_64]    = "CC_OP_ADD_64",
-        [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
         [CC_OP_SUB_64]    = "CC_OP_SUB_64",
         [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
         [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
         [CC_OP_ABS_64]    = "CC_OP_ABS_64",
         [CC_OP_NABS_64]   = "CC_OP_NABS_64",
         [CC_OP_ADD_32]    = "CC_OP_ADD_32",
-        [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
         [CC_OP_SUB_32]    = "CC_OP_SUB_32",
         [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
         [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9bf4c14f66..570b3c88c8 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -600,12 +600,10 @@ static void gen_op_calc_cc(DisasContext *s)
         dummy = tcg_const_i64(0);
         /* FALLTHRU */
     case CC_OP_ADD_64:
-    case CC_OP_ADDC_64:
     case CC_OP_SUB_64:
     case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
-    case CC_OP_ADDC_32:
     case CC_OP_SUB_32:
     case CC_OP_SUBU_32:
     case CC_OP_SUBB_32:
@@ -665,12 +663,10 @@ static void gen_op_calc_cc(DisasContext *s)
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, dummy);
         break;
     case CC_OP_ADD_64:
-    case CC_OP_ADDC_64:
     case CC_OP_SUB_64:
     case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
-    case CC_OP_ADDC_32:
     case CC_OP_SUB_32:
     case CC_OP_SUBU_32:
     case CC_OP_SUBB_32:
@@ -1442,30 +1438,40 @@ static DisasJumpType op_addu64(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_addc(DisasContext *s, DisasOps *o)
+/* Compute carry into cc_src. */
+static void compute_carry(DisasContext *s)
 {
-    DisasCompare cmp;
-    TCGv_i64 carry;
-
-    tcg_gen_add_i64(o->out, o->in1, o->in2);
-
-    /* The carry flag is the msb of CC, therefore the branch mask that would
-       create that comparison is 3.  Feeding the generated comparison to
-       setcond produces the carry flag that we desire.  */
-    disas_jcc(s, &cmp, 3);
-    carry = tcg_temp_new_i64();
-    if (cmp.is_64) {
-        tcg_gen_setcond_i64(cmp.cond, carry, cmp.u.s64.a, cmp.u.s64.b);
-    } else {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_setcond_i32(cmp.cond, t, cmp.u.s32.a, cmp.u.s32.b);
-        tcg_gen_extu_i32_i64(carry, t);
-        tcg_temp_free_i32(t);
+    switch (s->cc_op) {
+    case CC_OP_ADDU:
+        break;
+    default:
+        gen_op_calc_cc(s);
+        /* fall through */
+    case CC_OP_STATIC:
+        /* The carry flag is the msb of CC; compute into cc_src. */
+        tcg_gen_extu_i32_i64(cc_src, cc_op);
+        tcg_gen_shri_i64(cc_src, cc_src, 1);
+        break;
     }
-    free_compare(&cmp);
+}
+
+static DisasJumpType op_addc32(DisasContext *s, DisasOps *o)
+{
+    compute_carry(s);
+    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    tcg_gen_add_i64(o->out, o->out, cc_src);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
+{
+    compute_carry(s);
+
+    TCGv_i64 zero = tcg_const_i64(0);
+    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
+    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
+    tcg_temp_free_i64(zero);
 
-    tcg_gen_add_i64(o->out, o->out, carry);
-    tcg_temp_free_i64(carry);
     return DISAS_NEXT;
 }
 
@@ -5216,16 +5222,6 @@ static void cout_addu64(DisasContext *s, DisasOps *o)
     gen_op_update2_cc_i64(s, CC_OP_ADDU, cc_src, o->out);
 }
 
-static void cout_addc32(DisasContext *s, DisasOps *o)
-{
-    gen_op_update3_cc_i64(s, CC_OP_ADDC_32, o->in1, o->in2, o->out);
-}
-
-static void cout_addc64(DisasContext *s, DisasOps *o)
-{
-    gen_op_update3_cc_i64(s, CC_OP_ADDC_64, o->in1, o->in2, o->out);
-}
-
 static void cout_cmps32(DisasContext *s, DisasOps *o)
 {
     gen_op_update2_cc_i64(s, CC_OP_LTGT_32, o->in1, o->in2);
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b9ca9aeff5..d9e65a0380 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -82,10 +82,10 @@
     C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2_32u, new, r1_32h, add, addu32)
     C(0xcc0b, ALSIHN,  RIL_a, HW,  r1_sr32, i2_32u, new, r1_32h, add, 0)
 /* ADD LOGICAL WITH CARRY */
-    C(0xb998, ALCR,    RRE,   Z,   r1, r2, new, r1_32, addc, addc32)
-    C(0xb988, ALCGR,   RRE,   Z,   r1, r2, r1, 0, addc, addc64)
-    C(0xe398, ALC,     RXY_a, Z,   r1, m2_32u, new, r1_32, addc, addc32)
-    C(0xe388, ALCG,    RXY_a, Z,   r1, m2_64, r1, 0, addc, addc64)
+    C(0xb998, ALCR,    RRE,   Z,   r1_32u, r2_32u, new, r1_32, addc32, addu32)
+    C(0xb988, ALCGR,   RRE,   Z,   r1, r2, r1, 0, addc64, addu64)
+    C(0xe398, ALC,     RXY_a, Z,   r1_32u, m2_32u, new, r1_32, addc32, addu32)
+    C(0xe388, ALCG,    RXY_a, Z,   r1, m2_64, r1, 0, addc64, addu64)
 
 /* AND */
     C(0x1400, NR,      RR_a,  Z,   r1, r2, new, r1_32, and, nz32)
-- 
2.25.1


