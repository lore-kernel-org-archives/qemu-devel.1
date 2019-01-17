Received: from eggs.gnu.org ([209.51.188.92]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4CN-0005XF-T7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4CK-0006AM-2Y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:42:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk4CG-00064v-Ds
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:42:51 -0500
Date: Thu, 17 Jan 2019 10:42:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117094242.tihc3a5xgbmzpqeb@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<2770bdbdff44ea3ca88ab30378a8eddbd7e2ef52.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pfhfjrh4vuxdlcid"
Content-Disposition: inline
In-Reply-To: <2770bdbdff44ea3ca88ab30378a8eddbd7e2ef52.1547681517.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/50] audio: audiodev= parameters no
 longer optional when -audiodev present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org


--pfhfjrh4vuxdlcid
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 12:36:51AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> This means you should probably stop using -soundhw (as it doesn't allow
> you to specify any options) and add the device manually with -device.
> The exception is pcspk, it's currently not possible to manually add it.
> To use it with audiodev, use something like this:
>=20
>     -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundhw pc=
spk

Fixing that doesn't look hard ...

cheers,
  Gerd


--pfhfjrh4vuxdlcid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-audio-fix-pc-speaker-init.patch"

>From da41ae92d8da846ca363757e201993d35b74a669 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 Jan 2019 10:39:17 +0100
Subject: [PATCH] audio: fix pc speaker init

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/pcspk.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 908696d483..acd80eb674 100644
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
+        error_setg (errp, "Initializing audio voice failed");
+        AUD_remove_card (&s->card);
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
+    isa_create_simple (bus, TYPE_PC_SPEAKER);
+    return 0;
+}
+
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
-- 
2.9.3


--pfhfjrh4vuxdlcid--
