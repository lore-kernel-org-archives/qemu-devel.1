Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE97C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9872082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTtcKSX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9872082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvLy-0003QH-73
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyN-0004Gs-Px
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-0003ez-C4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyJ-0003Us-PR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so22144064wrs.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TZIl0foCHkb2oerndplBi0WwQQXiiCPRHz7GhA+SGls=;
 b=eTtcKSX/yCUhYJwp5fS/QtFyKAUIc6RlJ9hYmBXUtffT34dECEywk/H8/ynlWYWjJl
 S1JnQtOBiapbZFxxZMZKBO6P8ap95XPmJPhZazrX4fp6XNn1Yfj80NfAFPm92jdm5jVa
 +ex6cED9UaaxNIvO6Fpol6EICLUkEPW5XwHIOVpo5j1EqPNlluhSHP4fXN+LjU9ztrTv
 Sfii/CcnDniv8OhAWMinUWwCrHXmxt/zdK35Gv0iUaOzcGCFwtJ/hvbJk6R82/lZna8x
 pY8pMNWs6oC+XcPt/JQtARaEFMgJQVc5YSs16YEH9YEnTT/HBjnIBYycCVloJUiI3Wxo
 dVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TZIl0foCHkb2oerndplBi0WwQQXiiCPRHz7GhA+SGls=;
 b=n7FTZNVIXVGFZdM/CYFlblpbt/4B/Vu8HrGmRFMrofbbZGCc3qWnDF5QFKRPifMRs6
 azv5XVk0azmFwVXOv158OymxU/uDfngiXIT8GdbA1vgLeX0weM3y8LkxWZ0NaIJwzlGO
 UK2WTiZRmSKgTM+liZT/C63kXOWYLm4FJYtqFkO2p/bWhx1DzdCgZU7Ti9wphHWHjcdr
 lmTNBWdCbeSyQ5E42V9drRoXfH9jdnhzuTqpxIN/QFB+M5o4xdvv2fONG2YpB4/GrLjp
 sWr3ua4/9fc0VglKvP3j+kVCyondHd8CkxfHuU85lrNA/sGCiyL7lCvuh+sdOJmZb+vJ
 R+mg==
X-Gm-Message-State: APjAAAUx2t+WaXUohjIU4iCSr68Oi4mFogvFMvdYZ4p0ZH4wy5vvbhzn
 wVnqefjUZYnjrxC6MV3FwjRlUC93Cyk=
X-Google-Smtp-Source: APXvYqzcg25dmLuecek3yf+/whT0Qf+AZCyh1C+dy2U6T721Bq7l6wFPsZ7neBVVvsWTT7iZ87QNKw==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr26503508wrq.308.1562697355313; 
 Tue, 09 Jul 2019 11:35:55 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:54 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:43 +0200
Message-Id: <4f1ee2a0876bca759311c0efb31fbe7a6850fbad.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 03/11] audio: add audiodev properties to
 frontends
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 1eae5ab056..de0b2c8423 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -35,6 +35,7 @@ extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
+extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_link;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
@@ -236,6 +237,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
             + type_check(QemuUUID, typeof_field(_state, _field)),  \
         .set_default = true,                                       \
         }
+#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index fb98da2678..0d8e524233 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1409,6 +1409,7 @@ static int ac97_init (PCIBus *bus)
 }
 
 static Property ac97_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
     DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0),
     DEFINE_PROP_END_OF_LIST (),
 };
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 7dd9a89b89..df2e781788 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -299,6 +299,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
 }
 
 static Property adlib_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(AdlibState, card),
     DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
     DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
     DEFINE_PROP_END_OF_LIST (),
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 7216b41cc1..e3ea830b47 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -689,6 +689,7 @@ static int cs4231a_init (ISABus *bus)
 }
 
 static Property cs4231a_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(CSState, card),
     DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
     DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
     DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 260c142b70..7589671d20 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -887,6 +887,11 @@ static int es1370_init (PCIBus *bus)
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
@@ -903,6 +908,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     dc->desc = "ENSONIQ AudioPCI ES1370";
     dc->vmsd = &vmstate_es1370;
     dc->reset = es1370_on_reset;
+    dc->props = es1370_properties;
 }
 
 static const TypeInfo es1370_info = {
@@ -923,4 +929,3 @@ static void es1370_register_types (void)
 }
 
 type_init (es1370_register_types)
-
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 9ab51631d9..566864bc9e 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -297,6 +297,7 @@ static int GUS_init (ISABus *bus)
 }
 
 static Property gus_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(GUSState, card),
     DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
     DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
     DEFINE_PROP_UINT32 ("irq",     GUSState, emu.gusirq,  7),
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 84639b5424..967a10f189 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -840,6 +840,7 @@ static const VMStateDescription vmstate_hda_audio = {
 };
 
 static Property hda_audio_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
     DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bf6a5a6b96..4835229326 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -329,6 +329,11 @@ static const VMStateDescription vmstate_milkymist_ac97 = {
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
@@ -336,6 +341,7 @@ static void milkymist_ac97_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_ac97_realize;
     dc->reset = milkymist_ac97_reset;
     dc->vmsd = &vmstate_milkymist_ac97;
+    dc->props = milkymist_ac97_properties;
 }
 
 static const TypeInfo milkymist_ac97_info = {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a7b3ab0c2b..01127304c2 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -209,6 +209,7 @@ static const VMStateDescription vmstate_spk = {
 };
 
 static Property pcspk_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  -1),
     DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 59c6ce1f2e..ce430a7821 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -622,6 +622,7 @@ static const VMStateDescription vmstate_pl041 = {
 };
 
 static Property pl041_device_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
     /* Non-compact FIFO depth property */
     DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
                        DEFAULT_FIFO_DEPTH),
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index a2db06a2bb..6b604979cf 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1421,6 +1421,7 @@ static int SB16_init (ISABus *bus)
 }
 
 static Property sb16_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
     DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
     DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 81f83eea88..dfb4156ff4 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -701,6 +701,11 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
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
@@ -711,6 +716,7 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
     sc->recv = wm8750_rx;
     sc->send = wm8750_tx;
     dc->vmsd = &vmstate_wm8750;
+    dc->props = wm8750_properties;
 }
 
 static const TypeInfo wm8750_info = {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index ba412dd2ca..bf9974370c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "audio/audio.h"
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
@@ -353,6 +354,62 @@ const PropertyInfo qdev_prop_netdev = {
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
index 718ab53cbb..1b1cf91132 100644
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
2.22.0


