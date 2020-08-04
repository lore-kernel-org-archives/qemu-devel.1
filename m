Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85ED22B42
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lslg8Jtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85ED22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2koE-0002C4-0d
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 20:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Z6soXwMKCmANAAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--pcc.bounces.google.com>)
 id 1k2knb-0001fu-Vi
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:27:23 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a]:45396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Z6soXwMKCmANAAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--pcc.bounces.google.com>)
 id 1k2knZ-0006Yh-RN
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 20:27:23 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id k17so13421056qvj.12
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=NdI/lRvciywZTVwluPi9hRS2Qi8JdRc2jAMCVsyj+YA=;
 b=lslg8JtguB3I70C/3fIUX77sfu64t+DvwInYRQPOvTIwDuMgdhrcRGDnjQpZEIOUV1
 n8lhaqT6z2XwzirHU1c6Is9s+ihUNSBq5S3gjRcSke14qGDkaMQxWpk61fX+/r0Yxqg2
 Zco64D0PRVPLrnXH7tLGF4DSeFolWJAI5OsCjpBBNEiFEGGjpxAbO5SIhW+AUAphDojs
 oBoOtypM9wmtl6ccDK/gL8v7Yye0M7wLgl/d+lrFoZTwQqQXQ1Uq6Sts1DXfktYLczWD
 UxPtGsNVhIbvqOwS39jKUlzoj5o3shnomQOvM6iFxSMXjW8RqOfAkWA3YBiJWM2qA5pN
 Rgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=NdI/lRvciywZTVwluPi9hRS2Qi8JdRc2jAMCVsyj+YA=;
 b=iwQEPs0m4DznBSvOe37XdQ5e3bWQQmCrhSUI0N5lgFkvuhoDU80ZnSMAQu9+OupSum
 KP5Kogg3Q/u/AP0N9axp5aeW9N9F8XQ4cBDv+cSy7oKcKZl2L2peXjwTuP+6WjwDr85k
 1vz7shpXLAiYgVgB7YTJ+05vKXuOJVsOUWKYZbwBpBi9PpKMiXS+ULi4NGkclMFL3wdz
 hKuz3ojJvg9usX9cD/BqVmEIZBI9fme8i22jMJW55gX0EMCo+X0ueVQQpyyt/TVF2BGt
 517uqc+7cAtraqUzIkMWr57UG5zOYohCuGvfc47V9ubdsP1SBMuswGwvSfxE8i5S2Pvk
 uEng==
X-Gm-Message-State: AOAM533Yt4ti8605+fL2NpbHhr8O3bKflpdExHAWapADMyyEA9BcIoe3
 Bw+708BzxtAgZwSNO96HsH0JIZM=
X-Google-Smtp-Source: ABdhPJwrMdiBuOd7iTC2k8X4GI59jycQKE3C3WSVc9nXa5tOv3aSnWQ9N6eUDuFiT2oHfnPuLmIf670=
X-Received: by 2002:ad4:44e9:: with SMTP id p9mr12513721qvt.112.1596500839100; 
 Mon, 03 Aug 2020 17:27:19 -0700 (PDT)
Date: Mon,  3 Aug 2020 17:27:11 -0700
Message-Id: <20200804002712.27733-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] target/arm: Rename function disas_ldst_pac to disas_ld_pac
From: Peter Collingbourne <pcc@google.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Cc: Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3Z6soXwMKCmANAAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--pcc.bounces.google.com;
 helo=mail-qv1-xf4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The name disas_ldst_pac is misleading as it implies the existence
of authenticating store instructions, so rename it to avoid that
implication.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 target/arm/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c0764957c..749de2e509 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3408,8 +3408,8 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
  * W: pre-indexing flag
  * S: sign for imm9.
  */
-static void disas_ldst_pac(DisasContext *s, uint32_t insn,
-                           int size, int rt, bool is_vector)
+static void disas_ld_pac(DisasContext *s, uint32_t insn,
+                         int size, int rt, bool is_vector)
 {
     int rn = extract32(insn, 5, 5);
     bool is_wback = extract32(insn, 11, 1);
@@ -3562,7 +3562,7 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
             disas_ldst_reg_roffset(s, insn, opc, size, rt, is_vector);
             return;
         default:
-            disas_ldst_pac(s, insn, size, rt, is_vector);
+            disas_ld_pac(s, insn, size, rt, is_vector);
             return;
         }
         break;
-- 
2.28.0.163.g6104cc2f0b6-goog


