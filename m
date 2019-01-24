Received: from eggs.gnu.org ([209.51.188.92]:54539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew9-0006CV-1v
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmew5-0007Yv-8M
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmew3-0007LV-3S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:49 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 14:20:14 +0100
Message-Id: <20190124132020.13571-2-kraxel@redhat.com>
In-Reply-To: <20190124132020.13571-1-kraxel@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>

Get rid of the pcspk_state global, allow pc speaker
be added using "-device isa-pcspk".

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190124110810.1040-1-kraxel@redhat.com
---
 hw/audio/pcspk.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 908696d483..b80a62ce90 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -57,7 +57,6 @@ typedef struct {
 } PCSpkState;
=20
 static const char *s_spk =3D "pcspk";
-static PCSpkState *pcspk_state;
=20
 static inline void generate_samples(PCSpkState *s)
 {
@@ -111,22 +110,6 @@ static void pcspk_callback(void *opaque, int free)
     }
 }
=20
-static int pcspk_audio_init(ISABus *bus)
-{
-    PCSpkState *s =3D pcspk_state;
-    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
-
-    AUD_register_card(s_spk, &s->card);
-
-    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callba=
ck, &as);
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
=20
 static void pcspk_realizefn(DeviceState *dev, Error **errp)
 {
+    struct audsettings as =3D {PCSPK_SAMPLE_RATE, 1, AUD_FMT_U8, 0};
     ISADevice *isadev =3D ISA_DEVICE(dev);
     PCSpkState *s =3D PC_SPEAKER(dev);
=20
     isa_register_ioport(isadev, &s->ioport, s->iobase);
=20
-    pcspk_state =3D s;
+    AUD_register_card(s_spk, &s->card);
+
+    s->voice =3D AUD_open_out(&s->card, s->voice, s_spk, s, pcspk_callba=
ck, &as);
+    if (!s->voice) {
+        error_setg(errp, "Initializing audio voice failed");
+        AUD_remove_card(&s->card);
+        return;
+    }
 }
=20
 static bool migrate_needed(void *opaque)
@@ -221,8 +212,6 @@ static void pcspk_class_initfn(ObjectClass *klass, vo=
id *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd =3D &vmstate_spk;
     dc->props =3D pcspk_properties;
-    /* Reason: realize sets global pcspk_state */
-    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pcspk_info =3D {
@@ -233,6 +222,12 @@ static const TypeInfo pcspk_info =3D {
     .class_init     =3D pcspk_class_initfn,
 };
=20
+static int pcspk_audio_init(ISABus *bus)
+{
+    isa_create_simple(bus, TYPE_PC_SPEAKER);
+    return 0;
+}
+
 static void pcspk_register(void)
 {
     type_register_static(&pcspk_info);
--=20
2.9.3
