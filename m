Received: from eggs.gnu.org ([2001:4830:134:3::10]:38655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKM-000258-Ks
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKK-0003Gt-SC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:26 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33210)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fmcKK-0003GI-Fw
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:01:24 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon,  6 Aug 2018 12:01:14 +0200
Message-Id: <20180806100114.21410-8-contrib@steffen-goertz.de>
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] hw/display/led_matrix: Add LED matrix
 display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

The LEDs are not individually connected to the output
pins of the microcontroller. Instead, the LEDs share pins
for rows and columns.
The pattern for a row or a column is only displayed for a short moment.
The slowness of the human eye results in a complete and
flicker-free image (persistence of vision). More information
can be found here: https://en.wikipedia.org/wiki/Multiplexed_display .

This device demultiplexes the dot-matrix pattern to a grayscale
image as it would be perceived by the human eye.
The number of rows, columns and the refresh period can be configured.

At the moment it is assumed that the LEDs are connected in forward
direction from rows to columns.

The demultiplexed LEDs are drawn to the canvas of a graphics console.
In the future it is planed to send QMP events with the updated
matrix image.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/display/Makefile.objs        |   2 +
 hw/display/led_matrix.c         | 262 ++++++++++++++++++++++++++++++++
 include/hw/display/led_matrix.h |  38 +++++
 3 files changed, 302 insertions(+)
 create mode 100644 hw/display/led_matrix.c
 create mode 100644 include/hw/display/led_matrix.h

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index fb8408c6d0..c423f1eb1a 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -23,6 +23,8 @@ common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
=20
+common-obj-$(CONFIG_NRF51_SOC) +=3D led_matrix.o
+
 common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
 milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
 milkymist-tmu2.o-libs :=3D $(X11_LIBS)
diff --git a/hw/display/led_matrix.c b/hw/display/led_matrix.c
new file mode 100644
index 0000000000..34c3ad9bde
--- /dev/null
+++ b/hw/display/led_matrix.c
@@ -0,0 +1,262 @@
+/*
+ * LED Matrix Demultiplexer
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "ui/console.h"
+#include "hw/display/led_matrix.h"
+#include "ui/pixel_ops.h"
+
+static bool led_was_on(LEDMatrixState *s, size_t x, size_t y)
+{
+    /* TODO implying Direction is ROW |-> COL */
+    /* TODO add direction flag and generalize */
+    bool row_level =3D extract64(s->row, x, 1);
+    bool col_level =3D extract64(s->col, y, 1);
+
+    return row_level && !col_level;
+}
+
+static void update_on_times(LEDMatrixState *s)
+{
+    size_t x;
+    int64_t now =3D qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    int64_t diff =3D now - s->timestamp;
+    s->timestamp =3D now;
+
+    for (x =3D 0; x < s->nrows ; x++) {
+        for (size_t y =3D 0; y < s->ncols; y++) {
+            if (led_was_on(s, x, y)) {
+                s->led_working_dc[x * s->ncols + y] +=3D diff;
+            }
+        }
+    }
+}
+
+static void led_timer_expire(void *opaque)
+{
+    LEDMatrixState *s =3D LED_MATRIX(opaque);
+/*
+    uint8_t divider =3D s->strobe_row ? s->nrows : s->ncols;
+    int64_t max_on =3D (s->refresh_period * 1000) / divider;
+*/
+
+    update_on_times(s);
+
+    memcpy(s->led_frame_dc, s->led_working_dc,
+           sizeof(int64_t) * s->nrows * s->ncols);
+    memset(s->led_working_dc, 0x00, sizeof(int64_t) * s->nrows * s->ncol=
s);
+
+    timer_mod(&s->timer,
+            qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->refresh_period);
+    s->redraw =3D true;
+}
+
+static void set_row(void *opaque, int line, int value)
+{
+    LEDMatrixState *s =3D LED_MATRIX(opaque);
+
+    update_on_times(s);
+
+    s->row =3D deposit32(s->row, line, 1, value > 0);
+}
+
+static void set_column(void *opaque, int line, int value)
+{
+    LEDMatrixState *s =3D LED_MATRIX(opaque);
+
+    update_on_times(s);
+
+    s->col =3D deposit32(s->col, line, 1, value > 0);
+}
+
+static void draw_pixel(DisplaySurface *ds, int x, int y, uint32_t color)
+{
+    int bpp;
+    uint8_t *d;
+    bpp =3D (surface_bits_per_pixel(ds) + 7) >> 3;
+    d =3D surface_data(ds) + surface_stride(ds) * y + bpp * x;
+    switch (bpp) {
+    case 1:
+        *((uint8_t *) d) =3D color;
+        d++;
+        break;
+    case 2:
+        *((uint16_t *) d) =3D color;
+        d +=3D 2;
+        break;
+    case 4:
+        *((uint32_t *) d) =3D color;
+        d +=3D 4;
+        break;
+    }
+}
+
+static void draw_box(DisplaySurface *ds,
+                     int x0, int y0, int w, int h, uint32_t color)
+{
+    int x, y;
+    for (x =3D 0; x < w; x++) {
+        for (y =3D 0; y < h; y++) {
+            draw_pixel(ds, x0 + x, y0 + y, color);
+        }
+    }
+}
+
+typedef unsigned int (*color_func)(unsigned int, unsigned int, unsigned =
int);
+
+static void led_invalidate_display(void *opaque)
+{
+    LEDMatrixState *s =3D LED_MATRIX(opaque);
+    s->redraw =3D true;
+}
+
+static void led_update_display(void *opaque)
+{
+    LEDMatrixState *s =3D LED_MATRIX(opaque);
+    DisplaySurface *surface =3D qemu_console_surface(s->con);
+    color_func colorfunc;
+    uint32_t color_led;
+    int bpp;
+    uint8_t *d1;
+    uint8_t red;
+    size_t x, y, idx;
+
+    if (!s->redraw) {
+        return;
+    }
+
+    /* clear screen */
+    bpp =3D (surface_bits_per_pixel(surface) + 7) >> 3;
+    d1 =3D surface_data(surface);
+    for (y =3D 0; y < surface_height(surface); y++) {
+        memset(d1, 0x00, surface_width(surface) * bpp);
+        d1 +=3D surface_stride(surface);
+    }
+
+    /* set colors according to bpp */
+    switch (surface_bits_per_pixel(surface)) {
+    case 8:
+        colorfunc =3D rgb_to_pixel8;
+        break;
+    case 15:
+        colorfunc =3D rgb_to_pixel15;
+        break;
+    case 16:
+        colorfunc =3D rgb_to_pixel16;
+        break;
+    case 24:
+        colorfunc =3D rgb_to_pixel24;
+        break;
+    case 32:
+        colorfunc =3D rgb_to_pixel32;
+        break;
+    default:
+        return;
+    }
+
+    for (x =3D 0; x < s->nrows ; x++) {
+        for (y =3D 0; y < s->ncols; y++) {
+            idx =3D x * s->ncols + y;
+            red =3D (s->led_frame_dc[idx] * 0xFF) / (s->refresh_period *=
 1000);
+            color_led =3D colorfunc(red, 0x00, 0x00);
+
+            draw_box(surface, idx * 10, 0, 5, 10, color_led);
+        }
+    }
+
+    s->redraw =3D 0;
+    dpy_gfx_update(s->con, 0, 0, 500, 500);
+}
+
+static const GraphicHwOps graphic_ops =3D {
+    .invalidate  =3D led_invalidate_display,
+    .gfx_update  =3D led_update_display,
+};
+
+static void led_matrix_init(Object *obj)
+{
+    LEDMatrixState *s =3D LED_MATRIX(obj);
+
+    timer_init_ms(&s->timer, QEMU_CLOCK_VIRTUAL, led_timer_expire, s);
+}
+
+static void led_matrix_realize(DeviceState *dev, Error **errp)
+{
+    LEDMatrixState *s =3D LED_MATRIX(dev);
+    if (!s->nrows || (s->nrows > 64)) {
+        error_setg(errp, "rows not set or larger than 64");
+        return;
+    }
+
+    if (!s->ncols || (s->ncols > 64)) {
+        error_setg(errp, "cols not set or larger than 64");
+        return;
+    }
+
+    s->led_working_dc =3D g_malloc0_n(s->ncols * s->nrows, sizeof(int64_=
t));
+    s->led_frame_dc =3D g_malloc0_n(s->ncols * s->nrows, sizeof(int64_t)=
);
+
+    qdev_init_gpio_in_named(dev, set_row, "row", s->nrows);
+    qdev_init_gpio_in_named(dev, set_column, "col", s->ncols);
+
+    s->con =3D graphic_console_init(NULL, 0, &graphic_ops, s);
+    qemu_console_resize(s->con, 500, 500);
+}
+
+static void led_matrix_reset(DeviceState *dev)
+{
+    LEDMatrixState *s =3D LED_MATRIX(dev);
+
+    timer_mod(&s->timer,
+            qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->refresh_period);
+}
+
+static void led_matrix_unrealize(DeviceState *dev, Error **errp)
+{
+    LEDMatrixState *s =3D LED_MATRIX(dev);
+
+    g_free(s->led_working_dc);
+    s->led_working_dc =3D NULL;
+}
+
+static Property led_matrix_properties[] =3D {
+    DEFINE_PROP_UINT32("refresh_period", LEDMatrixState, refresh_period,=
 500),
+    DEFINE_PROP_UINT8("rows", LEDMatrixState, nrows, 0),
+    DEFINE_PROP_UINT8("cols", LEDMatrixState, ncols, 0),
+    DEFINE_PROP_BOOL("strobe_row", LEDMatrixState, strobe_row, true),
+    /* TODO Save/restore state of led_state matrix */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void led_matrix_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D led_matrix_properties;
+    dc->realize =3D led_matrix_realize;
+    dc->reset =3D led_matrix_reset;
+    dc->unrealize =3D led_matrix_unrealize;
+}
+
+static const TypeInfo led_matrix_info =3D {
+    .name =3D TYPE_LED_MATRIX,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(LEDMatrixState),
+    .instance_init =3D led_matrix_init,
+    .class_init =3D led_matrix_class_init
+};
+
+static void led_matrix_register_types(void)
+{
+    type_register_static(&led_matrix_info);
+}
+
+type_init(led_matrix_register_types)
diff --git a/include/hw/display/led_matrix.h b/include/hw/display/led_mat=
rix.h
new file mode 100644
index 0000000000..4a43b69f5b
--- /dev/null
+++ b/include/hw/display/led_matrix.h
@@ -0,0 +1,38 @@
+/*
+ * LED Matrix Demultiplexer
+ *
+ * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef LED_MATRIX_H
+#define LED_MATRIX_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#define TYPE_LED_MATRIX "led_matrix"
+#define LED_MATRIX(obj) OBJECT_CHECK(LEDMatrixState, (obj), TYPE_LED_MAT=
RIX)
+
+typedef struct LEDMatrixState {
+    SysBusDevice parent_obj;
+
+    QemuConsole *con;
+    bool redraw;
+
+    uint32_t refresh_period; /* refresh period in ms */
+    uint8_t nrows;
+    uint8_t ncols;
+    bool strobe_row;
+
+    QEMUTimer timer;
+    int64_t timestamp;
+
+    uint64_t row;
+    uint64_t col;
+    int64_t *led_working_dc; /* Current LED duty cycle acquisition */
+    int64_t *led_frame_dc; /* Last complete LED duty cycle acquisition *=
/
+} LEDMatrixState;
+
+
+#endif
--=20
2.18.0
