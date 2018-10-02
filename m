Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7Lmp-0005Ih-Hx
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1g7LdC-0004Qd-R6
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:26:36 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Tue,  2 Oct 2018 16:24:42 +0200
Message-Id: <20181002142443.30976-9-damien.hedde@greensocs.com>
In-Reply-To: <20181002142443.30976-1-damien.hedde@greensocs.com>
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 8/9] hw/char/cadence_uart: add clock support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, alistair@alistair23.me, saipava@xilinx.com, mark.burton@greensocs.com, luc.michel@greensocs.com, konrad@adacore.com, edgar.iglesias@xilinx.com, Damien Hedde <damien.hedde@greensocs.com>

Add bus interface and uart reference clock inputs.

Note: it is hard to find out from the doc what is the behavior when only =
one
of the clock is disabled.

The implemented behaviour is that register access needs both clock being =
active.

The bus interface control the mmios visibility

The reference clock controls the baudrate generation. If it disabled,
any input characters and events are ignored. Also register accesses are
conditioned to the clock being enabled (but is it really the case in
reality ?) and a guest error is triggerred if that is not the case.

If theses clocks remains unconnected, the uart behaves as before
(default to 50MHz ref clock).

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 include/hw/char/cadence_uart.h |  3 ++
 hw/char/cadence_uart.c         | 92 ++++++++++++++++++++++++++++++++--
 hw/char/trace-events           |  3 ++
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index 118e3f10de..fd1d4725f4 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
+#include "hw/clock-port.h"
=20
 #define CADENCE_UART_RX_FIFO_SIZE           16
 #define CADENCE_UART_TX_FIFO_SIZE           16
@@ -47,6 +48,8 @@ typedef struct {
     CharBackend chr;
     qemu_irq irq;
     QEMUTimer *fifo_trigger_handle;
+    ClockIn *refclk;
+    ClockIn *busclk;
 } CadenceUARTState;
=20
 static inline DeviceState *cadence_uart_create(hwaddr addr,
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fbdbd463bb..feb5cee4d7 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/char/cadence_uart.h"
+#include "trace.h"
=20
 #ifdef CADENCE_UART_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -94,7 +95,7 @@
 #define LOCAL_LOOPBACK         (0x2 << UART_MR_CHMODE_SH)
 #define REMOTE_LOOPBACK        (0x3 << UART_MR_CHMODE_SH)
=20
-#define UART_INPUT_CLK         50000000
+#define UART_DEFAULT_REF_CLK (50 * 1000 * 1000)
=20
 #define R_CR       (0x00/4)
 #define R_MR       (0x04/4)
@@ -165,15 +166,30 @@ static void uart_send_breaks(CadenceUARTState *s)
                       &break_enabled);
 }
=20
+static unsigned int uart_input_clk(CadenceUARTState *s)
+{
+    return clock_get_frequency(s->refclk);
+}
+
 static void uart_parameters_setup(CadenceUARTState *s)
 {
     QEMUSerialSetParams ssp;
     unsigned int baud_rate, packet_size;
=20
     baud_rate =3D (s->r[R_MR] & UART_MR_CLKS) ?
-            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
+            uart_input_clk(s) / 8 : uart_input_clk(s);
+    baud_rate /=3D (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
+    trace_cadence_uart_baudrate(baud_rate);
+
+    ssp.speed =3D baud_rate;
+    if (ssp.speed =3D=3D 0) {
+        /*
+         * Avoid division-by-zero below.
+         * TODO: find something better
+         */
+        ssp.speed =3D 1;
+    }
=20
-    ssp.speed =3D baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
     packet_size =3D 1;
=20
     switch (s->r[R_MR] & UART_MR_PAR) {
@@ -337,6 +353,11 @@ static void uart_receive(void *opaque, const uint8_t=
 *buf, int size)
     CadenceUARTState *s =3D opaque;
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    /* ignore characters when unclocked */
+    if (!clock_is_enabled(s->refclk)) {
+        return;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         uart_write_rx_fifo(opaque, buf, size);
     }
@@ -350,6 +371,11 @@ static void uart_event(void *opaque, int event)
     CadenceUARTState *s =3D opaque;
     uint8_t buf =3D '\0';
=20
+    /* ignore events when unclocked */
+    if (!clock_is_enabled(s->refclk)) {
+        return;
+    }
+
     if (event =3D=3D CHR_EVENT_BREAK) {
         uart_write_rx_fifo(opaque, &buf, 1);
     }
@@ -382,6 +408,14 @@ static void uart_write(void *opaque, hwaddr offset,
 {
     CadenceUARTState *s =3D opaque;
=20
+    /* ignore accesses when bus or ref clock is disabled */
+    if (!(clock_is_enabled(s->busclk) && clock_is_enabled(s->refclk))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "cadence_uart: Trying to write register 0x%x"
+                " while clock is disabled\n", (unsigned) offset);
+        return;
+    }
+
     DB_PRINT(" offset:%x data:%08x\n", (unsigned)offset, (unsigned)value=
);
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
@@ -440,6 +474,14 @@ static uint64_t uart_read(void *opaque, hwaddr offse=
t,
     CadenceUARTState *s =3D opaque;
     uint32_t c =3D 0;
=20
+    /* ignore accesses when bus or ref clock is disabled */
+    if (!(clock_is_enabled(s->busclk) && clock_is_enabled(s->refclk))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "cadence_uart: Trying to read register 0x%x"
+                " while clock is disabled\n", (unsigned) offset);
+        return 0;
+    }
+
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
         c =3D 0;
@@ -488,6 +530,14 @@ static void cadence_uart_realize(DeviceState *dev, E=
rror **errp)
                              uart_event, NULL, s, NULL, true);
 }
=20
+static void cadence_uart_refclk_update(void *opaque)
+{
+    CadenceUARTState *s =3D opaque;
+
+    /* recompute uart's speed on clock change */
+    uart_parameters_setup(s);
+}
+
 static void cadence_uart_init(Object *obj)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
@@ -497,9 +547,26 @@ static void cadence_uart_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
=20
+    s->refclk =3D qdev_init_clock_in(DEVICE(obj), "refclk",
+            cadence_uart_refclk_update, s);
+    /* initialize the frequency in case the clock remains unconnected */
+    clock_init_frequency(s->refclk, UART_DEFAULT_REF_CLK);
+    s->busclk =3D qdev_init_clock_in(DEVICE(obj), "busclk", NULL, NULL);
+    /* initialize the frequency to non-zero in case it remains unconnect=
ed */
+    clock_init_frequency(s->busclk, 100 * 1000 * 1000);
+
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 9600) * 10;
 }
=20
+static int cadence_uart_pre_load(void *opaque)
+{
+    CadenceUARTState *s =3D opaque;
+
+    clock_init_frequency(s->refclk, UART_DEFAULT_REF_CLK);
+    clock_init_frequency(s->busclk, 100 * 1000 * 1000);
+    return 0;
+}
+
 static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s =3D opaque;
@@ -516,10 +583,22 @@ static int cadence_uart_post_load(void *opaque, int=
 version_id)
     return 0;
 }
=20
+static const VMStateDescription vmstate_cadence_uart_clocks =3D {
+    .name =3D "cadence_uart_clocks",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_CLOCKIN(refclk, CadenceUARTState),
+        VMSTATE_CLOCKIN(busclk, CadenceUARTState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_cadence_uart =3D {
     .name =3D "cadence_uart",
     .version_id =3D 2,
     .minimum_version_id =3D 2,
+    .pre_load =3D cadence_uart_pre_load,
     .post_load =3D cadence_uart_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
@@ -532,7 +611,10 @@ static const VMStateDescription vmstate_cadence_uart=
 =3D {
         VMSTATE_UINT32(rx_wpos, CadenceUARTState),
         VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections =3D (const VMStateDescription * []) {
+        &vmstate_cadence_uart_clocks,
+    },
 };
=20
 static Property cadence_uart_properties[] =3D {
@@ -548,7 +630,7 @@ static void cadence_uart_class_init(ObjectClass *klas=
s, void *data)
     dc->vmsd =3D &vmstate_cadence_uart;
     dc->reset =3D cadence_uart_reset;
     dc->props =3D cadence_uart_properties;
-  }
+}
=20
 static const TypeInfo cadence_uart_info =3D {
     .name          =3D TYPE_CADENCE_UART,
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b64213d4dd..2ea25d1ea1 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -73,3 +73,6 @@ cmsdk_apb_uart_receive(uint8_t c) "CMSDK APB UART: got =
character 0x%x from backe
 cmsdk_apb_uart_tx_pending(void) "CMSDK APB UART: character send to backe=
nd pending"
 cmsdk_apb_uart_tx(uint8_t c) "CMSDK APB UART: character 0x%x sent to bac=
kend"
 cmsdk_apb_uart_set_params(int speed) "CMSDK APB UART: params set to %d 8=
N1"
+
+# hw/char/cadence_uart.c
+cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
--=20
2.19.0
