Received: from eggs.gnu.org ([2001:4830:134:3::10]:58372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGw-0001gR-FE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGv-0000G3-KP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:58 -0500
Received: from mail.kernel.org ([198.145.29.136]:39480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYYGv-0000Fv-DI
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:14:57 -0500
Date: Tue, 31 Jan 2017 15:14:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485868446-10587-13-git-send-email-mst@redhat.com>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485868446-10587-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 12/21] hw/i386: check if nvdimm is enabled
 before plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Haozhong Zhang <haozhong.zhang@intel.com>

The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
is disabled. QEMU should refuse to plug any NVDIMM device in this case
and report the misconfiguration.

The behavior of NVDIMM on unsupported platform (HW/FW) is vendor
specific. For some vendors, it's undefined and the platform may do
anything. Thus, I think QEMU is free to choose the implementation.
Aborting QEMU (i.e. refusing to boot) is the easiest one.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
Message-Id: 20170111093630.2088-1-stefanha@redhat.com
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 706e233..e3fcd51 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1708,6 +1708,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
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
MST
