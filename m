Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E4D206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIQ7c1kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E4D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRFe-0006pY-C9
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxt-0000vz-Gc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxs-0005KE-4g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxr-0005Jn-UA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a141so7117476wme.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KTIuh78cMB59hpCH/7alRZC339vDDeP7d5J9NS8IDKc=;
 b=vIQ7c1kdFihJyJgt8OTI4KkvxngEdn4+YSLhpCL0SJ6y43JBpS5wJKJNFznjdtDShN
 p7aW2ZQ4K7SoQsSEgKS94ctVU7Mlm02pDrkpv//ZBaWiggqIXQr4ZEqYOAD8obeRBfOB
 jsa3CbET2iHQNfzMSzUbudWSK8RiXlAIJBpj4grBINnpjizb84enWrto9g5Zt0QhYqwJ
 CP+l6kE998sS1g1q8gvDBia0IkE4l1Bu2dRL/fZZhNPRX0nX3LMG7TjXPm6vAYtwYcQF
 ly7RKiiAhQl/8dKOqM8g3UDHg1EPAa5z7Co6g5S7drm1f2S8PHIDzkvdtlKoEzcdfVYX
 rsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KTIuh78cMB59hpCH/7alRZC339vDDeP7d5J9NS8IDKc=;
 b=NlR2GC5KSS9FNG4b41cA7b5M7J4Sj0GsG/ltOejGmpBbBhnWy2Wy5zbWRsuho0qosJ
 2wEhXda8j5GJMFXItbe1aovSmY+Cicw9Cqf1HYvbifqs/hrC4LCAzKWGK/iGKqZHqqJ9
 qL13Hhi8X2QlIluQQQgn6NyVzs/3bIH9ZaXA0odh+k6h/aICwT4R8eQQDCC0zNsdyqxS
 2e6padlOd2KUxBgpp2rKil/c2kbFp6cKrGZ+Vj3HoXspyIcklbt7C9mNQSIKRbgc6R6o
 Gir7jFoeJQPOoNohjNdfld3bGvnhCtUp8v/by8tQbplMXTfoYwtAA/6Eam06tAsHBwEc
 0KvA==
X-Gm-Message-State: ANhLgQ13FIonTHYdRGM/gseBABlF3Ns07dGO5K0B7Zygvim4HFaQUhuc
 S3QNCZfcovPfmaQ4yUTR00U1gef38ZnbqA==
X-Google-Smtp-Source: ADFU+vtJiC4yyh9KLUG2vn7iPAKG7Z055CBbFZjVkUCo+8smM5qJEn6qKx7vnTLP9uTsJao1CAujWQ==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr3125030wmi.162.1584031542313; 
 Thu, 12 Mar 2020 09:45:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/36] hw/arm/virt: kvm: Restructure finalize_gic_version()
Date: Thu, 12 Mar 2020 16:44:57 +0000
Message-Id: <20200312164459.25924-35-peter.maydell@linaro.org>
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

Restructure the finalize_gic_version with switch cases and
clearly separate the following cases:

- KVM mode / in-kernel irqchip
- KVM mode / userspace irqchip
- TCG mode

In KVM mode / in-kernel irqchip , we explictly check whether
the chosen version is supported by the host. If the end-user
explicitly sets v2/v3 and this is not supported by the host,
then the user gets an explicit error message. Note that for
old kernels where the CREATE_DEVICE ioctl doesn't exist then
we will now fail if the user specifically asked for gicv2,
where previously we (probably) would have succeeded.

In KVM mode / userspace irqchip we immediatly output an error
in case the end-user explicitly selected v3. Also we warn the
end-user about the unexpected usage of gic-version=host in
that case as only userspace GICv2 is supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200311131618.7187-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 88 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a94bc5ddae5..90966580a3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1543,33 +1543,79 @@ static void virt_set_memmap(VirtMachineState *vms)
  */
 static void finalize_gic_version(VirtMachineState *vms)
 {
-    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
-        vms->gic_version == VIRT_GIC_VERSION_MAX) {
-        if (!kvm_enabled()) {
-            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
-                error_report("gic-version=host requires KVM");
-                exit(1);
-            } else {
-                /* "max": currently means 3 for TCG */
-                vms->gic_version = VIRT_GIC_VERSION_3;
-            }
-        } else {
-            int probe_bitmap = kvm_arm_vgic_probe();
+    if (kvm_enabled()) {
+        int probe_bitmap;
 
-            if (!probe_bitmap) {
+        if (!kvm_irqchip_in_kernel()) {
+            switch (vms->gic_version) {
+            case VIRT_GIC_VERSION_HOST:
+                warn_report(
+                    "gic-version=host not relevant with kernel-irqchip=off "
+                     "as only userspace GICv2 is supported. Using v2 ...");
+                return;
+            case VIRT_GIC_VERSION_MAX:
+            case VIRT_GIC_VERSION_NOSEL:
+                vms->gic_version = VIRT_GIC_VERSION_2;
+                return;
+            case VIRT_GIC_VERSION_2:
+                return;
+            case VIRT_GIC_VERSION_3:
                 error_report(
-                    "Unable to determine GIC version supported by host");
+                    "gic-version=3 is not supported with kernel-irqchip=off");
                 exit(1);
-            } else {
-                if (probe_bitmap & KVM_ARM_VGIC_V3) {
-                    vms->gic_version = VIRT_GIC_VERSION_3;
-                } else {
-                    vms->gic_version = VIRT_GIC_VERSION_2;
-                }
             }
         }
-    } else if (vms->gic_version == VIRT_GIC_VERSION_NOSEL) {
+
+        probe_bitmap = kvm_arm_vgic_probe();
+        if (!probe_bitmap) {
+            error_report("Unable to determine GIC version supported by host");
+            exit(1);
+        }
+
+        switch (vms->gic_version) {
+        case VIRT_GIC_VERSION_HOST:
+        case VIRT_GIC_VERSION_MAX:
+            if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                vms->gic_version = VIRT_GIC_VERSION_3;
+            } else {
+                vms->gic_version = VIRT_GIC_VERSION_2;
+            }
+            return;
+        case VIRT_GIC_VERSION_NOSEL:
+            vms->gic_version = VIRT_GIC_VERSION_2;
+            break;
+        case VIRT_GIC_VERSION_2:
+        case VIRT_GIC_VERSION_3:
+            break;
+        }
+
+        /* Check chosen version is effectively supported by the host */
+        if (vms->gic_version == VIRT_GIC_VERSION_2 &&
+            !(probe_bitmap & KVM_ARM_VGIC_V2)) {
+            error_report("host does not support in-kernel GICv2 emulation");
+            exit(1);
+        } else if (vms->gic_version == VIRT_GIC_VERSION_3 &&
+                   !(probe_bitmap & KVM_ARM_VGIC_V3)) {
+            error_report("host does not support in-kernel GICv3 emulation");
+            exit(1);
+        }
+        return;
+    }
+
+    /* TCG mode */
+    switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_NOSEL:
         vms->gic_version = VIRT_GIC_VERSION_2;
+        break;
+    case VIRT_GIC_VERSION_MAX:
+        vms->gic_version = VIRT_GIC_VERSION_3;
+        break;
+    case VIRT_GIC_VERSION_HOST:
+        error_report("gic-version=host requires KVM");
+        exit(1);
+    case VIRT_GIC_VERSION_2:
+    case VIRT_GIC_VERSION_3:
+        break;
     }
 }
 
-- 
2.20.1


