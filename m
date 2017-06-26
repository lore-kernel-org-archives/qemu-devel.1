Received: from eggs.gnu.org ([2001:4830:134:3::10]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXAD-0002Bo-V6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXA9-0002wj-VT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:01 -0400
Received: from mail-eopbgr50101.outbound.protection.outlook.com
	([40.107.5.101]:39904
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPXA9-0002wB-Fd
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:57 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:42 +0300
Message-ID: <1498495550-72357-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 05/13] char: avoid chardevice direct access
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h   | 7 +++++++
 chardev/char-fe.c           | 5 +++++
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
 net/filter-mirror.c         | 2 +-
 22 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 385aa99..61c7f97 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -77,6 +77,13 @@ Chardev *qemu_chr_fe_get_driver(CharBackend *be);
 bool qemu_chr_fe_backend_connected(CharBackend *be);
=20
 /**
+ * @qemu_chr_fe_backend_open:
+ *
+ * Returns true if chardevice associated with @be is open.
+ */
+bool qemu_chr_fe_backend_open(CharBackend *be);
+
+/**
  * @qemu_chr_fe_set_handlers:
  * @b: a CharBackend
  * @fd_can_read: callback to get the amount of data the frontend may
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index be96fb5..3120441 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -193,6 +193,11 @@ bool qemu_chr_fe_backend_connected(CharBackend *be)
     return !!be->chr;
 }
=20
+bool qemu_chr_fe_backend_open(CharBackend *be)
+{
+    return be->chr && be->chr->be_open;
+}
+
 bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag =3D 0;
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 1fa082c..6a45dcc 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1106,7 +1106,7 @@ static void strongarm_uart_tx(void *opaque)
=20
     if (s->utcr3 & UTCR3_LBM) /* loopback */ {
         strongarm_uart_receive(s, &s->tx_fifo[s->tx_start], 1);
-    } else if (qemu_chr_fe_get_driver(&s->chr)) {
+    } else if (qemu_chr_fe_backend_connected(&s->chr)) {
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &s->tx_fifo[s->tx_start], 1);
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 3a9335c..6143494 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -279,7 +279,7 @@ static gboolean cadence_uart_xmit(GIOChannel *chan, GIO=
Condition cond,
     int ret;
=20
     /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         s->tx_count =3D 0;
         return FALSE;
     }
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 9b56fb8..95ccec6 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -87,7 +87,7 @@ static const MemoryRegionOps debugcon_ops =3D {
=20
 static void debugcon_realize_core(DebugconState *s, Error **errp)
 {
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         error_setg(errp, "Can't create debugcon device, empty char device"=
);
         return;
     }
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3546df3..89ae9eb 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -417,7 +417,7 @@ static void escc_update_parameters(ChannelState *s)
     int speed, parity, data_bits, stop_bits;
     QEMUSerialSetParams ssp;
=20
-    if (!qemu_chr_fe_get_driver(&s->chr) || s->type !=3D ser)
+    if (!qemu_chr_fe_backend_connected(&s->chr) || s->type !=3D ser)
         return;
=20
     if (s->wregs[W_TXCTRL1] & TXCTRL1_PAREN) {
@@ -557,7 +557,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         trace_escc_mem_writeb_data(CHN_C(s), val);
         s->tx =3D val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
-            if (qemu_chr_fe_get_driver(&s->chr)) {
+            if (qemu_chr_fe_backend_connected(&s->chr)) {
                 /* XXX this blocks entire thread. Rewrite to use
                  * qemu_chr_fe_write and background I/O callbacks */
                 qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
@@ -1013,7 +1013,7 @@ static void escc_realize(DeviceState *dev, Error **er=
rp)
                           ESCC_SIZE << s->it_shift);
=20
     for (i =3D 0; i < 2; i++) {
-        if (qemu_chr_fe_get_driver(&s->chn[i].chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chn[i].chr)) {
             s->chn[i].clock =3D s->frequency / 2;
             qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
                                      serial_receive1, serial_event, NULL,
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index a84d2c3..3957e78 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -380,7 +380,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr =
offset,
         break;
=20
     case UTXH:
-        if (qemu_chr_fe_get_driver(&s->chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
             s->reg[I_(UTRSTAT)] &=3D ~(UTRSTAT_TRANSMITTER_EMPTY |
                     UTRSTAT_Tx_BUFFER_EMPTY);
             ch =3D (uint8_t)val;
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 12d0c99..bac11be 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -201,7 +201,7 @@ static void grlib_apbuart_write(void *opaque, hwaddr ad=
dr,
     case DATA_OFFSET:
     case DATA_OFFSET + 3:       /* When only one byte write */
         /* Transmit when character device available and transmitter enable=
d */
-        if (qemu_chr_fe_get_driver(&uart->chr) &&
+        if (qemu_chr_fe_backend_connected(&uart->chr) &&
             (uart->control & UART_TRANSMIT_ENABLE)) {
             c =3D value & 0xFF;
             /* XXX this blocks entire thread. Rewrite to use
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index cc8c8dc..5e09caf 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -542,7 +542,7 @@ static void ipoctal_realize(DeviceState *dev, Error **e=
rrp)
         ch->ipoctal =3D s;
=20
         /* Redirect IP-Octal channels to host character devices */
-        if (qemu_chr_fe_get_driver(&ch->dev)) {
+        if (qemu_chr_fe_backend_connected(&ch->dev)) {
             qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
                                      hostdev_receive, hostdev_event,
                                      NULL, ch, NULL, true);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 75a1a2f..055789f 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -513,7 +513,7 @@ static void parallel_isa_realizefn(DeviceState *dev, Er=
ror **errp)
     int base;
     uint8_t dummy;
=20
-    if (!qemu_chr_fe_get_driver(&s->chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
         error_setg(errp, "Can't create parallel device, empty char device"=
);
         return;
     }
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 741c641..c500bda 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -195,7 +195,7 @@ static int write_console_data(SCLPEvent *event, const u=
int8_t *buf, int len)
 {
     SCLPConsoleLM *scon =3D SCLPLM_CONSOLE(event);
=20
-    if (!qemu_chr_fe_get_driver(&scon->chr)) {
+    if (!qemu_chr_fe_backend_connected(&scon->chr)) {
         /* If there's no backend, we can just say we consumed all data. */
         return len;
     }
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index a92baa8..d0265df 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -163,7 +163,7 @@ static ssize_t write_console_data(SCLPEvent *event, con=
st uint8_t *buf,
 {
     SCLPConsole *scon =3D SCLP_CONSOLE(event);
=20
-    if (!qemu_chr_fe_get_driver(&scon->chr)) {
+    if (!qemu_chr_fe_backend_connected(&scon->chr)) {
         /* If there's no backend, we can just say we consumed all data. */
         return len;
     }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index ad043bd..835b537 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -110,7 +110,7 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
         return;
     case 0x0c: /* FTDR / TDR */
-        if (qemu_chr_fe_get_driver(&s->chr)) {
+        if (qemu_chr_fe_backend_connected(&s->chr)) {
             ch =3D val;
             /* XXX this blocks entire thread. Rewrite to use
              * qemu_chr_fe_write and background I/O callbacks */
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index ddd1b00..0fa416c 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -78,7 +78,7 @@ static void spapr_vty_realize(VIOsPAPRDevice *sdev, Error=
 **errp)
 {
     VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
=20
-    if (!qemu_chr_fe_get_driver(&dev->chardev)) {
+    if (!qemu_chr_fe_backend_connected(&dev->chardev)) {
         error_setg(errp, "chardev property not set");
         return;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 5adf95b..28f5991 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -239,7 +239,7 @@ static int write_payload_3270(EmulatedCcw3270Device *de=
v, uint8_t cmd,
             return 0;
         }
     }
-    if (!qemu_chr_fe_get_driver(&t->chr)) {
+    if (!qemu_chr_fe_backend_connected(&t->chr)) {
         /* We just say we consumed all data if there's no backend. */
         return count;
     }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index c4e8c72..3643dfe 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -150,7 +150,7 @@ static void xencons_send(struct XenConsole *con)
     ssize_t len, size;
=20
     size =3D con->buffer.size - con->buffer.consumed;
-    if (qemu_chr_fe_get_driver(&con->chr)) {
+    if (qemu_chr_fe_backend_connected(&con->chr)) {
         len =3D qemu_chr_fe_write(&con->chr,
                                 con->buffer.data + con->buffer.consumed,
                                 size);
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 182de58..abab3bb 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -447,7 +447,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, E=
rror **errp)
 {
     IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(dev);
=20
-    if (!qemu_chr_fe_get_driver(&ibe->chr)) {
+    if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
         error_setg(errp, "IPMI external bmc requires chardev attribute");
         return;
     }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a857e50..7f678d0 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1128,7 +1128,7 @@ static void ivshmem_doorbell_realize(PCIDevice *dev, =
Error **errp)
 {
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
=20
-    if (!qemu_chr_fe_get_driver(&s->server_chr)) {
+    if (!qemu_chr_fe_backend_connected(&s->server_chr)) {
         error_setg(errp, "You must specify a 'chardev'");
         return;
     }
@@ -1257,7 +1257,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **e=
rrp)
                      " or ivshmem-doorbell instead");
     }
=20
-    if (!!qemu_chr_fe_get_driver(&s->server_chr) + !!s->shmobj !=3D 1) {
+    if (qemu_chr_fe_backend_connected(&s->server_chr) + !!s->shmobj !=3D 1=
) {
         error_setg(errp, "You must specify either 'shm' or 'chardev'");
         return;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index e9f58c9..45d96b0 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -322,7 +322,7 @@ static void passthru_apdu_from_guest(
 {
     PassthruState *card =3D PASSTHRU_CCID_CARD(base);
=20
-    if (!qemu_chr_fe_get_driver(&card->cs)) {
+    if (!qemu_chr_fe_backend_connected(&card->cs)) {
         printf("ccid-passthru: no chardev, discarding apdu length %d\n", l=
en);
         return;
     }
@@ -343,7 +343,7 @@ static int passthru_initfn(CCIDCardState *base)
=20
     card->vscard_in_pos =3D 0;
     card->vscard_in_hdr =3D 0;
-    if (qemu_chr_fe_get_driver(&card->cs)) {
+    if (qemu_chr_fe_backend_connected(&card->cs)) {
         DPRINTF(card, D_INFO, "initing chardev\n");
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index dc145a6..94b5c34 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -484,13 +484,12 @@ static void usb_serial_realize(USBDevice *dev, Error =
**errp)
 {
     USBSerialState *s =3D USB_SERIAL_DEV(dev);
     Error *local_err =3D NULL;
-    Chardev *chr =3D qemu_chr_fe_get_driver(&s->cs);
=20
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     dev->auto_attach =3D 0;
=20
-    if (!chr) {
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {
         error_setg(errp, "Property chardev is required");
         return;
     }
@@ -505,7 +504,7 @@ static void usb_serial_realize(USBDevice *dev, Error **=
errp)
                              usb_serial_event, NULL, s, NULL, true);
     usb_serial_handle_reset(dev);
=20
-    if (chr->be_open && !dev->attached) {
+    if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
         usb_device_attach(dev, &error_abort);
     }
 }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 115efb9..c597145 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -273,10 +273,9 @@ static gboolean usbredir_write_unblocked(GIOChannel *c=
han, GIOCondition cond,
 static int usbredir_write(void *priv, uint8_t *data, int count)
 {
     USBRedirDevice *dev =3D priv;
-    Chardev *chr =3D qemu_chr_fe_get_driver(&dev->cs);
     int r;
=20
-    if (!chr->be_open) {
+    if (!qemu_chr_fe_backend_open(&dev->cs)) {
         return 0;
     }
=20
@@ -1366,7 +1365,7 @@ static void usbredir_realize(USBDevice *udev, Error *=
*errp)
     USBRedirDevice *dev =3D USB_REDIRECT(udev);
     int i;
=20
-    if (!qemu_chr_fe_get_driver(&dev->cs)) {
+    if (!qemu_chr_fe_backend_connected(&dev->cs)) {
         error_setg(errp, QERR_MISSING_PARAMETER, "chardev");
         return;
     }
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 62a8265..6043549 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -163,7 +163,7 @@ static ssize_t filter_redirector_receive_iov(NetFilterS=
tate *nf,
     MirrorState *s =3D FILTER_REDIRECTOR(nf);
     int ret;
=20
-    if (qemu_chr_fe_get_driver(&s->chr_out)) {
+    if (qemu_chr_fe_backend_connected(&s->chr_out)) {
         ret =3D filter_send(&s->chr_out, iov, iovcnt);
         if (ret) {
             error_report("filter redirector send failed(%s)", strerror(-re=
t));
--=20
2.7.4
