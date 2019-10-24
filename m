Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE682070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiRufVyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE682070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNekd-0004Rg-5J
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdij-00075A-LP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdih-0007eP-Rm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdih-0007dl-Jk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n15so15443696wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aHMT2RmStBudCWNCIOuhp+PQb1yFu2fWEBeieC/7ws8=;
 b=WiRufVywNpU+Z4aWXn+upt4fMizH8PkEaX8706XkSw/4W+8/lvBWkvXdnPdU9iPcfK
 mINAarbhhMIgL8trXbXBDznjHz8psAZtSIA2H7gzT0Oe8dErFjWBSsUSKNC12Te+0FrO
 ZRuTdM6NWw06pyXjr7EdYsVlGRc58yZNyzesIO8hFv0IIelUSkxe0b3GlD+J9HN0i/Ap
 06laKCjSMn9ywz986cOzzBBtnzBoibbdpeVnp7FTPSZdGPjPIGjIYfHrRoYZFu+cYQXP
 Sz7uxQ0ASgt2AexOj9o7bHMAyr7yx2oqVovMglg1vNX2Zy+YWGWZAf2tnf9kqXW5IAfz
 i6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aHMT2RmStBudCWNCIOuhp+PQb1yFu2fWEBeieC/7ws8=;
 b=RPVnNopGtpmZvzRmqDCQ45YoTtoCBQbEXltoxgA/KUPzbva4OzkoMMDmvEhgEoyfXK
 VT3hn94S8vwWY1vEV4GWv35oHRAQSgzPgaOhvhXSKe21XCAvI+AhKcKoF99NfteOBqqn
 NAACNbkkiw4/F7NprJBfcTt/VSz5JjX3qVd9kpXr1a0ClY29BRFkUNHChhdCFKVi4Jja
 iS/Hm7EWgUgYR20hngzvKQ95NjM+gUn6MFWYngHZVwpzwoARrFSY4i5ksRpTph7nBo5x
 REVMGoue/CdAJQT+6TEXyJgKfNnbnSndQjV1JH4WYW6aY6PZLrUt6Y9YNXaDWl299bUW
 oClQ==
X-Gm-Message-State: APjAAAWDz9SWfXprYHqeabRWUY5zQcudeZhZsc/TFZfnroNp6qXnoteO
 vQXiUFI6FPIqP6JrM+3bhbB7PIXv
X-Google-Smtp-Source: APXvYqwTwLX2vJwrTqgCpJZ4YZJubyQOw22H3TeM8UADba6bi96WEOWh8kK9WfzNMbBgRajEqj7NoQ==
X-Received: by 2002:a05:6000:343:: with SMTP id
 e3mr2572558wre.20.1571925846115; 
 Thu, 24 Oct 2019 07:04:06 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/39] hw/i386/pc: rename functions shared with non-PC machines
Date: Thu, 24 Oct 2019 16:03:24 +0200
Message-Id: <1571925835-31930-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

The following functions are named *pc* but are not PC-machine specific
but generic to the X86 architecture, rename them:

  load_linux                 -> x86_load_linux
  pc_new_cpu                 -> x86_new_cpu
  pc_cpus_init               -> x86_cpus_init
  pc_cpu_index_to_props      -> x86_cpu_index_to_props
  pc_get_default_cpu_node_id -> x86_get_default_cpu_node_id
  pc_possible_cpu_arch_ids   -> x86_possible_cpu_arch_ids
  old_pc_system_rom_init     -> x86_system_rom_init

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c         | 28 ++++++++++++++--------------
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 hw/i386/pc_sysfw.c   |  6 +++---
 include/hw/i386/pc.h |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b19042..1c27223 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1019,8 +1019,8 @@ static bool load_elfboot(const char *kernel_filename,
     return true;
 }
 
-static void load_linux(PCMachineState *pcms,
-                       FWCfgState *fw_cfg)
+static void x86_load_linux(PCMachineState *pcms,
+                           FWCfgState *fw_cfg)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
@@ -1374,7 +1374,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }
 
-static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
+static void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
 {
     Object *cpu = NULL;
     Error *local_err = NULL;
@@ -1490,14 +1490,14 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
         return;
     }
 
-    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
+    x86_cpu_new(PC_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 }
 
-void pc_cpus_init(PCMachineState *pcms)
+void x86_cpus_init(PCMachineState *pcms)
 {
     int i;
     const CPUArchIdList *possible_cpus;
@@ -1518,7 +1518,7 @@ void pc_cpus_init(PCMachineState *pcms)
                                                      ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
-        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -1621,7 +1621,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    load_linux(pcms, fw_cfg);
+    x86_load_linux(pcms, fw_cfg);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -1756,7 +1756,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        load_linux(pcms, fw_cfg);
+        x86_load_linux(pcms, fw_cfg);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -2681,7 +2681,7 @@ static void pc_machine_wakeup(MachineState *machine)
 }
 
 static CpuInstanceProperties
-pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
@@ -2690,7 +2690,7 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
     return possible_cpus->cpus[cpu_index].props;
 }
 
-static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
+static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoInfo topo;
    PCMachineState *pcms = PC_MACHINE(ms);
@@ -2702,7 +2702,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    return topo.pkg_id % ms->numa_state->num_nodes;
 }
 
-static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
+static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     PCMachineState *pcms = PC_MACHINE(ms);
     int i;
@@ -2804,9 +2804,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
-    mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
-    mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
-    mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
+    mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6824b72..de09e07 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -152,7 +152,7 @@ static void pc_init1(MachineState *machine,
         }
     }
 
-    pc_cpus_init(pcms);
+    x86_cpus_init(pcms);
 
     if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f..894989b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -179,7 +179,7 @@ static void pc_q35_init(MachineState *machine)
         xen_hvm_init(pcms, &ram_memory);
     }
 
-    pc_cpus_init(pcms);
+    x86_cpus_init(pcms);
 
     kvmclock_create();
 
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index a9983f0..28cb1f6 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -211,7 +211,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
     }
 }
 
-static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
+static void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     char *filename;
     MemoryRegion *bios, *isa_bios;
@@ -272,7 +272,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        old_pc_system_rom_init(rom_memory, true);
+        x86_bios_rom_init(rom_memory, true);
         return;
     }
 
@@ -293,7 +293,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        old_pc_system_rom_init(rom_memory, false);
+        x86_bios_rom_init(rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 37bfd95..7082b06 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -198,7 +198,7 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcms);
 void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
-void pc_cpus_init(PCMachineState *pcms);
+void x86_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
 void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
-- 
1.8.3.1



