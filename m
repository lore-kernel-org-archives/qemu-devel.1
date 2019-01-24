Received: from eggs.gnu.org ([209.51.188.92]:48895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcsG-00042A-Fa
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcsF-0004xL-E0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:08:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmcsF-0004De-6H
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:08:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 081E3432BA
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 11:08:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 12:08:10 +0100
Message-Id: <20190124110810.1040-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Get rid of the pcspk_state global, allow pc speaker
be added using "-device isa-pcspk".

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/pcspk.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 908696d483..b80a62ce90 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -57,7 +57,6 @@ typedef struct {
 } PCSpkState;
 
 static const char *s_spk = "pcspk";
-static PCSpkState *pcspk_state;
 
 static inline void generate_samples(PCSpkState *s)
 {
@@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int free)
     }
 }
 
-static int pcspk_audio_init(ISABus *bus)
-{
-    PCSpkState *s = pcspk_state;
-    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
-
-    AUD_register_card(s_spk, &s->card);
-
-    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
-    if (!s->voice) {
-        AUD_log(s_spk, "Could not open voice\n");
-        return -1;
-    }
-
-    return 0;
-}
-
 static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
@@ -179,12 +162,20 @@ static void pcspk_initfn(Object *obj)
 
 static void pcspk_realizefn(DeviceState *dev, Error **errp)
 {
+    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
     ISADevice *isadev = ISA_DEVICE(dev);
     PCSpkState *s = PC_SPEAKER(dev);
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    pcspk_state = s;
+    AUD_register_card(s_spk, &s->card);
+
+    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
+    if (!s->voice) {
+        error_setg(errp, "Initializing audio voice failed");
+        AUD_remove_card(&s->card);
+        return;
+    }
 }
 
 static bool migrate_needed(void *opaque)
@@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd = &vmstate_spk;
     dc->props = pcspk_properties;
-    /* Reason: realize sets global pcspk_state */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo pcspk_info = {
@@ -233,6 +222,12 @@ static const TypeInfo pcspk_info = {
     .class_init     = pcspk_class_initfn,
 };
 
+static int pcspk_audio_init(ISABus *bus)
+{
+    isa_create_simple(bus, TYPE_PC_SPEAKER);
+    return 0;
+}
+
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
-- 
2.9.3
