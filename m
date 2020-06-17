Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6273DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF522168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRM0C7pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF522168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfam-0001XX-E2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE7-0003Gm-4n
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:07 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDz-0008VC-QP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:06 -0400
Received: by mail-qk1-x743.google.com with SMTP id q8so3450292qkm.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0fBrT3P1tRSLH4phcxb7WjFxDduimB9rIeQgvMHfic=;
 b=IRM0C7pFoTg1L2sxI+taEDC+ZG+BeUGjMY10i9SdEfHlp8J4ikn0QpCpjT46EbbG7F
 Li03oMkZyZCDVCAxh4gcJInYBus6QuVgHT4CV7kc8Gt0TjbpI/AAZmd2zo5h6cboMpG2
 MG41Mt4E1It1M/E+CwmPObEW3vvXzdtG0YjZz0VtaoQl/30CDN3DfcIDju2vzBOr1XYk
 2PI3lsk8tJ1QWxJctVPOR9SBT+3UXu7aQfY1S5OmtS+I0UPe2KJiUuucUr5HX3t4YVUA
 fthaMmkKyjP5VQoUWnEC+VjpbVulj2QKs+2MUExykcqKdFup8m+kEx5mYsAHS6/E1OgF
 Q/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O0fBrT3P1tRSLH4phcxb7WjFxDduimB9rIeQgvMHfic=;
 b=DszzcW2csKduhfqt+QrMOaoZZkSSn5Q8TBk/+rOxd/NdlvJlYcK0GdY7Z15GF3LgsJ
 wORLddRiT+/8/aFL2Qnxu2pTEaaCPXVTVRJ3IvbVUbcK2zOPzoBVAMhHsxZvjyeEKarU
 420ZhkdG+Ich0Xbv5UBrP3tZG2m02Mu/UyiIg0YqfFkFH4nbLOshG0BpztRCRJ+irCcq
 9tIOQxy6aFa2O7msuibg47D2HRkVdCfwrqrqBSyiKIvruQEGUkW+kAc7xkMrQF3O7Qjr
 eidIxcAUhwM0g+CO2kePsxL/KCHvgbkE9MK5STYjNuam1wGaxziOYCLMI5rN1hOFskzK
 Zyzw==
X-Gm-Message-State: AOAM532YK1A9LVJ4ZSD+XcK4aY7cLbHqNuTZAlPhI44rQzbkKxIGXWtX
 mdZn3H3WFsL92CPmuwDOhaIHjzwu3pLDJw==
X-Google-Smtp-Source: ABdhPJxp01N+0tR1SNc6jCm8XkcTNe3ng9IOq+hSRY/lAQXSe/KRtNsuZN9EZ800nJwotnufr0Tvsw==
X-Received: by 2002:a05:620a:2213:: with SMTP id
 m19mr608072qkh.244.1592427838111; 
 Wed, 17 Jun 2020 14:03:58 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:57 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 29/73] openrisc: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:47 -0400
Message-Id: <20200617210231.4393-30-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: peter.puhov@linaro.org, Stafford Horne <shorne@gmail.com>, cota@braap.org,
 alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index d9fe6c5948..2615571ce7 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -134,7 +134,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
             cpu_restore_state(cs, GETPC(), true);
             env->pc += 4;
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             raise_exception(cpu, EXCP_HALTED);
         }
         break;
-- 
2.17.1


