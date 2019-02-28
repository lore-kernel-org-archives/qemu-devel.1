Received: from eggs.gnu.org ([209.51.188.92]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcm-00031S-L5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIck-0000wa-Pr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIck-0000u9-DR
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F2279D1F8
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:58 +0100
Message-Id: <20190228100858.28397-6-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
References: <20190228100858.28397-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] audio/sdlaudio: Simplify the sdl_callback
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

At the end of the while-loop, either "samples" or "sdl->live" is zero, so
now that we've removed the semaphore code, the content of the while-loop
is always only executed once. Thus we can remove the while-loop now to
get rid of one indentation level here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1549336101-17623-3-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/sdlaudio.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 53bfdbf72439..f7ee70b15347 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -189,37 +189,30 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     SDLAudioState *s = &glob_sdl;
     HWVoiceOut *hw = &sdl->hw;
     int samples = len >> hw->info.shift;
+    int to_mix, decr;
 
-    if (s->exit) {
+    if (s->exit || !sdl->live) {
         return;
     }
 
-    while (samples) {
-        int to_mix, decr;
-
-        /* dolog ("in callback samples=%d\n", samples); */
-
-        if (s->exit || !sdl->live) {
-            break;
-        }
-
-        /* dolog ("in callback live=%d\n", live); */
-        to_mix = audio_MIN (samples, sdl->live);
-        decr = to_mix;
-        while (to_mix) {
-            int chunk = audio_MIN (to_mix, hw->samples - hw->rpos);
-            struct st_sample *src = hw->mix_buf + hw->rpos;
-
-            /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
-            hw->clip (buf, src, chunk);
-            hw->rpos = (hw->rpos + chunk) % hw->samples;
-            to_mix -= chunk;
-            buf += chunk << hw->info.shift;
-        }
-        samples -= decr;
-        sdl->live -= decr;
-        sdl->decr += decr;
+    /* dolog ("in callback samples=%d live=%d\n", samples, sdl->live); */
+
+    to_mix = audio_MIN(samples, sdl->live);
+    decr = to_mix;
+    while (to_mix) {
+        int chunk = audio_MIN(to_mix, hw->samples - hw->rpos);
+        struct st_sample *src = hw->mix_buf + hw->rpos;
+
+        /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
+        hw->clip(buf, src, chunk);
+        hw->rpos = (hw->rpos + chunk) % hw->samples;
+        to_mix -= chunk;
+        buf += chunk << hw->info.shift;
     }
+    samples -= decr;
+    sdl->live -= decr;
+    sdl->decr += decr;
+
     /* dolog ("done len=%d\n", len); */
 
     /* SDL2 does not clear the remaining buffer for us, so do it on our own */
-- 
2.9.3
