Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F062FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7148206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRJC1MzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7148206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRIF-0000Jh-RG
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxs-0000qP-0k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxq-0005JV-RP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxq-0005JE-Kw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 25so6857428wmk.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Pp0Qd7rAylrm+t6bYKOIAaXuON6hnfSMoBAAsNzgCDc=;
 b=XRJC1MzBldxZB9nziuYqM/r06vnjTYWM4MJsR4G9v1lKmrwdCkwhkC2UYxONq8HZez
 hmOYHskAFx/+BxKJ5mflp5GKhPTPY62zaej3hzE92IKz70fQp+/dvu8RHwo26dotknxS
 cQiipf8euk9dJGk+/ti6YBw/Mi4IbVi8cCfA1txTXdNqEMQq9/SQfZ0cGA+ShN9JwPrU
 vEJV5dLZjCwK1d3VQH9gb7RHMefcn5qHFXom1/eha99+u1BiOUVUGp7fZ5ZFE8w/ujGc
 QXfgEJVMPOlyV3MW+pjqMv6s+WcGYwTnMl+t8p+2D/rgtj7Tcg1oYCdp7hNNmoADK9/S
 Os9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pp0Qd7rAylrm+t6bYKOIAaXuON6hnfSMoBAAsNzgCDc=;
 b=iuzAfRcLBb+3Uy7CqjoJGfpJLRYoVG++hSCwEtsHE3/4XOrIc9Bxd2s2FP7uisBztL
 1OVjhO8tl1mtWrykq3t0X3Ozte+URCOplhZAcchReFWYu6/lc/6Eget3B1vnIpTHxGph
 VkF0CuQSHQNhR3W8lR0HsyoMfXf/zHd3lAcD7LSJ6zPzYzQkUXeZO56z4YjIT1FBu5RQ
 maxaj/ncl1q0a+p5+KxKpOWQNXHAv6mjdsxotgTwvcdBjV7ghykO1DneICCZlAhYasxd
 v1hZqBqP8y88WA1jS0s/Fg8S1vsT6q17nZA9yBFR0OtsKAYV7uSOtTugYMxXRQqQBjqy
 uwwg==
X-Gm-Message-State: ANhLgQ0eu+mlo1Ntz3itS8He1+sEizh8T2+otm++2t9tD7gclgpfvDvQ
 T+GOCk5da4uIadp1c57DRbUfnr9MYOCR/Q==
X-Google-Smtp-Source: ADFU+vvfWLb3hKEXXDkWJux4Gok592ibvWZB3z2YpcMFzBesYmj4GC0TFNR9iqLIOOrj2MXDtava1A==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5921474wmc.95.1584031541392;
 Thu, 12 Mar 2020 09:45:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/36] target/arm/kvm: Let kvm_arm_vgic_probe() return a bitmap
Date: Thu, 12 Mar 2020 16:44:56 +0000
Message-Id: <20200312164459.25924-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

From: Eric Auger <eric.auger@redhat.com>

Convert kvm_arm_vgic_probe() so that it returns a
bitmap of supported in-kernel emulation VGIC versions instead
of the max version: at the moment values can be v2 and v3.
This allows to expose the case where the host GICv3 also
supports GICv2 emulation. This will be useful to choose the
default version in KVM accelerated mode.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200311131618.7187-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  3 +++
 hw/arm/virt.c        | 11 +++++++++--
 target/arm/kvm.c     | 14 ++++++++------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ae9e075d754..48bf5e16d58 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -15,6 +15,9 @@
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 
+#define KVM_ARM_VGIC_V2   (1 << 0)
+#define KVM_ARM_VGIC_V3   (1 << 1)
+
 /**
  * kvm_arm_vcpu_init:
  * @cs: CPUState
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e55cafa014b..a94bc5ddae5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1554,11 +1554,18 @@ static void finalize_gic_version(VirtMachineState *vms)
                 vms->gic_version = VIRT_GIC_VERSION_3;
             }
         } else {
-            vms->gic_version = kvm_arm_vgic_probe();
-            if (!vms->gic_version) {
+            int probe_bitmap = kvm_arm_vgic_probe();
+
+            if (!probe_bitmap) {
                 error_report(
                     "Unable to determine GIC version supported by host");
                 exit(1);
+            } else {
+                if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                    vms->gic_version = VIRT_GIC_VERSION_3;
+                } else {
+                    vms->gic_version = VIRT_GIC_VERSION_2;
+                }
             }
         }
     } else if (vms->gic_version == VIRT_GIC_VERSION_NOSEL) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6f954..390077c5182 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -874,15 +874,17 @@ int kvm_arch_irqchip_create(KVMState *s)
 
 int kvm_arm_vgic_probe(void)
 {
+    int val = 0;
+
     if (kvm_create_device(kvm_state,
                           KVM_DEV_TYPE_ARM_VGIC_V3, true) == 0) {
-        return 3;
-    } else if (kvm_create_device(kvm_state,
-                                 KVM_DEV_TYPE_ARM_VGIC_V2, true) == 0) {
-        return 2;
-    } else {
-        return 0;
+        val |= KVM_ARM_VGIC_V3;
     }
+    if (kvm_create_device(kvm_state,
+                          KVM_DEV_TYPE_ARM_VGIC_V2, true) == 0) {
+        val |= KVM_ARM_VGIC_V2;
+    }
+    return val;
 }
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
-- 
2.20.1


