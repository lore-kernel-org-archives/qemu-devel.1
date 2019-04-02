Received: from eggs.gnu.org ([209.51.188.92]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDQs-0000vx-4n
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDQq-0005j5-Nt
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC0-0005Qf-L9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BD7F308A968
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 06:46:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:35 +0200
Message-Id: <20190402064639.27108-2-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
References: <20190402064639.27108-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] Revert "audio: fix pc speaker init"
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

This reverts commit bd56d378842c238c8901536c06c20a4a51ee9761.

Turned out it isn't that simple as the device needs the pit object link.
So "-device isa-pcspk" isn't going wo work anyway.  We are in freeze, so
just reverting the thing is the best way to handle this for now, trying
to come up with something better can be done in the 4.1 devel cycle.

Also add a comment noting the object link.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190328071121.21147-1-kraxel@redhat.com
---
 hw/audio/pcspk.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index fdbb4b6e9923..9c7fd74aeba7 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -57,6 +57,7 @@ typedef struct {
 } PCSpkState;
 
 static const char *s_spk = "pcspk";
+static PCSpkState *pcspk_state;
 
 static inline void generate_samples(PCSpkState *s)
 {
@@ -110,6 +111,22 @@ static void pcspk_callback(void *opaque, int free)
     }
 }
 
+static int pcspk_audio_init(ISABus *bus)
+{
+    PCSpkState *s = pcspk_state;
+    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
+
+    AUD_register_card(s_spk, &s->card);
+
+    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
+    if (!s->voice) {
+        AUD_log(s_spk, "Could not open voice\n");
+        return -1;
+    }
+
+    return 0;
+}
+
 static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
@@ -162,20 +179,12 @@ static void pcspk_initfn(Object *obj)
 
 static void pcspk_realizefn(DeviceState *dev, Error **errp)
 {
-    struct audsettings as = {PCSPK_SAMPLE_RATE, 1, AUDIO_FORMAT_U8, 0};
     ISADevice *isadev = ISA_DEVICE(dev);
     PCSpkState *s = PC_SPEAKER(dev);
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    AUD_register_card(s_spk, &s->card);
-
-    s->voice = AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callback, &as);
-    if (!s->voice) {
-        error_setg(errp, "Initializing audio voice failed");
-        AUD_remove_card(&s->card);
-        return;
-    }
+    pcspk_state = s;
 }
 
 static bool migrate_needed(void *opaque)
@@ -212,6 +221,9 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd = &vmstate_spk;
     dc->props = pcspk_properties;
+    /* Reason: realize sets global pcspk_state */
+    /* Reason: pit object link */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo pcspk_info = {
@@ -222,12 +234,6 @@ static const TypeInfo pcspk_info = {
     .class_init     = pcspk_class_initfn,
 };
 
-static int pcspk_audio_init(ISABus *bus)
-{
-    isa_create_simple(bus, TYPE_PC_SPEAKER);
-    return 0;
-}
-
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
-- 
2.18.1
