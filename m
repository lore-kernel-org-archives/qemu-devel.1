Received: from eggs.gnu.org ([2001:4830:134:3::10]:60208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovV-0000uf-3S
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovU-0004sE-AD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:06:25 -0300
Message-Id: <20180123030630.26613-10-f4bug@amsat.org>
In-Reply-To: <20180123030630.26613-1-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 09/14] hw/arm/fsl-imx6: implement SDHCI
 Spec. v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
various FreeBSD console output from google search show this register having
a value of 0x0377c800.

 hw/arm/fsl-imx6.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b0d4088290..1f4607f206 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -27,6 +27,8 @@
 #include "chardev/char.h"
 #include "qemu/error-report.h"
 
+#define IMX6_ESDHC_CAPABILITIES     0x057834b4
+
 #define NAME_SIZE 20
 
 static void fsl_imx6_init(Object *obj)
@@ -348,6 +350,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_uSDHC4_ADDR, FSL_IMX6_uSDHC4_IRQ },
         };
 
+        /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
+        object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
+                                 &err);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
+                                 "capareg", &err);
         object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.15.1
