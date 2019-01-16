Received: from eggs.gnu.org ([209.51.188.92]:58003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuks-00046z-4h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukk-0002vN-96
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukj-0002nr-OY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so8967341wrp.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:42 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:50 +0100
Message-Id: <6d0d1750d8a588aee76d14b08bdef7948ed02d6c.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/50] audio: add audiodev properties to
 frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Michael Walle <michael@walle.cc>

Finally add audiodev= options to audio frontends so users can specify
which backend to use when multiple backends exist.  Not specifying an
audiodev= option currently causes the first audiodev to be used, this is
fixed in the next commit.

Example usage: -audiodev pa,id=foo -device AC97,audiodev=foo

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.h                    |  3 ++
 include/hw/qdev-properties.h     |  3 ++
 hw/audio/ac97.c                  |  1 +
 hw/audio/adlib.c                 |  1 +
 hw/audio/cs4231a.c               |  1 +
 hw/audio/es1370.c                |  7 +++-
 hw/audio/gus.c                   |  1 +
 hw/audio/hda-codec.c             |  1 +
 hw/audio/milkymist-ac97.c        |  6 ++++
 hw/audio/pcspk.c                 |  1 +
 hw/audio/pl041.c                 |  1 +
 hw/audio/sb16.c                  |  1 +
 hw/audio/wm8750.c                |  6 ++++
 hw/core/qdev-properties-system.c | 57 ++++++++++++++++++++++++++++++++
 hw/usb/dev-audio.c               |  1 +
 15 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/audio/audio.h b/audio/audio.h
index ad2457f4de..c0722a5cda 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -181,4 +181,7 @@ void audio_legacy_help(void);
 AudioState *audio_state_by_name(const char *name);
 const char *audio_get_id(QEMUSoundCard *card);
 
+#define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
+    DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
+
 #endif /* QEMU_AUDIO_H */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b6758c852e..6156409062 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,6 +34,7 @@ extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
+extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_link;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
@@ -233,6 +234,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
             + type_check(QemuUUID, typeof_field(_state, _field)),  \
         .set_default = true,                                       \
         }
+#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2265622d44..03e3da4f31 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1408,6 +1408,7 @@ static int ac97_init (PCIBus *bus)
 }
 
 static Property ac97_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0),
     DEFINE_PROP_END_OF_LIST (),
 };
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 0957780a3d..0d01cd07c5 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -298,6 +298,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
 }
 
 static Property adlib_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(AdlibState, card),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
     DEFINE_PROP_END_OF_LIST (),
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 62da75eefe..d25a120b0f 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -687,6 +687,7 @@ static int cs4231a_init (ISABus *bus)
 }
 
 static Property cs4231a_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(CSState, card),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
     DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index a5314d66fd..8c63912a82 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -886,6 +886,11 @@ static int es1370_init (PCIBus *bus)
     return 0;
 }
 
+static Property es1370_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(ES1370State, card),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void es1370_class_init (ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS (klass);
@@ -902,6 +907,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     dc->desc = "ENSONIQ AudioPCI ES1370";
     dc->vmsd = &vmstate_es1370;
     dc->reset = es1370_on_reset;
+    dc->props = es1370_properties;
 }
 
 static const TypeInfo es1370_info = {
@@ -922,4 +928,3 @@ static void es1370_register_types (void)
 }
 
 type_init (es1370_register_types)
-
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index b3e2a7fdd5..dfb74cf0d3 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -295,6 +295,7 @@ static int GUS_init (ISABus *bus)
 }
 
 static Property gus_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(GUSState, card),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
     DEFINE_PROP_UINT32 ("irq",     GUSState, emu.gusirq,  7),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c25bfa38b1..e66103aedf 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -839,6 +839,7 @@ static const VMStateDescription vmstate_hda_audio = {
 };
 
 static Property hda_audio_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
     DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 90cce1e6ed..8739cb376a 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -328,6 +328,11 @@ static const VMStateDescription vmstate_milkymist_ac97 = {
     }
 };
 
+static Property milkymist_ac97_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(MilkymistAC97State, card),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void milkymist_ac97_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -335,6 +340,7 @@ static void milkymist_ac97_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_ac97_realize;
     dc->reset = milkymist_ac97_reset;
     dc->vmsd = &vmstate_milkymist_ac97;
+    dc->props = milkymist_ac97_properties;
 }
 
 static const TypeInfo milkymist_ac97_info = {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 4a7386a689..1457cd1ac6 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -208,6 +208,7 @@ static const VMStateDescription vmstate_spk = {
 };
 
 static Property pcspk_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  -1),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index c8cc503236..fca1dc8a54 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -621,6 +621,7 @@ static const VMStateDescription vmstate_pl041 = {
 };
 
 static Property pl041_device_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
                        DEFAULT_FIFO_DEPTH),
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 65ea0cd938..5a6a880f2e 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1419,6 +1419,7 @@ static int SB16_init (ISABus *bus)
 }
 
 static Property sb16_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
     DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
     DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index d563f31e7c..0451ad87f1 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -700,6 +700,11 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
     wm8750_clk_update(s, 1);
 }
 
+static Property wm8750_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(WM8750State, card),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void wm8750_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -710,6 +715,7 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
     sc->recv = wm8750_rx;
     sc->send = wm8750_tx;
     dc->vmsd = &vmstate_wm8750;
+    dc->props = wm8750_properties;
 }
 
 static const TypeInfo wm8750_info = {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b45a7ef54b..4659b6986f 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "audio/audio.h"
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
@@ -318,6 +319,62 @@ const PropertyInfo qdev_prop_netdev = {
 };
 
 
+/* --- audiodev --- */
+static void get_audiodev(Object *obj, Visitor *v, const char* name,
+                         void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
+    char *p = g_strdup(audio_get_id(card));
+
+    visit_type_str(v, name, &p, errp);
+    g_free(p);
+}
+
+static void set_audiodev(Object *obj, Visitor *v, const char* name,
+                         void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
+    AudioState *state;
+    Error *local_err = NULL;
+    int err = 0;
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    state = audio_state_by_name(str);
+
+    if (!state) {
+        err = -ENOENT;
+        goto out;
+    }
+    card->state = state;
+
+out:
+    error_set_from_qdev_prop_error(errp, err, dev, prop, str);
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_audiodev = {
+    .name = "str",
+    .description = "ID of an audiodev to use as a backend",
+    /* release done on shutdown */
+    .get = get_audiodev,
+    .set = set_audiodev,
+};
+
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp)
 {
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index c46d5eeb79..84e737808c 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -666,6 +666,7 @@ static const VMStateDescription vmstate_usb_audio = {
 };
 
 static Property usb_audio_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
     DEFINE_PROP_UINT32("buffer", USBAudioState, buffer,
                        32 * USBAUDIO_PACKET_SIZE),
-- 
2.20.1
