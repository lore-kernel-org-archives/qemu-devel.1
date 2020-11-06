Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA518C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A99A206FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4668tyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A99A206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBZN-0001Vv-2B
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbBVl-0006BA-U3
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 18:51:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbBVi-0004XZ-JK
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 18:51:17 -0500
Received: by mail-wm1-x341.google.com with SMTP id p22so3011623wmg.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 15:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ciIxu8fgfHqLwzeZe9kzt7oqxoPUcHRTdGjgpHaZohw=;
 b=W4668tyxn/0cj88UQ1FP5bqj7dji5vObycPBabRnBtNNBiE7nRTaBVhaQWxQE8GROf
 zYI3VmTX5BVs83tVHTxhM9J5PXiZENYXLaL5/bMVTLst8k16Vsf0oHMoOadKAEaIE4mL
 VV4Va2EeNZtdqacMv8hK/PIz0tC6rzZaDE2AmxqzWbJpZtPHWFgJ4aLyWYigtk+zKrH0
 fXvPFyhqoXNaMYmncGJQ5ESr58lLruZ1Lac2EnGlqiRgylIu5gnocCrxH2QOXuYPpkzs
 FuCoGSH49PnNXtdwyxoTu1ysFxcu1vV7B9EGQeDN84bJXiTIgIBqFbeYVFwGvuSTI4Ag
 9OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ciIxu8fgfHqLwzeZe9kzt7oqxoPUcHRTdGjgpHaZohw=;
 b=Lzx/Rd8KZzI+c+fKgRn5anr4wkJVKSheeapWO7DegQldkKpMRGA3W28VlgAauNnzoR
 +vGORKuVRqhHhACOAazPz1CA/0pJdj8pvIi4h1+p5w5o+oWgYD7SHbx7+FuYaiQ/2v7d
 BcV2nL8WNwrUzTs+Pwjw7KL/jXfdnlybj7y3GeLrAzAgn8xDc1dVSM4lEY7yUmdOJEst
 NkJKeV/6dYncqbs3q1W1v04k+TkeR4tq+LDL9+yvpFhIgA/W1a+VAAc9BpNLRaCNcxox
 ZSY5w8IHGQWyx/EVFVxzYE1OsGDjY0UbHq4KxTUIyU1IWm922/fy6vogDLaPCe7Pp7Lp
 eevA==
X-Gm-Message-State: AOAM532zkHA+SubB0rxe1jjstzF0XetqqP9PYcqOCM+NYsSyutwfBMqi
 Eeaf0GVC5WPMKdfRyvDcMFiK89HOBusRug==
X-Google-Smtp-Source: ABdhPJwlcVvabq9ZbZ2JTWQYniTKPz3dUCLsxCtxUyHBEFA+z3E5GG4RwdAHorKuBGFcU5d5ir59DQ==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr1980037wmg.62.1604706672408; 
 Fri, 06 Nov 2020 15:51:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n8sm4025374wmc.11.2020.11.06.15.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 15:51:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/m68k/q800: Don't connect two qemu_irqs directly to the
 same input
Date: Fri,  6 Nov 2020 23:51:08 +0000
Message-Id: <20201106235109.7066-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106235109.7066-1-peter.maydell@linaro.org>
References: <20201106235109.7066-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The q800 board code connects both of the IRQ outputs of the ESCC
to the same pic[3] qemu_irq. Connecting two qemu_irqs outputs directly
to the same input is not valid as it produces subtly wrong behaviour
(for instance if both the IRQ lines are high, and then one goes
low, the PIC input will see this as a high-to-low transition
even though the second IRQ line should still be holding it high).

This kind of wiring needs an explicitly created OR gate; add one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/q800.c  | 12 ++++++++++--
 hw/m68k/Kconfig |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ce4b47c3e34..dc13007aaf2 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/or-irq.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "ui/console.h"
@@ -171,6 +172,7 @@ static void q800_init(MachineState *machine)
     CPUState *cs;
     DeviceState *dev;
     DeviceState *via_dev;
+    DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
     SysBusDevice *sysbus;
@@ -283,8 +285,14 @@ static void q800_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnAtype", 0);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_connect_irq(sysbus, 0, pic[3]);
-    sysbus_connect_irq(sysbus, 1, pic[3]);
+
+    /* Logically OR both its IRQs together */
+    escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    object_property_set_int(OBJECT(escc_orgate), "num-lines", 2, &error_fatal);
+    qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
+    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
+    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, pic[3]);
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
 
     /* SCSI */
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index c757e7dfa48..60d7bcfb8f2 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -22,3 +22,4 @@ config Q800
     select ESCC
     select ESP
     select DP8393X
+    select OR_IRQ
-- 
2.20.1


