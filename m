Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1FC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3C3206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0n1MCn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3C3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43195 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmSn-0008RG-3R
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJT-0006wT-OQ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJS-0000zE-Mk
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:36556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJS-0000yw-HE
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id y22so9268896pfr.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eU6/QJc2xrfxfZzNiKt2RQhZfpRk2OkG4frCv/G8gNE=;
 b=D0n1MCn1OXfFigXAA5xSt0gWCnuQh0ZEPybHgCtzZJgA+letvrTa8Bg92b1PvV+rTe
 t8LJw4HT5JfnSsfLu3mK0w4Wa14Zwvf6lYC+67FhhgjAgjnWa4Gzn/idkii34qC45oOn
 OvP+BSP5mbP6pw5el8vj3D6h3OyOKcdYYx4yXKEoV4xTMs2PTzD/7A5AJCvW1EjDfSV2
 sv9uAafgUZGHfmjnt2Wg7JVWxGV1r1rC+46WlX7Rqc0PrlaensGGe7lu/L7NWFvApOmU
 kgUJLMveDlNpGfHL0jM8NDh56ipMFMQZvc8HanMieBGSPiSWyA1OOMUshgdftntZX1at
 VCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eU6/QJc2xrfxfZzNiKt2RQhZfpRk2OkG4frCv/G8gNE=;
 b=iCVP7vZTxBGrcPOgO5j+jmQhXbKJ+kQXJQUPDD3TayFU2gAkdNjh1H2F/I1jilS1xf
 uATqurUTK4eHOiNZIPF/IhaPDjgckwbHMYCY6T987Ua4tAJosT+Kl46dSc954GrYcaW+
 zRovArJW2SuxUwun14FhC460aNOKIhnVgygkmNvXLTka7T/Dbik7x3xoqlufoY9DegX1
 9KKaJbSGE9II/GdccXgKjzq1DQUeVksfnBcKpIexcbL0rx/LuGdNkolM/QGVRnosvFT0
 VxUq7BNWT/5CXePxl9CssVY2pBVbODsyqzXGKL2gxfRgUMCVEuzEGeCCm8bzSLir6sOM
 fhxw==
X-Gm-Message-State: APjAAAV2JX9HNvEQMXFSs1hDnVl5wSfJofGHAMeu3L/q3qYIKN3DPUXu
 8t65I/vQBi6Efmh3EN23tEsIBPEfYwE=
X-Google-Smtp-Source: APXvYqwm16q6DyxW0FHvkhsXhdapRJ5meYnJM9Zx5gdcMsw8slGM4+4zR+bwDecgsJbhAs6cuGBGWg==
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr32394179pjq.96.1571005564950; 
 Sun, 13 Oct 2019 15:26:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/23] tcg/ppc: Support vector dup2
Date: Sun, 13 Oct 2019 15:25:35 -0700
Message-Id: <20191013222544.3679-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is only used for 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d4b3354626..8a508136ce 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3102,6 +3102,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_dup2_vec:
+        assert(TCG_TARGET_REG_BITS == 32);
+        /* With inputs a1 = xLxx, a2 = xHxx  */
+        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
+        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
+        return;
+
     case INDEX_op_ppc_mrgh_vec:
         insn = mrgh_op[vece];
         break;
@@ -3480,6 +3488,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
     case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


