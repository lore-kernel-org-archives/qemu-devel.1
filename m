Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2496D2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFoCLSAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2496D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOcY-0006Gc-AL
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSj-0001SI-2B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35290)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSh-0003pX-1u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id q25so5333150wmj.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXS6Jvw/GsSQRzbLxX/W7xj1FrkzmEuqqbzjBJFsOR0=;
 b=wFoCLSAgc5g40uPU2llbxpOqxSM74OV2GVb1HeAEKcEx8PJioV6K8MVDjTXak/sLgk
 x2CpBpbJach8FfpbBcyNmOzVP0K2mkXtkb9qK+OaphKHdknCdIj21V1gG5HB3eg7NS+8
 ndcG+e3JC7CqptrRbryF2Ldx96IbJHgdxwe5pjxwKsLbE4G3+R7k16aB2cJib2hmJ6JE
 R5AFO+m260tprgWtXj6TUwI2Kyjqs71SUg6sesg7SUOYYqgKqNBXbyU5MUxUAnImpAHK
 R+zM13Br/M+vGoc3pfmxPkp/pEG1Ma4e8ATGVOp0lSviIuq+eVAAy3mW/NZiMDXyokT5
 VbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXS6Jvw/GsSQRzbLxX/W7xj1FrkzmEuqqbzjBJFsOR0=;
 b=PCvVxqJYJ8spLSiVsHPf6YCSceH7ZWaulkl6KweKgoblMtakF81AaOaLJZ7FLIepcw
 DpZ/7XKzWLwDm31Li0QMqiDT4hUI8Ocaz9O4aOFAyQG+4K5BVbXZwND49hJcDSLPhrWQ
 XdIDufNZ5fa5YAMgS5Y2F9fxVm09jwWTacHU4Gu294qChWp192s2EJbLc0YIYPMa/ijx
 5YqWiWYm+fZxxFWbVeZ/ANeA2BaGCZY05bf+R/7bvAN1lhXQmEGg1eDePQpbthZmG+N5
 sVXzQtirjQw6wUoviUFckyJM695NdYNXNBHT9QpJdWg1H3c0y/ypqX6VYviUg9JaPaiD
 oePQ==
X-Gm-Message-State: AOAM530A1z0UmQYjTFIRvIIBqysJGvO8KOxSRVf/Iky93Kel/K0aon2w
 dnMbqfdUEP/olBMCS+/nbtUo2A==
X-Google-Smtp-Source: ABdhPJyL3NeanDqGvc20q08m9wL5k8LZTcyOc3MORZlmBnqTv2ufM/vChghBfzANzboMEDbZy4pqCQ==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr8448712wma.101.1591886739090; 
 Thu, 11 Jun 2020 07:45:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/10] target/arm: Convert Neon 2-reg-scalar VQDMULH,
 VQRDMULH to decodetree
Date: Thu, 11 Jun 2020 15:45:24 +0100
Message-Id: <20200611144529.8873-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VQDMULH and VQRDMULH insns in the 2-reg-scalar group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 29 +++++++++++++++++++++++
 target/arm/translate.c          | 42 ++-------------------------------
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index cc2ee9641d6..105cf2b2db3 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -485,5 +485,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VMUL_2sc     1111 001 . 1 . .. .... .... 1000 . 1 . 0 .... @2scalar
     VMUL_F_2sc   1111 001 . 1 . .. .... .... 1001 . 1 . 0 .... @2scalar
+
+    VQDMULH_2sc  1111 001 . 1 . .. .... .... 1100 . 1 . 0 .... @2scalar
+    VQRDMULH_2sc 1111 001 . 1 . .. .... .... 1101 . 1 . 0 .... @2scalar
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a5c7d60bdac..6301016d5cf 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2546,3 +2546,32 @@ static bool trans_VMLS_F_2sc(DisasContext *s, arg_2scalar *a)
 
     return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
 }
+
+WRAP_ENV_FN(gen_VQDMULH_16, gen_helper_neon_qdmulh_s16)
+WRAP_ENV_FN(gen_VQDMULH_32, gen_helper_neon_qdmulh_s32)
+WRAP_ENV_FN(gen_VQRDMULH_16, gen_helper_neon_qrdmulh_s16)
+WRAP_ENV_FN(gen_VQRDMULH_32, gen_helper_neon_qrdmulh_s32)
+
+static bool trans_VQDMULH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        gen_VQDMULH_16,
+        gen_VQDMULH_32,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VQRDMULH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        gen_VQRDMULH_16,
+        gen_VQRDMULH_32,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], NULL);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e4a6a38c782..5d0e00f92e0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2973,19 +2973,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
 
 #define CPU_V001 cpu_V0, cpu_V0, cpu_V1
 
-static TCGv_i32 neon_load_scratch(int scratch)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, offsetof(CPUARMState, vfp.scratch[scratch]));
-    return tmp;
-}
-
-static void neon_store_scratch(int scratch, TCGv_i32 var)
-{
-    tcg_gen_st_i32(var, cpu_env, offsetof(CPUARMState, vfp.scratch[scratch]));
-    tcg_temp_free_i32(var);
-}
-
 static int gen_neon_unzip(int rd, int rm, int size, int q)
 {
     TCGv_ptr pd, pm;
@@ -5190,35 +5177,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case 1: /* Float VMLA scalar */
                 case 5: /* Floating point VMLS scalar */
                 case 9: /* Floating point VMUL scalar */
-                    return 1; /* handled by decodetree */
-
                 case 12: /* VQDMULH scalar */
                 case 13: /* VQRDMULH scalar */
-                    if (u && ((rd | rn) & 1)) {
-                        return 1;
-                    }
-                    tmp = neon_get_scalar(size, rm);
-                    neon_store_scratch(0, tmp);
-                    for (pass = 0; pass < (u ? 4 : 2); pass++) {
-                        tmp = neon_load_scratch(0);
-                        tmp2 = neon_load_reg(rn, pass);
-                        if (op == 12) {
-                            if (size == 1) {
-                                gen_helper_neon_qdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_neon_qdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                            }
-                        } else {
-                            if (size == 1) {
-                                gen_helper_neon_qrdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_neon_qrdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                            }
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        neon_store_reg(rd, pass, tmp);
-                    }
-                    break;
+                    return 1; /* handled by decodetree */
+
                 case 3: /* VQDMLAL scalar */
                 case 7: /* VQDMLSL scalar */
                 case 11: /* VQDMULL scalar */
-- 
2.20.1


