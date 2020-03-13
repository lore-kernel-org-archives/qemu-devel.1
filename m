Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8850CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D6F206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+SPbV+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D6F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZSq-00011B-HR
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCZOk-0001Kc-3l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCZOj-00066V-1i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCZOi-00064F-S8; Thu, 12 Mar 2020 21:46:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id c7so4025896pgw.3;
 Thu, 12 Mar 2020 18:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TTRtnjLmKGasCHgoCZZ6mIWvssKRcsC6jDX/Sfg7Vyk=;
 b=H+SPbV+0boI/qN54OFpGpaeB9SUxyl4uFMZZ4u0Hw/6FKBjD+VvORoA//L4qvwV5me
 VjK9tsNwZcmbR4YtJxq1CzdpAgobYWWWZxUi0OxOAWWymsYP4Ffa5qOZBO+k4fC0aJxq
 YvrHwRhnWiQ44a51kyZDoTE1i9i5YFovslzEnG1JM6Fr7ZaNb4SJYnfcJHK7PAy/HzgO
 jUkh4vW5NIPNXVJaf7Abl0Hg8gI1mwk87q8wmnT7foX0OKgN4bp8O3h5HnWYVCg1DXBQ
 72TatygVorrYcBfapjz9gHQz/0hQUqGgiuFejClLhfLDex57qkW/GHItS0Aa8I0cyJC8
 5kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TTRtnjLmKGasCHgoCZZ6mIWvssKRcsC6jDX/Sfg7Vyk=;
 b=HACIs+VccBEJC/5oxl3LT4xSFqVRsHu2NhO7E/efF8vuQK3jFUDWGI1t9Lif2tH8tV
 Za5cahuuqNb3jlk0/MyH2LLsSH5glXVcmLfTCIW1o3JQEFeBZ6nBbn7s46yIxrrgX97S
 qJH/5RB0lWW2Kp0lfgLC0wbLiDXITXgTYjAZtKF7RFCN+ZZKEWSaPgDzOYvS3WCqlFAj
 6VmwNhllHCREVq5T0POOAKer2HNRhcVTQJCeFukvuCfIuXK2wBCkuF8PWTW/4hXh1CV2
 NzXIH9kSo6MVvlj0RIlClICe3n2aud80yUdPI1pq8TjQVzEZKWaZz1/jpxUVMIWdOnuD
 MaMw==
X-Gm-Message-State: ANhLgQ2TeD4JDdEYFoJqOQzTnR8Uh0cuUpsF8r9qM90L3HRFYDVE67ia
 x0brR4KDBQvZbANprdIOH/Q=
X-Google-Smtp-Source: ADFU+vt+DmL4Ta2d2H7II9JY3/CUErtQJ1KZteqO6avn+xpKno1GU/R/d+H+gKgdHjn4qVvd01uBfQ==
X-Received: by 2002:a62:2f01:: with SMTP id v1mr11076556pfv.148.1584063959734; 
 Thu, 12 Mar 2020 18:45:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h64sm542092pfg.191.2020.03.12.18.45.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 18:45:59 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/5] hw/arm/fsl-imx6ul: Instantiate unimplemented pwm and
 can devices
Date: Thu, 12 Mar 2020 18:45:49 -0700
Message-Id: <20200313014551.12554-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313014551.12554-1-linux@roeck-us.net>
References: <20200313014551.12554-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent Linux kernels (post v4.20) crash due to accesses to flexcan
and pwm controllers. Instantiate as unimplemented devices to work
around the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: New patch

 hw/arm/fsl-imx6ul.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68d1d..a0bcc6f895 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -516,6 +516,20 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR, 0x4000);
 
+    /*
+     * PWM
+     */
+    create_unimplemented_device("pwm1", FSL_IMX6UL_PWM1_ADDR, 0x4000);
+    create_unimplemented_device("pwm2", FSL_IMX6UL_PWM2_ADDR, 0x4000);
+    create_unimplemented_device("pwm3", FSL_IMX6UL_PWM3_ADDR, 0x4000);
+    create_unimplemented_device("pwm4", FSL_IMX6UL_PWM4_ADDR, 0x4000);
+
+    /*
+     * CAN
+     */
+    create_unimplemented_device("can1", FSL_IMX6UL_CAN1_ADDR, 0x4000);
+    create_unimplemented_device("can2", FSL_IMX6UL_CAN2_ADDR, 0x4000);
+
     /*
      * APHB_DMA
      */
-- 
2.17.1


