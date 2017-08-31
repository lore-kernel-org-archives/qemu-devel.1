Received: from eggs.gnu.org ([2001:4830:134:3::10]:55547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXk-0000gN-BW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXj-0006ZR-EI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:02 -0300
Message-Id: <20170831035306.29170-4-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/7] hw/arm/fsl_imx*: use serial_chr_nonnull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/imx_serial.h |  1 +
 hw/arm/fsl-imx25.c           |  9 +--------
 hw/arm/fsl-imx31.c           |  9 +--------
 hw/arm/fsl-imx6.c            | 10 +---------
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index baeec3183f..55139dc6ec 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -20,6 +20,7 @@
 
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
+#include "hw/char/serial.h"
 
 #define TYPE_IMX_SERIAL "imx.serial"
 #define IMX_SERIAL(obj) OBJECT_CHECK(IMXSerialState, (obj), TYPE_IMX_SERIAL)
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 3b97eceb3c..425a9edc36 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -120,14 +120,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         if (i < MAX_SERIAL_PORTS) {
             Chardev *chr;
 
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char label[20];
-                snprintf(label, sizeof(label), "imx31.uart%d", i);
-                chr = qemu_chr_new(label, "null");
-            }
-
+            chr = serial_chr_nonnull(serial_hds[i]);
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 0f2ebe8161..8d4535a536 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -109,14 +109,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         if (i < MAX_SERIAL_PORTS) {
             Chardev *chr;
 
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char label[20];
-                snprintf(label, sizeof(label), "imx31.uart%d", i);
-                chr = qemu_chr_new(label, "null");
-            }
-
+            chr = serial_chr_nonnull(serial_hds[i]);
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 26fd214004..7bc1aa1fbe 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -189,15 +189,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         if (i < MAX_SERIAL_PORTS) {
             Chardev *chr;
 
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char *label = g_strdup_printf("imx6.uart%d", i + 1);
-                chr = qemu_chr_new(label, "null");
-                g_free(label);
-                serial_hds[i] = chr;
-            }
-
+            chr = serial_chr_nonnull(serial_hds[i]);
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
-- 
2.14.1
