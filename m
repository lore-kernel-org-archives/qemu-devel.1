Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290EC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BACE2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlx3UgxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BACE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv68V-0003G4-Rg
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv659-00081T-Q4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:51 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv658-0004X3-89
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:51 -0400
Received: by mail-pj1-x1044.google.com with SMTP id md7so519340pjb.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DIdbI/TyoASf3/tuMyHXAq5AcBUAtBDJaojE6aqGDY8=;
 b=jlx3UgxF36aRyoGqa0A5weot5N48d4/gDVwwqcd/PmWFXXcN9qwrU6sQl7sGbzLOwb
 5FY2tt+bisnoVfmprVOfR6bS1kDFbazygT8ZIs2NH4oefSBeJWUsEcpnUkHrQNIyzAuw
 sEM3RKpsy0WqxQ/BRULMIarC9HXlQtrP70fHYFgMAz4jDrAWAk/aVw0XF/hXSfTkwSKz
 3T+t6GKtncVcD9O0Ks4KoPkC28N0OB5YtHIZZZBxsU0ndtFM85IPGUn9luYrnPPvICnX
 u0CkWFzDlFv4v665h5Ey/J1EoFSUHKzRL0XE9T7/N7v3sXa4ckDeX/2AZON9A/CtK3T5
 ys8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DIdbI/TyoASf3/tuMyHXAq5AcBUAtBDJaojE6aqGDY8=;
 b=uiK/LpcIL2YDYbHt8+y1iWHIAe+Pm5Irk5XIQIny0HSWPxiwNJ+NzX+IW0ZmKqffbt
 bTY4EtXGKe8lE+WBskYnlQRjwKORtVWoZEGf0s3Xuq5WxoTL0eLfDWEjkZVpClENFY5A
 4417ixv90bfa4YYKaQ8Dlp63/9DqgYvHj6R+2DWvKPHh7rOWWoeIXGmO10/1WoKbWY+P
 76YJCttgHCk/8Gs82+jwtJ+14M8uFxNvVUMi5dKbZ+u3plt7GH3XIpQloAL6TR2lWCXb
 0ScCMiNrZh63TNAZtkcbNBdVW3K5OwfTHRxxbiDIzxZ/DZYOu/hXUraxFN46Mkxk9BV1
 GGMQ==
X-Gm-Message-State: AOAM530Wfzsh4Wy0evdK8UCiA25cybmxR/EBGjaMmzHpO13RvUOjriLX
 SzdETmio2zCJSbPkA+FtrFTVhwHsE2w=
X-Google-Smtp-Source: ABdhPJyPuMPRzQGWbdb31sF59vQxPytgTy7wkBhq90mawdCT0IjQ0PLOc12P/YOkhZOBN2CTMqCwxQ==
X-Received: by 2002:a17:90a:1901:: with SMTP id
 1mr1393604pjg.199.1594676028548; 
 Mon, 13 Jul 2020 14:33:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l207sm3591565pfd.79.2020.07.13.14.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 14:33:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/arm/virt: Disable memory hotplug when MTE is enabled
Date: Mon, 13 Jul 2020 14:33:41 -0700
Message-Id: <20200713213341.590275-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713213341.590275-1-richard.henderson@linaro.org>
References: <20200713213341.590275-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When MTE is enabled, tag memory must exist for all RAM.

It might be possible to simultaneously hot plug tag memory
alongside the corresponding normal memory, but for now just
disable hotplug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a7f3d442db..ecfee362a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2194,6 +2194,11 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    if (vms->mte) {
+        error_setg(errp, "memory hotplug is not enabled: MTE is enabled");
+        return;
+    }
+
     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
         error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
         return;
-- 
2.25.1


