Received: from eggs.gnu.org ([2001:4830:134:3::10]:52216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1enQ8r-0004qN-FQ
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 09:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1enQ8m-00080I-Ap
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 09:40:37 -0500
Received: from bart.luffy.cx ([78.47.78.131]:41145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bernat@luffy.cx>) id 1enQ8l-0007zc-MG
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 09:40:32 -0500
From: Vincent Bernat <vincent@bernat.im>
Date: Sun, 18 Feb 2018 15:40:21 +0100
Message-Id: <20180218144021.11641-1-vincent@bernat.im>
Subject: [Qemu-devel] [RFC, PATCH,
 v1] hw/audio/opl2lpt: add support for OPL2LPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Vincent Bernat <vincent@bernat.im>

OPL2LPT is an OPL2 chip on the parallel port. It can be programmed
mostly like an OPL2 chip, except it is write-only. Timers are
therefore not usable and we emulate a simplified version of them: they
expire immediately (in the future, this could be updated to properly
emulate them). Timers are usually only used to detect the card.

The driver needs a parallel port to be usable:

    -chardev parport,id=parport0,path=/dev/parport0
    -device opl2lpt,chardev=parport0

>From a timing perspective, usleep() is used to ensure to give enough
time to OPL2 to react properly. Ideally, the timing should be handled
by the game, but testing with Indy3, this didn't work. I have also
tried to be smarter by sleeping less depending on the current clock
but a few glitches were still present. With the current approach,
Indy3 is able to use the sound card without a glitch. The DOS driver
doesn't add delays (but it doesn't work on QEMU either due to similar
issues, so it may be a clue).

On shutdown, the OPL2 chip should be reset to not continue sustaining
a note. I was unable to find the appropriate function to
register (unrealize callback is not called on shutdown and
qemu_register() isn't always called on shutdown either). The user has
to reset the VM, then stop it if they don't want to reset the OPL2LPT
manually.

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 default-configs/sound.mak |   1 +
 hw/audio/Makefile.objs    |   1 +
 hw/audio/opl2lpt.c        | 211 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/audio/soundhw.c        |   2 +-
 4 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 hw/audio/opl2lpt.c

diff --git a/default-configs/sound.mak b/default-configs/sound.mak
index 4f22c34b5dac..d18725a1ea30 100644
--- a/default-configs/sound.mak
+++ b/default-configs/sound.mak
@@ -1,4 +1,5 @@
 CONFIG_SB16=y
 CONFIG_ADLIB=y
+CONFIG_OPL2LPT=y
 CONFIG_GUS=y
 CONFIG_CS4231A=y
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 63db383709a1..274d5faa504a 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -3,6 +3,7 @@ common-obj-$(CONFIG_SB16) += sb16.o
 common-obj-$(CONFIG_ES1370) += es1370.o
 common-obj-$(CONFIG_AC97) += ac97.o
 common-obj-$(CONFIG_ADLIB) += fmopl.o adlib.o
+common-obj-$(CONFIG_OPL2LPT) += opl2lpt.o
 common-obj-$(CONFIG_GUS) += gus.o gusemu_hal.o gusemu_mixer.o
 common-obj-$(CONFIG_CS4231A) += cs4231a.o
 common-obj-$(CONFIG_HDA) += intel-hda.o hda-codec.o
diff --git a/hw/audio/opl2lpt.c b/hw/audio/opl2lpt.c
new file mode 100644
index 000000000000..53286504c8cd
--- /dev/null
+++ b/hw/audio/opl2lpt.c
@@ -0,0 +1,211 @@
+/*
+ * QEMU Proxy for OPL2LPT
+ *
+ * Copyright (c) 2018 Vincent Bernat
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* TODO: emulate timers */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/audio/soundhw.h"
+#include "audio/audio.h"
+#include "hw/isa/isa.h"
+#include "chardev/char-parallel.h"
+#include "chardev/char-fe.h"
+
+#define DEBUG
+
+#define OPL2LPT_DESC "OPL2LPT (Yamaha YM3812 over parallel port)"
+
+#define dolog(...) AUD_log("opl2lpt", __VA_ARGS__)
+#ifdef DEBUG
+#define ldebug(...) dolog(__VA_ARGS__)
+#else
+#define ldebug(...)
+#endif
+
+#define TYPE_OPL2LPT "opl2lpt"
+#define OPL2LPT(obj) OBJECT_CHECK(Opl2lptState, (obj), TYPE_OPL2LPT)
+
+#define PP_NOT_STROBE  0x1
+#define PP_NOT_AUTOFD  0x2
+#define PP_INIT        0x4
+#define PP_NOT_SELECT  0x8
+
+typedef struct {
+    ISADevice parent_obj;
+
+    uint8_t address;
+    uint8_t timer_reg;
+    int64_t last_clock;
+    PortioList port_list;
+    CharBackend chr;
+} Opl2lptState;
+
+static void opl2lpt_lpt_write(Opl2lptState *s, uint8_t d, uint8_t c)
+{
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_WRITE_DATA, &d);
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_WRITE_CONTROL, &c);
+    c ^= PP_INIT;
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_WRITE_CONTROL, &c);
+    c ^= PP_INIT;
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_WRITE_CONTROL, &c);
+}
+
+static void opl2lpt_write(void *opaque, uint32_t nport, uint32_t val)
+{
+    Opl2lptState *s = opaque;
+    int a = nport & 1;
+    uint8_t v = val & 0xff;
+    uint8_t c = 0;
+#ifdef DEBUG
+    int64_t last_clock = get_clock();
+    uint64_t diff = last_clock - s->last_clock;
+    s->last_clock = last_clock;
+#endif
+
+    switch (a) {
+    case 0:
+        /* address port */
+        ldebug("[%10" PRIu64 "]: write 0x%" PRIx32 " (address) = %" PRIx8 "\n",
+               diff/1000, nport, v);
+        s->address = v;
+        c = PP_INIT | PP_NOT_SELECT | PP_NOT_STROBE;
+        opl2lpt_lpt_write(s, v, c);
+        usleep(3);
+        break;
+    case 1:
+        /* data port */
+        if (s->address == 4) {
+            /* Timer Control Byte register */
+            s->timer_reg = v;
+        }
+        ldebug("[%10" PRIu64 "]: write 0x%" PRIx32 " (data) = %d\n",
+               diff/1000, nport, v);
+        c = PP_INIT | PP_NOT_SELECT;
+        opl2lpt_lpt_write(s, v, c);
+        usleep(23);
+        break;
+    default:
+        assert(0);
+    }
+}
+
+static uint32_t opl2lpt_read(void *opaque, uint32_t nport)
+{
+    Opl2lptState *s = opaque;
+    int a = nport & 1;
+    uint8_t v = 0;
+
+    switch (a) {
+    case 0:
+        /* address port: only emulate timers. They expire
+         * instantaneously: they are generally not used for anything
+         * else than a detection feature. */
+        if ((s->timer_reg & 0xC1) == 1) {
+            v |= 0xC0;
+        }
+        if ((s->timer_reg & 0xA2) == 2) {
+            v |= 0xA0;
+        }
+        v |= 0x06;              /* Value stolen from opl2lpt DOS driver */
+
+        ldebug("read 0x%" PRIx32 " (address) = 0x%" PRIx8 "\n", nport, v);
+        break;
+    case 1:
+        /* data port: write-only */
+        ldebug("read 0x%" PRIx32 " (data) = 0\n", nport);
+        break;
+    }
+    return v;
+}
+
+static MemoryRegionPortio opl2lpt_portio_list[] = {
+    { 0x388, 2, 1, .read = opl2lpt_read, .write = opl2lpt_write, },
+    PORTIO_END_OF_LIST(),
+};
+
+static void opl2lpt_reset(DeviceState *dev)
+{
+    Opl2lptState *s = OPL2LPT(dev);
+
+    ldebug("reset OPL2 chip\n");
+    for (int i = 0; i < 256; i ++) {
+        opl2lpt_lpt_write(s, i, PP_INIT | PP_NOT_STROBE | PP_NOT_SELECT);
+        usleep(4);
+        opl2lpt_lpt_write(s, 0, PP_INIT | PP_NOT_SELECT);
+        usleep(23);
+    }
+
+    s->last_clock = get_clock();
+}
+
+static void opl2lpt_realize(DeviceState *dev, Error **errp)
+{
+    Opl2lptState *s = OPL2LPT(dev);
+
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        error_setg(errp, "Can't create OPL2LPT device, empty char device");
+        return;
+    }
+
+    portio_list_init(&s->port_list, OBJECT(s), opl2lpt_portio_list, s, "opl2lpt");
+    portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj), 0);
+}
+
+static Property opl2lpt_properties[] = {
+    DEFINE_PROP_CHR("chardev", Opl2lptState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void opl2lpt_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = opl2lpt_realize;
+    dc->reset = opl2lpt_reset;
+    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
+    dc->desc = OPL2LPT_DESC;
+    dc->props = opl2lpt_properties;
+}
+
+static const TypeInfo opl2lpt_info = {
+    .name          = TYPE_OPL2LPT,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(Opl2lptState),
+    .class_init    = opl2lpt_class_initfn,
+};
+
+static int Opl2lpt_init(ISABus *bus)
+{
+    isa_create_simple(bus, TYPE_OPL2LPT);
+    return 0;
+}
+
+static void opl2lpt_register_types(void)
+{
+    type_register_static(&opl2lpt_info);
+    isa_register_soundhw("opl2lpt", OPL2LPT_DESC, Opl2lpt_init);
+}
+
+type_init(opl2lpt_register_types)
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index e698909d348b..1e318c869c52 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -41,7 +41,7 @@ struct soundhw {
     } init;
 };
 
-static struct soundhw soundhw[9];
+static struct soundhw soundhw[10];
 static int soundhw_count;
 
 void isa_register_soundhw(const char *name, const char *descr,
-- 
2.16.1
