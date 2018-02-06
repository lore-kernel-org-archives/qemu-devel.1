Received: from eggs.gnu.org ([2001:4830:134:3::10]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Gh-0003ER-SS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej9Ge-00043Q-EZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej9Ge-00042F-3u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:51:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Feb 2018 20:50:32 +0100
Message-Id: <20180206195044.8347-3-armbru@redhat.com>
In-Reply-To: <20180206195044.8347-1-armbru@redhat.com>
References: <20180206195044.8347-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] audio: Replace AUDIO_FUNC with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Apparently we don't use __MSC_VER as a compiler anymore and we always
require a C99 compiler (which means we always have __func__) so we don't
need a special AUDIO_FUNC macro. We can just replace AUDIO_FUNC with
__func__ instead.

Checkpatch failures were manually fixed.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180203084315.20497-2-armbru@redhat.com>
---
 audio/alsaaudio.c      |  4 ++--
 audio/audio.c          | 40 ++++++++++++++++++------------------
 audio/audio_int.h      |  6 ------
 audio/audio_pt_int.c   | 28 ++++++++++++-------------
 audio/audio_template.h | 26 +++++++++++------------
 audio/dsoundaudio.c    |  2 +-
 audio/mixeng.c         |  2 +-
 audio/ossaudio.c       | 10 ++++-----
 audio/paaudio.c        | 56 +++++++++++++++++++++++++-------------------=
------
 audio/sdlaudio.c       |  2 +-
 audio/wavaudio.c       |  2 +-
 11 files changed, 85 insertions(+), 93 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3652a7b5fa..92a96f8b2b 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -823,7 +823,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D obt.samples;
=20
-    alsa->pcm_buf =3D audio_calloc (AUDIO_FUNC, obt.samples, 1 << hw->in=
fo.shift);
+    alsa->pcm_buf =3D audio_calloc(__func__, obt.samples, 1 << hw->info.=
shift);
     if (!alsa->pcm_buf) {
         dolog ("Could not allocate DAC buffer (%d samples, each %d bytes=
)\n",
                hw->samples, 1 << hw->info.shift);
@@ -934,7 +934,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D obt.samples;
=20
-    alsa->pcm_buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->in=
fo.shift);
+    alsa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.=
shift);
     if (!alsa->pcm_buf) {
         dolog ("Could not allocate ADC buffer (%d samples, each %d bytes=
)\n",
                hw->samples, 1 << hw->info.shift);
diff --git a/audio/audio.c b/audio/audio.c
index beafed209b..7658d2af66 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -424,12 +424,12 @@ static void audio_process_options (const char *pref=
ix,
     const char qemu_prefix[] =3D "QEMU_";
     size_t preflen, optlen;
=20
-    if (audio_bug (AUDIO_FUNC, !prefix)) {
+    if (audio_bug(__func__, !prefix)) {
         dolog ("prefix =3D NULL\n");
         return;
     }
=20
-    if (audio_bug (AUDIO_FUNC, !opt)) {
+    if (audio_bug(__func__, !opt)) {
         dolog ("opt =3D NULL\n");
         return;
     }
@@ -792,7 +792,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         SWVoiceOut *sw;
         HWVoiceOut *hw_cap =3D &cap->hw;
=20
-        sc =3D audio_calloc (AUDIO_FUNC, 1, sizeof (*sc));
+        sc =3D audio_calloc(__func__, 1, sizeof(*sc));
         if (!sc) {
             dolog ("Could not allocate soft capture voice (%zu bytes)\n"=
,
                    sizeof (*sc));
@@ -848,7 +848,7 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 int audio_pcm_hw_get_live_in (HWVoiceIn *hw)
 {
     int live =3D hw->total_samples_captured - audio_pcm_hw_find_min_in (=
hw);
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
         return 0;
     }
@@ -886,7 +886,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     int live =3D hw->total_samples_captured - sw->total_hw_samples_acqui=
red;
     int rpos;
=20
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
         return 0;
     }
@@ -909,7 +909,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int =
size)
     rpos =3D audio_pcm_sw_get_rpos_in (sw) % hw->samples;
=20
     live =3D hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live_in=3D%d hw->samples=3D%d\n", live, hw->samples);
         return 0;
     }
@@ -935,7 +935,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int =
size)
         }
         osamp =3D swlim;
=20
-        if (audio_bug (AUDIO_FUNC, osamp < 0)) {
+        if (audio_bug(__func__, osamp < 0)) {
             dolog ("osamp=3D%d\n", osamp);
             return 0;
         }
@@ -990,7 +990,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw,=
 int *nb_live)
     if (nb_live1) {
         int live =3D smin;
=20
-        if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
             dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
             return 0;
         }
@@ -1014,7 +1014,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, =
int size)
     hwsamples =3D sw->hw->samples;
=20
     live =3D sw->total_hw_samples_mixed;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hwsamples)){
+    if (audio_bug(__func__, live < 0 || live > hwsamples)) {
         dolog ("live=3D%d hw->samples=3D%d\n", live, hwsamples);
         return 0;
     }
@@ -1263,7 +1263,7 @@ static int audio_get_avail (SWVoiceIn *sw)
     }
=20
     live =3D sw->hw->total_samples_captured - sw->total_hw_samples_acqui=
red;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > sw->hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
         dolog ("live=3D%d sw->hw->samples=3D%d\n", live, sw->hw->samples=
);
         return 0;
     }
@@ -1287,7 +1287,7 @@ static int audio_get_free (SWVoiceOut *sw)
=20
     live =3D sw->total_hw_samples_mixed;
=20
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > sw->hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
         dolog ("live=3D%d sw->hw->samples=3D%d\n", live, sw->hw->samples=
);
         return 0;
     }
@@ -1354,7 +1354,7 @@ static void audio_run_out (AudioState *s)
             live =3D 0;
         }
=20
-        if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
             dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
             continue;
         }
@@ -1389,7 +1389,7 @@ static void audio_run_out (AudioState *s)
         prev_rpos =3D hw->rpos;
         played =3D hw->pcm_ops->run_out (hw, live);
         replay_audio_out(&played);
-        if (audio_bug (AUDIO_FUNC, hw->rpos >=3D hw->samples)) {
+        if (audio_bug(__func__, hw->rpos >=3D hw->samples)) {
             dolog ("hw->rpos=3D%d hw->samples=3D%d played=3D%d\n",
                    hw->rpos, hw->samples, played);
             hw->rpos =3D 0;
@@ -1410,7 +1410,7 @@ static void audio_run_out (AudioState *s)
                 continue;
             }
=20
-            if (audio_bug (AUDIO_FUNC, played > sw->total_hw_samples_mix=
ed)) {
+            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)=
) {
                 dolog ("played=3D%d sw->total_hw_samples_mixed=3D%d\n",
                        played, sw->total_hw_samples_mixed);
                 played =3D sw->total_hw_samples_mixed;
@@ -1513,7 +1513,7 @@ static void audio_run_capture (AudioState *s)
                 continue;
             }
=20
-            if (audio_bug (AUDIO_FUNC, captured > sw->total_hw_samples_m=
ixed)) {
+            if (audio_bug(__func__, captured > sw->total_hw_samples_mixe=
d)) {
                 dolog ("captured=3D%d sw->total_hw_samples_mixed=3D%d\n"=
,
                        captured, sw->total_hw_samples_mixed);
                 captured =3D sw->total_hw_samples_mixed;
@@ -1924,7 +1924,7 @@ CaptureVoiceOut *AUD_add_capture (
         goto err0;
     }
=20
-    cb =3D audio_calloc (AUDIO_FUNC, 1, sizeof (*cb));
+    cb =3D audio_calloc(__func__, 1, sizeof(*cb));
     if (!cb) {
         dolog ("Could not allocate capture callback information, size %z=
u\n",
                sizeof (*cb));
@@ -1942,7 +1942,7 @@ CaptureVoiceOut *AUD_add_capture (
         HWVoiceOut *hw;
         CaptureVoiceOut *cap;
=20
-        cap =3D audio_calloc (AUDIO_FUNC, 1, sizeof (*cap));
+        cap =3D audio_calloc(__func__, 1, sizeof(*cap));
         if (!cap) {
             dolog ("Could not allocate capture voice, size %zu\n",
                    sizeof (*cap));
@@ -1955,8 +1955,8 @@ CaptureVoiceOut *AUD_add_capture (
=20
         /* XXX find a more elegant way */
         hw->samples =3D 4096 * 4;
-        hw->mix_buf =3D audio_calloc (AUDIO_FUNC, hw->samples,
-                                    sizeof (struct st_sample));
+        hw->mix_buf =3D audio_calloc(__func__, hw->samples,
+                                   sizeof(struct st_sample));
         if (!hw->mix_buf) {
             dolog ("Could not allocate capture mix buffer (%d samples)\n=
",
                    hw->samples);
@@ -1965,7 +1965,7 @@ CaptureVoiceOut *AUD_add_capture (
=20
         audio_pcm_init_info (&hw->info, as);
=20
-        cap->buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->inf=
o.shift);
+        cap->buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
         if (!cap->buf) {
             dolog ("Could not allocate capture buffer "
                    "(%d samples, each %d bytes)\n",
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5bcb1c60e1..5b25da0a37 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -252,10 +252,4 @@ static inline int audio_ring_dist (int dst, int src,=
 int len)
 #define AUDIO_STRINGIFY_(n) #n
 #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
=20
-#if defined _MSC_VER || defined __GNUC__
-#define AUDIO_FUNC __FUNCTION__
-#else
-#define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
-#endif
-
 #endif /* QEMU_AUDIO_INT_H */
diff --git a/audio/audio_pt_int.c b/audio/audio_pt_int.c
index 21ff9c5803..3fe56d8514 100644
--- a/audio/audio_pt_int.c
+++ b/audio/audio_pt_int.c
@@ -31,7 +31,7 @@ int audio_pt_init (struct audio_pt *p, void *(*func) (v=
oid *),
=20
     err =3D sigfillset (&set);
     if (err) {
-        logerr (p, errno, "%s(%s): sigfillset failed", cap, AUDIO_FUNC);
+        logerr(p, errno, "%s(%s): sigfillset failed", cap, __func__);
         return -1;
     }
=20
@@ -57,8 +57,8 @@ int audio_pt_init (struct audio_pt *p, void *(*func) (v=
oid *),
=20
     err2 =3D pthread_sigmask (SIG_SETMASK, &old_set, NULL);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_sigmask (restore) failed",
-                cap, AUDIO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_sigmask (restore) failed",
+               cap, __func__);
         /* We have failed to restore original signal mask, all bets are =
off,
            so terminate the process */
         exit (EXIT_FAILURE);
@@ -74,17 +74,17 @@ int audio_pt_init (struct audio_pt *p, void *(*func) =
(void *),
  err2:
     err2 =3D pthread_cond_destroy (&p->cond);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_cond_destroy failed", cap, AUD=
IO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_cond_destroy failed", cap, __fu=
nc__);
     }
=20
  err1:
     err2 =3D pthread_mutex_destroy (&p->mutex);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_mutex_destroy failed", cap, AU=
DIO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_mutex_destroy failed", cap, __f=
unc__);
     }
=20
  err0:
-    logerr (p, err, "%s(%s): %s failed", cap, AUDIO_FUNC, efunc);
+    logerr(p, err, "%s(%s): %s failed", cap, __func__, efunc);
     return -1;
 }
=20
@@ -94,13 +94,13 @@ int audio_pt_fini (struct audio_pt *p, const char *ca=
p)
=20
     err =3D pthread_cond_destroy (&p->cond);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_destroy failed", cap, AUDI=
O_FUNC);
+        logerr(p, err, "%s(%s): pthread_cond_destroy failed", cap, __fun=
c__);
         ret =3D -1;
     }
=20
     err =3D pthread_mutex_destroy (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_destroy failed", cap, AUD=
IO_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_destroy failed", cap, __fu=
nc__);
         ret =3D -1;
     }
     return ret;
@@ -112,7 +112,7 @@ int audio_pt_lock (struct audio_pt *p, const char *ca=
p)
=20
     err =3D pthread_mutex_lock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_lock failed", cap, AUDIO_=
FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_lock failed", cap, __func_=
_);
         return -1;
     }
     return 0;
@@ -124,7 +124,7 @@ int audio_pt_unlock (struct audio_pt *p, const char *=
cap)
=20
     err =3D pthread_mutex_unlock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_unlock failed", cap, AUDI=
O_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __fun=
c__);
         return -1;
     }
     return 0;
@@ -136,7 +136,7 @@ int audio_pt_wait (struct audio_pt *p, const char *ca=
p)
=20
     err =3D pthread_cond_wait (&p->cond, &p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_wait failed", cap, AUDIO_F=
UNC);
+        logerr(p, err, "%s(%s): pthread_cond_wait failed", cap, __func__=
);
         return -1;
     }
     return 0;
@@ -148,12 +148,12 @@ int audio_pt_unlock_and_signal (struct audio_pt *p,=
 const char *cap)
=20
     err =3D pthread_mutex_unlock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_unlock failed", cap, AUDI=
O_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __fun=
c__);
         return -1;
     }
     err =3D pthread_cond_signal (&p->cond);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_signal failed", cap, AUDIO=
_FUNC);
+        logerr(p, err, "%s(%s): pthread_cond_signal failed", cap, __func=
__);
         return -1;
     }
     return 0;
@@ -166,7 +166,7 @@ int audio_pt_join (struct audio_pt *p, void **arg, co=
nst char *cap)
=20
     err =3D pthread_join (p->thread, &ret);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_join failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_join failed", cap, __func__);
         return -1;
     }
     *arg =3D ret;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 99b27b285e..7de227d2d1 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -57,13 +57,13 @@ static void glue (audio_init_nb_voices_, TYPE) (struc=
t audio_driver *drv)
         glue (s->nb_hw_voices_, TYPE) =3D max_voices;
     }
=20
-    if (audio_bug (AUDIO_FUNC, !voice_size && max_voices)) {
+    if (audio_bug(__func__, !voice_size && max_voices)) {
         dolog ("drv=3D`%s' voice_size=3D0 max_voices=3D%d\n",
                drv->name, max_voices);
         glue (s->nb_hw_voices_, TYPE) =3D 0;
     }
=20
-    if (audio_bug (AUDIO_FUNC, voice_size && !max_voices)) {
+    if (audio_bug(__func__, voice_size && !max_voices)) {
         dolog ("drv=3D`%s' voice_size=3D%d max_voices=3D0\n",
                drv->name, voice_size);
     }
@@ -77,7 +77,7 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (=
HW *hw)
=20
 static int glue (audio_pcm_hw_alloc_resources_, TYPE) (HW *hw)
 {
-    HWBUF =3D audio_calloc (AUDIO_FUNC, hw->samples, sizeof (struct st_s=
ample));
+    HWBUF =3D audio_calloc(__func__, hw->samples, sizeof(struct st_sampl=
e));
     if (!HWBUF) {
         dolog ("Could not allocate " NAME " buffer (%d samples)\n",
                hw->samples);
@@ -105,7 +105,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE)=
 (SW *sw)
=20
     samples =3D ((int64_t) sw->hw->samples << 32) / sw->ratio;
=20
-    sw->buf =3D audio_calloc (AUDIO_FUNC, samples, sizeof (struct st_sam=
ple));
+    sw->buf =3D audio_calloc(__func__, samples, sizeof(struct st_sample)=
);
     if (!sw->buf) {
         dolog ("Could not allocate buffer for `%s' (%d samples)\n",
                SW_NAME (sw), samples);
@@ -238,17 +238,17 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (stru=
ct audsettings *as)
         return NULL;
     }
=20
-    if (audio_bug (AUDIO_FUNC, !drv)) {
+    if (audio_bug(__func__, !drv)) {
         dolog ("No host audio driver\n");
         return NULL;
     }
=20
-    if (audio_bug (AUDIO_FUNC, !drv->pcm_ops)) {
+    if (audio_bug(__func__, !drv->pcm_ops)) {
         dolog ("Host audio driver without pcm_ops\n");
         return NULL;
     }
=20
-    hw =3D audio_calloc (AUDIO_FUNC, 1, glue (drv->voice_size_, TYPE));
+    hw =3D audio_calloc(__func__, 1, glue(drv->voice_size_, TYPE));
     if (!hw) {
         dolog ("Can not allocate voice `%s' size %d\n",
                drv->name, glue (drv->voice_size_, TYPE));
@@ -266,7 +266,7 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct=
 audsettings *as)
         goto err0;
     }
=20
-    if (audio_bug (AUDIO_FUNC, hw->samples <=3D 0)) {
+    if (audio_bug(__func__, hw->samples <=3D 0)) {
         dolog ("hw->samples=3D%d\n", hw->samples);
         goto err1;
     }
@@ -339,7 +339,7 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) =
(
         hw_as =3D *as;
     }
=20
-    sw =3D audio_calloc (AUDIO_FUNC, 1, sizeof (*sw));
+    sw =3D audio_calloc(__func__, 1, sizeof(*sw));
     if (!sw) {
         dolog ("Could not allocate soft voice `%s' (%zu bytes)\n",
                sw_name ? sw_name : "unknown", sizeof (*sw));
@@ -379,7 +379,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
 void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
 {
     if (sw) {
-        if (audio_bug (AUDIO_FUNC, !card)) {
+        if (audio_bug(__func__, !card)) {
             dolog ("card=3D%p\n", card);
             return;
         }
@@ -399,7 +399,7 @@ SW *glue (AUD_open_, TYPE) (
 {
     AudioState *s =3D &glob_audio_state;
=20
-    if (audio_bug (AUDIO_FUNC, !card || !name || !callback_fn || !as)) {
+    if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
         dolog ("card=3D%p name=3D%p callback_fn=3D%p as=3D%p\n",
                card, name, callback_fn, as);
         goto fail;
@@ -408,12 +408,12 @@ SW *glue (AUD_open_, TYPE) (
     ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
             name, as->freq, as->nchannels, as->fmt);
=20
-    if (audio_bug (AUDIO_FUNC, audio_validate_settings (as))) {
+    if (audio_bug(__func__, audio_validate_settings(as))) {
         audio_print_settings (as);
         goto fail;
     }
=20
-    if (audio_bug (AUDIO_FUNC, !s->drv)) {
+    if (audio_bug(__func__, !s->drv)) {
         dolog ("Can not open `%s' (no host audio driver)\n", name);
         goto fail;
     }
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 516846eb80..bc39cb9b4d 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -543,7 +543,7 @@ static int dsound_run_out (HWVoiceOut *hw, int live)
         }
     }
=20
-    if (audio_bug (AUDIO_FUNC, len < 0 || len > bufsize)) {
+    if (audio_bug(__func__, len < 0 || len > bufsize)) {
         dolog ("len=3D%d bufsize=3D%d old_pos=3D%ld ppos=3D%ld\n",
                len, bufsize, old_pos, ppos);
         return 0;
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 0bf9b5360f..2ab22df2aa 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -344,7 +344,7 @@ struct rate {
  */
 void *st_rate_start (int inrate, int outrate)
 {
-    struct rate *rate =3D audio_calloc (AUDIO_FUNC, 1, sizeof (*rate));
+    struct rate *rate =3D audio_calloc(__func__, 1, sizeof(*rate));
=20
     if (!rate) {
         dolog ("Could not allocate resampler (%zu bytes)\n", sizeof (*ra=
te));
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0edd7ea5fe..a0428881c2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -582,11 +582,9 @@ static int oss_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
     }
=20
     if (!oss->mmapped) {
-        oss->pcm_buf =3D audio_calloc (
-            AUDIO_FUNC,
-            hw->samples,
-            1 << hw->info.shift
-            );
+        oss->pcm_buf =3D audio_calloc(__func__,
+                                    hw->samples,
+                                    1 << hw->info.shift);
         if (!oss->pcm_buf) {
             dolog (
                 "Could not allocate DAC buffer (%d samples, each %d byte=
s)\n",
@@ -705,7 +703,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
     }
=20
     hw->samples =3D (obt.nfrags * obt.fragsize) >> hw->info.shift;
-    oss->pcm_buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->inf=
o.shift);
+    oss->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
     if (!oss->pcm_buf) {
         dolog ("Could not allocate ADC buffer (%d samples, each %d bytes=
)\n",
                hw->samples, 1 << hw->info.shift);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 2a35e6f82c..aa0a7477d3 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -206,7 +206,7 @@ static void *qpa_thread_out (void *arg)
     PAVoiceOut *pa =3D arg;
     HWVoiceOut *hw =3D &pa->hw;
=20
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return NULL;
     }
=20
@@ -222,7 +222,7 @@ static void *qpa_thread_out (void *arg)
                 break;
             }
=20
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
+            if (audio_pt_wait(&pa->pt, __func__)) {
                 goto exit;
             }
         }
@@ -230,7 +230,7 @@ static void *qpa_thread_out (void *arg)
         decr =3D to_mix =3D audio_MIN (pa->live, pa->g->conf.samples >> =
2);
         rpos =3D pa->rpos;
=20
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_unlock(&pa->pt, __func__)) {
             return NULL;
         }
=20
@@ -251,7 +251,7 @@ static void *qpa_thread_out (void *arg)
             to_mix -=3D chunk;
         }
=20
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_lock(&pa->pt, __func__)) {
             return NULL;
         }
=20
@@ -261,7 +261,7 @@ static void *qpa_thread_out (void *arg)
     }
=20
  exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+    audio_pt_unlock(&pa->pt, __func__);
     return NULL;
 }
=20
@@ -270,7 +270,7 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     int decr;
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return 0;
     }
=20
@@ -279,10 +279,10 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     pa->live =3D live - decr;
     hw->rpos =3D pa->rpos;
     if (pa->live > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock_and_signal(&pa->pt, __func__);
     }
     else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock(&pa->pt, __func__);
     }
     return decr;
 }
@@ -298,7 +298,7 @@ static void *qpa_thread_in (void *arg)
     PAVoiceIn *pa =3D arg;
     HWVoiceIn *hw =3D &pa->hw;
=20
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return NULL;
     }
=20
@@ -314,7 +314,7 @@ static void *qpa_thread_in (void *arg)
                 break;
             }
=20
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
+            if (audio_pt_wait(&pa->pt, __func__)) {
                 goto exit;
             }
         }
@@ -322,7 +322,7 @@ static void *qpa_thread_in (void *arg)
         incr =3D to_grab =3D audio_MIN (pa->dead, pa->g->conf.samples >>=
 2);
         wpos =3D pa->wpos;
=20
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_unlock(&pa->pt, __func__)) {
             return NULL;
         }
=20
@@ -342,7 +342,7 @@ static void *qpa_thread_in (void *arg)
             to_grab -=3D chunk;
         }
=20
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_lock(&pa->pt, __func__)) {
             return NULL;
         }
=20
@@ -352,7 +352,7 @@ static void *qpa_thread_in (void *arg)
     }
=20
  exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+    audio_pt_unlock(&pa->pt, __func__);
     return NULL;
 }
=20
@@ -361,7 +361,7 @@ static int qpa_run_in (HWVoiceIn *hw)
     int live, incr, dead;
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return 0;
     }
=20
@@ -372,10 +372,10 @@ static int qpa_run_in (HWVoiceIn *hw)
     pa->dead =3D dead - incr;
     hw->wpos =3D pa->wpos;
     if (pa->dead > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock_and_signal(&pa->pt, __func__);
     }
     else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock(&pa->pt, __func__);
     }
     return incr;
 }
@@ -579,7 +579,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
=20
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D g->conf.samples;
-    pa->pcm_buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info=
.shift);
+    pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
     pa->rpos =3D hw->rpos;
     if (!pa->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
@@ -587,7 +587,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
         goto fail2;
     }
=20
-    if (audio_pt_init (&pa->pt, qpa_thread_out, hw, AUDIO_CAP, AUDIO_FUN=
C)) {
+    if (audio_pt_init(&pa->pt, qpa_thread_out, hw, AUDIO_CAP, __func__))=
 {
         goto fail3;
     }
=20
@@ -636,7 +636,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
=20
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D g->conf.samples;
-    pa->pcm_buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info=
.shift);
+    pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
     pa->wpos =3D hw->wpos;
     if (!pa->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
@@ -644,7 +644,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
         goto fail2;
     }
=20
-    if (audio_pt_init (&pa->pt, qpa_thread_in, hw, AUDIO_CAP, AUDIO_FUNC=
)) {
+    if (audio_pt_init(&pa->pt, qpa_thread_in, hw, AUDIO_CAP, __func__)) =
{
         goto fail3;
     }
=20
@@ -667,17 +667,17 @@ static void qpa_fini_out (HWVoiceOut *hw)
     void *ret;
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
+    audio_pt_lock(&pa->pt, __func__);
     pa->done =3D 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
+    audio_pt_unlock_and_signal(&pa->pt, __func__);
+    audio_pt_join(&pa->pt, &ret, __func__);
=20
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream =3D NULL;
     }
=20
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
+    audio_pt_fini(&pa->pt, __func__);
     g_free (pa->pcm_buf);
     pa->pcm_buf =3D NULL;
 }
@@ -687,17 +687,17 @@ static void qpa_fini_in (HWVoiceIn *hw)
     void *ret;
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
+    audio_pt_lock(&pa->pt, __func__);
     pa->done =3D 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
+    audio_pt_unlock_and_signal(&pa->pt, __func__);
+    audio_pt_join(&pa->pt, &ret, __func__);
=20
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream =3D NULL;
     }
=20
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
+    audio_pt_fini(&pa->pt, __func__);
     g_free (pa->pcm_buf);
     pa->pcm_buf =3D NULL;
 }
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index e8d91d22af..e92135bd2f 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -277,7 +277,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, i=
nt len)
             return;
         }
=20
-        if (audio_bug (AUDIO_FUNC, sdl->live < 0 || sdl->live > hw->samp=
les)) {
+        if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples=
)) {
             dolog ("sdl->live=3D%d hw->samples=3D%d\n",
                    sdl->live, hw->samples);
             return;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 341eec3121..068a595732 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -139,7 +139,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
=20
     hw->samples =3D 1024;
-    wav->pcm_buf =3D audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->inf=
o.shift);
+    wav->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
     if (!wav->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
                hw->samples << hw->info.shift);
--=20
2.13.6
