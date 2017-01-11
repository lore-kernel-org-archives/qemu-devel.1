Received: from eggs.gnu.org ([2001:4830:134:3::10]:50394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYw-0004pH-Ng
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYw-0001hx-3V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRFYv-0001hk-UN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 11 Jan 2017 09:36:30 +0000
Message-Id: <20170111093630.2088-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] nvdimm acpi: fix g_array_free() with NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
The following error is logged when an nvdimm device is realized:

  GLib-CRITICAL **: g_array_free: assertion 'array' failed

Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/acpi/nvdimm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec..8f0a484 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -375,7 +375,9 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
 
 static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
 {
-    g_array_free(fit_buf->fit, true);
+    if (fit_buf->fit) {
+        g_array_free(fit_buf->fit, true);
+    }
     fit_buf->fit = nvdimm_build_device_structure();
     fit_buf->dirty = true;
 }
-- 
2.9.3
