Received: from eggs.gnu.org ([209.51.188.92]:46855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vr_qemu@t-online.de>) id 1hB29W-0007sj-C1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vr_qemu@t-online.de>) id 1hB29V-0004ap-6a
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:59:26 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:58026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1hB29U-0004ZG-OF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:59:25 -0400
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de>
Date: Mon, 1 Apr 2019 20:59:20 +0200
MIME-Version: 1.0
Content-Language: en-GB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] audio: fix audio timer rate conversion bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Currently the default audio timer frequency is 10000Hz instead of
a period of 10000us. Also the audiodev timer-period property gets
converted like a frequency. Only handling of the legacy
QEMU_AUDIO_TIMER_PERIOD environment variable is correct because
it's actually a frequency.

With this patch the property timer-period is really a timer period
and QEMU_AUDIO_TIMER_PERIOD remains a frequency.

This fixes commit 71830221fb23388b32e6516c2fb7a698453a6c5a
-audiodev command line option basic implementation.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio.c        | 2 +-
 audio/audio_legacy.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 5fd9a58a80..2040762fef 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1471,7 +1471,7 @@ static int audio_init(Audiodev *dev)
     if (dev->timer_period <=3D 0) {
         s->period_ticks =3D 1;
     } else {
-        s->period_ticks =3D NANOSECONDS_PER_SECOND / dev->timer_period;
+        s->period_ticks =3D dev->timer_period * SCALE_US;
     }
=20
     e =3D qemu_add_vm_change_state_handler (audio_vm_change_state_handle=
r, s);
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 6d140119d9..2fd58cb8ef 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -26,6 +26,7 @@
 #include "audio_int.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
+#include "qemu/timer.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/visitor-impl.h"
@@ -338,8 +339,13 @@ static AudiodevListEntry *legacy_opt(const char *drv=
name)
     handle_per_direction(audio_get_pdo_in(e->dev), "QEMU_AUDIO_ADC_");
     handle_per_direction(audio_get_pdo_out(e->dev), "QEMU_AUDIO_DAC_");
=20
+    /* Original description: Timer period in HZ (0 - use lowest possible=
) */
     get_int("QEMU_AUDIO_TIMER_PERIOD",
             &e->dev->timer_period, &e->dev->has_timer_period);
+    if (e->dev->has_timer_period && e->dev->timer_period) {
+        e->dev->timer_period =3D NANOSECONDS_PER_SECOND / 1000 /
+                               e->dev->timer_period;
+    }
=20
     switch (e->dev->driver) {
     case AUDIODEV_DRIVER_ALSA:
--=20
2.16.4
