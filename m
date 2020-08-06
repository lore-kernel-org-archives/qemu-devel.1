Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A36922D3E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcpn54wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A36922D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dU5-0005iC-Km
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOX-0005UH-JQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOR-0007Ip-6k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so8415564wme.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oVvqKqlUGUYnxjk1oIPFfZzk4tyrvTEr7tv+ZDt5Avo=;
 b=bcpn54wMF6GymuKOsDDLoxwwiEsFleU/5z/m5wJq+ndG+040IDN1YSAwPjlcBZAlM1
 UN1d0f12Img+8uKgcN+VvlgSG+e04JyPU2KoiZsxPGuJHppTFAIyFIOEMC4qHeXJqgXc
 XxHf8YyxMpQBrXzm+7WqWu9la0vFrCmIdl0G5hZJXwnz5iS/lKQ8ZgROtOV4EAwbc4VI
 mtSA/+fnD9YfkTUFzKwGcxu1jJ4eH9Ur+rDZBYX3B6yzutnEaINQmYgpE2FTf90iAYM+
 sdbMC4yA9bD3m5Lu5t4eAhGrhxDBVgKyTjjAiWI3lC+/mwMsRVY/zXyAwDyiOAbAtHcZ
 SS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oVvqKqlUGUYnxjk1oIPFfZzk4tyrvTEr7tv+ZDt5Avo=;
 b=QmHn57RyhujZoZ+HSAxQ3CDOzjh99FTeR4CPYCMwsiHBOq3vFPozUBPSSImV/pQ3Yp
 MfTvqfmEdZzoK6g+RiyvqbZMrxUWKPv+1k919KZy4M2ZhwKwRKKl9uedLrUJEwn0qxXV
 BZYv/b7c5HiXu88EWywR2kk1twbwYCLL2yES7M3CSZL+m5LkOFaFBjEdqbOjzIxOU8Am
 Y9QqN9wnBgpQoeoyk8XNu5VTqEH0eoOgOomBE+gIC+GaS9B8i2rYKvXGKuxiBxY59QwT
 lgoy12HUUUlcpWaweqnIZrmaoMJFhSJ8nT4dBobITsMryWYelDAevLOz9IqpNOjNsGPP
 Lzmg==
X-Gm-Message-State: AOAM5308SpDEAIj6jGs2QIuRK8o6x+xev2gb7Q0AG++4uKzt2X44oM7V
 eP/0nbAiEXQkh3Td7jwkzPLY0aeeTA3sKg==
X-Google-Smtp-Source: ABdhPJzd3/P0IgR+Lwbu5iHEi/ag3uY00B7D2MUr+zWTkHtoVhWRgr8RbbcAHETl/Glp9RaDspBuGA==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr7586788wmb.25.1596710701609; 
 Thu, 06 Aug 2020 03:45:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a10sm6042189wrx.15.2020.08.06.03.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:45:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Use correct FPST for VCMLA, VCADD on fp16
Date: Thu,  6 Aug 2020 11:44:53 +0100
Message-Id: <20200806104453.30393-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200806104453.30393-1-peter.maydell@linaro.org>
References: <20200806104453.30393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we implemented the VCMLA and VCADD insns we put in the
code to handle fp16, but left it using the standard fp status
flags. Correct them to use FPST_STD_F16 for fp16 operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 5158dd14ad2..96e27e28009 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -181,7 +181,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -218,7 +218,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -322,7 +322,7 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
                    : gen_helper_gvec_fcmlah_idx);
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
-- 
2.20.1


