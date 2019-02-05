Received: from eggs.gnu.org ([209.51.188.92]:42755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrEM-0007aV-Nv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqr6L-0002c9-GJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:08:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Feb 2019 04:08:21 +0100
Message-Id: <1549336101-17623-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1549336101-17623-1-git-send-email-thuth@redhat.com>
References: <1549336101-17623-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] audio/sdlaudio: Simplify the sdl_callback
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>

At the end of the while-loop, either "samples" or "sdl->live" is zero, so
now that we've removed the semaphore code, the content of the while-loop
is always only executed once. Thus we can remove the while-loop now to
get rid of one indentation level here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/sdlaudio.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 53bfdbf..f7ee70b 100644
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
1.8.3.1
