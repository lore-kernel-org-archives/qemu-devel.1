Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E1C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA08121927
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Osvai1zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA08121927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWvX-0000p7-Lf
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs0-0004HY-5h
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWry-0005z6-9A
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id n6so6547346wrm.13
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mUWxkTyEIk2JnpjsU6rZN6KvWfmkqRnVuhjHNTzz8/o=;
 b=Osvai1zWywsVacRiXBoozskA6yIXXa6/t2kk+5/EudrH7s6RMf7cy94gqsxIGQQxfF
 F++CJ6AT5gN8fbB5Z1o5R8PGjveoN8Ra1it7w2Z+qRCMpiDtLw0/O0J93ZguqO9c4OXk
 L0KS9C71objpe+6pf5LdyIsfvcU76uPGrj4LVP1EYhhr+jEPVE8Rt5x4hSbLNfsqN1PI
 7M/h7Pt78zxrPKnQT4H6c8XPhH8kuKm0qHoiqpgEDlxlrLlkTneotoyM1wMkMD0B1LnF
 m5/BIqltJYHg9YY7vpn9x5AyKpwSS79cZAAisAArjRQmn943ZTZGTER6jbUKPAGkcrEi
 XI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mUWxkTyEIk2JnpjsU6rZN6KvWfmkqRnVuhjHNTzz8/o=;
 b=YRMeQoZ3KoI1uWdmg5OSWkLJeBpgbArhMIBPKagUbWNdV/3HVI1Ps4SequI1JJgyJ4
 3DrpWKSB6ye2QjUiXHyhBtYGxR/IYVl1ggyHoZANsKUUudLNFT824jowEzyDSxIyBxir
 XmpMcsJPtnFQCLuZKWVr5/m15EjfljHqlzbVgg7SzqauFTQs5ZwVZRfNsCFMNjJxgQD4
 /Xf2ArSNvTfArVpIPtdZV73i5H+6oDFnb54xGr8pKJxl5DPT8pnhRUXLEqUE0U2xmSin
 TQk1flI6Amf2BDKPGha3m+FzC2ruPXa2V0AD9chbZWWsd1HQnY5lt+4lkBj8cl4cbU4l
 NbUg==
X-Gm-Message-State: AOAM531pxYx9Utn31+XoJHoPBntZJsDnt09E46O/CpVSfE7eWafDer9G
 /+b2j4Opfs4aeFi6RCFANv4o7+m+MjPR5Utm
X-Google-Smtp-Source: ABdhPJx3VhDl4Fw63VIG0fiNgzKwP9fiPyKmvfSiAyVurjGchvFqpmwtnb04ugQQbujx/ailRwmxfQ==
X-Received: by 2002:a05:6000:8e:: with SMTP id
 m14mr9616520wrx.400.1602167168691; 
 Thu, 08 Oct 2020 07:26:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] hw/arm/virt: Move post cpu realize check into its own
 function
Date: Thu,  8 Oct 2020 15:25:53 +0100
Message-Id: <20201008142557.9845-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

We'll add more to this new function in coming patches so we also
state the gic must be created and call it below create_gic().

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-4-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1231a197c85..524eafe22df 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1672,6 +1672,31 @@ static void finalize_gic_version(VirtMachineState *vms)
     }
 }
 
+/*
+ * virt_cpu_post_init() must be called after the CPUs have
+ * been realized and the GIC has been created.
+ */
+static void virt_cpu_post_init(VirtMachineState *vms)
+{
+    bool aarch64;
+
+    aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
+
+    if (!kvm_enabled()) {
+        if (aarch64 && vms->highmem) {
+            int requested_pa_size = 64 - clz64(vms->highest_gpa);
+            int pamax = arm_pamax(ARM_CPU(first_cpu));
+
+            if (pamax < requested_pa_size) {
+                error_report("VCPU supports less PA bits (%d) than "
+                             "requested by the memory map (%d)",
+                             pamax, requested_pa_size);
+                exit(1);
+            }
+        }
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1886,22 +1911,6 @@ static void machvirt_init(MachineState *machine)
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
-   if (!kvm_enabled()) {
-        ARMCPU *cpu = ARM_CPU(first_cpu);
-        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
-
-        if (aarch64 && vms->highmem) {
-            int requested_pa_size, pamax = arm_pamax(cpu);
-
-            requested_pa_size = 64 - clz64(vms->highest_gpa);
-            if (pamax < requested_pa_size) {
-                error_report("VCPU supports less PA bits (%d) than requested "
-                            "by the memory map (%d)", pamax, requested_pa_size);
-                exit(1);
-            }
-        }
-    }
-
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
     if (machine->device_memory) {
@@ -1913,6 +1922,8 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms);
 
+    virt_cpu_post_init(vms);
+
     fdt_add_pmu_nodes(vms);
 
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
-- 
2.20.1


