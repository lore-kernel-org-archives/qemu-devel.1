Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzS-0001yE-RZ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mzS-000094-2A
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:59:06 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  1 Nov 2017 07:58:56 +0100
Message-Id: <1509519537-6964-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1509519537-6964-1-git-send-email-thuth@redhat.com>
References: <1509519537-6964-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] hw/arm: Mark the "fsl,
 imx25" device with user_creatable = false
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

QEMU currently crashes when the user tries to instantiate the fsl,imx25
device manually:

$ aarch64-softmmu/qemu-system-aarch64 -S -M imx25-pdk -device fsl,,imx25
**
ERROR:/home/thuth/devel/qemu/tcg/tcg.c:538:tcg_register_thread:
 assertion failed: (n < max_cpus)

The imx25-pdk board (which is the one that uses this CPU type) only
supports one CPU, and the realize function of the "fsl,imx25" device
also uses serial_hds[] directly, so this device clearly can not be
instantiated twice and thus we should mark it with user_creatable = 0.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/fsl-imx25.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 3b97ece..cb988a6 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -288,8 +288,12 @@ static void fsl_imx25_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = fsl_imx25_realize;
-
     dc->desc = "i.MX25 SOC";
+    /*
+     * Reason: uses serial_hds in realize and the imx25 board does not
+     * support multiple CPUs
+     */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
-- 
1.8.3.1
