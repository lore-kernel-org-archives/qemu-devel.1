Received: from eggs.gnu.org ([2001:4830:134:3::10]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhK3-0000eU-TO
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhK1-0004Mk-P6
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:59 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com
	([40.107.0.136]:31167
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBhK1-0004AG-HJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:57 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 15:47:22 +0300
Message-ID: <1495198042-124203-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 9/9] char: avoid chardevice direct access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

frontends should avoid accessing CharDriver struct where possible

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 chardev/char.c              | 5 +++++
 gdbstub.c                   | 2 +-
 hw/arm/strongarm.c          | 2 +-
 hw/char/cadence_uart.c      | 2 +-
 hw/char/debugcon.c          | 2 +-
 hw/char/escc.c              | 6 +++---
 hw/char/exynos4210_uart.c   | 2 +-
 hw/char/grlib_apbuart.c     | 2 +-
 hw/char/ipoctal232.c        | 2 +-
 hw/char/parallel.c          | 2 +-
 hw/char/sclpconsole-lm.c    | 2 +-
 hw/char/sclpconsole.c       | 2 +-
 hw/char/sh_serial.c         | 2 +-
 hw/char/spapr_vty.c         | 2 +-
 hw/char/terminal3270.c      | 2 +-
 hw/char/xen_console.c       | 2 +-
 hw/ipmi/ipmi_bmc_extern.c   | 2 +-
 hw/misc/ivshmem.c           | 4 ++--
 hw/usb/ccid-card-passthru.c | 4 ++--
 hw/usb/dev-serial.c         | 5 ++---
 hw/usb/redirect.c           | 5 ++---
 include/sysemu/char.h       | 7 +++++++
 net/filter-mirror.c         | 2 +-
 23 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 36d6f36..e43d840 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -494,6 +494,11 @@ bool qemu_chr_fe_backend_connected(CharBackend *be)
     return !!be->chr;
 }
 
+bool qemu_chr_fe_backend_open(CharBackend *be)
+{
+    return be->chr && be->chr->be_open;
+}
+
 static bool fe_connect(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
diff --git a/gdbstub.c b/gdbstub.c
index 1ac0489..68cbe8a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2001,7 +2001,7 @@ int gdbserver_start(const char *device)
                                    NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
-        if (qemu_chr_fe_get_driver(&s->chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
             object_unparent(OBJECT(qemu_chr_fe_get_driver(&s->chr)));
         }
         mon_chr = s->mon_chr;
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index bec093d..9d7cf21 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1105,7 +1105,7 @@ static void strongarm_uart_tx(void *opaque)
 
     if (s->utcr3 & UTCR3_LBM) /* loopback */ {
         strongarm_uart_receive(s, &s->tx_fifo[s->tx_start], 1);
-    } else if (qemu_chr_fe_get_driver(&s->chr)) {
+    } else if (qemu_chr_fe_backend_connected(&s->chr)) {
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &s->tx_fifo[s->tx_start], 1);
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 71867b3..19636c0 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -278,7 +278,7 @@ static gboolean cadence_uart_xmit(GIOChannel *chan, GIOCondition cond,
     int ret;
 
     /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         s->tx_count = 0;
         return FALSE;
     }
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 6d95297..bd0d4f0 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -87,7 +87,7 @@ static const MemoryRegionOps debugcon_ops = {
 
 static void debugcon_realize_core(DebugconState *s, Error **errp)
 {
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         error_setg(errp, "Can't create debugcon device, empty char device");
         return;
     }
diff --git a/hw/char/escc.c b/hw/char/escc.c
index aa882b6..dbbeb4a 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -416,7 +416,7 @@ static void escc_update_parameters(ChannelState *s)
     int speed, parity, data_bits, stop_bits;
     QEMUSerialSetParams ssp;
 
-    if (!qemu_chr_fe_get_driver(&s->chr) || s->type != ser)
+    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type != ser)
         return;
 
     if (s->wregs[W_TXCTRL1] & TXCTRL1_PAREN) {
@@ -556,7 +556,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         trace_escc_mem_writeb_data(CHN_C(s), val);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
-            if (qemu_chr_fe_get_driver(&s->chr)) {
+            if (qemu_chr_fe_backend_connected(&s->chr)) {
                 /* XXX this blocks entire thread. Rewrite to use
                  * qemu_chr_fe_write and background I/O callbacks */
                 qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
@@ -1012,7 +1012,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
                           ESCC_SIZE << s->it_shift);
 
     for (i = 0; i < 2; i++) {
-        if (qemu_chr_fe_get_driver(&s->chn[i].chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chn[i].chr)) {
             s->chn[i].clock = s->frequency / 2;
             qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
                                      serial_receive1, serial_event, NULL,
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 7ef4ea5..2b0576c 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -379,7 +379,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         break;
 
     case UTXH:
-        if (qemu_chr_fe_get_driver(&s->chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
             s->reg[I_(UTRSTAT)] &= ~(UTRSTAT_TRANSMITTER_EMPTY |
                     UTRSTAT_Tx_BUFFER_EMPTY);
             ch = (uint8_t)val;
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 610a317..1cb9026 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -201,7 +201,7 @@ static void grlib_apbuart_write(void *opaque, hwaddr addr,
     case DATA_OFFSET:
     case DATA_OFFSET + 3:       /* When only one byte write */
         /* Transmit when character device available and transmitter enabled */
-        if (qemu_chr_fe_get_driver(&uart->chr) &&
+        if (qemu_chr_fe_backend_connected(&uart->chr) &&
             (uart->control & UART_TRANSMIT_ENABLE)) {
             c = value & 0xFF;
             /* XXX this blocks entire thread. Rewrite to use
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 734e42c..b5ada43 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -542,7 +542,7 @@ static void ipoctal_realize(DeviceState *dev, Error **errp)
         ch->ipoctal = s;
 
         /* Redirect IP-Octal channels to host character devices */
-        if (qemu_chr_fe_get_driver(&ch->dev)) {
+        if (qemu_chr_fe_backend_connected(&ch->dev)) {
             qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
                                      hostdev_receive, hostdev_event,
                                      NULL, ch, NULL, true);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index c71a4a0..b3ed117 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -512,7 +512,7 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
     int base;
     uint8_t dummy;
 
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         error_setg(errp, "Can't create parallel device, empty char device");
         return;
     }
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index ed1e2c5..ff54d19 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -195,7 +195,7 @@ static int write_console_data(SCLPEvent *event, const uint8_t *buf, int len)
 {
     SCLPConsoleLM *scon = SCLPLM_CONSOLE(event);
 
-    if (!qemu_chr_fe_get_driver(&scon->chr)) {
+    if (!qemu_chr_fe_backend_connected(&scon->chr)) {
         /* If there's no backend, we can just say we consumed all data. */
         return len;
     }
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 9a65010..7e23d09 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -163,7 +163,7 @@ static ssize_t write_console_data(SCLPEvent *event, const uint8_t *buf,
 {
     SCLPConsole *scon = SCLP_CONSOLE(event);
 
-    if (!qemu_chr_fe_get_driver(&scon->chr)) {
+    if (!qemu_chr_fe_backend_connected(&scon->chr)) {
         /* If there's no backend, we can just say we consumed all data. */
         return len;
     }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index c352337..868773f 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -110,7 +110,7 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
         return;
     case 0x0c: /* FTDR / TDR */
-        if (qemu_chr_fe_get_driver(&s->chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
             ch = val;
             /* XXX this blocks entire thread. Rewrite to use
              * qemu_chr_fe_write and background I/O callbacks */
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 9cdc0e0..6d1ccff 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -78,7 +78,7 @@ static void spapr_vty_realize(VIOsPAPRDevice *sdev, Error **errp)
 {
     VIOsPAPRVTYDevice *dev = VIO_SPAPR_VTY_DEVICE(sdev);
 
-    if (!qemu_chr_fe_get_driver(&dev->chardev)) {
+    if (!qemu_chr_fe_backend_connected(&dev->chardev)) {
         error_setg(errp, "chardev property not set");
         return;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 943a0f3..62803e5 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -239,7 +239,7 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd,
             return 0;
         }
     }
-    if (!qemu_chr_fe_get_driver(&t->chr)) {
+    if (!qemu_chr_fe_backend_connected(&t->chr)) {
         /* We just say we consumed all data if there's no backend. */
         return count;
     }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index cb7975f..b066176 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -150,7 +150,7 @@ static void xencons_send(struct XenConsole *con)
     ssize_t len, size;
 
     size = con->buffer.size - con->buffer.consumed;
-    if (qemu_chr_fe_get_driver(&con->chr)) {
+    if (qemu_chr_fe_backend_connected(&con->chr)) {
         len = qemu_chr_fe_write(&con->chr,
                                 con->buffer.data + con->buffer.consumed,
                                 size);
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 6f2339d..0ca9e92 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -447,7 +447,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
 {
     IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
 
-    if (!qemu_chr_fe_get_driver(&ibe->chr)) {
+    if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
         error_setg(errp, "IPMI external bmc requires chardev attribute");
         return;
     }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index e2dece8..a1be4bb 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1130,7 +1130,7 @@ static void ivshmem_doorbell_realize(PCIDevice *dev, Error **errp)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
 
-    if (!qemu_chr_fe_get_driver(&s->server_chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->server_chr)) {
         error_setg(errp, "You must specify a 'chardev'");
         return;
     }
@@ -1259,7 +1259,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
                      " or ivshmem-doorbell instead");
     }
 
-    if (!!qemu_chr_fe_get_driver(&s->server_chr) + !!s->shmobj != 1) {
+    if (qemu_chr_fe_backend_connected(&s->server_chr) + !!s->shmobj != 1) {
         error_setg(errp, "You must specify either 'shm' or 'chardev'");
         return;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 9ace5ac..c0f8acd 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -325,7 +325,7 @@ static void passthru_apdu_from_guest(
 {
     PassthruState *card = PASSTHRU_CCID_CARD(base);
 
-    if (!qemu_chr_fe_get_driver(&card->cs)) {
+    if (!qemu_chr_fe_backend_connected(&card->cs)) {
         printf("ccid-passthru: no chardev, discarding apdu length %d\n", len);
         return;
     }
@@ -346,7 +346,7 @@ static int passthru_initfn(CCIDCardState *base)
 
     card->vscard_in_pos = 0;
     card->vscard_in_hdr = 0;
-    if (qemu_chr_fe_get_driver(&card->cs)) {
+    if (qemu_chr_fe_backend_connected(&card->cs)) {
         DPRINTF(card, D_INFO, "initing chardev\n");
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index e6b2c7c..7aa7290 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -483,13 +483,12 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
 {
     USBSerialState *s = USB_SERIAL_DEV(dev);
     Error *local_err = NULL;
-    Chardev *chr = qemu_chr_fe_get_driver(&s->cs);
 
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     dev->auto_attach = 0;
 
-    if (!chr) {
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {
         error_setg(errp, "Property chardev is required");
         return;
     }
@@ -504,7 +503,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
                              usb_serial_event, NULL, s, NULL, true);
     usb_serial_handle_reset(dev);
 
-    if (chr->be_open && !dev->attached) {
+    if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
         usb_device_attach(dev, &error_abort);
     }
 }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 1e9bf69..6992d92 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -273,10 +273,9 @@ static gboolean usbredir_write_unblocked(GIOChannel *chan, GIOCondition cond,
 static int usbredir_write(void *priv, uint8_t *data, int count)
 {
     USBRedirDevice *dev = priv;
-    Chardev *chr = qemu_chr_fe_get_driver(&dev->cs);
     int r;
 
-    if (!chr->be_open) {
+    if (!qemu_chr_fe_backend_open(&dev->cs)) {
         return 0;
     }
 
@@ -1366,7 +1365,7 @@ static void usbredir_realize(USBDevice *udev, Error **errp)
     USBRedirDevice *dev = USB_REDIRECT(udev);
     int i;
 
-    if (!qemu_chr_fe_get_driver(&dev->cs)) {
+    if (!qemu_chr_fe_backend_connected(&dev->cs)) {
         error_setg(errp, QERR_MISSING_PARAMETER, "chardev");
         return;
     }
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index fa21535..e1a0e52 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -418,6 +418,13 @@ Chardev *qemu_chr_fe_get_driver(CharBackend *be);
 bool qemu_chr_fe_backend_connected(CharBackend *be);
 
 /**
+ * @qemu_chr_fe_backend_open:
+ *
+ * Returns true if chardevice associated with @be is open.
+ */
+bool qemu_chr_fe_backend_open(CharBackend *be);
+
+/**
  * @qemu_chr_fe_deinit:
  *
  * Dissociate the CharBackend from the Chardev.
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 06321d7..72a6077 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -163,7 +163,7 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
     MirrorState *s = FILTER_REDIRECTOR(nf);
     int ret;
 
-    if (qemu_chr_fe_get_driver(&s->chr_out)) {
+    if (qemu_chr_fe_backend_connected(&s->chr_out)) {
         ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
         if (ret) {
             error_report("filter_mirror_send failed(%s)", strerror(-ret));
-- 
2.7.4
