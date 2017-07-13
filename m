Received: from eggs.gnu.org ([2001:4830:134:3::10]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf42-0001Y6-UJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3y-0003Ox-Ox
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3y-0003Ju-7f
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id p204so5453836wmg.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:02 +0200
Message-Id: <1499955874-10954-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/41] char: add backend hotswap handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Frontends should have an interface to setup the handler of a backend change.
The interface will be used in the next commits

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-3-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/rng-egd.c          |  2 +-
 chardev/char-fe.c           |  4 +++-
 chardev/char-mux.c          |  1 +
 gdbstub.c                   |  2 +-
 hw/arm/pxa2xx.c             |  3 ++-
 hw/arm/strongarm.c          |  2 +-
 hw/char/bcm2835_aux.c       |  2 +-
 hw/char/cadence_uart.c      |  2 +-
 hw/char/debugcon.c          |  2 +-
 hw/char/digic-uart.c        |  2 +-
 hw/char/escc.c              |  2 +-
 hw/char/etraxfs_ser.c       |  2 +-
 hw/char/exynos4210_uart.c   |  2 +-
 hw/char/grlib_apbuart.c     |  2 +-
 hw/char/imx_serial.c        |  2 +-
 hw/char/ipoctal232.c        |  2 +-
 hw/char/lm32_juart.c        |  2 +-
 hw/char/lm32_uart.c         |  2 +-
 hw/char/mcf_uart.c          |  2 +-
 hw/char/milkymist-uart.c    |  2 +-
 hw/char/pl011.c             |  2 +-
 hw/char/sclpconsole-lm.c    |  2 +-
 hw/char/sclpconsole.c       |  2 +-
 hw/char/serial.c            |  2 +-
 hw/char/sh_serial.c         |  2 +-
 hw/char/spapr_vty.c         |  2 +-
 hw/char/stm32f2xx_usart.c   |  3 ++-
 hw/char/terminal3270.c      |  2 +-
 hw/char/virtio-console.c    |  4 ++--
 hw/char/xen_console.c       |  2 +-
 hw/char/xilinx_uartlite.c   |  2 +-
 hw/ipmi/ipmi_bmc_extern.c   |  2 +-
 hw/mips/boston.c            |  2 +-
 hw/mips/mips_malta.c        |  2 +-
 hw/misc/ivshmem.c           |  2 +-
 hw/usb/ccid-card-passthru.c |  2 +-
 hw/usb/dev-serial.c         |  2 +-
 hw/usb/redirect.c           |  2 +-
 include/chardev/char-fe.h   |  5 +++++
 monitor.c                   |  4 ++--
 net/colo-compare.c          | 10 ++++++----
 net/filter-mirror.c         |  6 +++---
 net/slirp.c                 |  2 +-
 net/vhost-user.c            |  7 ++++---
 qtest.c                     |  2 +-
 target/xtensa/xtensa-semi.c |  2 +-
 tests/test-char.c           | 14 ++++++++++----
 tests/vhost-user-test.c     |  2 +-
 48 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index e7ce2ca..d2b9ce6 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -106,7 +106,7 @@ static void rng_egd_opened(RngBackend *b, Error **errp)
 
     /* FIXME we should resubmit pending requests when the CDS reconnects. */
     qemu_chr_fe_set_handlers(&s->chr, rng_egd_chr_can_read,
-                             rng_egd_chr_read, NULL, s, NULL, true);
+                             rng_egd_chr_read, NULL, NULL, s, NULL, true);
 }
 
 static void rng_egd_set_chardev(Object *obj, const char *value, Error **errp)
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 3f90f05..7054863 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -216,7 +216,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
     assert(b);
 
     if (b->chr) {
-        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
+        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, NULL, true);
         if (b->chr->be == b) {
             b->chr->be = NULL;
         }
@@ -235,6 +235,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
                               IOEventHandler *fd_event,
+                              BackendChangeHandler *be_change,
                               void *opaque,
                               GMainContext *context,
                               bool set_open)
@@ -258,6 +259,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_can_read = fd_can_read;
     b->chr_read = fd_read;
     b->chr_event = fd_event;
+    b->chr_be_change = be_change;
     b->opaque = opaque;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s, context);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 08570b9..4cda5e7 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -278,6 +278,7 @@ void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
                              mux_chr_can_read,
                              mux_chr_read,
                              mux_chr_event,
+                             NULL,
                              chr,
                              context, true);
 }
diff --git a/gdbstub.c b/gdbstub.c
index ec4e4b2..e561244 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2003,7 +2003,7 @@ int gdbserver_start(const char *device)
     if (chr) {
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive, gdb_chr_receive,
-                                 gdb_chr_event, NULL, NULL, true);
+                                 gdb_chr_event, NULL, NULL, NULL, true);
     }
     s->state = chr ? RS_IDLE : RS_INACTIVE;
     s->mon_chr = mon_chr;
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 629e6c6..731ed08 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1970,7 +1970,8 @@ static void pxa2xx_fir_realize(DeviceState *dev, Error **errp)
     PXA2xxFIrState *s = PXA2XX_FIR(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, pxa2xx_fir_is_empty,
-                             pxa2xx_fir_rx, pxa2xx_fir_event, s, NULL, true);
+                             pxa2xx_fir_rx, pxa2xx_fir_event, NULL, s, NULL,
+                             true);
 }
 
 static bool pxa2xx_fir_vmstate_validate(void *opaque, int version_id)
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 7683edc..1fa082c 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1247,7 +1247,7 @@ static void strongarm_uart_realize(DeviceState *dev, Error **errp)
                              strongarm_uart_can_receive,
                              strongarm_uart_receive,
                              strongarm_uart_event,
-                             s, NULL, true);
+                             NULL, s, NULL, true);
 }
 
 static void strongarm_uart_reset(DeviceState *dev)
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 4d46ad6..370dc7e 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -279,7 +279,7 @@ static void bcm2835_aux_realize(DeviceState *dev, Error **errp)
     BCM2835AuxState *s = BCM2835_AUX(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
-                             bcm2835_aux_receive, NULL, s, NULL, true);
+                             bcm2835_aux_receive, NULL, NULL, s, NULL, true);
 }
 
 static Property bcm2835_aux_props[] = {
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 4a2c124..3a9335c 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -485,7 +485,7 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
                                           fifo_trigger_update, s);
 
     qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
-                             uart_event, s, NULL, true);
+                             uart_event, NULL, s, NULL, true);
 }
 
 static void cadence_uart_init(Object *obj)
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 762e3d8..9b56fb8 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -92,7 +92,7 @@ static void debugcon_realize_core(DebugconState *s, Error **errp)
         return;
     }
 
-    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, s, NULL, true);
+    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL, s, NULL, true);
 }
 
 static void debugcon_isa_realizefn(DeviceState *dev, Error **errp)
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 34306e1..6ebcb87 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -146,7 +146,7 @@ static void digic_uart_realize(DeviceState *dev, Error **errp)
     DigicUartState *s = DIGIC_UART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
-                             uart_event, s, NULL, true);
+                             uart_event, NULL, s, NULL, true);
 }
 
 static void digic_uart_init(Object *obj)
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3f78763..3546df3 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -1016,7 +1016,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
         if (qemu_chr_fe_get_driver(&s->chn[i].chr)) {
             s->chn[i].clock = s->frequency / 2;
             qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
-                                     serial_receive1, serial_event,
+                                     serial_receive1, serial_event, NULL,
                                      &s->chn[i], NULL, true);
         }
     }
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index c1fba9f..a184026 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -233,7 +233,7 @@ static void etraxfs_ser_realize(DeviceState *dev, Error **errp)
 
     qemu_chr_fe_set_handlers(&s->chr,
                              serial_can_receive, serial_receive,
-                             serial_event, s, NULL, true);
+                             serial_event, NULL, s, NULL, true);
 }
 
 static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index b51d44a..a84d2c3 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -645,7 +645,7 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
 
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
-                             s, NULL, true);
+                             NULL, s, NULL, true);
 }
 
 static Property exynos4210_uart_properties[] = {
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 32d98ed..12d0c99 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -247,7 +247,7 @@ static int grlib_apbuart_init(SysBusDevice *dev)
                              grlib_apbuart_can_receive,
                              grlib_apbuart_receive,
                              grlib_apbuart_event,
-                             uart, NULL, true);
+                             NULL, uart, NULL, true);
 
     sysbus_init_irq(dev, &uart->irq);
 
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index af25030..70405cc 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -315,7 +315,7 @@ static void imx_serial_realize(DeviceState *dev, Error **errp)
     DPRINTF("char dev for uart: %p\n", qemu_chr_fe_get_driver(&s->chr));
 
     qemu_chr_fe_set_handlers(&s->chr, imx_can_receive, imx_receive,
-                             imx_event, s, NULL, true);
+                             imx_event, NULL, s, NULL, true);
 }
 
 static void imx_serial_init(Object *obj)
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 337a3e56..cc8c8dc 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -545,7 +545,7 @@ static void ipoctal_realize(DeviceState *dev, Error **errp)
         if (qemu_chr_fe_get_driver(&ch->dev)) {
             qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
                                      hostdev_receive, hostdev_event,
-                                     ch, NULL, true);
+                                     NULL, ch, NULL, true);
             DPRINTF("Redirecting channel %u to %s\n", i, ch->dev->label);
         } else {
             DPRINTF("Could not redirect channel %u, no chardev set\n", i);
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index 3948dcd..d75c835 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -119,7 +119,7 @@ static void lm32_juart_realize(DeviceState *dev, Error **errp)
     LM32JuartState *s = LM32_JUART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, juart_can_rx, juart_rx,
-                             juart_event, s, NULL, true);
+                             juart_event, NULL, s, NULL, true);
 }
 
 static const VMStateDescription vmstate_lm32_juart = {
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index cff8c38..c4a3b9b 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -266,7 +266,7 @@ static void lm32_uart_realize(DeviceState *dev, Error **errp)
     LM32UartState *s = LM32_UART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
-                             uart_event, s, NULL, true);
+                             uart_event, NULL, s, NULL, true);
 }
 
 static const VMStateDescription vmstate_lm32_uart = {
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index fe12ad5..56fa402 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -305,7 +305,7 @@ static void mcf_uart_realize(DeviceState *dev, Error **errp)
     mcf_uart_state *s = MCF_UART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, mcf_uart_can_receive, mcf_uart_receive,
-                             mcf_uart_event, s, NULL, true);
+                             mcf_uart_event, NULL, s, NULL, true);
 }
 
 static Property mcf_uart_properties[] = {
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index e19d0f6..548ee27 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -199,7 +199,7 @@ static void milkymist_uart_realize(DeviceState *dev, Error **errp)
     MilkymistUartState *s = MILKYMIST_UART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
-                             uart_event, s, NULL, true);
+                             uart_event, NULL, s, NULL, true);
 }
 
 static void milkymist_uart_init(Object *obj)
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 33802f0..2aa277f 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -329,7 +329,7 @@ static void pl011_realize(DeviceState *dev, Error **errp)
     PL011State *s = PL011(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
-                             pl011_event, s, NULL, true);
+                             pl011_event, NULL, s, NULL, true);
 }
 
 static void pl011_class_init(ObjectClass *oc, void *data)
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 1b15046..741c641 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -313,7 +313,7 @@ static int console_init(SCLPEvent *event)
     console_available = true;
 
     qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
-                             chr_read, NULL, scon, NULL, true);
+                             chr_read, NULL, NULL, scon, NULL, true);
 
     return 0;
 }
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 4a107a2..a92baa8 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -228,7 +228,7 @@ static int console_init(SCLPEvent *event)
     }
     console_available = true;
     qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
-                             chr_read, NULL, scon, NULL, true);
+                             chr_read, NULL, NULL, scon, NULL, true);
 
     return 0;
 }
diff --git a/hw/char/serial.c b/hw/char/serial.c
index e1f1250..ab14ca4 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -897,7 +897,7 @@ void serial_realize_core(SerialState *s, Error **errp)
     qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
-                             serial_event, s, NULL, true);
+                             serial_event, NULL, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
     serial_reset(s);
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index ca9816d..ad043bd 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -400,7 +400,7 @@ void sh_serial_init(MemoryRegion *sysmem,
         qemu_chr_fe_init(&s->chr, chr, &error_abort);
         qemu_chr_fe_set_handlers(&s->chr, sh_serial_can_receive1,
                                  sh_serial_receive1,
-                                 sh_serial_event, s, NULL, true);
+                                 sh_serial_event, NULL, s, NULL, true);
     }
 
     s->eri = eri_source;
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 8f02f3a..ddd1b00 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -84,7 +84,7 @@ static void spapr_vty_realize(VIOsPAPRDevice *sdev, Error **errp)
     }
 
     qemu_chr_fe_set_handlers(&dev->chardev, vty_can_receive,
-                             vty_receive, NULL, dev, NULL, true);
+                             vty_receive, NULL, NULL, dev, NULL, true);
 }
 
 /* Forward declaration */
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 59872e6..268e435 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -207,7 +207,8 @@ static void stm32f2xx_usart_realize(DeviceState *dev, Error **errp)
     STM32F2XXUsartState *s = STM32F2XX_USART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, stm32f2xx_usart_can_receive,
-                             stm32f2xx_usart_receive, NULL, s, NULL, true);
+                             stm32f2xx_usart_receive, NULL, NULL,
+                             s, NULL, true);
 }
 
 static void stm32f2xx_usart_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 7b10a04..5adf95b 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -179,7 +179,7 @@ static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
     }
     terminal_available = true;
     qemu_chr_fe_set_handlers(&t->chr, terminal_can_read,
-                             terminal_read, chr_event, t, NULL, true);
+                             terminal_read, chr_event, NULL, t, NULL, true);
 }
 
 static int read_payload_3270(EmulatedCcw3270Device *dev, uint32_t cda,
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 0cb1668..afb4949 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -188,11 +188,11 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, vcon, NULL, true);
+                                     NULL, NULL, vcon, NULL, true);
             virtio_serial_open(port);
         } else {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     chr_event, vcon, NULL, false);
+                                     chr_event, NULL, vcon, NULL, false);
         }
     }
 }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index f9af8ca..c4e8c72 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -246,7 +246,7 @@ static int con_initialise(struct XenDevice *xendev)
 
     xen_be_bind_evtchn(&con->xendev);
     qemu_chr_fe_set_handlers(&con->chr, xencons_can_receive,
-                             xencons_receive, NULL, con, NULL, true);
+                             xencons_receive, NULL, NULL, con, NULL, true);
 
     xen_pv_printf(xendev, 1,
                   "ring mfn %d, remote port %d, local port %d, limit %zd\n",
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 71ed2fc..2a8bc1e 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -212,7 +212,7 @@ static void xilinx_uartlite_realize(DeviceState *dev, Error **errp)
     XilinxUARTLite *s = XILINX_UARTLITE(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
-                             uart_event, s, NULL, true);
+                             uart_event, NULL, s, NULL, true);
 }
 
 static void xilinx_uartlite_init(Object *obj)
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 329b03e..182de58 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -453,7 +453,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
-                             chr_event, ibe, NULL, true);
+                             chr_event, NULL, ibe, NULL, true);
 }
 
 static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a4677f7..146be2a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -533,7 +533,7 @@ static void boston_mach_init(MachineState *machine)
     chr = qemu_chr_new("lcd", "vc:320x240");
     qemu_chr_fe_init(&s->lcd_display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
-                             boston_lcd_event, s, NULL, true);
+                             boston_lcd_event, NULL, s, NULL, true);
 
     ahci = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0),
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index dad2f37..8cb9d3c 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -570,7 +570,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     chr = qemu_chr_new("fpga", "vc:320x200");
     qemu_chr_fe_init(&s->display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->display, NULL, NULL,
-                             malta_fgpa_display_event, s, NULL, true);
+                             malta_fgpa_display_event, NULL, s, NULL, true);
 
     s->uart = serial_mm_init(address_space, base + 0x900, 3, uart_irq,
                              230400, uart_chr, DEVICE_NATIVE_ENDIAN);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 2f0819d..a857e50 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -894,7 +894,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
         }
 
         qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_can_receive,
-                                 ivshmem_read, NULL, s, NULL, true);
+                                 ivshmem_read, NULL, NULL, s, NULL, true);
 
         if (ivshmem_setup_interrupts(s, errp) < 0) {
             error_prepend(errp, "Failed to initialize interrupts: ");
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index ac1725e..e9f58c9 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -348,7 +348,7 @@ static int passthru_initfn(CCIDCardState *base)
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
             ccid_card_vscard_read,
-            ccid_card_vscard_event, card, NULL, true);
+            ccid_card_vscard_event, NULL, card, NULL, true);
         ccid_card_vscard_send_init(card);
     } else {
         error_report("missing chardev");
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index bfbf7cd..dc145a6 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -502,7 +502,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
     }
 
     qemu_chr_fe_set_handlers(&s->cs, usb_serial_can_read, usb_serial_read,
-                             usb_serial_event, s, NULL, true);
+                             usb_serial_event, NULL, s, NULL, true);
     usb_serial_handle_reset(dev);
 
     if (chr->be_open && !dev->attached) {
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index aa22d69..115efb9 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1399,7 +1399,7 @@ static void usbredir_realize(USBDevice *udev, Error **errp)
     /* Let the backend know we are ready */
     qemu_chr_fe_set_handlers(&dev->cs, usbredir_chardev_can_read,
                              usbredir_chardev_read, usbredir_chardev_event,
-                             dev, NULL, true);
+                             NULL, dev, NULL, true);
 
     dev->vmstate =
         qemu_add_vm_change_state_handler(usbredir_vm_state_change, dev);
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 2cbb262..9f38060 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -4,6 +4,7 @@
 #include "chardev/char.h"
 
 typedef void IOEventHandler(void *opaque, int event);
+typedef int BackendChangeHandler(void *opaque);
 
 /* This is the backend as seen by frontend, the actual backend is
  * Chardev */
@@ -12,6 +13,7 @@ struct CharBackend {
     IOEventHandler *chr_event;
     IOCanReadHandler *chr_can_read;
     IOReadHandler *chr_read;
+    BackendChangeHandler *chr_be_change;
     void *opaque;
     int tag;
     int fe_open;
@@ -54,6 +56,8 @@ Chardev *qemu_chr_fe_get_driver(CharBackend *be);
  *               receive
  * @fd_read: callback to receive data from char
  * @fd_event: event callback
+ * @be_change: backend change callback; passing NULL means hot backend change
+ *             is not supported and will not be attempted
  * @opaque: an opaque pointer for the callbacks
  * @context: a main loop context or NULL for the default
  * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
@@ -68,6 +72,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
                               IOReadHandler *fd_read,
                               IOEventHandler *fd_event,
+                              BackendChangeHandler *be_change,
                               void *opaque,
                               GMainContext *context,
                               bool set_open);
diff --git a/monitor.c b/monitor.c
index d8ac20f..292fc34 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4110,12 +4110,12 @@ void monitor_init(Chardev *chr, int flags)
 
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
-                                 monitor_qmp_event, mon, NULL, true);
+                                 monitor_qmp_event, NULL, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
-                                 monitor_event, mon, NULL, true);
+                                 monitor_event, NULL, mon, NULL, true);
     }
 
     qemu_mutex_lock(&monitor_lock);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6d500e1..abfc23c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -543,7 +543,7 @@ static void compare_pri_chr_in(void *opaque, const uint8_t *buf, int size)
 
     ret = net_fill_rstate(&s->pri_rs, buf, size);
     if (ret == -1) {
-        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
+        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
                                  NULL, NULL, true);
         error_report("colo-compare primary_in error");
     }
@@ -560,7 +560,7 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
 
     ret = net_fill_rstate(&s->sec_rs, buf, size);
     if (ret == -1) {
-        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
+        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
                                  NULL, NULL, true);
         error_report("colo-compare secondary_in error");
     }
@@ -588,9 +588,11 @@ static void *colo_compare_thread(void *opaque)
     s->worker_context = g_main_context_new();
 
     qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
-                          compare_pri_chr_in, NULL, s, s->worker_context, true);
+                             compare_pri_chr_in, NULL, NULL,
+                             s, s->worker_context, true);
     qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
-                          compare_sec_chr_in, NULL, s, s->worker_context, true);
+                             compare_sec_chr_in, NULL, NULL,
+                             s, s->worker_context, true);
 
     s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 52d978f..62a8265 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -112,7 +112,7 @@ static void redirector_chr_read(void *opaque, const uint8_t *buf, int size)
 
     if (ret == -1) {
         qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
-                                 NULL, NULL, true);
+                                 NULL, NULL, NULL, true);
     }
 }
 
@@ -124,7 +124,7 @@ static void redirector_chr_event(void *opaque, int event)
     switch (event) {
     case CHR_EVENT_CLOSED:
         qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
-                                 NULL, NULL, true);
+                                 NULL, NULL, NULL, true);
         break;
     default:
         break;
@@ -245,7 +245,7 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 
         qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
                                  redirector_chr_read, redirector_chr_event,
-                                 nf, NULL, true);
+                                 NULL, nf, NULL, true);
     }
 
     if (s->outdev) {
diff --git a/net/slirp.c b/net/slirp.c
index 6a6d727..9fbc949 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -778,7 +778,7 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str,
         fwd->slirp = s->slirp;
 
         qemu_chr_fe_set_handlers(&fwd->hd, guestfwd_can_read, guestfwd_read,
-                                 NULL, fwd, NULL, true);
+                                 NULL, NULL, fwd, NULL, true);
     }
     return 0;
 
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a042ec6..36f32a2 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -211,7 +211,7 @@ static void chr_closed_bh(void *opaque)
     vhost_user_stop(queues, ncs);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
-                             opaque, NULL, true);
+                             NULL, opaque, NULL, true);
 
     if (err) {
         error_report_err(err);
@@ -257,7 +257,7 @@ static void net_vhost_user_event(void *opaque, int event)
 
             g_source_remove(s->watch);
             s->watch = 0;
-            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
+            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
                                      NULL, NULL, false);
 
             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
@@ -305,7 +305,8 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
             return -1;
         }
         qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
-                                 net_vhost_user_event, nc0->name, NULL, true);
+                                 net_vhost_user_event, NULL, nc0->name, NULL,
+                                 true);
     } while (!s->started);
 
     assert(s->vhost_net);
diff --git a/qtest.c b/qtest.c
index 9a5d1dc..88a09e9 100644
--- a/qtest.c
+++ b/qtest.c
@@ -691,7 +691,7 @@ void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
 
     qemu_chr_fe_init(&qtest_chr, chr, errp);
     qemu_chr_fe_set_handlers(&qtest_chr, qtest_can_read, qtest_read,
-                             qtest_event, &qtest_chr, NULL, true);
+                             qtest_event, NULL, &qtest_chr, NULL, true);
     qemu_chr_fe_set_echo(&qtest_chr, true);
 
     inbuf = g_string_new("");
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 32e2bd7..7aa1d13 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -158,7 +158,7 @@ void xtensa_sim_open_console(Chardev *chr)
     static CharBackend console;
 
     qemu_chr_fe_init(&console, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&console, NULL, NULL, NULL, NULL, NULL, true);
+    qemu_chr_fe_set_handlers(&console, NULL, NULL, NULL, NULL, NULL, NULL, true);
     xtensa_sim_console = &console;
 }
 
diff --git a/tests/test-char.c b/tests/test-char.c
index b962063..38aaa27 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -178,6 +178,7 @@ static void char_mux_test(void)
                              fe_can_read,
                              fe_read,
                              fe_event,
+                             NULL,
                              &h1,
                              NULL, true);
 
@@ -186,6 +187,7 @@ static void char_mux_test(void)
                              fe_can_read,
                              fe_read,
                              fe_event,
+                             NULL,
                              &h2,
                              NULL, true);
     qemu_chr_fe_take_focus(&chr_be2);
@@ -209,7 +211,8 @@ static void char_mux_test(void)
     h1.read_count = 0;
 
     /* remove first handler */
-    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL, NULL, true);
+    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
+                             NULL, NULL, true);
     qemu_chr_be_write(base, (void *)"hello", 6);
     g_assert_cmpint(h1.read_count, ==, 0);
     g_assert_cmpint(h2.read_count, ==, 0);
@@ -307,13 +310,13 @@ static void char_socket_test(void)
 
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
-                             NULL, &d, NULL, true);
+                             NULL, NULL, &d, NULL, true);
 
     chr_client = qemu_chr_new("client", tmp);
     qemu_chr_fe_init(&client_be, chr_client, &error_abort);
     qemu_chr_fe_set_handlers(&client_be, socket_can_read_hello,
                              socket_read_hello,
-                             NULL, &d, NULL, true);
+                             NULL, NULL, &d, NULL, true);
     g_free(tmp);
 
     d.conn_expected = true;
@@ -383,6 +386,7 @@ static void char_pipe_test(void)
                              fe_can_read,
                              fe_read,
                              fe_event,
+                             NULL,
                              &fe,
                              NULL, true);
 
@@ -431,7 +435,7 @@ static void char_udp_test(void)
     d.chr = chr;
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be, socket_can_read_hello, socket_read_hello,
-                             NULL, &d, NULL, true);
+                             NULL, NULL, &d, NULL, true);
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
     g_assert_cmpint(ret, ==, 5);
 
@@ -523,6 +527,7 @@ static void char_file_test(void)
                                  fe_can_read,
                                  fe_read,
                                  fe_event,
+                                 NULL,
                                  &fe, NULL, true);
 
         g_assert_cmpint(fe.last_event, !=, CHR_EVENT_BREAK);
@@ -583,6 +588,7 @@ static void char_null_test(void)
                              fe_can_read,
                              fe_read,
                              fe_event,
+                             NULL,
                              NULL, NULL, true);
 
     ret = qemu_chr_fe_write(&be, (void *)"buf", 4);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index b3cc045..d4da09f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -464,7 +464,7 @@ static void test_server_create_chr(TestServer *server, const gchar *opt)
 
     qemu_chr_fe_init(&server->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
-                             chr_event, server, NULL, true);
+                             chr_event, NULL, server, NULL, true);
 }
 
 static void test_server_listen(TestServer *server)
-- 
1.8.3.1
