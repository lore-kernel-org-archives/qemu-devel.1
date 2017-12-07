Received: from eggs.gnu.org ([2001:4830:134:3::10]:52080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGK-0005KM-NF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGI-0003FD-G6
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGI-000355-6w
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:38 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:07 +0800
Message-Id: <20171207101812.23602-6-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 05/10] xen-hvm: initialize fw_cfg
 interface
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

Xen is going to reuse QEMU to build ACPI of some devices (e.g., NFIT
and SSDT for NVDIMM) for HVM domains. The existing QEMU ACPI build
code requires a fw_cfg interface which will also be used to pass QEMU
built ACPI to Xen. Therefore, we need to initialize fw_cfg when any
ACPI is going to be built by QEMU.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/xen/xen-hvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index fe01b7a025..4b29f4052b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
+#include "hw/loader.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
@@ -1234,6 +1235,14 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
+static void xen_fw_cfg_init(PCMachineState *pcms)
+{
+    FWCfgState *fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
+
+    rom_set_fw(fw_cfg);
+    pcms->fw_cfg = fw_cfg;
+}
+
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     int i, rc;
@@ -1384,6 +1393,9 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     /* Disable ACPI build because Xen handles it */
     pcms->acpi_build_enabled = false;
+    if (pcms->acpi_build_enabled) {
+        xen_fw_cfg_init(pcms);
+    }
 
     return;
 
-- 
2.15.1
