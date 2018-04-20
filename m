Received: from eggs.gnu.org ([2001:4830:134:3::10]:43400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPO-0006MD-LY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPN-0007ro-SK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPN-0007mN-KP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:45 +0100
Message-Id: <20180420145249.32435-10-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] hw/char/exynos4210_uart.c: Remove
 unneeded handling of NULL chardev
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

The handling of NULL chardevs in exynos4210_uart_create() is now
all unnecessary: we don't need to create 'null' chardevs, and we
don't need to enforce a bounds check on serial_hd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index c2bba03362..a5a285655f 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -589,28 +589,8 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     DeviceState  *dev;
     SysBusDevice *bus;
 
-    const char chr_name[] = "serial";
-    char label[ARRAY_SIZE(chr_name) + 1];
-
     dev = qdev_create(NULL, TYPE_EXYNOS4210_UART);
 
-    if (!chr) {
-        if (channel >= MAX_SERIAL_PORTS) {
-            error_report("Only %d serial ports are supported by QEMU",
-                         MAX_SERIAL_PORTS);
-            exit(1);
-        }
-        chr = serial_hd(channel);
-        if (!chr) {
-            snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
-            chr = qemu_chr_new(label, "null");
-            if (!(chr)) {
-                error_report("Can't assign serial port to UART%d", channel);
-                exit(1);
-            }
-        }
-    }
-
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint32(dev, "channel", channel);
     qdev_prop_set_uint32(dev, "rx-size", fifo_size);
-- 
2.17.0
