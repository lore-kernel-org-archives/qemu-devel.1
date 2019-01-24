Received: from eggs.gnu.org ([209.51.188.92]:54391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmevz-00066h-4S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmevx-0007SR-91
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmevx-0007N1-1S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:20:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 14:20:19 +0100
Message-Id: <20190124132020.13571-7-kraxel@redhat.com>
In-Reply-To: <20190124132020.13571-1-kraxel@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] audio: error message tweak
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

Only print a message about the failed driver initialization in case it
was the driver explicitly requested by the user via QEMU_AUDIO_DRV=3D$drv=
.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190124112055.547-6-kraxel@redhat.com
---
 audio/audio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 1ace47f510..d163ffbc88 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1762,7 +1762,7 @@ void AUD_help (void)
         );
 }
=20
-static int audio_driver_init (AudioState *s, struct audio_driver *drv)
+static int audio_driver_init(AudioState *s, struct audio_driver *drv, bo=
ol msg)
 {
     if (drv->options) {
         audio_process_options (drv->name, drv->options);
@@ -1776,7 +1776,9 @@ static int audio_driver_init (AudioState *s, struct=
 audio_driver *drv)
         return 0;
     }
     else {
-        dolog ("Could not init `%s' audio driver\n", drv->name);
+        if (msg) {
+            dolog("Could not init `%s' audio driver\n", drv->name);
+        }
         return -1;
     }
 }
@@ -1901,7 +1903,7 @@ static void audio_init (void)
     if (drvname) {
         driver =3D audio_driver_lookup(drvname);
         if (driver) {
-            done =3D !audio_driver_init(s, driver);
+            done =3D !audio_driver_init(s, driver, true);
         } else {
             dolog ("Unknown audio driver `%s'\n", drvname);
             dolog ("Run with -audio-help to list available drivers\n");
@@ -1912,14 +1914,14 @@ static void audio_init (void)
         for (i =3D 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
             driver =3D audio_driver_lookup(audio_prio_list[i]);
             if (driver && driver->can_be_default) {
-                done =3D !audio_driver_init(s, driver);
+                done =3D !audio_driver_init(s, driver, false);
             }
         }
     }
=20
     if (!done) {
         driver =3D audio_driver_lookup("none");
-        done =3D !audio_driver_init(s, driver);
+        done =3D !audio_driver_init(s, driver, false);
         assert(done);
         dolog("warning: Using timer based audio emulation\n");
     }
--=20
2.9.3
