Received: from eggs.gnu.org ([2001:4830:134:3::10]:47133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJnb-00038d-Jt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJnY-0007Tl-Bm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:31 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:23:29 +0200
Message-Id: <20180627232334.14142-6-laurent@vivier.eu>
In-Reply-To: <20180627232334.14142-1-laurent@vivier.eu>
References: <20180627232334.14142-1-laurent@vivier.eu>
Subject: [Qemu-devel] [C v2 05/10] hw/m68k: Apple Sound Chip (ASC) emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

This is broken as the linux driver seems broken too...

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/audio/Makefile.objs |   1 +
 hw/audio/asc.c         | 463 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/audio/asc.h |  48 +++++
 3 files changed, 512 insertions(+)
 create mode 100644 hw/audio/asc.c
 create mode 100644 include/hw/audio/asc.h

diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 63db383709..44d1ada7b0 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -16,3 +16,4 @@ common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
 
 common-obj-y += soundhw.o
+common-obj-$(CONFIG_ASC) += asc.o
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
new file mode 100644
index 0000000000..1066bf4488
--- /dev/null
+++ b/hw/audio/asc.c
@@ -0,0 +1,463 @@
+/*
+ *  QEMU Apple Sound Chip emulation
+ *
+ *  Apple Sound Chip (ASC) 344S0063
+ *  Enhanced Apple Sound Chip (EASC) 343S1063
+ *
+ *  Copyright (c) 2012-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "audio/audio.h"
+#include "hw/audio/asc.h"
+
+/*
+ * Linux doesn't provide information about ASC, see arch/m68k/mac/macboing.c
+ * and arch/m68k/include/asm/mac_asc.h
+ *
+ * best information is coming from MAME:
+ *   http://mamedev.org/source/src/emu/sound/asc.h.html
+ *   http://mamedev.org/source/src/emu/sound/asc.c.html
+ *   Emulation by R. Belmont
+ *
+ *     0x800: VERSION
+ *     0x801: MODE
+ *            1=FIFO mode,
+ *            2=wavetable mode
+ *     0x802: CONTROL
+ *            bit 0=analog or PWM output,
+ *                1=stereo/mono,
+ *                7=processing time exceeded
+ *     0x803: FIFO MODE
+ *            bit 7=clear FIFO,
+ *            bit 1="non-ROM companding",
+ *            bit 0="ROM companding")
+ *     0x804: FIFO IRQ STATUS
+ *            bit 0=ch A 1/2 full,
+ *                1=ch A full,
+ *                2=ch B 1/2 full,
+ *                3=ch B full)
+ *     0x805: WAVETABLE CONTROL
+ *            bits 0-3 wavetables 0-3 start
+ *     0x806: VOLUME
+ *            bits 2-4 = 3 bit internal ASC volume,
+ *            bits 5-7 = volume control sent to Sony sound chip
+ *     0x807: CLOCK RATE
+ *            0 = Mac 22257 Hz,
+ *            1 = undefined,
+ *            2 = 22050 Hz,
+ *            3 = 44100 Hz
+ *     0x80a: PLAY REC A
+ *     0x80f: TEST
+ *            bits 6-7 = digital test,
+ *            bits 4-5 = analog test
+ *     0x810: WAVETABLE 0 PHASE
+ *            big-endian 9.15 fixed-point, only 24 bits valid
+ *     0x814: WAVETABLE 0 INCREMENT
+ *            big-endian 9.15 fixed-point, only 24 bits valid
+ *     0x818: WAVETABLE 1 PHASE
+ *     0x81C: WAVETABLE 1 INCREMENT
+ *     0x820: WAVETABLE 2 PHASE
+ *     0x824: WAVETABLE 2 INCREMENT
+ *     0x828: WAVETABLE 3 PHASE
+ *     0x82C: WAVETABLE 3 INCREMENT
+ */
+
+#define ASC_LENGTH   0x2000
+#define ASC_BUF_SIZE 0x0800
+
+#define ASC_REG_BASE 0x0800
+enum {
+    ASC_VERSION     = 0x00,
+    ASC_MODE        = 0x01,
+    ASC_CONTROL     = 0x02,
+    ASC_FIFOMODE    = 0x03,
+    ASC_FIFOIRQ     = 0x04,
+    ASC_WAVECTRL    = 0x05,
+    ASC_VOLUME      = 0x06,
+    ASC_CLOCK       = 0x07,
+    ASC_PLAYRECA    = 0x0a,
+    ASC_TEST        = 0x0f,
+    ASC_WAVETABLE   = 0x10
+};
+
+static inline uint32_t get_phase(ASCState *s, int channel)
+{
+    return be32_to_cpu(*(uint32_t *)(s->regs + ASC_WAVETABLE + channel * 8));
+}
+
+static inline void set_phase(ASCState *s, int channel, uint32_t phase)
+{
+    *(uint32_t *)(s->regs + ASC_WAVETABLE + channel * 8) = cpu_to_be32(phase);
+}
+
+static inline uint32_t get_incr(ASCState *s, int channel)
+{
+    return be32_to_cpu(*(uint32_t *)(s->regs + ASC_WAVETABLE + 4 +
+                                     channel * 8));
+}
+
+static inline uint32_t incr_phase(ASCState *s, int channel)
+{
+    uint32_t incr = get_incr(s, channel);
+    uint32_t phase = get_phase(s, channel);
+
+    set_phase(s, channel, phase + incr);
+
+    return get_phase(s, channel);
+}
+
+static void generate_fifo(ASCState *s, int free_b)
+{
+    int8_t buf[2048];
+    int i;
+    int to_copy;
+
+    do {
+        to_copy = audio_MIN(sizeof(buf), free_b);
+        for (i = 0; i < (to_copy >> 1); to_copy++) {
+            int8_t left, right;
+
+            left = s->fifo[s->a_rptr] ^ 0x80;
+            right = s->fifo[s->b_rptr + 0x400] ^ 0x80;
+
+            if (s->a_cnt) {
+                s->a_rptr++;
+                s->a_rptr &= 0x3ff;
+                s->a_cnt--;
+            }
+
+            if (s->b_cnt) {
+                s->b_rptr++;
+                s->b_rptr &= 0x3ff;
+                s->b_cnt--;
+            }
+
+            if (s->type == ASC_TYPE_SONORA) {
+                if (s->a_cnt < 0x200) {
+                    s->regs[ASC_FIFOIRQ] |= 4; /* FIFO A less than half full */
+                    qemu_irq_raise(s->irq);
+                }
+                if (s->b_cnt < 0x200) {
+                    s->regs[ASC_FIFOIRQ] |= 8; /* FIFO B less than half full */
+                    qemu_irq_raise(s->irq);
+                }
+            } else {
+                if (s->a_cnt == 0x1ff) {
+                    s->regs[ASC_FIFOIRQ] |= 1; /* FIFO A half empty */
+                    qemu_irq_raise(s->irq);
+                } else if (s->a_cnt == 0x001) {
+                    s->regs[ASC_FIFOIRQ] |= 2; /* FIFO A half empty */
+                    qemu_irq_raise(s->irq);
+                }
+                if (s->b_cnt == 0x1ff) {
+                    s->regs[ASC_FIFOIRQ] |= 4; /* FIFO A half empty */
+                    qemu_irq_raise(s->irq);
+                } else if (s->b_cnt == 0x001) {
+                    s->regs[ASC_FIFOIRQ] |= 8; /* FIFO A half empty */
+                    qemu_irq_raise(s->irq);
+                }
+            }
+            buf[i * 2] = left;
+            buf[i * 2 + 1] = right;
+        }
+        AUD_write(s->channel, buf, to_copy);
+        free_b -= to_copy;
+    } while (free_b);
+}
+
+static void generate_wavetable(ASCState *s, int free_b)
+{
+    int8_t buf[2048];
+    int i;
+    int channel;
+    int to_copy;
+    int control = s->regs[ASC_WAVECTRL];
+
+    do {
+        to_copy = audio_MIN(sizeof(buf), free_b);
+        for (i = 0; i < (to_copy >> 1); i++) {
+                int32_t left, right;
+                int8_t sample;
+
+                left = 0;
+                right = 0;
+
+                if (control) { /* FIXME: how to use it ? */
+                    for (channel = 0; channel < 4; channel++) {
+                        uint32_t phase = incr_phase(s, channel);
+
+                        phase = (phase >> 15) & 0x1ff;
+                        sample = s->fifo[0x200 * channel + phase] ^ 0x80;
+
+                        left += sample;
+                        right += sample;
+                    }
+                    buf[i * 2] = left >> 2;
+                    buf[i * 2 + 1] = right >> 2;
+                } else {
+                    /* FIXME: only works with linux macboing.c */
+                    uint32_t phase = incr_phase(s, 0);
+                    phase = (phase >> 15) & 0x7ff;
+                    sample = s->fifo[phase];
+                    buf[i * 2] = sample;
+                    buf[i * 2 + 1] = sample;
+                }
+        }
+        AUD_write(s->channel, buf, to_copy);
+        free_b -= to_copy;
+    } while (free_b);
+}
+
+static void asc_out_cb(void *opaque, int free_b)
+{
+    ASCState *s = opaque;
+
+    switch (s->regs[ASC_MODE] & 3) {
+    case 0: /* Off */
+        break;
+    case 1: /* FIFO mode */
+        generate_fifo(s, free_b);
+        break;
+    case 2: /* Wave table mode */
+        generate_wavetable(s, free_b);
+        break;
+    }
+}
+
+static uint64_t asc_read(void *opaque, hwaddr addr,
+                              unsigned size)
+{
+    ASCState *s = opaque;
+    uint64_t prev;
+
+    if (addr < 0x800) {
+        return s->fifo[addr];
+    }
+
+    addr -= 0x800;
+
+    if (addr >= 0x030) {
+        return 0;
+    }
+
+    switch (addr) {
+    case ASC_VERSION:
+        switch (s->type) {
+        case ASC_TYPE_ASC:
+            return 0;
+        case ASC_TYPE_V8:
+        case ASC_TYPE_EAGLE:
+        case ASC_TYPE_SPICE:
+        case ASC_TYPE_VASP:
+            return 0xe8;
+        case ASC_TYPE_SONORA:
+            return 0xbc;
+        default:
+            break;
+        }
+        break;
+    case ASC_MODE:
+        switch (s->type) {
+        case ASC_TYPE_V8:
+        case ASC_TYPE_EAGLE:
+        case ASC_TYPE_SPICE:
+        case ASC_TYPE_VASP:
+            return 1;
+        default:
+            break;
+        }
+        break;
+    case ASC_CONTROL:
+        switch (s->type) {
+        case ASC_TYPE_V8:
+        case ASC_TYPE_EAGLE:
+        case ASC_TYPE_SPICE:
+        case ASC_TYPE_VASP:
+            return 1;
+        default:
+            break;
+        }
+        break;
+    case ASC_FIFOIRQ:
+        if (s->type == ASC_TYPE_V8) {
+            prev = 3;
+        } else {
+            prev = s->regs[ASC_FIFOIRQ];
+        }
+        s->regs[ASC_FIFOIRQ] = 0;
+        qemu_irq_lower(s->irq);
+        return prev;
+    default:
+        break;
+    }
+
+    return s->regs[addr];
+}
+
+static void asc_write(void *opaque, hwaddr addr, uint64_t value,
+                           unsigned size)
+{
+    ASCState *s = opaque;
+
+    if (addr < 0x800) {
+        if (s->regs[ASC_MODE] == 1) {
+            if (addr < 0x400) {
+                /* FIFO A */
+                s->fifo[s->a_wptr++] = value;
+                s->a_cnt++;
+                if (s->a_cnt == 0x3ff) {
+                    s->regs[ASC_FIFOIRQ] |= 2; /* FIFO A Full */
+                }
+                s->a_wptr &= 0x3ff;
+            } else {
+                /* FIFO B */
+                s->fifo[s->b_wptr++ + 0x400] = value;
+                s->b_cnt++;
+                if (s->b_cnt == 0x3ff) {
+                    s->regs[ASC_FIFOIRQ] |= 8; /* FIFO B Full */
+                }
+                s->b_wptr &= 0x3ff;
+            }
+        } else {
+            s->fifo[addr] = value;
+        }
+        return;
+    }
+
+    addr -= 0x800;
+    if (addr >= 0x30) {
+        return;
+    }
+    switch (addr) {
+    case ASC_MODE:
+        value &= 3;
+        if (value != s->regs[ASC_MODE]) {
+            s->a_rptr = 0;
+            s->a_wptr = 0;
+            s->a_cnt = 0;
+            s->b_rptr = 0;
+            s->b_wptr = 0;
+            s->b_cnt = 0;
+            if (value != 0) {
+                AUD_set_active_out(s->channel, 1);
+            } else {
+                AUD_set_active_out(s->channel, 0);
+            }
+        }
+        break;
+    case ASC_FIFOMODE:
+        if (value & 0x80) {
+            s->a_rptr = 0;
+            s->a_wptr = 0;
+            s->a_cnt = 0;
+            s->b_rptr = 0;
+            s->b_wptr = 0;
+            s->b_cnt = 0;
+        }
+        break;
+    case ASC_WAVECTRL:
+        break;
+    }
+    s->regs[addr] = value;
+}
+
+static const MemoryRegionOps asc_mmio_ops = {
+    .read = asc_read,
+    .write = asc_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static int asc_post_load(void *opaque, int version_id)
+{
+    return 0;
+}
+
+static const VMStateDescription vmstate_asc = {
+    .name = "apple-sound-chip",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .post_load = asc_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void asc_reset(DeviceState *d)
+{
+    ASCState *s = ASC(d);
+
+    AUD_set_active_out(s->channel, 0);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->a_wptr = 0;
+    s->a_rptr = 0;
+    s->a_cnt = 0;
+    s->b_wptr = 0;
+    s->b_rptr = 0;
+    s->b_cnt = 0;
+}
+
+static void asc_init(Object *obj)
+{
+    ASCState *s = ASC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    struct audsettings as;
+
+    AUD_register_card("Apple Sound Chip", &s->card);
+
+    as.freq = 22257;
+    as.nchannels = 2;
+    as.fmt = AUD_FMT_S8;
+    as.endianness = 0;
+
+    s->channel = AUD_open_out(&s->card, s->channel, "asc.out",
+                              s, asc_out_cb, &as);
+
+    s->fifo = g_malloc0(ASC_BUF_SIZE);
+
+    memory_region_init_io(&s->mem_regs, NULL, &asc_mmio_ops, s, "asc",
+                          ASC_LENGTH);
+
+    sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_mmio(sbd, &s->mem_regs);
+}
+
+static Property asc_properties[] = {
+    DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void asc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->reset = asc_reset;
+    dc->vmsd = &vmstate_asc;
+    dc->props = asc_properties;
+}
+
+static TypeInfo asc_info = {
+    .name = TYPE_ASC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ASCState),
+    .instance_init = asc_init,
+    .class_init = asc_class_init,
+};
+
+static void asc_register_types(void)
+{
+    type_register_static(&asc_info);
+}
+
+type_init(asc_register_types)
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
new file mode 100644
index 0000000000..3540e32f69
--- /dev/null
+++ b/include/hw/audio/asc.h
@@ -0,0 +1,48 @@
+/*
+ *  Copyright (c) 2012-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_AUDIO_ASC_H
+#define HW_AUDIO_ASC_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "audio/audio.h"
+
+enum {
+    ASC_TYPE_ASC    = 0,  /* original discrete Apple Sound Chip */
+    ASC_TYPE_EASC   = 1,  /* discrete Enhanced Apple Sound Chip */
+    ASC_TYPE_V8     = 2,  /* ASC included in the V8 ASIC (LC/LCII) */
+    ASC_TYPE_EAGLE  = 3,  /* ASC included in the Eagle ASIC (Classic II) */
+    ASC_TYPE_SPICE  = 4,  /* ASC included in the Spice ASIC (Color Classic) */
+    ASC_TYPE_SONORA = 5,  /* ASC included in the Sonora ASIC (LCIII) */
+    ASC_TYPE_VASP   = 6,  /* ASC included in the VASP ASIC  (IIvx/IIvi) */
+    ASC_TYPE_ARDBEG = 7   /* ASC included in the Ardbeg ASIC (LC520) */
+};
+
+typedef struct ASCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mem_regs;
+    QEMUSoundCard card;
+    SWVoiceOut *channel;
+
+    qemu_irq irq;
+
+    uint8_t type;
+    int a_wptr, a_rptr, a_cnt;
+    int b_wptr, b_rptr, b_cnt;
+
+    uint8_t *fifo;
+
+    uint8_t regs[48];
+} ASCState;
+
+#define TYPE_ASC "apple-sound-chip"
+#define ASC(obj) OBJECT_CHECK(ASCState, (obj), TYPE_ASC)
+
+#endif
-- 
2.14.4
