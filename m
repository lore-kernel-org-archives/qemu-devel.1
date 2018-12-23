Received: from eggs.gnu.org ([208.118.235.92]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjp-0007Rw-K1
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjo-0001sq-45
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjn-0001pa-RC
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so10134020wrw.1
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:39 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:45 +0100
Message-Id: <b3b22b76ca66afa4fd6e9383ebec29cee8169a78.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/52] dsoundaudio: port to -audiodev config
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio_legacy.c    | 12 +++++++++
 audio/dsound_template.h |  6 ++---
 audio/dsoundaudio.c     | 59 ++++++++++++-----------------------------
 3 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 42b55035e3..48a22c390a 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -71,6 +71,16 @@ SimpleEnvMap coreaudio_map[] = {
     { /* End of list */ }
 };
 
+SimpleEnvMap dsound_map[] = {
+    { "QEMU_DSOUND_LATENCY_MILLIS", "latency", ENV_TRANSFORM_MILLIS_TO_USECS },
+    { "QEMU_DSOUND_BUFSIZE_OUT", "out.buffer-len",
+      ENV_TRANSFORM_BYTES_TO_USECS_OUT },
+    { "QEMU_DSOUND_BUFSIZE_IN", "in.buffer-len",
+      ENV_TRANSFORM_BYTES_TO_USECS_IN },
+
+    { /* End of list */ }
+};
+
 static unsigned long long toull(const char *str)
 {
     unsigned long long ret;
@@ -243,6 +253,8 @@ static void legacy_opt(const char *drv)
         handle_alsa(opts);
     } else if (strcmp(drv, "coreaudio") == 0) {
         handle_env_opts(opts, coreaudio_map);
+    } else if (strcmp(drv, "dsound") == 0) {
+        handle_env_opts(opts, dsound_map);
     }
 }
 
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index b439f33f58..96181efb36 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -167,17 +167,18 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     dsound *s = drv_opaque;
     WAVEFORMATEX wfx;
     struct audsettings obt_as;
-    DSoundConf *conf = &s->conf;
 #ifdef DSBTYPE_IN
     const char *typ = "ADC";
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     DSCBUFFERDESC bd;
     DSCBCAPS bc;
+    AudiodevPerDirectionOptions *pdo = s->dev->in;
 #else
     const char *typ = "DAC";
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     DSBUFFERDESC bd;
     DSBCAPS bc;
+    AudiodevPerDirectionOptions *pdo = s->dev->out;
 #endif
 
     if (!s->FIELD2) {
@@ -193,8 +194,8 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     memset (&bd, 0, sizeof (bd));
     bd.dwSize = sizeof (bd);
     bd.lpwfxFormat = &wfx;
+    bd.dwBufferBytes = audio_buffer_bytes(pdo, as, 92880);
 #ifdef DSBTYPE_IN
-    bd.dwBufferBytes = conf->bufsize_in;
     hr = IDirectSoundCapture_CreateCaptureBuffer (
         s->dsound_capture,
         &bd,
@@ -203,7 +204,6 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
         );
 #else
     bd.dwFlags = DSBCAPS_STICKYFOCUS | DSBCAPS_GETCURRENTPOSITION2;
-    bd.dwBufferBytes = conf->bufsize_out;
     hr = IDirectSound_CreateSoundBuffer (
         s->dsound,
         &bd,
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 02fe777cba..a7d04b5033 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -32,6 +32,7 @@
 
 #define AUDIO_CAP "dsound"
 #include "audio_int.h"
+#include "qemu/host-utils.h"
 
 #include <windows.h>
 #include <mmsystem.h>
@@ -42,17 +43,11 @@
 
 /* #define DEBUG_DSOUND */
 
-typedef struct {
-    int bufsize_in;
-    int bufsize_out;
-    int latency_millis;
-} DSoundConf;
-
 typedef struct {
     LPDIRECTSOUND dsound;
     LPDIRECTSOUNDCAPTURE dsound_capture;
     struct audsettings settings;
-    DSoundConf conf;
+    Audiodev *dev;
 } dsound;
 
 typedef struct {
@@ -248,9 +243,9 @@ static void GCC_FMT_ATTR (3, 4) dsound_logerr2 (
     dsound_log_hresult (hr);
 }
 
-static DWORD millis_to_bytes (struct audio_pcm_info *info, DWORD millis)
+static uint64_t usecs_to_bytes(struct audio_pcm_info *info, uint32_t usecs)
 {
-    return (millis * info->bytes_per_second) / 1000;
+    return muldiv64(usecs, info->bytes_per_second, 1000000);
 }
 
 #ifdef DEBUG_DSOUND
@@ -478,7 +473,7 @@ static int dsound_run_out (HWVoiceOut *hw, int live)
     LPVOID p1, p2;
     int bufsize;
     dsound *s = ds->s;
-    DSoundConf *conf = &s->conf;
+    AudiodevDsoundOptions *dso = &s->dev->u.dsound;
 
     if (!dsb) {
         dolog ("Attempt to run empty with playback buffer\n");
@@ -501,14 +496,14 @@ static int dsound_run_out (HWVoiceOut *hw, int live)
     len = live << hwshift;
 
     if (ds->first_time) {
-        if (conf->latency_millis) {
+        if (dso->latency) {
             DWORD cur_blat;
 
             cur_blat = audio_ring_dist (wpos, ppos, bufsize);
             ds->first_time = 0;
             old_pos = wpos;
             old_pos +=
-                millis_to_bytes (&hw->info, conf->latency_millis) - cur_blat;
+                usecs_to_bytes(&hw->info, dso->latency) - cur_blat;
             old_pos %= bufsize;
             old_pos &= ~hw->info.align;
         }
@@ -747,12 +742,6 @@ static int dsound_run_in (HWVoiceIn *hw)
     return decr;
 }
 
-static DSoundConf glob_conf = {
-    .bufsize_in         = 16384,
-    .bufsize_out        = 16384,
-    .latency_millis     = 10
-};
-
 static void dsound_audio_fini (void *opaque)
 {
     HRESULT hr;
@@ -788,8 +777,17 @@ static void *dsound_audio_init(Audiodev *dev)
     int err;
     HRESULT hr;
     dsound *s = g_malloc0(sizeof(dsound));
+    AudiodevDsoundOptions *dso;
+
+    assert(dev->driver == AUDIODEV_DRIVER_DSOUND);
+    s->dev = dev;
+    dso = &dev->u.dsound;
+
+    if (!dso->has_latency) {
+        dso->has_latency = true;
+        dso->latency = 10000; /* 10 ms */
+    }
 
-    s->conf = glob_conf;
     hr = CoInitialize (NULL);
     if (FAILED (hr)) {
         dsound_logerr (hr, "Could not initialize COM\n");
@@ -854,28 +852,6 @@ static void *dsound_audio_init(Audiodev *dev)
     return s;
 }
 
-static struct audio_option dsound_options[] = {
-    {
-        .name  = "LATENCY_MILLIS",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.latency_millis,
-        .descr = "(undocumented)"
-    },
-    {
-        .name  = "BUFSIZE_OUT",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.bufsize_out,
-        .descr = "(undocumented)"
-    },
-    {
-        .name  = "BUFSIZE_IN",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.bufsize_in,
-        .descr = "(undocumented)"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops dsound_pcm_ops = {
     .init_out = dsound_init_out,
     .fini_out = dsound_fini_out,
@@ -893,7 +869,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
 static struct audio_driver dsound_audio_driver = {
     .name           = "dsound",
     .descr          = "DirectSound http://wikipedia.org/wiki/DirectSound",
-    .options        = dsound_options,
     .init           = dsound_audio_init,
     .fini           = dsound_audio_fini,
     .pcm_ops        = &dsound_pcm_ops,
-- 
2.20.1
