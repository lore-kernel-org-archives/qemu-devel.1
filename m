Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8CD206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLJPYVYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8CD206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0lH-0004dI-74
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0it-0000bb-5H
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0ir-0001UD-IT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:02 -0400
Received: by mail-pl1-x641.google.com with SMTP id b9so4749920plx.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lOHdNtnGRgA8GSOMatWc2CH3AkgDKMG7+oF07eCfw/c=;
 b=jLJPYVYh6hin9xv3K0vjweMbM5AEPCEJEr/o+Z1tvwk/0HuJDhzzRMFrnDnQumwPVG
 gKUlIPwyALqzN1UGy5o9cwC6aFw5fqF06i6hM/JaKfDcd4mH2azd9AMU2G7fefTurh80
 ERcfxMt6BCVz78DCOLhrsuqobfAz2sBmp9kNi9fbrKN9cm8XYHxWz2IN6C724bbbfyat
 0xT3YzAZi3AF5Ny2XtkjRKWPaRG6j7DHwd633v5vRfjRUfitba5JAOnP1uSE7qBZPtQA
 T9R2VDPc/WCr//R6oqkW+/wvbJ9kFVb+F7NFJ/mOBli/qKcYyDZMGkLUL2FVjvAsd/kn
 hRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lOHdNtnGRgA8GSOMatWc2CH3AkgDKMG7+oF07eCfw/c=;
 b=SKXyZyE/z9lLvka4+fTGJ4qI8E44UZomBm7mrNyIYZaM7GDeX9kgq90U2WCMC5gk4M
 AxyWW5stIc9uLfsDBXPMWL4BhWfmnW19nK2GDqmPMB6zrKh1k23c6tbUufLICspaNEAU
 2+YGj4B1joCL6RJ6QMVzKmLI1vtw2MMpBrOLxeAWqmUKEp8MHMysfM+CWwkcG4unoSrs
 rM97Sinx4Kt5sok5fkx3xMvTJ9h8fR72BMCGrTBxYVdHIrjqOg5uoP8YrWefzrMuL26L
 8cA7PIR5VVnxG3L1ypgDVef/K8OacLrveVRH4IQY1/5ybgzCpBPcRpbI+P9otaZHkhwl
 Cwfw==
X-Gm-Message-State: AOAM532HE7s/ESOfFq1NdoF3iHD3/4wV1dY0Jcdm4VlWaTZFIXgh3x4O
 GmjTF9o0QRdx0IqFDo+YBzJ6UBkurQM=
X-Google-Smtp-Source: ABdhPJyNZdOOCHqEGa6agTWPXMiiJCseXHK9+9EC6PoMDDdJMkfVcmvedfTTiBFnblZSfJrT6JNZqA==
X-Received: by 2002:a17:902:e904:: with SMTP id
 k4mr3448584pld.156.1595608738183; 
 Fri, 24 Jul 2020 09:38:58 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r191sm7261663pfr.181.2020.07.24.09.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/arm/boot: Fix MTE for EL3 direct kernel boot
Date: Fri, 24 Jul 2020 09:38:52 -0700
Message-Id: <20200724163853.504655-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724163853.504655-1-richard.henderson@linaro.org>
References: <20200724163853.504655-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: peter.maydell@linaro.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When booting an EL3 cpu with -kernel, we set up EL3 and then
drop down to EL2.  We need to enable access to v8.5-MemTag
tag allocation at EL3 before doing so.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c44fd3382d..3e9816af80 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -739,6 +739,9 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_pauth, cpu)) {
                         env->cp15.scr_el3 |= SCR_API | SCR_APK;
                     }
+                    if (cpu_isar_feature(aa64_mte, cpu)) {
+                        env->cp15.scr_el3 |= SCR_ATA;
+                    }
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.25.1


