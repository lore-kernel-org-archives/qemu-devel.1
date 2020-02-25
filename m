Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEACCC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725D2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqXuYXG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6etX-0004Ph-Lp
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6esr-0003tj-V7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6esq-0003rx-Iv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:24:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6esq-0003or-BH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:24:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so208575wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hlelqfIWVmI72/3gUGEctsr+NvJ/BDNB42f/K9zNjaU=;
 b=SqXuYXG30MjayQimou0Dob2Aq+HcMKVWvxQLDs8XnHnebdZYDAhutN0Lk1IsflJleB
 O/U7IzrRUijfCYTJCtvH7Ia1TquxohchnGW57hYfmqNMzYFxHMhE4NRUdBjY5CrMZBXy
 xLOAY2X6gxJlr7/xDTZctLBORvmRMeCTetN1EH++iuah6VGriAE5nj+tk7tDEGHNnjkG
 i3fodrKetr9/2z0e79vMDpAMCz0ymfqlJXRb2sfAxDK9tdfVv6NbOXNK4ykz02+lTvR0
 UY95CX3CEhD0iP4d/5ferpVkuPjMbLlwnrDVDxiGHg8XHoXRyM6ocWjMURbWsewcMXrG
 mnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hlelqfIWVmI72/3gUGEctsr+NvJ/BDNB42f/K9zNjaU=;
 b=WptFMaX+tC6yghVI4oP3N62S/ijQBF7Y5HAYOC/FDWMRY6WZnhvFGYXXH2fh15bG9W
 p83wsGPYdSssD2uPRbJhMtUS0tzL2WinG3Q9mJ2r7RA5J7A97GGqxnCTDgv6UNk064rP
 ZVi2m0yfA+EwLWVkqAmU2yyB1HYcYIbIgpiSx52hhkVQcUuXUG1tGTMM5HZWrL5zMpXo
 sbPu3XuljJ+ls8Yf/Ydbj8jWvCmwztCS1QaCq8zeTNB2QJiAEO6oXPoxUDBCZepUKqal
 MedTZFrJL2EYEhi6uM0D+Yf5nJowe6MTMJSdOcfb4jy2QI9Wjm5YkeKD7v6Npe9/zPpR
 LO1Q==
X-Gm-Message-State: APjAAAX5xA1k5MbdYz+V1wAxM4G3U5b7Yg5M2l3BT34o5B1RJvdze71z
 1p+2PUGuKtqtPOFy6b+xiCYfBA==
X-Google-Smtp-Source: APXvYqyfyyy1VpfKJk90MVu3TLSOxoD4aJB4jC5m8PijJzuaoILKZ3L16OPX5iWdMYjBV36owPhAHA==
X-Received: by 2002:a1c:7f0d:: with SMTP id a13mr479289wmd.182.1582655079012; 
 Tue, 25 Feb 2020 10:24:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c26sm4794560wmb.8.2020.02.25.10.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:24:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/arm_gic_kvm: Don't assume kernel can provide a GICv2
Date: Tue, 25 Feb 2020 18:24:35 +0000
Message-Id: <20200225182435.1131-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In our KVM GICv2 realize function, we try to cope with old kernels
that don't provide the device control API (KVM_CAP_DEVICE_CTRL): we
try to use the device control, and if that fails we fall back to
assuming that the kernel has the old style KVM_CREATE_IRQCHIP and
that it will provide a GICv2.

This doesn't cater for the possibility of a kernel and hardware which
only provide a GICv3, which is very common now.  On that setup we
will abort() later on in kvm_arm_pmu_set_irq() when we try to wire up
an interrupt to the GIC we failed to create:

qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
qemu-system-aarch64: failed to set irq for PMU
Aborted

If the kernel advertises KVM_CAP_DEVICE_CTRL we should trust it if it
says it can't create a GICv2, rather than assuming it has one.  We
can then produce a more helpful error message including a hint about
the most probable reason for the failure.

If the kernel doesn't advertise KVM_CAP_DEVICE_CTRL then it is truly
ancient by this point but we might as well still fall back to a
KVM_CREATE_IRQCHIP GICv2.

With this patch then the user misconfiguration which previously
caused an abort now prints:
qemu-system-aarch64: Initialization of device kvm-arm-gic failed: error creating in-kernel VGIC: No such device
Perhaps the host CPU does not support GICv2?

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I spent a while wondering if the PMU code was broken before Marc
put me on the right track about what was going wrong (ie that
I hadn't put "-machine gic-version=host" on the commandline).

 hw/intc/arm_gic_kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 9deb15e7e69..d7df423a7a3 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -551,7 +551,16 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
                               KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true,
                               &error_abort);
         }
+    } else if (kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
+        error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
+        error_append_hint(errp,
+                          "Perhaps the host CPU does not support GICv2?\n");
     } else if (ret != -ENODEV && ret != -ENOTSUP) {
+        /*
+         * Very ancient kernel without KVM_CAP_DEVICE_CTRL: assume that
+         * ENODEV or ENOTSUP mean "can't create GICv2 with KVM_CREATE_DEVICE",
+         * and that we will get a GICv2 via KVM_CREATE_IRQCHIP.
+         */
         error_setg_errno(errp, -ret, "error creating in-kernel VGIC");
         return;
     }
-- 
2.20.1


