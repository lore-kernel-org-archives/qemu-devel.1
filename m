Received: from eggs.gnu.org ([2001:4830:134:3::10]:38191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1x-0003Ij-EU
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1w-00060G-DZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1w-0005zz-7Q
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:08 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:31 -0200
Message-Id: <20170123232738.20796-7-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] pc: cleanup: move smbios_set_cpuid() into
 pc_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

move smbios_set_cpuid() close to the rest of smbios init code
where it belongs to instead of calling it from pc_cpus_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1484759609-264075-3-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f721fde0c2..c0d0d2c6a1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -701,16 +701,20 @@ static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
     }
 }
 
-static void pc_build_smbios(FWCfgState *fw_cfg)
+static void pc_build_smbios(PCMachineState *pcms)
 {
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
+    X86CPU *cpu = X86_CPU(pcms->possible_cpus->cpus[0].cpu);
+
+    /* tell smbios about cpuid version and features */
+    smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
     smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
     if (smbios_tables) {
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
+        fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
     }
 
@@ -731,9 +735,9 @@ static void pc_build_smbios(FWCfgState *fw_cfg)
     g_free(mem_array);
 
     if (smbios_anchor) {
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-tables",
+        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-tables",
                         smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
+        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
 }
@@ -1191,9 +1195,6 @@ void pc_cpus_init(PCMachineState *pcms)
             object_unref(OBJECT(cpu));
         }
     }
-
-    /* tell smbios about cpuid version and features */
-    smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 }
 
 static void pc_build_feature_control_file(PCMachineState *pcms)
@@ -1266,7 +1267,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     acpi_setup();
     if (pcms->fw_cfg) {
-        pc_build_smbios(pcms->fw_cfg);
+        pc_build_smbios(pcms);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
-- 
2.11.0.259.g40922b1
