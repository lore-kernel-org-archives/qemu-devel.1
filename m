Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7120FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCB420CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usxY39ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCB420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZRg-0006te-Ef
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl7-0001Nt-92
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0000Es-Hw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl3-00008g-7m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m3so2665755wmi.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rYF1by3zBxwkTmx83mm/R2nQl+i3lwz2wxLfnHw0qiE=;
 b=usxY39taoSQWJ5UhRgPhPk2WlLRqNxRwMhH3NE4ME+JXHh242llgtGUaxlqDu2bQGo
 CrkuMm53DAYABly5UFyLgl+p48k6K4wzcE1MllIjN4e0ra3NZXpdqEqSiDcA2jbW0SXP
 Np642QSAKVnLZgf6gGqeWpg2QvFx33cD2ELMRyQQlidnZKbJSBoFlMWmfaDXre0wm22S
 vGT3Jpm+ysvJpzI1PMmkNTPDTqnw3JVKPxZiuAHJACWjpm57eMzCnTup6tgCXROxy11b
 qwFmVSX1fgyPltXQIHRkrmEiixeksfg/X133DXSePijv8fm+wz4ZqrdIPVee0/Cs5/KK
 RAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rYF1by3zBxwkTmx83mm/R2nQl+i3lwz2wxLfnHw0qiE=;
 b=dcVEkqu98Z8s4azbUVbbpSb3+G0HJSULxtjxlcidZ7gRc4WgGxux3P81rUk7OYSS5z
 4lG2Wq3XJxZ0uYw6pt3NYeVDvOxA9BHu3ZUzwx2eRqtZvr+8zxz1XeCKOFgAnFA6bh0B
 i8wLCy8qy+eGCBhJDTEYLtQ3OTaudsEq2AtG/HQuwaw6z0CczQqCLNmcbfSCQybRsWaa
 p7LgxK2/qnJRHId5+Ga307n4uWkSf/ZybZqCbR51B5hqNP6fMMVo512c4dK5ACHCDeuH
 FWGxP5cOFCiNgDSeXJUuWYS83Z51kMJ53jmpGE7AoluRyClTH0f3ZFmv8NdkN4x1xNJ5
 tMXw==
X-Gm-Message-State: APjAAAUEtoWpPXhJ70QNf3dFsExBGCGz/5xlL8QbWh3xrqpe9EWG3RqX
 xcz/SaXiiwTWPk5wqIHS7E2B5+nU
X-Google-Smtp-Source: APXvYqx/hPAl2gUoU7gOg473sb/WhKdc3ZbeThjTvjv8XsHLeO/iFv2lg+WNMiUCUeEs7jTfg9bzXA==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr4942206wmf.124.1582631530975; 
 Tue, 25 Feb 2020 03:52:10 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 070/136] sparc/sun4m: use memdev for RAM
Date: Tue, 25 Feb 2020 12:50:00 +0100
Message-Id: <1582631466-13880-70-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Patch moves ram size check into sun4m_hw_init() and drops
ram_init() moving remainder to sun4m_hw_init() as well,
as it was the only place that called it.

Also it rewrites impl. of RamDevice a little bit, which
could serve as an example of frontend device for RAM backend.
(Caveats are:
  1. it doesn't check for memdev backend being mapped
     since it's been  usurped by generic machine to handle
     majority of machines which don't have RAM frontend device
  2. it still lacks 'addr' property and still has hardcoded
     sysbus_mmio_map() in board init. If done right, board should
     set 'addr' property and bus/machine plug handler should map
     it during device realize time.
)
Further improvements were left as exercise for the future,
since frontends are out scope of RAM conversion to memdev.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-71-imammedo@redhat.com>
---
 hw/sparc/sun4m.c | 74 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 25e96db..f5bf95f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -777,63 +777,42 @@ static const TypeInfo prom_info = {
 
 typedef struct RamDevice {
     SysBusDevice parent_obj;
-
-    MemoryRegion ram;
-    uint64_t size;
+    HostMemoryBackend *memdev;
 } RamDevice;
 
 /* System RAM */
 static void ram_realize(DeviceState *dev, Error **errp)
 {
     RamDevice *d = SUN4M_RAM(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *ram = host_memory_backend_get_memory(d->memdev);
 
-    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
-                                         d->size);
-    sysbus_init_mmio(sbd, &d->ram);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
 }
 
-static void ram_init(hwaddr addr, ram_addr_t RAM_size,
-                     uint64_t max_mem)
+static void ram_initfn(Object *obj)
 {
-    DeviceState *dev;
-    SysBusDevice *s;
-    RamDevice *d;
-
-    /* allocate RAM */
-    if ((uint64_t)RAM_size > max_mem) {
-        error_report("Too much memory for this machine: %" PRId64 ","
-                     " maximum %" PRId64,
-                     RAM_size / MiB, max_mem / MiB);
-        exit(1);
-    }
-    dev = qdev_create(NULL, "memory");
-    s = SYS_BUS_DEVICE(dev);
-
-    d = SUN4M_RAM(dev);
-    d->size = RAM_size;
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(s, 0, addr);
+    RamDevice *d = SUN4M_RAM(obj);
+    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
+                             (Object **)&d->memdev,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+    object_property_set_description(obj, "memdev", "Set RAM backend"
+                                    "Valid value is ID of a hostmem backend",
+                                     &error_abort);
 }
 
-static Property ram_properties[] = {
-    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void ram_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ram_realize;
-    device_class_set_props(dc, ram_properties);
 }
 
 static const TypeInfo ram_info = {
     .name          = TYPE_SUN4M_MEMORY,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RamDevice),
+    .instance_init = ram_initfn,
     .class_init    = ram_class_init,
 };
 
@@ -879,6 +858,15 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     SysBusDevice *s;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
+    Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
+                                                  TYPE_MEMORY_BACKEND, NULL);
+
+    if (machine->ram_size > hwdef->max_mem) {
+        error_report("Too much memory for this machine: %" PRId64 ","
+                     " maximum %" PRId64,
+                     machine->ram_size / MiB, hwdef->max_mem / MiB);
+        exit(1);
+    }
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
@@ -888,9 +876,12 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     for (i = smp_cpus; i < MAX_CPUS; i++)
         cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
 
+    /* Create and map RAM frontend */
+    dev = qdev_create(NULL, "memory");
+    object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
-    /* set up devices */
-    ram_init(0, machine->ram_size, hwdef->max_mem);
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
         empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
@@ -1078,7 +1069,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_DEPTH, graphic_depth);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_WIDTH, graphic_width);
@@ -1415,6 +1406,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss5_type = {
@@ -1434,6 +1426,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss10_type = {
@@ -1453,6 +1446,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss600mp_type = {
@@ -1472,6 +1466,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss20_type = {
@@ -1490,6 +1485,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo voyager_type = {
@@ -1508,6 +1504,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss_lx_type = {
@@ -1526,6 +1523,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo ss4_type = {
@@ -1544,6 +1542,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo scls_type = {
@@ -1562,6 +1561,7 @@ static void sbook_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
     mc->default_display = "tcx";
+    mc->default_ram_id = "sun4m.ram";
 }
 
 static const TypeInfo sbook_type = {
-- 
1.8.3.1



