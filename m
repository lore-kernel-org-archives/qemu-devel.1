Received: from eggs.gnu.org ([209.51.188.92]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDT3-0002bL-Um
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDT1-0001Md-6w
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC2-0005Su-5r
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:46 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:39 +0200
Message-Id: <20190402064639.27108-6-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
References: <20190402064639.27108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] audio: fix audio timer rate conversion bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Currently the default audio timer frequency is 10000Hz instead of
a period of 10000us. Also the audiodev timer-period property gets
converted like a frequency. Only handling of the legacy
QEMU_AUDIO_TIMER_PERIOD environment variable is correct because
it's actually a frequency.

With this patch the property timer-period is really a timer period
and QEMU_AUDIO_TIMER_PERIOD remains a frequency.

Fixes: 71830221fb "-audiodev command line option basic implementation."
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Reviewed-by: Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.hu@gmail.com>
Message-id: 90b95e4f-39ef-2b01-da6a-857ebaee1ec5@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c        | 2 +-
 audio/audio_legacy.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 5fd9a58a808f..2040762feff1 100644
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
index 6d140119d98a..2fd58cb8ef25 100644
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
2.18.1
