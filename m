Received: from eggs.gnu.org ([2001:4830:134:3::10]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9ht-0008CK-Oh
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9hs-0005u7-VP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:36:53 -0500
Received: from mail.kernel.org ([198.145.29.136]:37346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9hs-0005tp-P5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:36:52 -0500
Date: Wed, 25 Jan 2017 00:36:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485297322-10595-11-git-send-email-mst@redhat.com>
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485297322-10595-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/16] hw/i386: check if nvdimm is enabled
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
index c949cf0..47984c8 100644
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
