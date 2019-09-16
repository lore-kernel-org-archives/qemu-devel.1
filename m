Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D65C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C88214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJRH0t+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C88214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tTQ-0005BO-74
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDN-0006kn-3P
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sDK-0007cy-FE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sDI-0007aQ-9U
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id o184so77148wme.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lSmdP+pHZng8BEWPjDjiZZ2csyBsn+ff1HE03fLpH0c=;
 b=ZJRH0t+I69orU39wws4PL7LeBvfkH8pmrppDdA2zoUdEW+TPloFBPCXMwxbfrzcIaW
 KYcLOXFl8u2cWFKglM6XPEr79eupxUYyiCglej5H9QBD4L+9Nhna7/5wXUe8FmfNm/bm
 +pV2oS/jnX93Qy28l/drCasBhLqMFv0o0+KAjED/DZtzQA1gTWKO6W+L3QpmGlNyZiZh
 aV7egj1QRSNNDgMyoBP7c4no+9Ta2QVFl+XTyGUi+kuODoG0w2LZx1pI0B5PyOqaXSYO
 zLIJPDJjnEWZFkmtmTkm+pfhTc6IrY5V91zWwBclmRVhgv0rOYeAqloHd0/QilUI9sYa
 kBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lSmdP+pHZng8BEWPjDjiZZ2csyBsn+ff1HE03fLpH0c=;
 b=LY1/pv/lboUofG3Ly25o8msarh8m9xGCtUiMP4xnKpbIh9jj57q7eOtS7PnlhoMUqC
 V/2h38IaiComcNFe2xUipG6Wd8WK22SYakT8yj3tBGqnFJcc+fSaSeVeXsP/W16hd1BI
 x4mmgDKF6srPwZYhpxXDCJqeDqFs7LY5pivyGDGTl51I3nCPws9FkxE5ZWNcEUgHkF+y
 E46WEI7GzrIfLLMclO0xABNBJFI4DspiPPGK7v2fVkEr5TyDFb51IGH9ov8SMWjqKHT9
 GwptNWhyIf+XT2g6Nn3ReB9FeqGe1ivtY/lsI4f6wnRHVlohEWB4eiV6pmZ3jAFtRmir
 9GtQ==
X-Gm-Message-State: APjAAAXtZ1XLiURTimGaBTIF0aDkp3OFyJyba2dKjp6+33ZAymoIHLuo
 bKz7iqMpymT5XykzlksHDfeCx7bk
X-Google-Smtp-Source: APXvYqxIgnIUMfvPaICfNonbaL3CcJj9ABMjH4Wq5dNNPLzfZRgd+7+ebz7ySbkDYHQh1eFHR+rCHA==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr46956wmj.5.1568644962463;
 Mon, 16 Sep 2019 07:42:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:42:09 +0200
Message-Id: <1568644929-9124-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 29/29] hw/i386/pc: Extract the x86 generic
 fw_cfg code
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Extract all the functions that are not PC-machine specific into
the (arch-specific) fw_cfg.c file. This will allow other X86-machine
to reuse these functions.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-16-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/fw_cfg.h |   7 +++
 hw/i386/pc.c     | 132 +----------------------------------------------------
 3 files changed, 145 insertions(+), 131 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 380a819..39b6bc6 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -13,8 +13,15 @@
  */
 
 #include "qemu/osdep.h"
+#include "sysemu/numa.h"
+#include "hw/acpi/acpi.h"
+#include "hw/firmware/smbios.h"
+#include "hw/i386/pc.h"
 #include "hw/i386/fw_cfg.h"
+#include "hw/timer/hpet.h"
 #include "hw/nvram/fw_cfg.h"
+#include "e820_memory_layout.h"
+#include "kvm_i386.h"
 
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
@@ -36,3 +43,133 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     }
     return NULL;
 }
+
+void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
+{
+    uint8_t *smbios_tables, *smbios_anchor;
+    size_t smbios_tables_len, smbios_anchor_len;
+    struct smbios_phys_mem_area *mem_array;
+    unsigned i, array_count;
+    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
+
+    /* tell smbios about cpuid version and features */
+    smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
+
+    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
+    if (smbios_tables) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
+                         smbios_tables, smbios_tables_len);
+    }
+
+    /* build the array of physical mem area from e820 table */
+    mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
+    for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
+        uint64_t addr, len;
+
+        if (e820_get_entry(i, E820_RAM, &addr, &len)) {
+            mem_array[array_count].address = addr;
+            mem_array[array_count].length = len;
+            array_count++;
+        }
+    }
+    smbios_get_tables(ms, mem_array, array_count,
+                      &smbios_tables, &smbios_tables_len,
+                      &smbios_anchor, &smbios_anchor_len);
+    g_free(mem_array);
+
+    if (smbios_anchor) {
+        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-tables",
+                        smbios_tables, smbios_tables_len);
+        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
+                        smbios_anchor, smbios_anchor_len);
+    }
+}
+
+FWCfgState *fw_cfg_arch_create(MachineState *ms,
+                                      uint16_t boot_cpus,
+                                      uint16_t apic_id_limit)
+{
+    FWCfgState *fw_cfg;
+    uint64_t *numa_fw_cfg;
+    int i;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *cpus = mc->possible_cpu_arch_ids(ms);
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
+                                &address_space_memory);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
+
+    /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
+     *
+     * For machine types prior to 1.8, SeaBIOS needs FW_CFG_MAX_CPUS for
+     * building MPTable, ACPI MADT, ACPI CPU hotplug and ACPI SRAT table,
+     * that tables are based on xAPIC ID and QEMU<->SeaBIOS interface
+     * for CPU hotplug also uses APIC ID and not "CPU index".
+     * This means that FW_CFG_MAX_CPUS is not the "maximum number of CPUs",
+     * but the "limit to the APIC ID values SeaBIOS may see".
+     *
+     * So for compatibility reasons with old BIOSes we are stuck with
+     * "etc/max-cpus" actually being apic_id_limit
+     */
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
+                     acpi_tables, acpi_tables_len);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
+                     &e820_reserve, sizeof(e820_reserve));
+    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
+                    sizeof(struct e820_entry) * e820_get_num_entries());
+
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    /* allocate memory for the NUMA channel: one (64bit) word for the number
+     * of nodes, one word for each VCPU->node and one word for each node to
+     * hold the amount of memory.
+     */
+    numa_fw_cfg = g_new0(uint64_t, 1 + apic_id_limit + nb_numa_nodes);
+    numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
+    for (i = 0; i < cpus->len; i++) {
+        unsigned int apic_id = cpus->cpus[i].arch_id;
+        assert(apic_id < apic_id_limit);
+        numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);
+    }
+    for (i = 0; i < nb_numa_nodes; i++) {
+        numa_fw_cfg[apic_id_limit + 1 + i] =
+            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
+    }
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
+                     (1 + apic_id_limit + nb_numa_nodes) *
+                     sizeof(*numa_fw_cfg));
+
+    return fw_cfg;
+}
+
+void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
+{
+    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
+    CPUX86State *env = &cpu->env;
+    uint32_t unused, ecx, edx;
+    uint64_t feature_control_bits = 0;
+    uint64_t *val;
+
+    cpu_x86_cpuid(env, 1, 0, &unused, &unused, &ecx, &edx);
+    if (ecx & CPUID_EXT_VMX) {
+        feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+    }
+
+    if ((edx & (CPUID_EXT2_MCE | CPUID_EXT2_MCA)) ==
+        (CPUID_EXT2_MCE | CPUID_EXT2_MCA) &&
+        (env->mcg_cap & MCG_LMCE_P)) {
+        feature_control_bits |= FEATURE_CONTROL_LMCE;
+    }
+
+    if (!feature_control_bits) {
+        return;
+    }
+
+    val = g_malloc(sizeof(*val));
+    *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
+    fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
+}
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 17a4bc3..e0856a3 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -9,6 +9,7 @@
 #ifndef HW_I386_FW_CFG_H
 #define HW_I386_FW_CFG_H
 
+#include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
 #define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
@@ -17,4 +18,10 @@
 #define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
 #define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
 
+FWCfgState *fw_cfg_arch_create(MachineState *ms,
+                               uint16_t boot_cpus,
+                               uint16_t apic_id_limit);
+void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
+
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9446596..e5b59ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,6 +88,7 @@
 #include "qapi/qmp/qerror.h"
 #include "config-devices.h"
 #include "e820_memory_layout.h"
+#include "fw_cfg.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -894,108 +895,6 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     }
 }
 
-static void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
-{
-    uint8_t *smbios_tables, *smbios_anchor;
-    size_t smbios_tables_len, smbios_anchor_len;
-    struct smbios_phys_mem_area *mem_array;
-    unsigned i, array_count;
-    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
-
-    /* tell smbios about cpuid version and features */
-    smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
-
-    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
-    if (smbios_tables) {
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
-                         smbios_tables, smbios_tables_len);
-    }
-
-    /* build the array of physical mem area from e820 table */
-    mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
-    for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
-        uint64_t addr, len;
-
-        if (e820_get_entry(i, E820_RAM, &addr, &len)) {
-            mem_array[array_count].address = addr;
-            mem_array[array_count].length = len;
-            array_count++;
-        }
-    }
-    smbios_get_tables(ms, mem_array, array_count,
-                      &smbios_tables, &smbios_tables_len,
-                      &smbios_anchor, &smbios_anchor_len);
-    g_free(mem_array);
-
-    if (smbios_anchor) {
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-tables",
-                        smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
-                        smbios_anchor, smbios_anchor_len);
-    }
-}
-
-static FWCfgState *fw_cfg_arch_create(MachineState *ms,
-                                      uint16_t boot_cpus,
-                                      uint16_t apic_id_limit)
-{
-    FWCfgState *fw_cfg;
-    uint64_t *numa_fw_cfg;
-    int i;
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    const CPUArchIdList *cpus = mc->possible_cpu_arch_ids(ms);
-    int nb_numa_nodes = ms->numa_state->num_nodes;
-
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
-
-    /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
-     *
-     * For machine types prior to 1.8, SeaBIOS needs FW_CFG_MAX_CPUS for
-     * building MPTable, ACPI MADT, ACPI CPU hotplug and ACPI SRAT table,
-     * that tables are based on xAPIC ID and QEMU<->SeaBIOS interface
-     * for CPU hotplug also uses APIC ID and not "CPU index".
-     * This means that FW_CFG_MAX_CPUS is not the "maximum number of CPUs",
-     * but the "limit to the APIC ID values SeaBIOS may see".
-     *
-     * So for compatibility reasons with old BIOSes we are stuck with
-     * "etc/max-cpus" actually being apic_id_limit
-     */
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
-                     acpi_tables, acpi_tables_len);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
-
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
-                     &e820_reserve, sizeof(e820_reserve));
-    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_get_num_entries());
-
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
-    /* allocate memory for the NUMA channel: one (64bit) word for the number
-     * of nodes, one word for each VCPU->node and one word for each node to
-     * hold the amount of memory.
-     */
-    numa_fw_cfg = g_new0(uint64_t, 1 + apic_id_limit + nb_numa_nodes);
-    numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
-    for (i = 0; i < cpus->len; i++) {
-        unsigned int apic_id = cpus->cpus[i].arch_id;
-        assert(apic_id < apic_id_limit);
-        numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);
-    }
-    for (i = 0; i < nb_numa_nodes; i++) {
-        numa_fw_cfg[apic_id_limit + 1 + i] =
-            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
-    }
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
-                     (1 + apic_id_limit + nb_numa_nodes) *
-                     sizeof(*numa_fw_cfg));
-
-    return fw_cfg;
-}
-
 static long get_file_size(FILE *f)
 {
     long where, size;
@@ -1623,35 +1522,6 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
 
-static void fw_cfg_build_feature_control(MachineState *ms,
-                                         FWCfgState *fw_cfg)
-{
-    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
-    CPUX86State *env = &cpu->env;
-    uint32_t unused, ecx, edx;
-    uint64_t feature_control_bits = 0;
-    uint64_t *val;
-
-    cpu_x86_cpuid(env, 1, 0, &unused, &unused, &ecx, &edx);
-    if (ecx & CPUID_EXT_VMX) {
-        feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
-    }
-
-    if ((edx & (CPUID_EXT2_MCE | CPUID_EXT2_MCA)) ==
-        (CPUID_EXT2_MCE | CPUID_EXT2_MCA) &&
-        (env->mcg_cap & MCG_LMCE_P)) {
-        feature_control_bits |= FEATURE_CONTROL_LMCE;
-    }
-
-    if (!feature_control_bits) {
-        return;
-    }
-
-    val = g_malloc(sizeof(*val));
-    *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
-    fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
-}
-
 static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
 {
     if (cpus_count > 0xff) {
-- 
1.8.3.1


