Received: from eggs.gnu.org ([2001:4830:134:3::10]:55575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXq-0000kU-E8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXo-0006ay-Uo
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:04 -0300
Message-Id: <20170831035306.29170-6-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/7] hw/char/exynos4210_uart: use
 serial_chr_nonnull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This ARRAY_SIZE() first surprised me but was valid :)

 hw/char/exynos4210_uart.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 3957e78abf..b6cdfc3006 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -27,6 +27,7 @@
 #include "chardev/char-serial.h"
 
 #include "hw/arm/exynos4210.h"
+#include "hw/char/serial.h"
 
 #undef DEBUG_UART
 #undef DEBUG_UART_EXTEND
@@ -589,9 +590,6 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     DeviceState  *dev;
     SysBusDevice *bus;
 
-    const char chr_name[] = "serial";
-    char label[ARRAY_SIZE(chr_name) + 1];
-
     dev = qdev_create(NULL, TYPE_EXYNOS4210_UART);
 
     if (!chr) {
@@ -600,15 +598,7 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
                          MAX_SERIAL_PORTS);
             exit(1);
         }
-        chr = serial_hds[channel];
-        if (!chr) {
-            snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
-            chr = qemu_chr_new(label, "null");
-            if (!(chr)) {
-                error_report("Can't assign serial port to UART%d", channel);
-                exit(1);
-            }
-        }
+        chr = serial_chr_nonnull(serial_hds[channel]);
     }
 
     qdev_prop_set_chr(dev, "chardev", chr);
-- 
2.14.1
