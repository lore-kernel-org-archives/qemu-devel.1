Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9427DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C10F20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFKLlZUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C10F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhaI-00042f-JI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHF-0003R7-2p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHD-0003Nf-AT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id g18so11115058wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MBKYbSiXN65dT2RVlfq1Jpp2c5vfU6vQcHV1D6oFaoA=;
 b=vFKLlZUX6uRZP0irqipsg6uEeRN5XOZbQ0Bpr+2Jw54FB1wxs7RQbhXSf6XwLxLl5e
 LoSyMqcAiFV3VGHylsT3CG4EjYWQI8IFrDNHnWsADnwqZElruiBtxlofSQ5GCq4P1YW8
 t2qhqBoRKSl4Gmn/1+Vn0XvJj40djmDG55mXGgma4PlT3PdlbU+26mY9oj64/7UkECfz
 ndagV42m3kGoHHxnWipn2OPBK1lViX6+dDOK0WdPJwRqO/ZUeh669ftvwB9tQ7e2Woc0
 H/CE3WTLUr84vjEtLn4GzkViFVZrEysV4DP3FmB0But2/HbgC7IqNixm3YTT3iICAPgd
 2uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBKYbSiXN65dT2RVlfq1Jpp2c5vfU6vQcHV1D6oFaoA=;
 b=i70E1XD9BZ8Pa/sfUDkgcqNeUmCGZw1Qwjn8xttUISIQ96V4uWTigLHVOX45dShdva
 10E2m//SUitrNfSWO/Iamq1ECI0Ng7e9nFdMs2K3NndpUwSSsTiiLWYt1PCexRPEdFjX
 yy05HK7y3YvX0sN5Ek4q9WZxr09L9PN2Q6K9ZHH9z9rdqD9yheHNXxLSfIvxZshoyIF4
 bCAQPJcwQkk12/AsemNqmG31y5NgQV+GpcL2lOf5QGJvCF3QLdp1EAbtK3Gf8BfCMMUS
 szvnVNeDN3rxWplHOiyZ/PSoApHpB0zJxkwT/WLv+DhSNXoU4dswepJhEjYTvyvwqfbf
 +BUA==
X-Gm-Message-State: AOAM530fjUYYxbOI/uGS0JMf/RQ1HSt1UNCt5EJMhW8936fubIYKpbfy
 WiT0jm1eGqTNyVHDyhD6731L19YkgPq6PA==
X-Google-Smtp-Source: ABdhPJyxiOqVu4JJS7ZA10w0jmk5MYJ6HxHAvtCnHlHzvxuhaQPECi99sYMO/g96pOXKcfWoblo/DQ==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr25089905wru.399.1592912381507; 
 Tue, 23 Jun 2020 04:39:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/42] hw/arm: Use TYPE_VERSATILE_I2C instead of hardcoded
 string
Date: Tue, 23 Jun 2020 12:38:52 +0100
Message-Id: <20200623113904.28805-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

By using the TYPE_* definitions for devices, we can:
 - quickly find where devices are used with 'git-grep'
 - easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-6-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/realview.c    | 3 ++-
 hw/arm/versatilepb.c | 3 ++-
 hw/arm/vexpress.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f3c00fe00cf..b6c0a1adb98 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -26,6 +26,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -282,7 +283,7 @@ static void realview_init(MachineState *machine,
         }
     }
 
-    dev = sysbus_create_simple("versatile_i2c", 0x10002000, NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 2ebdcbd8ac3..e596b8170f4 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
@@ -314,7 +315,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Add PL031 Real Time Clock. */
     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
 
-    dev = sysbus_create_simple("versatile_i2c", 0x10002000, NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 7ca5d523a4c..24d656e6537 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -42,6 +42,7 @@
 #include "hw/char/pl011.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -640,7 +641,7 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
 
-    dev = sysbus_create_simple("versatile_i2c", map[VE_SERIALDVI], NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "sii9022", 0x39);
 
-- 
2.20.1


