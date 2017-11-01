Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzV-0001z3-Cd
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzU-00009d-Oc
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:09 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  1 Nov 2017 07:58:55 +0100
Message-Id: <1509519537-6964-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1509519537-6964-1-git-send-email-thuth@redhat.com>
References: <1509519537-6964-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] hw/arm: Mark the "fsl,
 imx6" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

This device causes QEMU to abort if the user tries to instantiate it:

$ qemu-system-aarch64 -M sabrelite -smp 1,maxcpus=2 -device fsl,,imx6
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
qemu-system-aarch64: -device fsl,,imx6: Device 'serial0' is in use
Aborted (core dumped)

The device uses serial_hds[] directly in its realize function, so it
can not be instantiated again by the user.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 26fd214..59ef33e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -440,8 +440,9 @@ static void fsl_imx6_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = fsl_imx6_realize;
-
     dc->desc = "i.MX6 SOC";
+    /* Reason: Uses serial_hds[] in the realize() function */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6_type_info = {
-- 
1.8.3.1
