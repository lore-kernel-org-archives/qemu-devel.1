Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836012068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOUfDWf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836012068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAKt-0002EE-MD
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIg-0005mX-5D
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:06 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIf-0007Qe-3j
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id g5so5319794pfm.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k8C/GQtIdOwZhYe9ry4RvUtTwTpZcqFEriAcRPm0GJU=;
 b=zOUfDWf1AOBCC2PM8rvcswZBtoNEenEmDJD7AT0WoGH0Eovhlhofh3YsNYnTkIeO4s
 6vqyh+EelLsDMF5IUCrCBS4gjoHVWc44LxVYQyE4KYJNISpniZJyCIEpVI8af0dDH5UO
 lpyocWIPih8wLciHcmQUqIZVlQ1IaOyDCekVSgCSEAiHVU46QktMQEMHTaLTx31Ty83o
 zPJxtDQLYTMUWrcIJqZNIBgRdPQ66la6UYM3HxBkBVA9EusdArKXjzgIPJsv/S4KH2Md
 jHYqSicLPvtCMfVimB+/cwQm29eR1Yz88ZghF/hw+3FQtdIkTt3lYLEQN2x5NUlNqoCT
 cbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k8C/GQtIdOwZhYe9ry4RvUtTwTpZcqFEriAcRPm0GJU=;
 b=JnFKLiayuAx0Ap/XbFhyoYRz+rF4RAsCxV2jX53+LfMmVAI91PWcrKyhvY5x6F/nNE
 +EIfXFzTAuGdRY7sdOyDIm4B7eCKQJf0vSAWvliYT6DFhIlytbmtTwJ3Lp4bM8Du6uAF
 ZZzhitcXnwWwIutMjgjY+7v2cafZ+VGQqW7JKTFhMn+g4vLPULg0x9ngcNq5mlAKRIO2
 sRHg6z413X+knh41fIpD27b+upqQ2kX+FqagLkI/JwYcS8vrKl6/n6Kww+ATwWi2lkWd
 40NBqz/00UnoDVedMbzc1W3KFx90E8dLGzWi/9j/oMEIXwevhezAfjH8uBg2xK/uKFC1
 H0Mg==
X-Gm-Message-State: AOAM532NNjJFY2YaDP3MfgOyFXN5uTWAXVpGsHRfFeqoZrH9AWwwyOSF
 rZ2hvuGIhYJ7JEB21Cx/khaO2tA0MOk=
X-Google-Smtp-Source: ABdhPJwipHm0xuOYXp8zqZoEfh/Dlg3ShCakNWLXsUxg4f1H4clp48eLwDK2r7UWEv3BOSUXwrNiAA==
X-Received: by 2002:a63:6dc9:: with SMTP id
 i192mr22560694pgc.402.1591117323072; 
 Tue, 02 Jun 2020 10:02:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] tcg/ppc: Implement INDEX_op_rot[lr]v_vec
Date: Tue,  2 Jun 2020 10:01:46 -0700
Message-Id: <20200602170151.321389-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already had support for rotlv, using a target-specific opcode;
convert to use the generic opcode.  Handle rotrv via simple negation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.opc.h |  1 -
 tcg/ppc/tcg-target.inc.c | 23 +++++++++++++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4a17aebc5a..be5b2901c3 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -163,7 +163,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
index 1373f77e82..db514403c3 100644
--- a/tcg/ppc/tcg-target.opc.h
+++ b/tcg/ppc/tcg-target.opc.h
@@ -30,4 +30,3 @@ DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
 DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
 DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
 DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_rotl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index ee1f9227c1..7da67086c6 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2995,6 +2995,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
         return vece <= MO_32 || have_isa_2_07;
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
@@ -3005,6 +3006,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
     case INDEX_op_neg_vec:
         return vece >= MO_32 && have_isa_3_00;
@@ -3019,6 +3021,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         return 0;
     case INDEX_op_bitsel_vec:
         return have_vsx;
+    case INDEX_op_rotrv_vec:
+        return -1;
     default:
         return 0;
     }
@@ -3301,7 +3305,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ppc_pkum_vec:
         insn = pkum_op[vece];
         break;
-    case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_rotlv_vec:
         insn = rotl_op[vece];
         break;
     case INDEX_op_ppc_msum_vec:
@@ -3409,7 +3413,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
         t3 = tcg_temp_new_vec(type);
         t4 = tcg_temp_new_vec(type);
         tcg_gen_dupi_vec(MO_8, t4, -16);
-        vec_gen_3(INDEX_op_ppc_rotl_vec, type, MO_32, tcgv_vec_arg(t1),
+        vec_gen_3(INDEX_op_rotlv_vec, type, MO_32, tcgv_vec_arg(t1),
                   tcgv_vec_arg(v2), tcgv_vec_arg(t4));
         vec_gen_3(INDEX_op_ppc_mulou_vec, type, MO_16, tcgv_vec_arg(t2),
                   tcgv_vec_arg(v1), tcgv_vec_arg(v2));
@@ -3434,7 +3438,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1, v2;
+    TCGv_vec v0, v1, v2, t0;
     TCGArg a2;
 
     va_start(va, a0);
@@ -3452,6 +3456,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     case INDEX_op_sari_vec:
         expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_sarv_vec);
         break;
+    case INDEX_op_rotli_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_rotlv_vec);
+        break;
     case INDEX_op_cmp_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
@@ -3460,6 +3467,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_mul(type, vece, v0, v1, v2);
         break;
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t0 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t0, v2);
+        tcg_gen_rotlv_vec(vece, v0, v1, t0);
+        tcg_temp_free_vec(t0);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -3664,12 +3678,13 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
     case INDEX_op_ppc_mrgh_vec:
     case INDEX_op_ppc_mrgl_vec:
     case INDEX_op_ppc_muleu_vec:
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
-    case INDEX_op_ppc_rotl_vec:
     case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
-- 
2.25.1


