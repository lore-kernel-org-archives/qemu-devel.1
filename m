Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9891BC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DC7206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eklCwXRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DC7206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR6e-0008DM-GH
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxr-0000o3-77
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxp-0005JA-UO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxp-0005Is-NZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id m3so7127549wmi.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5StNhOglz0tuYymrag2M9iv7MApEblmV5uK5Xq5Tk+o=;
 b=eklCwXRw0e9iJVeIHwzXq+FArQCSwR//l/rnOv5XpVopuzQO0ALToFaC3AooB1Y6UT
 0MKGIFlsiNlzN4tEv1DwNU0frK5VYJwLp7x2e/VsIZ5zglAuqQVx8/NgakNwHa4gB+zV
 9ko6IjcKIAR/kLa+DBg7Z9CHxSEt87IuvoasFQIsSPlGr62Sx8hSryPQio9/v8Pb+qh5
 cny5eRJ+ZwknogQDmcJO1GNZRVWhZR5wj5918l5EnLslMfXM7KcfZ8edhGree7+niMgU
 zDGsWqBEffeasSKDGI0/0bJdpNwv/wjI0m5YUkIDHhz9tk98yjLDmJ/LZplDMnQPsCGG
 i3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5StNhOglz0tuYymrag2M9iv7MApEblmV5uK5Xq5Tk+o=;
 b=nAqh2a4xEsiF4Y2QH0LCU1COK+hLU19qNiF/fAFdBa2gLWtl1gnkLUFoRLW47ZHNo4
 ndKhJ2SdWC8l/VOrjTAlGAGt0PkJmk5ZMjofZueP1wEB6slLKq/dg/uqkJlT1Bj8b+DD
 iaozquSSJRH4rbQdWvVeHqLnLJaKP2msRHVtzCXnegguVQe4jwQNuESp0Uf4bwUQXnhP
 ag2q6m+SyYhKeHFrDJCd4Q5lXDtN08uxE3FeIdv1Om9u96bFghd/KIXKa/E9tVERMJmS
 SrtFHq9lBi94OjlKMNepiTm5dttfZTSU5hqo5JgtmXLpJ3SHPxgpPCvMBu8Qt2qZUDTf
 PMRg==
X-Gm-Message-State: ANhLgQ2G37ylQwwsSxvf5H0hYPM0h46cCdAfOR+qe1kHK7ZZMbDyAuHk
 nosFyL5s9YKGFhs4Sk9xvbL3FJpS9vApSg==
X-Google-Smtp-Source: ADFU+vuxRJ0KNGpPEkswdkVG1Xk4xzBF6LeD9MWDNIy0QMZEfUWt+UqkcEH9oBB9dRhiBGUo/mtnhw==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr5848498wmj.170.1584031540420; 
 Thu, 12 Mar 2020 09:45:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/36] hw/arm/virt: Introduce finalize_gic_version()
Date: Thu, 12 Mar 2020 16:44:55 +0000
Message-Id: <20200312164459.25924-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

Let's move the code which freezes which gic-version to
be applied in a dedicated function. We also now set by
default the VIRT_GIC_VERSION_NO_SET. This eventually
turns into the legacy v2 choice in the finalize() function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200311131618.7187-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 54 ++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c0827cacdf3..893796d3b06 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -100,6 +100,7 @@ typedef enum VirtGICType {
     VIRT_GIC_VERSION_HOST,
     VIRT_GIC_VERSION_2,
     VIRT_GIC_VERSION_3,
+    VIRT_GIC_VERSION_NOSEL,
 } VirtGICType;
 
 typedef struct MemMapEntry {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4ed1f0cb2e5..e55cafa014b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1535,6 +1535,37 @@ static void virt_set_memmap(VirtMachineState *vms)
     }
 }
 
+/*
+ * finalize_gic_version - Determines the final gic_version
+ * according to the gic-version property
+ *
+ * Default GIC type is v2
+ */
+static void finalize_gic_version(VirtMachineState *vms)
+{
+    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
+        vms->gic_version == VIRT_GIC_VERSION_MAX) {
+        if (!kvm_enabled()) {
+            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
+                error_report("gic-version=host requires KVM");
+                exit(1);
+            } else {
+                /* "max": currently means 3 for TCG */
+                vms->gic_version = VIRT_GIC_VERSION_3;
+            }
+        } else {
+            vms->gic_version = kvm_arm_vgic_probe();
+            if (!vms->gic_version) {
+                error_report(
+                    "Unable to determine GIC version supported by host");
+                exit(1);
+            }
+        }
+    } else if (vms->gic_version == VIRT_GIC_VERSION_NOSEL) {
+        vms->gic_version = VIRT_GIC_VERSION_2;
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1561,25 +1592,7 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
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
-            vms->gic_version = kvm_arm_vgic_probe();
-            if (!vms->gic_version) {
-                error_report(
-                    "Unable to determine GIC version supported by host");
-                exit(1);
-            }
-        }
-    }
+    finalize_gic_version(vms);
 
     if (!cpu_type_valid(machine->cpu_type)) {
         error_report("mach-virt: CPU type %s not supported", machine->cpu_type);
@@ -2140,8 +2153,7 @@ static void virt_instance_init(Object *obj)
                                     "Set on/off to enable/disable using "
                                     "physical address space above 32 bits",
                                     NULL);
-    /* Default GIC type is v2 */
-    vms->gic_version = VIRT_GIC_VERSION_2;
+    vms->gic_version = VIRT_GIC_VERSION_NOSEL;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
-- 
2.20.1


