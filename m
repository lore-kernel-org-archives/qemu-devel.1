Received: from eggs.gnu.org ([2001:4830:134:3::10]:36800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41m-0006Wh-9r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41l-0005y7-Iz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:54 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41l-0005vT-D6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41h-0004Sg-J6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:17 +0000
Message-Id: <1510061722-14092-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/7] hw/arm: Mark the "fsl,
 imx6" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

This device causes QEMU to abort if the user tries to instantiate it:

$ qemu-system-aarch64 -M sabrelite -smp 1,maxcpus=2 -device fsl,,imx6
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
qemu-system-aarch64: -device fsl,,imx6: Device 'serial0' is in use
Aborted (core dumped)

The device uses serial_hds[] directly in its realize function, so it
can not be instantiated again by the user.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1509519537-6964-2-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
