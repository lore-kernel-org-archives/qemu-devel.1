Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8U-0004gQ-14
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8R-0001sF-St
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faK8R-0001rg-HD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3BF30832D4
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:10:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 14:10:13 +0200
Message-Id: <20180703121013.12126-4-kraxel@redhat.com>
In-Reply-To: <20180703121013.12126-1-kraxel@redhat.com>
References: <20180703121013.12126-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] audio: add audio timer trace points
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

Track audio timer starts and stops.  Also trace delayed audio timer calls=
.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180702161524.17268-1-kraxel@redhat.com
---
 audio/audio.c      | 28 +++++++++++++++++++++++++---
 audio/trace-events |  5 +++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index d6e91901aa..1ace47f510 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
+#include "trace.h"
=20
 #define AUDIO_CAP "audio"
 #include "audio_int.h"
@@ -1129,6 +1130,10 @@ static void audio_pcm_print_info (const char *cap,=
 struct audio_pcm_info *info)
 /*
  * Timer
  */
+
+static bool audio_timer_running;
+static uint64_t audio_timer_last;
+
 static int audio_is_timer_needed (void)
 {
     HWVoiceIn *hwi =3D NULL;
@@ -1148,14 +1153,31 @@ static void audio_reset_timer (AudioState *s)
     if (audio_is_timer_needed ()) {
         timer_mod_anticipate_ns(s->ts,
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
-    }
-    else {
-        timer_del (s->ts);
+        if (!audio_timer_running) {
+            audio_timer_running =3D true;
+            audio_timer_last =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            trace_audio_timer_start(conf.period.ticks / SCALE_MS);
+        }
+    } else {
+        timer_del(s->ts);
+        if (audio_timer_running) {
+            audio_timer_running =3D false;
+            trace_audio_timer_stop();
+        }
     }
 }
=20
 static void audio_timer (void *opaque)
 {
+    int64_t now, diff;
+
+    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    diff =3D now - audio_timer_last;
+    if (diff > conf.period.ticks * 3 / 2) {
+        trace_audio_timer_delayed(diff / SCALE_MS);
+    }
+    audio_timer_last =3D now;
+
     audio_run ("timer");
     audio_reset_timer (opaque);
 }
diff --git a/audio/trace-events b/audio/trace-events
index d37639e611..c986469319 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -15,3 +15,8 @@ alsa_no_frames(int state) "No frames available and ALSA=
 state is %d"
 # audio/ossaudio.c
 oss_version(int version) "OSS version =3D 0x%x"
 oss_invalid_available_size(int size, int bufsize) "Invalid available siz=
e, size=3D%d bufsize=3D%d"
+
+# audio/audio.c
+audio_timer_start(int interval) "interval %d ms"
+audio_timer_stop(void) ""
+audio_timer_delayed(int interval) "interval %d ms"
--=20
2.9.3
