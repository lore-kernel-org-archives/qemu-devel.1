Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1v-0001UX-Gk
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1r-0004aV-TL
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1r-0004ZS-Kt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B05468046D
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:46 +0200
Message-Id: <20170504071811.3547-6-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 05/30] adlib: Remove support for YMF262
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Notice that the code was supposed to be in the file ymf262.h, that has
never been on qemu source tree.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-2-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/adlib.c | 45 +--------------------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 7836446fc8..f9adcd709a 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -33,11 +33,7 @@
 
 #define ADLIB_KILL_TIMERS 1
 
-#ifdef HAS_YMF262
-#define ADLIB_DESC "Yamaha YMF262 (OPL3)"
-#else
 #define ADLIB_DESC "Yamaha YM3812 (OPL2)"
-#endif
 
 #ifdef DEBUG
 #include "qemu/timer.h"
@@ -50,14 +46,8 @@
 #define ldebug(...)
 #endif
 
-#ifdef HAS_YMF262
-#include "ymf262.h"
-void YMF262UpdateOneQEMU (int which, INT16 *dst, int length);
-#define SHIFT 2
-#else
 #include "fmopl.h"
 #define SHIFT 1
-#endif
 
 #define TYPE_ADLIB "adlib"
 #define ADLIB(obj) OBJECT_CHECK(AdlibState, (obj), TYPE_ADLIB)
@@ -80,9 +70,7 @@ typedef struct {
     SWVoiceOut *voice;
     int left, pos, samples;
     QEMUAudioTimeStamp ats;
-#ifndef HAS_YMF262
     FM_OPL *opl;
-#endif
     PortioList port_list;
 } AdlibState;
 
@@ -90,11 +78,7 @@ static AdlibState *glob_adlib;
 
 static void adlib_stop_opl_timer (AdlibState *s, size_t n)
 {
-#ifdef HAS_YMF262
-    YMF262TimerOver (0, n);
-#else
     OPLTimerOver (s->opl, n);
-#endif
     s->ticking[n] = 0;
 }
 
@@ -131,11 +115,7 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
 
     adlib_kill_timers (s);
 
-#ifdef HAS_YMF262
-    YMF262Write (0, a, val);
-#else
     OPLWrite (s->opl, a, val);
-#endif
 }
 
 static uint32_t adlib_read(void *opaque, uint32_t nport)
@@ -145,12 +125,8 @@ static uint32_t adlib_read(void *opaque, uint32_t nport)
     int a = nport & 3;
 
     adlib_kill_timers (s);
-
-#ifdef HAS_YMF262
-    data = YMF262Read (0, a);
-#else
     data = OPLRead (s->opl, a);
-#endif
+
     return data;
 }
 
@@ -240,11 +216,7 @@ static void adlib_callback (void *opaque, int free)
         return;
     }
 
-#ifdef HAS_YMF262
-    YMF262UpdateOneQEMU (0, s->mixbuf + s->pos * 2, samples);
-#else
     YM3812UpdateOne (s->opl, s->mixbuf + s->pos, samples);
-#endif
 
     while (samples) {
         written = write_audio (s, samples);
@@ -263,14 +235,10 @@ static void adlib_callback (void *opaque, int free)
 
 static void Adlib_fini (AdlibState *s)
 {
-#ifdef HAS_YMF262
-    YMF262Shutdown ();
-#else
     if (s->opl) {
         OPLDestroy (s->opl);
         s->opl = NULL;
     }
-#endif
 
     g_free(s->mixbuf);
 
@@ -297,16 +265,6 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     }
     glob_adlib = s;
 
-#ifdef HAS_YMF262
-    if (YMF262Init (1, 14318180, s->freq)) {
-        error_setg (errp, "YMF262Init %d failed", s->freq);
-        return;
-    }
-    else {
-        YMF262SetTimerHandler (0, timer_handler, 0);
-        s->enabled = 1;
-    }
-#else
     s->opl = OPLCreate (OPL_TYPE_YM3812, 3579545, s->freq);
     if (!s->opl) {
         error_setg (errp, "OPLCreate %d failed", s->freq);
@@ -316,7 +274,6 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
         OPLSetTimerHandler (s->opl, timer_handler, 0);
         s->enabled = 1;
     }
-#endif
 
     as.freq = s->freq;
     as.nchannels = SHIFT;
-- 
2.9.3
