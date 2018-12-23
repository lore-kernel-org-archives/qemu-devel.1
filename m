Received: from eggs.gnu.org ([208.118.235.92]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAk0-0007tg-QP
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjz-0002bb-Oy
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjz-0002Ya-Gy
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id t6so10090887wrr.12
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:51 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:00 +0100
Message-Id: <a785e3cb6e5bb38503f15d11c2df0c2dcb3a6b2a.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 24/52] audio: do not run each backend in
 audio_run
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

audio_run is called manually by alsa and oss backends when polling.
In this case only the requesting backend should be run, not all of them.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c |  7 +++++--
 audio/audio.c     | 14 +++++---------
 audio/audio_int.h |  2 +-
 audio/ossaudio.c  | 12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index d4bb540cb9..ffc6220d7a 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -39,6 +39,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
+    AudioState *s;
 };
 
 typedef struct ALSAVoiceOut {
@@ -199,11 +200,11 @@ static void alsa_poll_handler (void *opaque)
         break;
 
     case SND_PCM_STATE_PREPARED:
-        audio_run ("alsa run (prepared)");
+        audio_run(hlp->s, "alsa run (prepared)");
         break;
 
     case SND_PCM_STATE_RUNNING:
-        audio_run ("alsa run (running)");
+        audio_run (hlp->s, "alsa run (running)");
         break;
 
     default:
@@ -757,6 +758,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
+    alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
     return 0;
@@ -858,6 +860,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         return -1;
     }
 
+    alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
     return 0;
diff --git a/audio/audio.c b/audio/audio.c
index a32b86a813..4779061859 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -839,7 +839,7 @@ static void audio_timer (void *opaque)
     }
     s->timer_last = now;
 
-    audio_run("timer");
+    audio_run(s, "timer");
     audio_reset_timer(s);
 }
 
@@ -1241,15 +1241,11 @@ static void audio_run_capture (AudioState *s)
     }
 }
 
-void audio_run (const char *msg)
+void audio_run(AudioState *s, const char *msg)
 {
-    AudioState *s;
-
-    QTAILQ_FOREACH(s, &audio_states, list) {
-        audio_run_out (s);
-        audio_run_in (s);
-        audio_run_capture (s);
-    }
+    audio_run_out(s);
+    audio_run_in(s);
+    audio_run_capture(s);
 
 #ifdef DEBUG_POLL
     {
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9d9db8c270..9950cea869 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -220,7 +220,7 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
-void audio_run (const char *msg);
+void audio_run(AudioState *s, const char *msg);
 
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index ae06e58d13..fde62c8ce2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -110,28 +110,28 @@ static void oss_anal_close (int *fdp)
 
 static void oss_helper_poll_out (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_out");
+    AudioState *s = opaque;
+    audio_run(s, "oss_poll_out");
 }
 
 static void oss_helper_poll_in (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_in");
+    AudioState *s = opaque;
+    audio_run(s, "oss_poll_in");
 }
 
 static void oss_poll_out (HWVoiceOut *hw)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
 
-    qemu_set_fd_handler (oss->fd, NULL, oss_helper_poll_out, NULL);
+    qemu_set_fd_handler(oss->fd, NULL, oss_helper_poll_out, hw->s);
 }
 
 static void oss_poll_in (HWVoiceIn *hw)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
 
-    qemu_set_fd_handler (oss->fd, oss_helper_poll_in, NULL, NULL);
+    qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
 
 static int oss_write (SWVoiceOut *sw, void *buf, int len)
-- 
2.20.1
