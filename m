Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CAE2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjaRrWkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CAE2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jAk-0004BL-C6
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifa-0008PR-H0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifZ-00028p-Cj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifZ-00028S-5T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id a141so3906052wme.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9eBbOH0iWuMB9GEnPRYXejUJxzdgvoce0O5T0LTK50c=;
 b=vjaRrWkXCn/6xIFIZqWZ9vmo176BfKUwna2HsJnX5ctBNlYEcnuvNESEjEe2BkFILl
 wgxV8MdTm8054TpkKhmgBAf7WKoUp5zmAtb553tDN7gM8zAFou1DG6thQiqhHHUtTuLF
 NgkLE6kjGw0yfek887/ionU7N1NkN1G3oZ92dPGvZ8dBJvrFSf+R2rCk5k0D1bA18x9c
 MEdES4sMGPireYNO7+DxK7zmVBKNPA9OLtbhXluRan5lCCkaV8qNcrrqTcK4JaI4mapw
 JrBPFNy+F41kR5iQQL7uc+aJxGKR4CRUS8KSXH/1SRqnYOPNNTBjKS88E2sk8ZDYfB8j
 DWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eBbOH0iWuMB9GEnPRYXejUJxzdgvoce0O5T0LTK50c=;
 b=l2NGK59FkTahJX4TpD8rI+YE6H3M1pm3wcbu1fxQGGdrE54evfgbnyDcETP249/eK+
 EFTTWXKhiRL+ig+hx9lCL2ZQ3j/9d8DXUAbp9Rx5taeKBiSwJ1/96b+5HAyxhzJw+/AW
 MeZKVBbxC1/DnwenjJlwPt4UDL1mlQKaJOw5+U5Utaf02S2d+Iz484SCXUZbAWJZKxQn
 EYra0KJY9Ib2YGFfMHaw16EEJfQxB/iFklgkknBsKWdhP04A5nfaIhfYcUxqPIAbhLGS
 m6RpC5kgzB+YVUWN3PYkHuHnzylG/m3w0Sk0unH69TpK3763+Vm3yxkTxrMTggBsgDEr
 FsiQ==
X-Gm-Message-State: APjAAAW9kht9cK3Fag/kJfYQaHz4/BlqxkrWWSpW92umUVMPcBmnUfsw
 xeLI7oDPqxD2UGK4/SVqiqA+z/1wkchGDg==
X-Google-Smtp-Source: APXvYqy+HaQZtC+M6A7ZKd592/T/7G2eP+lMgXh+J0NCw/kFlt/YlXtePH9KPF7y4BOnuWLoeRIYyA==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr3926263wma.171.1582907959828; 
 Fri, 28 Feb 2020 08:39:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/33] hw/intc/arm_gic_kvm: Don't assume kernel can provide a
 GICv2
Date: Fri, 28 Feb 2020 16:38:40 +0000
Message-Id: <20200228163840.23585-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200225182435.1131-1-peter.maydell@linaro.org
---
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


