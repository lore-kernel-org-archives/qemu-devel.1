Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A93C46478
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E542054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpb6uRVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E542054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhD7K-0005Oo-9E
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyE-0007ze-7j
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003cr-6p
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003Rr-KD
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so11444878wmj.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=emP6dWoUPqOedFjKNUj+V8rg9amcwEcg4Kk6M44arTs=;
 b=bpb6uRVbngu7JnL0cxiBRFzetqIf/ZajCN02bzgJUPuLSP20iSeQ5ybNsygMGzrmU4
 0D/U78WoWiD+w+Q7fbn99n/hOWyEGD51pYNa5dHmTqhrkOdGj/kvE20B/odbT8nUvO/s
 BVxFS2/M4Hl+riV+zHy+Ev6tzOpgAVOlSOnx/z4DgrWkgDYW2TQ2eRzIsa8ONVMxhe7+
 nUeUnSORv0ep2IQxwwgXlz3ux1iOXJl9m6y39INiCma0ufpjwMenXnFa80NS+g0tf+nQ
 h0c/uN3sxFyLjiPBSYXds92c50sK87gLoq161UX7hFNMQc8s+cLbiR8w3yOd5MVwNrRL
 ugAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=emP6dWoUPqOedFjKNUj+V8rg9amcwEcg4Kk6M44arTs=;
 b=kKB6o3fjkHpLlba1TAn/CU5l5BCicc+D0LFe0TVFcQJYCdmy8zKaucYBuML6n7BjQU
 JCAkh4RA9tluvPwi8j42rwV6NUfrFdNcOHGJrYKOLTjkyFyWqNYapmsq4B+2MI/DzAiF
 bQmBpzairGhOFPZ5LAgU7fKWO9/9aTd0Jbxh/pWRyZrIvqLG1YFnKkBSeSCVvOTItJMD
 KPhQNkdUmNVqAHjc2ko+hMWJy6inOFaVC/YWm8+VqdBoAS+MjtStOaVpuoeWWG6mrBMe
 FozA3ujFUGR6+NN3bCx6e0DE8Q5oj7lnibtBotOd8PxzenN9tG+1MCmjNnY2AxsOv66x
 nBZQ==
X-Gm-Message-State: APjAAAXzXBYSkReMbBA+1RS1FGhVyMA1j+g7aRcb2AD4TTRUd8dvfdvT
 7aic4qVy7YrG8NO193TcMzhfHkCenJpMxQ==
X-Google-Smtp-Source: APXvYqywcDDdaIX+5xBZVHCDulgOKCDxSflh66/k68mh6DxWhfHRLpWT3RHAlbu2XTjJeRZxxeKa2Q==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr10796331wmc.53.1561813229143; 
 Sat, 29 Jun 2019 06:00:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:11 +0200
Message-Id: <20190629130017.2973-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 10/16] tcg/ppc: Support vector shift by
 immediate
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Altivec, this is done via vector shift by vector,
and loading the immediate into a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 58 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 368c250c6a..766706fd30 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -152,7 +152,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index e19400609c..7ddef950f7 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -517,6 +517,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
 
+#define VSLB       VX4(260)
+#define VSLH       VX4(324)
+#define VSLW       VX4(388)
+#define VSRB       VX4(516)
+#define VSRH       VX4(580)
+#define VSRW       VX4(644)
+#define VSRAB      VX4(772)
+#define VSRAH      VX4(836)
+#define VSRAW      VX4(900)
+
 #define VAND       VX4(1028)
 #define VANDC      VX4(1092)
 #define VNOR       VX4(1284)
@@ -2863,8 +2873,14 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
     default:
         return 0;
@@ -2971,7 +2987,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
-        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 };
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
+        shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
+        shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
+        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3018,6 +3037,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_op[vece];
         break;
+    case INDEX_op_shlv_vec:
+        insn = shlv_op[vece];
+        break;
+    case INDEX_op_shrv_vec:
+        insn = shrv_op[vece];
+        break;
+    case INDEX_op_sarv_vec:
+        insn = sarv_op[vece];
+        break;
     case INDEX_op_and_vec:
         insn = VAND;
         break;
@@ -3062,6 +3090,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
 }
 
+static void expand_vec_shi(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGArg imm, TCGOpcode opci)
+{
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+
+    /* Splat w/bytes for xxspltib.  */
+    tcg_gen_dupi_vec(MO_8, t1, imm & ((8 << vece) - 1));
+    vec_gen_3(opci, type, vece, tcgv_vec_arg(v0),
+              tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+    tcg_temp_free_vec(t1);
+}
+
 static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
@@ -3113,14 +3153,25 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGv_vec v0, v1, v2;
+    TCGArg a2;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
     v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
 
     switch (opc) {
+    case INDEX_op_shli_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shlv_vec);
+        break;
+    case INDEX_op_shri_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shrv_vec);
+        break;
+    case INDEX_op_sari_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_sarv_vec);
+        break;
     case INDEX_op_cmp_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
     default:
@@ -3321,6 +3372,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


