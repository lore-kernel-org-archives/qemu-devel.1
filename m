Received: from eggs.gnu.org ([209.51.188.92]:58562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjulD-0004WL-JF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Qo-7I
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul3-00033H-KU
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so8962902wrt.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:50 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:58 +0100
Message-Id: <158b6e78ba56fd24cc46685761d0fa4cf571997d.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 25/50] audio: use size_t where makes sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v2:
    * Update REPLAY_VERSION
    * Fix run_in/run_out prototypes in audio_pcm_ops

 audio/audio.h           |   4 +-
 audio/audio_int.h       |  26 +++----
 audio/audio_template.h  |  14 ++--
 audio/mixeng.h          |   9 ++-
 audio/rate_template.h   |   2 +-
 include/sysemu/replay.h |   4 +-
 audio/alsaaudio.c       |  26 +++----
 audio/audio.c           | 162 ++++++++++++++++++++--------------------
 audio/coreaudio.c       |  10 +--
 audio/dsoundaudio.c     |  11 +--
 audio/noaudio.c         |  16 ++--
 audio/ossaudio.c        |  45 +++++------
 audio/paaudio.c         |  44 +++++------
 audio/sdlaudio.c        |  19 +++--
 audio/spiceaudio.c      |  12 +--
 audio/wavaudio.c        |   8 +-
 replay/replay-audio.c   |  16 ++--
 replay/replay.c         |   2 +-
 18 files changed, 214 insertions(+), 216 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 4a95758516..2db27bba7b 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -112,7 +112,7 @@ SWVoiceOut *AUD_open_out (
     );
 
 void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
-int  AUD_write (SWVoiceOut *sw, void *pcm_buf, int size);
+size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
 int  AUD_is_active_out (SWVoiceOut *sw);
@@ -133,7 +133,7 @@ SWVoiceIn *AUD_open_in (
     );
 
 void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
-int  AUD_read (SWVoiceIn *sw, void *pcm_buf, int size);
+size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in (SWVoiceIn *sw, int on);
 int  AUD_is_active_in (SWVoiceIn *sw);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 40b3515b4e..9dcdf541fb 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -60,12 +60,12 @@ typedef struct HWVoiceOut {
 
     f_sample *clip;
 
-    int rpos;
+    size_t rpos;
     uint64_t ts_helper;
 
     struct st_sample *mix_buf;
 
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
     int ctl_caps;
@@ -81,13 +81,13 @@ typedef struct HWVoiceIn {
 
     t_sample *conv;
 
-    int wpos;
-    int total_samples_captured;
+    size_t wpos;
+    size_t total_samples_captured;
     uint64_t ts_helper;
 
     struct st_sample *conv_buf;
 
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
     int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
@@ -102,7 +102,7 @@ struct SWVoiceOut {
     int64_t ratio;
     struct st_sample *buf;
     void *rate;
-    int total_hw_samples_mixed;
+    size_t total_hw_samples_mixed;
     int active;
     int empty;
     HWVoiceOut *hw;
@@ -119,7 +119,7 @@ struct SWVoiceIn {
     struct audio_pcm_info info;
     int64_t ratio;
     void *rate;
-    int total_hw_samples_acquired;
+    size_t total_hw_samples_acquired;
     struct st_sample *buf;
     f_sample *clip;
     HWVoiceIn *hw;
@@ -148,12 +148,12 @@ struct audio_driver {
 struct audio_pcm_ops {
     int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_out)(HWVoiceOut *hw);
-    int  (*run_out) (HWVoiceOut *hw, int live);
+    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
 
     int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
     void (*fini_in) (HWVoiceIn *hw);
-    int  (*run_in)  (HWVoiceIn *hw);
+    size_t (*run_in)(HWVoiceIn *hw);
     int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
 
@@ -207,10 +207,10 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
 
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending);
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending);
 
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
@@ -223,7 +223,7 @@ void audio_run(AudioState *s, const char *msg);
 
 #define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
 
-static inline int audio_ring_dist (int dst, int src, int len)
+static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >= src) ? (dst - src) : (len - src + dst);
 }
diff --git a/audio/audio_template.h b/audio/audio_template.h
index ce1e5d6559..9a8aa1eebf 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -75,16 +75,16 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
     HWBUF = NULL;
 }
 
-static int glue (audio_pcm_hw_alloc_resources_, TYPE) (HW *hw)
+static bool glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
     HWBUF = audio_calloc(__func__, hw->samples, sizeof(struct st_sample));
     if (!HWBUF) {
-        dolog ("Could not allocate " NAME " buffer (%d samples)\n",
-               hw->samples);
-        return -1;
+        dolog("Could not allocate " NAME " buffer (%zu samples)\n",
+              hw->samples);
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -265,7 +265,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
     }
 
     if (audio_bug(__func__, hw->samples <= 0)) {
-        dolog ("hw->samples=%d\n", hw->samples);
+        dolog("hw->samples=%zd\n", hw->samples);
         goto err1;
     }
 
@@ -279,7 +279,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
 
-    if (glue (audio_pcm_hw_alloc_resources_, TYPE) (hw)) {
+    if (!glue(audio_pcm_hw_alloc_resources_, TYPE)(hw)) {
         goto err1;
     }
 
diff --git a/audio/mixeng.h b/audio/mixeng.h
index b53a5ef99a..18e62c7c49 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -33,6 +33,7 @@ struct st_sample { mixeng_real l; mixeng_real r; };
 struct mixeng_volume { int mute; int64_t r; int64_t l; };
 struct st_sample { int64_t l; int64_t r; };
 #endif
+typedef struct st_sample st_sample;
 
 typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
@@ -41,10 +42,10 @@ extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
 void *st_rate_start (int inrate, int outrate);
-void st_rate_flow (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-                   int *isamp, int *osamp);
-void st_rate_flow_mix (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-                       int *isamp, int *osamp);
+void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
+                  size_t *isamp, size_t *osamp);
+void st_rate_flow_mix(void *opaque, st_sample *ibuf, st_sample *obuf,
+                      size_t *isamp, size_t *osamp);
 void st_rate_stop (void *opaque);
 void mixeng_clear (struct st_sample *buf, int len);
 void mixeng_volume (struct st_sample *buf, int len, struct mixeng_volume *vol);
diff --git a/audio/rate_template.h b/audio/rate_template.h
index 6e93588877..f94c940c61 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -28,7 +28,7 @@
  * Return number of samples processed.
  */
 void NAME (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-           int *isamp, int *osamp)
+           size_t *isamp, size_t *osamp)
 {
     struct rate *rate = opaque;
     struct st_sample *istart, *iend;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e423..5c0a91e44f 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -179,9 +179,9 @@ void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
 /* Audio */
 
 /*! Saves/restores number of played samples of audio out operation. */
-void replay_audio_out(int *played);
+void replay_audio_out(size_t *played);
 /*! Saves/restores recorded samples of audio in operation. */
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size);
 
 /* VM state operations */
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 4c6bbdbc1d..6ad2a09d16 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -688,10 +688,10 @@ static void alsa_write_pending (ALSAVoiceOut *alsa)
     }
 }
 
-static int alsa_run_out (HWVoiceOut *hw, int live)
+static size_t alsa_run_out(HWVoiceOut *hw, size_t live)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
-    int decr;
+    size_t decr;
     snd_pcm_sframes_t avail;
 
     avail = alsa_get_avail (alsa->handle);
@@ -746,8 +746,8 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     alsa->pcm_buf = audio_calloc(__func__, obt.samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate DAC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -848,8 +848,8 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     alsa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -870,17 +870,17 @@ static void alsa_fini_in (HWVoiceIn *hw)
     alsa->pcm_buf = NULL;
 }
 
-static int alsa_run_in (HWVoiceIn *hw)
+static size_t alsa_run_in(HWVoiceIn *hw)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     int hwshift = hw->info.shift;
     int i;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
-    int decr;
+    size_t live = audio_pcm_hw_get_live_in (hw);
+    size_t dead = hw->samples - live;
+    size_t decr;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] = {
         { .add = hw->wpos, .len = 0 },
         { .add = 0,        .len = 0 }
@@ -920,7 +920,7 @@ static int alsa_run_in (HWVoiceIn *hw)
         }
     }
 
-    decr = MIN (dead, avail);
+    decr = MIN(dead, avail);
     if (!decr) {
         return 0;
     }
diff --git a/audio/audio.c b/audio/audio.c
index f844411d59..33b11e4feb 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -529,10 +529,10 @@ static int audio_attach_capture (HWVoiceOut *hw)
 /*
  * Hard voice (capture)
  */
-static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
+static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 {
     SWVoiceIn *sw;
-    int m = hw->total_samples_captured;
+    size_t m = hw->total_samples_captured;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active) {
@@ -542,28 +542,28 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-int audio_pcm_hw_get_live_in (HWVoiceIn *hw)
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
-    int live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+    size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
     return live;
 }
 
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending)
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending)
 {
-    int left = hw->samples - pending;
-    int len = MIN (left, live);
-    int clipped = 0;
+    size_t left = hw->samples - pending;
+    size_t len = MIN (left, live);
+    size_t clipped = 0;
 
     while (len) {
         struct st_sample *src = hw->mix_buf + hw->rpos;
         uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
-        int samples_till_end_of_buf = hw->samples - hw->rpos;
-        int samples_to_clip = MIN (len, samples_till_end_of_buf);
+        size_t samples_till_end_of_buf = hw->samples - hw->rpos;
+        size_t samples_to_clip = MIN (len, samples_till_end_of_buf);
 
         hw->clip (dst, src, samples_to_clip);
 
@@ -577,14 +577,14 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
 /*
  * Soft voice (capture)
  */
-static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
+static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *sw)
 {
     HWVoiceIn *hw = sw->hw;
-    int live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    int rpos;
+    ssize_t live = hw->total_samples_captured - sw->total_hw_samples_acquired;
+    ssize_t rpos;
 
     if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
 
@@ -597,17 +597,17 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     }
 }
 
-static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
+static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw = sw->hw;
-    int samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
+    size_t samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
     struct st_sample *src, *dst = sw->buf;
 
     rpos = audio_pcm_sw_get_rpos_in (sw) % hw->samples;
 
     live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live_in=%d hw->samples=%d\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live_in=%zu hw->samples=%zu\n", live, hw->samples);
         return 0;
     }
 
@@ -621,9 +621,9 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 
     while (swlim) {
         src = hw->conv_buf + rpos;
-        isamp = hw->wpos - rpos;
-        /* XXX: <= ? */
-        if (isamp <= 0) {
+        if (hw->wpos > rpos) {
+            isamp = hw->wpos - rpos;
+        } else {
             isamp = hw->samples - rpos;
         }
 
@@ -632,11 +632,6 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
         }
         osamp = swlim;
 
-        if (audio_bug(__func__, osamp < 0)) {
-            dolog ("osamp=%d\n", osamp);
-            return 0;
-        }
-
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -= osamp;
         rpos = (rpos + isamp) % hw->samples;
@@ -657,10 +652,10 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 /*
  * Hard voice (playback)
  */
-static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
+static size_t audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
 {
     SWVoiceOut *sw;
-    int m = INT_MAX;
+    size_t m = SIZE_MAX;
     int nb_live = 0;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
@@ -674,9 +669,9 @@ static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
     return m;
 }
 
-static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
+static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 {
-    int smin;
+    size_t smin;
     int nb_live1;
 
     smin = audio_pcm_hw_find_min_out (hw, &nb_live1);
@@ -685,10 +680,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     }
 
     if (nb_live1) {
-        int live = smin;
+        size_t live = smin;
 
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog("live=%zu hw->samples=%zu\n", live, hw->samples);
             return 0;
         }
         return live;
@@ -699,10 +694,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 /*
  * Soft voice (playback)
  */
-static int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
+static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
 {
-    int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
-    int ret = 0, pos = 0, total = 0;
+    size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
+    size_t ret = 0, pos = 0, total = 0;
 
     if (!sw) {
         return size;
@@ -711,8 +706,8 @@ static int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
     hwsamples = sw->hw->samples;
 
     live = sw->total_hw_samples_mixed;
-    if (audio_bug(__func__, live < 0 || live > hwsamples)) {
-        dolog ("live=%d hw->samples=%d\n", live, hwsamples);
+    if (audio_bug(__func__, live > hwsamples)) {
+        dolog("live=%zu hw->samples=%zu\n", live, hwsamples);
         return 0;
     }
 
@@ -766,7 +761,7 @@ static int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
 
 #ifdef DEBUG_OUT
     dolog (
-        "%s: write size %d ret %d total sw %d\n",
+        "%s: write size %zu ret %zu total sw %zu\n",
         SW_NAME (sw),
         size >> sw->info.shift,
         ret,
@@ -845,7 +840,7 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-int AUD_write (SWVoiceOut *sw, void *buf, int size)
+size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -860,7 +855,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
     return audio_pcm_sw_write(sw, buf, size);
 }
 
-int AUD_read (SWVoiceIn *sw, void *buf, int size)
+size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -969,17 +964,17 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
     }
 }
 
-static int audio_get_avail (SWVoiceIn *sw)
+static size_t audio_get_avail (SWVoiceIn *sw)
 {
-    int live;
+    size_t live;
 
     if (!sw) {
         return 0;
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
         return 0;
     }
 
@@ -992,9 +987,9 @@ static int audio_get_avail (SWVoiceIn *sw)
     return (((int64_t) live << 32) / sw->ratio) << sw->info.shift;
 }
 
-static int audio_get_free (SWVoiceOut *sw)
+static size_t audio_get_free(SWVoiceOut *sw)
 {
-    int live, dead;
+    size_t live, dead;
 
     if (!sw) {
         return 0;
@@ -1002,8 +997,8 @@ static int audio_get_free (SWVoiceOut *sw)
 
     live = sw->total_hw_samples_mixed;
 
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=%zu sw->hw->samples=%zu\n", live, sw->hw->samples);
         return 0;
     }
 
@@ -1018,9 +1013,10 @@ static int audio_get_free (SWVoiceOut *sw)
     return (((int64_t) dead << 32) / sw->ratio) << sw->info.shift;
 }
 
-static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
+static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
+                                        size_t samples)
 {
-    int n;
+    size_t n;
 
     if (hw->enabled) {
         SWVoiceCap *sc;
@@ -1031,17 +1027,17 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
 
             n = samples;
             while (n) {
-                int till_end_of_hw = hw->samples - rpos2;
-                int to_write = MIN (till_end_of_hw, n);
-                int bytes = to_write << hw->info.shift;
-                int written;
+                size_t till_end_of_hw = hw->samples - rpos2;
+                size_t to_write = MIN(till_end_of_hw, n);
+                size_t bytes = to_write << hw->info.shift;
+                size_t written;
 
                 sw->buf = hw->mix_buf + rpos2;
                 written = audio_pcm_sw_write (sw, NULL, bytes);
                 if (written - bytes) {
-                    dolog ("Could not mix %d bytes into a capture "
-                           "buffer, mixed %d\n",
-                           bytes, written);
+                    dolog("Could not mix %zu bytes into a capture "
+                          "buffer, mixed %zu\n",
+                          bytes, written);
                     break;
                 }
                 n -= to_write;
@@ -1050,9 +1046,9 @@ static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int samples)
         }
     }
 
-    n = MIN (samples, hw->samples - rpos);
-    mixeng_clear (hw->mix_buf + rpos, n);
-    mixeng_clear (hw->mix_buf, samples - n);
+    n = MIN(samples, hw->samples - rpos);
+    mixeng_clear(hw->mix_buf + rpos, n);
+    mixeng_clear(hw->mix_buf, samples - n);
 }
 
 static void audio_run_out (AudioState *s)
@@ -1061,16 +1057,16 @@ static void audio_run_out (AudioState *s)
     SWVoiceOut *sw;
 
     while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
-        int played;
-        int live, free, nb_live, cleanup_required, prev_rpos;
+        size_t played, live, prev_rpos, free;
+        int nb_live, cleanup_required;
 
         live = audio_pcm_hw_get_live_out (hw, &nb_live);
         if (!nb_live) {
             live = 0;
         }
 
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=%d hw->samples=%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog ("live=%zu hw->samples=%zu\n", live, hw->samples);
             continue;
         }
 
@@ -1105,13 +1101,13 @@ static void audio_run_out (AudioState *s)
         played = hw->pcm_ops->run_out (hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
-            dolog ("hw->rpos=%d hw->samples=%d played=%d\n",
-                   hw->rpos, hw->samples, played);
+            dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
+                  hw->rpos, hw->samples, played);
             hw->rpos = 0;
         }
 
 #ifdef DEBUG_OUT
-        dolog ("played=%d\n", played);
+        dolog("played=%zu\n", played);
 #endif
 
         if (played) {
@@ -1126,8 +1122,8 @@ static void audio_run_out (AudioState *s)
             }
 
             if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
-                dolog ("played=%d sw->total_hw_samples_mixed=%d\n",
-                       played, sw->total_hw_samples_mixed);
+                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
+                      played, sw->total_hw_samples_mixed);
                 played = sw->total_hw_samples_mixed;
             }
 
@@ -1167,7 +1163,7 @@ static void audio_run_in (AudioState *s)
 
     while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
-        int captured = 0, min;
+        size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
             captured = hw->pcm_ops->run_in(hw);
@@ -1182,7 +1178,7 @@ static void audio_run_in (AudioState *s)
             sw->total_hw_samples_acquired -= min;
 
             if (sw->active) {
-                int avail;
+                size_t avail;
 
                 avail = audio_get_avail (sw);
                 if (avail > 0) {
@@ -1198,15 +1194,15 @@ static void audio_run_capture (AudioState *s)
     CaptureVoiceOut *cap;
 
     for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
-        int live, rpos, captured;
+        size_t live, rpos, captured;
         HWVoiceOut *hw = &cap->hw;
         SWVoiceOut *sw;
 
         captured = live = audio_pcm_hw_get_live_out (hw, NULL);
         rpos = hw->rpos;
         while (live) {
-            int left = hw->samples - rpos;
-            int to_capture = MIN (live, left);
+            size_t left = hw->samples - rpos;
+            size_t to_capture = MIN(live, left);
             struct st_sample *src;
             struct capture_callback *cb;
 
@@ -1229,8 +1225,8 @@ static void audio_run_capture (AudioState *s)
             }
 
             if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
-                dolog ("captured=%d sw->total_hw_samples_mixed=%d\n",
-                       captured, sw->total_hw_samples_mixed);
+                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
+                      captured, sw->total_hw_samples_mixed);
                 captured = sw->total_hw_samples_mixed;
             }
 
@@ -1591,8 +1587,8 @@ CaptureVoiceOut *AUD_add_capture(
         hw->mix_buf = audio_calloc(__func__, hw->samples,
                                    sizeof(struct st_sample));
         if (!hw->mix_buf) {
-            dolog ("Could not allocate capture mix buffer (%d samples)\n",
-                   hw->samples);
+            dolog("Could not allocate capture mix buffer (%zu samples)\n",
+                  hw->samples);
             goto err2;
         }
 
@@ -1601,7 +1597,7 @@ CaptureVoiceOut *AUD_add_capture(
         cap->buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
         if (!cap->buf) {
             dolog ("Could not allocate capture buffer "
-                   "(%d samples, each %d bytes)\n",
+                   "(%zu samples, each %d bytes)\n",
                    hw->samples, 1 << hw->info.shift);
             goto err3;
         }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index abbbb45d69..646aea06a0 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,9 +43,9 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
-    int live;
-    int decr;
-    int rpos;
+    size_t live;
+    size_t decr;
+    size_t rpos;
 } coreaudioVoiceOut;
 
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6
@@ -397,9 +397,9 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-static int coreaudio_run_out (HWVoiceOut *hw, int live)
+static size_t coreaudio_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
 
     if (coreaudio_lock (core, "coreaudio_run_out")) {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index dfcb70c81a..906cca3235 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,19 +454,20 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_run_out (HWVoiceOut *hw, int live)
+static size_t dsound_run_out(HWVoiceOut *hw, size_t live)
 {
     int err;
     HRESULT hr;
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
-    int len, hwshift;
+    size_t len;
+    int hwshift;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
     DWORD wpos, ppos, old_pos;
     LPVOID p1, p2;
-    int bufsize;
+    size_t bufsize;
     dsound *s = ds->s;
     AudiodevDsoundOptions *dso = &s->dev->u.dsound;
 
@@ -640,13 +641,13 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static int dsound_run_in (HWVoiceIn *hw)
+static size_t dsound_run_in(HWVoiceIn *hw)
 {
     int err;
     HRESULT hr;
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
-    int live, len, dead;
+    size_t live, len, dead;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 4fe7720861..59e680db6f 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -40,10 +40,10 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
 
-static int no_run_out (HWVoiceOut *hw, int live)
+static size_t no_run_out(HWVoiceOut *hw, size_t live)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
-    int decr, samples;
+    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -51,7 +51,7 @@ static int no_run_out (HWVoiceOut *hw, int live)
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks = now - no->old_ticks;
     bytes = muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
-    bytes = MIN(bytes, INT_MAX);
+    bytes = MIN(bytes, SIZE_MAX);
     samples = bytes >> hw->info.shift;
 
     no->old_ticks = now;
@@ -91,12 +91,12 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
 
-static int no_run_in (HWVoiceIn *hw)
+static size_t no_run_in(HWVoiceIn *hw)
 {
     NoVoiceIn *no = (NoVoiceIn *) hw;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
-    int samples = 0;
+    size_t live = audio_pcm_hw_get_live_in(hw);
+    size_t dead = hw->samples - live;
+    size_t samples = 0;
 
     if (dead) {
         int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -105,7 +105,7 @@ static int no_run_in (HWVoiceIn *hw)
             muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
         no->old_ticks = now;
-        bytes = MIN (bytes, INT_MAX);
+        bytes = MIN (bytes, SIZE_MAX);
         samples = bytes >> hw->info.shift;
         samples = MIN (samples, dead);
     }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 3eee7a3970..c6d4086573 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -410,13 +410,14 @@ static void oss_write_pending (OSSVoiceOut *oss)
     }
 }
 
-static int oss_run_out (HWVoiceOut *hw, int live)
+static size_t oss_run_out(HWVoiceOut *hw, size_t live)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
-    int err, decr;
+    int err;
+    size_t decr;
     struct audio_buf_info abinfo;
     struct count_info cntinfo;
-    int bufsize;
+    size_t bufsize;
 
     bufsize = hw->samples << hw->info.shift;
 
@@ -475,8 +476,8 @@ static void oss_fini_out (HWVoiceOut *hw)
         if (oss->mmapped) {
             err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
             if (err) {
-                oss_logerr (errno, "Failed to unmap buffer %p, size %d\n",
-                            oss->pcm_buf, hw->samples << hw->info.shift);
+                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+                           oss->pcm_buf, hw->samples << hw->info.shift);
             }
         }
         else {
@@ -542,8 +543,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
             0
             );
         if (oss->pcm_buf == MAP_FAILED) {
-            oss_logerr (errno, "Failed to map %d bytes of DAC\n",
-                        hw->samples << hw->info.shift);
+            oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
+                       hw->samples << hw->info.shift);
         }
         else {
             int err;
@@ -567,8 +568,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
             if (!oss->mmapped) {
                 err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
                 if (err) {
-                    oss_logerr (errno, "Failed to unmap buffer %p size %d\n",
-                                oss->pcm_buf, hw->samples << hw->info.shift);
+                    oss_logerr(errno, "Failed to unmap buffer %p size %zu\n",
+                               oss->pcm_buf, hw->samples << hw->info.shift);
                 }
             }
         }
@@ -580,7 +581,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
                                     1 << hw->info.shift);
         if (!oss->pcm_buf) {
             dolog (
-                "Could not allocate DAC buffer (%d samples, each %d bytes)\n",
+                "Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
                 hw->samples,
                 1 << hw->info.shift
                 );
@@ -692,8 +693,8 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
     oss->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!oss->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
+              hw->samples, 1 << hw->info.shift);
         oss_anal_close (&fd);
         return -1;
     }
@@ -713,17 +714,17 @@ static void oss_fini_in (HWVoiceIn *hw)
     oss->pcm_buf = NULL;
 }
 
-static int oss_run_in (HWVoiceIn *hw)
+static size_t oss_run_in(HWVoiceIn *hw)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     int hwshift = hw->info.shift;
     int i;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
+    size_t live = audio_pcm_hw_get_live_in (hw);
+    size_t dead = hw->samples - live;
     size_t read_samples = 0;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] = {
         { .add = hw->wpos, .len = 0 },
         { .add = 0,        .len = 0 }
@@ -750,9 +751,9 @@ static int oss_run_in (HWVoiceIn *hw)
 
             if (nread > 0) {
                 if (nread & hw->info.align) {
-                    dolog ("warning: Misaligned read %zd (requested %d), "
-                           "alignment %d\n", nread, bufs[i].add << hwshift,
-                           hw->info.align + 1);
+                    dolog("warning: Misaligned read %zd (requested %zu), "
+                          "alignment %d\n", nread, bufs[i].add << hwshift,
+                          hw->info.align + 1);
                 }
                 read_samples += nread >> hwshift;
                 hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshift);
@@ -765,9 +766,9 @@ static int oss_run_in (HWVoiceIn *hw)
                     case EAGAIN:
                         break;
                     default:
-                        oss_logerr (
+                        oss_logerr(
                             errno,
-                            "Failed to read %d bytes of audio (to %p)\n",
+                            "Failed to read %zu bytes of audio (to %p)\n",
                             bufs[i].len, p
                             );
                         break;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index f5b924d50c..a1be0726b7 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -29,30 +29,30 @@ typedef struct {
 
 typedef struct {
     HWVoiceOut hw;
-    int done;
-    int live;
-    int decr;
-    int rpos;
+    size_t done;
+    size_t live;
+    size_t decr;
+    size_t rpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
-    int done;
-    int dead;
-    int incr;
-    int wpos;
+    size_t done;
+    size_t dead;
+    size_t incr;
+    size_t wpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     const void *read_data;
     size_t read_index, read_length;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceIn;
 
 static void qpa_conn_fini(PAConnection *c);
@@ -218,7 +218,7 @@ static void *qpa_thread_out (void *arg)
     }
 
     for (;;) {
-        int decr, to_mix, rpos;
+        size_t decr, to_mix, rpos;
 
         for (;;) {
             if (pa->done) {
@@ -243,7 +243,7 @@ static void *qpa_thread_out (void *arg)
 
         while (to_mix) {
             int error;
-            int chunk = MIN (to_mix, hw->samples - rpos);
+            size_t chunk = MIN (to_mix, hw->samples - rpos);
             struct st_sample *src = hw->mix_buf + rpos;
 
             hw->clip (pa->pcm_buf, src, chunk);
@@ -272,9 +272,9 @@ static void *qpa_thread_out (void *arg)
     return NULL;
 }
 
-static int qpa_run_out (HWVoiceOut *hw, int live)
+static size_t qpa_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
 
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -305,7 +305,7 @@ static void *qpa_thread_in (void *arg)
     }
 
     for (;;) {
-        int incr, to_grab, wpos;
+        size_t incr, to_grab, wpos;
 
         for (;;) {
             if (pa->done) {
@@ -330,7 +330,7 @@ static void *qpa_thread_in (void *arg)
 
         while (to_grab) {
             int error;
-            int chunk = MIN (to_grab, hw->samples - wpos);
+            size_t chunk = MIN (to_grab, hw->samples - wpos);
             void *buf = advance (pa->pcm_buf, wpos);
 
             if (qpa_simple_read (pa, buf,
@@ -358,9 +358,9 @@ static void *qpa_thread_in (void *arg)
     return NULL;
 }
 
-static int qpa_run_in (HWVoiceIn *hw)
+static size_t qpa_run_in(HWVoiceIn *hw)
 {
-    int live, incr, dead;
+    size_t live, incr, dead;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
 
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -584,8 +584,8 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->rpos = hw->rpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
 
@@ -645,8 +645,8 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->wpos = hw->wpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index ab9166d054..ff19484430 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -42,11 +42,11 @@
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    int live;
+    size_t live;
 #if USE_SEMAPHORE
-    int rpos;
+    size_t rpos;
 #endif
-    int decr;
+    size_t decr;
 } SDLVoiceOut;
 
 static struct SDLAudioState {
@@ -252,14 +252,14 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     SDLVoiceOut *sdl = opaque;
     SDLAudioState *s = &glob_sdl;
     HWVoiceOut *hw = &sdl->hw;
-    int samples = len >> hw->info.shift;
+    size_t samples = len >> hw->info.shift;
 
     if (s->exit) {
         return;
     }
 
     while (samples) {
-        int to_mix, decr;
+        size_t to_mix, decr;
 
         /* dolog ("in callback samples=%d\n", samples); */
 #if USE_SEMAPHORE
@@ -273,8 +273,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         }
 
         if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples)) {
-            dolog ("sdl->live=%d hw->samples=%d\n",
-                   sdl->live, hw->samples);
+            dolog("sdl->live=%d hw->samples=%zu\n", sdl->live, hw->samples);
             return;
         }
 
@@ -291,7 +290,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         to_mix = MIN (samples, sdl->live);
         decr = to_mix;
         while (to_mix) {
-            int chunk = MIN (to_mix, hw->samples - hw->rpos);
+            size_t chunk = MIN(to_mix, hw->samples - hw->rpos);
             struct st_sample *src = hw->mix_buf + hw->rpos;
 
             /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
@@ -325,9 +324,9 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 #endif
 }
 
-static int sdl_run_out (HWVoiceOut *hw, int live)
+static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
     SDLAudioState *s = &glob_sdl;
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index f963853ed8..1a777bba17 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -152,11 +152,11 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
 
-static int line_out_run (HWVoiceOut *hw, int live)
+static size_t line_out_run (HWVoiceOut *hw, size_t live)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
-    int rpos, decr;
-    int samples;
+    size_t rpos, decr;
+    size_t samples;
 
     if (!live) {
         return 0;
@@ -275,12 +275,12 @@ static void line_in_fini (HWVoiceIn *hw)
     spice_server_remove_interface (&in->sin.base);
 }
 
-static int line_in_run (HWVoiceIn *hw)
+static size_t line_in_run(HWVoiceIn *hw)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
-    int num_samples;
+    size_t num_samples;
     int ready;
-    int len[2];
+    size_t len[2];
     uint64_t delta_samp;
     const uint32_t *samples;
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index dda6993fb9..a805e5e94b 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -38,10 +38,10 @@ typedef struct WAVVoiceOut {
     int total_samples;
 } WAVVoiceOut;
 
-static int wav_run_out (HWVoiceOut *hw, int live)
+static size_t wav_run_out(HWVoiceOut *hw, size_t live)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    int rpos, decr, samples;
+    size_t rpos, decr, samples;
     uint8_t *dst;
     struct st_sample *src;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -137,8 +137,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     hw->samples = 1024;
     wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!wav->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         return -1;
     }
 
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index b113836de4..efe1628727 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -16,18 +16,18 @@
 #include "sysemu/sysemu.h"
 #include "audio/audio.h"
 
-void replay_audio_out(int *played)
+void replay_audio_out(size_t *played)
 {
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_OUT);
-        replay_put_dword(*played);
+        replay_put_qword(*played);
     } else if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_OUT)) {
-            *played = replay_get_dword();
+            *played = replay_get_qword();
             replay_finish_event();
         } else {
             error_report("Missing audio out event in the replay log");
@@ -36,7 +36,7 @@ void replay_audio_out(int *played)
     }
 }
 
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
 {
     int pos;
     uint64_t left, right;
@@ -44,8 +44,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_IN);
-        replay_put_dword(*recorded);
-        replay_put_dword(*wpos);
+        replay_put_qword(*recorded);
+        replay_put_qword(*wpos);
         for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
              ; pos = (pos + 1) % size) {
             audio_sample_to_uint64(samples, pos, &left, &right);
@@ -56,8 +56,8 @@ void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_IN)) {
-            *recorded = replay_get_dword();
-            *wpos = replay_get_dword();
+            *recorded = replay_get_qword();
+            *wpos = replay_get_qword();
             for (pos = (*wpos - *recorded + size) % size ; pos != *wpos
                  ; pos = (pos + 1) % size) {
                 left = replay_get_qword();
diff --git a/replay/replay.c b/replay/replay.c
index 8b172b2d1b..a1135a9943 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02007
+#define REPLAY_VERSION              0xe02008
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 
-- 
2.20.1
