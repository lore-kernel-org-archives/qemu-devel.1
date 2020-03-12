Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDD3205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9XIN6Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDD3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUBt-0001qc-EF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjj-0006yc-2W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjh-0002RN-EO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:18 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjh-0002Qq-7N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:17 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u10so2970981pjy.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+73iwASsu5lzlOybkbOY4CdCjWsCZuUFo6OKJUGx3Sw=;
 b=i9XIN6Jeid6D8co5y14WOMpHIfeol1PAp1hLHzvy7Br7mXjcvoiE3dw21sB4mI2yQa
 IDdelTqopZWFoy9Q9L+32to0nY3sDv+P0xej8/twLk9fL6HgqFBfLpVsQx2uFAS82lpp
 hyEWvNFWQ2KsiW1haTvnTD8k9G1/1K6DoU6W1nY8a511KIubwivGHG9EEKc1u4DIaQGs
 Y00MoulHX0xELO4ckrDlrPJWh3NOfqKfnTJHFhYPdAcfMDN4X5RhU6QdGdkVzFiZeNls
 b9fjdUuUneaXlZhD+DBstYpN18HKMFQN2fg4v3f/yKFJUqU3r4CBqtXJb9dLmGaDW2iU
 qOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+73iwASsu5lzlOybkbOY4CdCjWsCZuUFo6OKJUGx3Sw=;
 b=nxvGLYE8RbeNYtRpTLeB2bUQV33D/p1z7qloDPMMkuNnksCYBLpCZ9Ll1EsZRmkH2R
 qHv26w1XbGYwFCtibG0xnNWfkZ6ykhVhhG0jHG1AHHyugqO5/gqQENPxStu06NuANnBN
 h6Wm9VX2nNZkCvs2gBT5J6l8/oXDSbHIGCK9+cwCK/EBrl/P7HtAarOuLIIa5lWtQKFT
 haZuVAdvMTw8bHfCfld6YOsXALrObsc3hoAqGG9aC63k2WXb4VlJTks48avtBaXzLVk0
 GHFWDf95BBL3FwH1HWsThwQqtzJgn4gLCafdA8GFusH3dZ+6pSW4KF028aKF+6aX7n78
 hWvw==
X-Gm-Message-State: ANhLgQ2+ovbv6JLpH2DqR58LV93vACbPZbT1ZajcliCk1WV77I6E3QLo
 iqajBsxh+rkz3OquXZ5MQzCDcreoTf4=
X-Google-Smtp-Source: ADFU+vuL4J/HvLhJpQq9iPw+tVLZMFowB5eyJBCwo7qi84TqzgJS9YBBKmiZYJcZSq9hb3fG7fQ+WA==
X-Received: by 2002:a17:90a:8b08:: with SMTP id
 y8mr5628166pjn.87.1584042195867; 
 Thu, 12 Mar 2020 12:43:15 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 41/42] target/arm: Create tagged ram when MTE is enabled
Date: Thu, 12 Mar 2020 12:42:18 -0700
Message-Id: <20200312194219.24406-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Assign cs->num_ases to the final value first.
    Downgrade to ID_AA64PFR1.MTE=1 if tag memory is not available.
v6: Add secure tag memory for EL3.
---
 target/arm/cpu.h |  6 ++++++
 hw/arm/virt.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b78bf2be4a..b360123b37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -771,6 +771,10 @@ struct ARMCPU {
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
 
+    /* MemoryRegion to use for allocation tag accesses */
+    MemoryRegion *tag_memory;
+    MemoryRegion *secure_tag_memory;
+
     /* For v8M, pointer to the IDAU interface provided by board/SoC */
     Object *idau;
 
@@ -2953,6 +2957,8 @@ typedef enum ARMMMUIdxBit {
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
     ARMASIdx_S = 1,
+    ARMASIdx_TagNS = 2,
+    ARMASIdx_TagS = 3,
 } ARMASIdx;
 
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 32d865a488..63b9d84eb8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1389,6 +1389,16 @@ static void create_secure_ram(VirtMachineState *vms,
     g_free(nodename);
 }
 
+static void create_tag_ram(MemoryRegion *tag_sysmem,
+                           hwaddr base, hwaddr size,
+                           const char *name)
+{
+    MemoryRegion *tagram = g_new(MemoryRegion, 1);
+
+    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
+    memory_region_add_subregion(tag_sysmem, base / 32, tagram);
+}
+
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
     const VirtMachineState *board = container_of(binfo, VirtMachineState,
@@ -1543,6 +1553,8 @@ static void machvirt_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *tag_sysmem = NULL;
+    MemoryRegion *secure_tag_sysmem = NULL;
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
@@ -1715,6 +1727,35 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        /*
+         * The cpu adds the property if and only if MemTag is supported.
+         * If it is, we must allocate the ram to back that up.
+         */
+        if (object_property_find(cpuobj, "tag-memory", NULL)) {
+            if (!tag_sysmem) {
+                tag_sysmem = g_new(MemoryRegion, 1);
+                memory_region_init(tag_sysmem, OBJECT(machine),
+                                   "tag-memory", UINT64_MAX / 32);
+
+                if (vms->secure) {
+                    secure_tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                       "secure-tag-memory", UINT64_MAX / 32);
+
+                    /* As with ram, secure-tag takes precedence over tag.  */
+                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
+                                                        tag_sysmem, -1);
+                }
+            }
+
+            object_property_set_link(cpuobj, OBJECT(tag_sysmem),
+                                     "tag-memory", &error_abort);
+            if (vms->secure) {
+                object_property_set_link(cpuobj, OBJECT(secure_tag_sysmem),
+                                         "secure-tag-memory", &error_abort);
+            }
+        }
+
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
@@ -1757,6 +1798,17 @@ static void machvirt_init(MachineState *machine)
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
+    if (tag_sysmem) {
+        create_tag_ram(tag_sysmem, vms->memmap[VIRT_MEM].base,
+                       machine->ram_size, "mach-virt.tag");
+        if (vms->secure) {
+            create_tag_ram(secure_tag_sysmem,
+                           vms->memmap[VIRT_SECURE_MEM].base,
+                           vms->memmap[VIRT_SECURE_MEM].size,
+                           "mach-virt.secure-tag");
+        }
+    }
+
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
     create_rtc(vms);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 96c20317ad..c320b4bc71 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1298,6 +1298,27 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+        cpu_isar_feature(aa64_mte, cpu)) {
+        object_property_add_link(obj, "tag-memory",
+                                 TYPE_MEMORY_REGION,
+                                 (Object **)&cpu->tag_memory,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG,
+                                 &error_abort);
+
+        if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+            object_property_add_link(obj, "secure-tag-memory",
+                                     TYPE_MEMORY_REGION,
+                                     (Object **)&cpu->secure_tag_memory,
+                                     qdev_prop_allow_set_link_before_realize,
+                                     OBJ_PROP_LINK_STRONG,
+                                     &error_abort);
+        }
+    }
+#endif
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1788,17 +1809,43 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
 
-    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+    /*
+     * We must set cs->num_ases to the final value before
+     * the first call to cpu_address_space_init.
+     */
+    if (cpu->tag_memory != NULL) {
+        cs->num_ases = 4;
+    } else if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
+    } else {
+        cs->num_ases = 1;
+    }
 
+    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
         cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
                                cpu->secure_memory);
-    } else {
-        cs->num_ases = 1;
     }
+
+    if (cpu->tag_memory != NULL) {
+        cpu_address_space_init(cs, ARMASIdx_TagNS, "cpu-tag-memory",
+                               cpu->tag_memory);
+        if (cpu->has_el3) {
+            cpu_address_space_init(cs, ARMASIdx_TagS, "cpu-tag-memory",
+                                   cpu->secure_tag_memory);
+        }
+    } else if (cpu_isar_feature(aa64_mte, cpu)) {
+        /*
+         * Since there is no tag memory, we can't meaningfully support MTE
+         * to its fullest.  To avoid problems later, when we would come to
+         * use the tag memory, downgrade support to insns only.
+         */
+        cpu->isar.id_aa64pfr1 =
+            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
+    }
+
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     /* No core_count specified, default to smp_cpus. */
-- 
2.20.1


