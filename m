Received: from eggs.gnu.org ([2001:4830:134:3::10]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cS0Tg-0005EK-4K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cS0Td-000752-26
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:57:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:20839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cS0Tc-00073h-PX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:57:01 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 13 Jan 2017 19:56:51 +0800
Message-Id: <20170113115651.17607-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, imammedo@redhat.com, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
is disabled. QEMU should refuse to plug any NVDIMM device in this case
and report the misconfiguration.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
Message-Id: 20170111093630.2088-1-stefanha@redhat.com
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 25e8586..3907609 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
     }
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        if (!pcms->acpi_nvdimm_state.is_enabled) {
+            error_setg(&local_err,
+                       "nvdimm is not enabled: missing 'nvdimm' in '-M'");
+            goto out;
+        }
         nvdimm_plug(&pcms->acpi_nvdimm_state);
     }
 
-- 
2.10.1
