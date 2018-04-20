Received: from eggs.gnu.org ([2001:4830:134:3::10]:43539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPW-0006Ug-3w
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPV-0007wb-2C
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPU-0007mN-Q3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:38 +0100
Message-Id: <20180420145249.32435-3-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/13] hw/arm/fsl-imx*: Don't create "null"
 chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Following commit 12051d82f004024, UART devices should handle
being passed a NULL pointer chardev, so we don't need to
create "null" backends in board code. Remove the code that
does this and updates serial_hds[].

(fsl-imx7.c was already written this way.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx25.c | 12 +-----------
 hw/arm/fsl-imx31.c | 12 +-----------
 hw/arm/fsl-imx6.c  | 13 +------------
 3 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index cb988a6c25..d7d064e5ce 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -118,17 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            Chardev *chr;
-
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char label[20];
-                snprintf(label, sizeof(label), "imx31.uart%d", i);
-                chr = qemu_chr_new(label, "null");
-            }
-
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 3eee83d547..e6c788049d 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -107,17 +107,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            Chardev *chr;
-
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char label[20];
-                snprintf(label, sizeof(label), "imx31.uart%d", i);
-                chr = qemu_chr_new(label, "null");
-            }
-
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 9dfbc9a8c4..ea14de33c6 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -189,18 +189,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         if (i < MAX_SERIAL_PORTS) {
-            Chardev *chr;
-
-            chr = serial_hds[i];
-
-            if (!chr) {
-                char *label = g_strdup_printf("imx6.uart%d", i + 1);
-                chr = qemu_chr_new(label, "null");
-                g_free(label);
-                serial_hds[i] = chr;
-            }
-
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hds[i]);
         }
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-- 
2.17.0
