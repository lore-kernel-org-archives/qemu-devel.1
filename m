Received: from eggs.gnu.org ([2001:4830:134:3::10]:36776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41l-0006Vq-A3
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41k-0005wK-FX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41k-0005rx-7f
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:52 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41i-0004Tv-PH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:19 +0000
Message-Id: <1510061722-14092-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 4/7] hw/arm: Mark the "fsl,
 imx31" device with user_creatable = false
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

QEMU currently crashes when the user tries to instantiate the fsl,imx31
device manually:

$ aarch64-softmmu/qemu-system-aarch64 -M kzm -device fsl,,imx31
**
ERROR:/home/thuth/devel/qemu/tcg/tcg.c:538:tcg_register_thread:
 assertion failed: (n < max_cpus)
Aborted (core dumped)

The kzm board (which is the one that uses this CPU type) only supports
one CPU, and the realize function of the "fsl,imx31" device also uses
serial_hds[] directly, so this device clearly can not be instantiated
twice and thus we should mark it with user_creatable = false.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1509519537-6964-4-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx31.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 0f2ebe8..3eee83d 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -260,8 +260,12 @@ static void fsl_imx31_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = fsl_imx31_realize;
-
     dc->desc = "i.MX31 SOC";
+    /*
+     * Reason: uses serial_hds in realize and the kzm board does not
+     * support multiple CPUs
+     */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx31_type_info = {
-- 
2.7.4
