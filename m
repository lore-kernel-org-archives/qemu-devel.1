Received: from eggs.gnu.org ([209.51.188.92]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEH-0003b9-CN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7t-0005Xf-N9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7t-0005Wz-GV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id u18so8063320plq.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:17 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:43 -0600
Message-Id: <20190128175458.27255-5-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 04/19] i2c: Don't check return value from
 i2c_recv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

i2c_recv() cannot fail, so there is no need to check the return
value.  It also returns unt8_t, so comparing with < 0 is not
meaningful.

Fix up various I2C controllers to remove the unneeded code.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/aspeed_i2c.c     |  9 ++-------
 hw/i2c/exynos4210_i2c.c |  8 +-------
 hw/i2c/imx_i2c.c        | 12 ++----------
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a2dfa82760..a085510cfd 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -189,16 +189,11 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
 
 static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
 {
-    int ret;
+    uint8_t ret;
 
     aspeed_i2c_set_state(bus, I2CD_MRXD);
     ret = i2c_recv(bus->bus);
-    if (ret < 0) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
-        ret = 0xff;
-    } else {
-        bus->intr_status |= I2CD_INTR_RX_DONE;
-    }
+    bus->intr_status |= I2CD_INTR_RX_DONE;
     bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
     if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
         i2c_nack(bus->bus);
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index c96fa7d7be..d154b05739 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -106,16 +106,10 @@ static inline void exynos4210_i2c_raise_interrupt(Exynos4210I2CState *s)
 static void exynos4210_i2c_data_receive(void *opaque)
 {
     Exynos4210I2CState *s = (Exynos4210I2CState *)opaque;
-    int ret;
 
     s->i2cstat &= ~I2CSTAT_LAST_BIT;
     s->scl_free = false;
-    ret = i2c_recv(s->bus);
-    if (ret < 0 && (s->i2ccon & I2CCON_ACK_GEN)) {
-        s->i2cstat |= I2CSTAT_LAST_BIT;  /* Data is not acknowledged */
-    } else {
-        s->i2cds = ret;
-    }
+    s->i2cds = i2c_recv(s->bus);
     exynos4210_i2c_raise_interrupt(s);
 }
 
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 6c81b98ebd..6da5224e2e 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -120,7 +120,7 @@ static uint64_t imx_i2c_read(void *opaque, hwaddr offset,
         value = s->i2dr_read;
 
         if (imx_i2c_is_master(s)) {
-            int ret = 0xff;
+            uint8_t ret = 0xff;
 
             if (s->address == ADDR_RESET) {
                 /* something is wrong as the address is not set */
@@ -133,15 +133,7 @@ static uint64_t imx_i2c_read(void *opaque, hwaddr offset,
             } else {
                 /* get the next byte */
                 ret = i2c_recv(s->bus);
-
-                if (ret >= 0) {
-                    imx_i2c_raise_interrupt(s);
-                } else {
-                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
-                                  "for device 0x%02x\n", TYPE_IMX_I2C,
-                                  __func__, s->address);
-                    ret = 0xff;
-                }
+                imx_i2c_raise_interrupt(s);
             }
 
             s->i2dr_read = ret;
-- 
2.17.1
