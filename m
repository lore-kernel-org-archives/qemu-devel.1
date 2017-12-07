Received: from eggs.gnu.org ([2001:4830:134:3::10]:52149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGY-0005VG-Nh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGX-0003ee-LU
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGX-000355-Bh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:53 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:12 +0800
Message-Id: <20171207101812.23602-11-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 10/10] xen-hvm: enable building
 NFIT and SSDT of vNVDIMM for HVM domains
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

When QEMU is used the device model of Xen HVM domain and vNVDIMM
devices are present, enable building ACPI tables related to vNVDIMM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/xen/xen-hvm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index a7e99bd438..33447fc482 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1236,6 +1236,11 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
+static bool xen_dm_acpi_build_enabled(PCMachineState *pcms)
+{
+    return pcms->acpi_nvdimm_state.is_enabled;
+}
+
 static void xen_fw_cfg_init(PCMachineState *pcms)
 {
     FWCfgState *fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
@@ -1392,8 +1397,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     xen_be_register_common();
     xen_read_physmap(state);
 
-    /* Disable ACPI build because Xen handles it */
-    pcms->acpi_build_enabled = false;
+    pcms->acpi_build_enabled = xen_dm_acpi_build_enabled(pcms);;
     if (pcms->acpi_build_enabled) {
         xen_fw_cfg_init(pcms);
     }
@@ -1486,6 +1490,11 @@ void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
         return;
     }
 
+    if (pcms->acpi_nvdimm_state.is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          &pcms->acpi_nvdimm_state, machine->ram_slots);
+    }
+
     /*
      * QEMU RSDP and RSDT are only used by hvmloader to enumerate
      * QEMU-built tables. HVM domains still use Xen-built RSDP and RSDT.
-- 
2.15.1
