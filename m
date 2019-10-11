Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BDECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1623120679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBCRIpGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvZK-0008Rn-Rp
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJO-0006AE-TR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJN-0004Cp-DD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:30 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJN-0004CM-9T
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:29 -0400
Received: by mail-yb1-xb43.google.com with SMTP id h7so1025165ybp.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sQCxz2oMYepQwc17fX+5BMmc0MrbQQ1A+BstlG5vP/M=;
 b=UBCRIpGv826pFo7+smVnIhRkHKPbU6YQUY9q02165kRzu21ZvBwJaqgccZJzMNr10H
 dMK1bWWuajt8miGs07UjI9S/IPdANX+UV2s6y0T/k7mr9aBRArMThHlmHL3MRzYsO8yB
 1ZwqqyXp5gc8jxjg33dLjR8ouq+r/9aWbhgVKSeqfmDRwI3Mms3or81+8tBR51U8jekL
 NbC39GCyBvTWig1zgGfxf9QqrT4gIIktsLLsCdSpdiY7puPYyvPFQxJp4v9GvEeZ9ngq
 ycQ50MDoBYy43K4rxf3EKRLN6ZQNdTxJWqkzOfLr7+/ik8kIE+GFbpqPPknYlz4GP4vZ
 OizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sQCxz2oMYepQwc17fX+5BMmc0MrbQQ1A+BstlG5vP/M=;
 b=VLGTBct04G3DZmepPFVBwNo01oJ4bQM8KqI3WCEFh6gf1WujyW3T8zIOJRRn7E4m+A
 12yMf+3NU2xZv4W54gYcdlEPHn4a68UzX76yHNTOb7ez3T2ymMrJknZxO04SGgihd2Ql
 FFTPrujy0zRSQ7DaaMJdpYRTUnzLzYODQ6zZCUs30kZ18+Ev2KkmllNBTnWJl3p7d2Ro
 +mZFBQXX8AcGS/XVPRR/vXPX7SozVG8ckOd6C5F4ctFK6Lk5ym4pmdASjp0boo/3Pbix
 q1/fsgUszjv6ESQEIQkcnvmhAMqZ0Olwt5iIoeqDcJhRRTPKrDXUwcq+PXo8sGFTC57Q
 9o6A==
X-Gm-Message-State: APjAAAXeUmQXWDL0sRnPkpF/4n1XW2NtGsKkvpXclLwfLfeVvcC9434Q
 44yupN/FV+ABQdHvx1SBewcUh+lMEPE=
X-Google-Smtp-Source: APXvYqxHgpGD7hn900AWpgsm35ws37zzDgicHBeOl8A5lKzfCRCjAoViPSNkfu78WGCMapiUBYdzHQ==
X-Received: by 2002:a25:5:: with SMTP id 5mr5481277yba.310.1570801828237;
 Fri, 11 Oct 2019 06:50:28 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/22] target/arm: Create tagged ram when MTE is enabled
Date: Fri, 11 Oct 2019 09:47:42 -0400
Message-Id: <20191011134744.2477-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
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
 hw/arm/virt.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 93a362708b..faca43ea78 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -765,6 +765,10 @@ struct ARMCPU {
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
 
+    /* MemoryRegion to use for allocation tag accesses */
+    MemoryRegion *tag_memory;
+    MemoryRegion *secure_tag_memory;
+
     /* For v8M, pointer to the IDAU interface provided by board/SoC */
     Object *idau;
 
@@ -2956,6 +2960,8 @@ int cpu_mmu_index(CPUARMState *env, bool ifetch);
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
     ARMASIdx_S = 1,
+    ARMASIdx_TagNS = 2,
+    ARMASIdx_TagS = 3,
 } ARMASIdx;
 
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d74538b021..573988ba4d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1330,6 +1330,18 @@ static void create_secure_ram(VirtMachineState *vms,
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
+
+    /* ??? Do we really need an fdt entry, or is MemTag enabled sufficient.  */
+}
+
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
     const VirtMachineState *board = container_of(binfo, VirtMachineState,
@@ -1485,6 +1497,8 @@ static void machvirt_init(MachineState *machine)
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *tag_sysmem = NULL;
+    MemoryRegion *secure_tag_sysmem = NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
@@ -1652,6 +1666,35 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        /*
+         * The cpu adds the property iff MemTag is supported.
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
@@ -1695,6 +1738,17 @@ static void machvirt_init(MachineState *machine)
         create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
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
 
     create_rtc(vms, pic);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 12fffa3ee4..a3a49cd5bf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1182,6 +1182,27 @@ void arm_cpu_post_init(Object *obj)
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
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
@@ -1632,17 +1653,43 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
2.17.1


