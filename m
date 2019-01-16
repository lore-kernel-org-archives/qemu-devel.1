Received: from eggs.gnu.org ([209.51.188.92]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul9-0004RD-MM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003SC-Jd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul4-00037m-4a
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id m22so3886383wml.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:53 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:02 +0100
Message-Id: <2c553c7af6354961d100d7be7f8ea221cfdad243.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 29/50] dsoundaudio: port to the new audio
 backend api
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
 audio/dsound_template.h |  45 +++---
 audio/dsoundaudio.c     | 329 ++++++++++------------------------------
 2 files changed, 102 insertions(+), 272 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 96181efb36..ff5a1f85fd 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -29,6 +29,8 @@
 #define BUFPTR LPDIRECTSOUNDCAPTUREBUFFER
 #define FIELD dsound_capture_buffer
 #define FIELD2 dsound_capture
+#define HWVOICE HWVoiceIn
+#define DSOUNDVOICE DSoundVoiceIn
 #else
 #define NAME "playback buffer"
 #define NAME2 "DirectSound"
@@ -37,6 +39,8 @@
 #define BUFPTR LPDIRECTSOUNDBUFFER
 #define FIELD dsound_buffer
 #define FIELD2 dsound
+#define HWVOICE HWVoiceOut
+#define DSOUNDVOICE DSoundVoiceOut
 #endif
 
 static int glue (dsound_unlock_, TYPE) (
@@ -72,8 +76,6 @@ static int glue (dsound_lock_, TYPE) (
     )
 {
     HRESULT hr;
-    LPVOID p1 = NULL, p2 = NULL;
-    DWORD blen1 = 0, blen2 = 0;
     DWORD flag;
 
 #ifdef DSBTYPE_IN
@@ -81,7 +83,7 @@ static int glue (dsound_lock_, TYPE) (
 #else
     flag = entire ? DSBLOCK_ENTIREBUFFER : 0;
 #endif
-    hr = glue(IFACE, _Lock)(buf, pos, len, &p1, &blen1, &p2, &blen2, flag);
+    hr = glue(IFACE, _Lock)(buf, pos, len, p1p, blen1p, p2p, blen2p, flag);
 
     if (FAILED (hr)) {
 #ifndef DSBTYPE_IN
@@ -96,34 +98,34 @@ static int glue (dsound_lock_, TYPE) (
         goto fail;
     }
 
-    if ((p1 && (blen1 & info->align)) || (p2 && (blen2 & info->align))) {
+    if ((p1p && *p1p && (*blen1p & info->align)) ||
+        (p2p && *p2p && (*blen2p & info->align))) {
         dolog ("DirectSound returned misaligned buffer %ld %ld\n",
-               blen1, blen2);
-        glue (dsound_unlock_, TYPE) (buf, p1, p2, blen1, blen2);
+               *blen1p, *blen2p);
+        glue (dsound_unlock_, TYPE) (buf, *p1p, p2p ? *p2p : NULL, *blen1p,
+                                     blen2p ? *blen2p : 0);
         goto fail;
     }
 
-    if (!p1 && blen1) {
-        dolog ("warning: !p1 && blen1=%ld\n", blen1);
-        blen1 = 0;
+    if (p1p && !*p1p && *blen1p) {
+        dolog("warning: !p1 && blen1=%ld\n", *blen1p);
+        *blen1p = 0;
     }
 
-    if (!p2 && blen2) {
-        dolog ("warning: !p2 && blen2=%ld\n", blen2);
-        blen2 = 0;
+    if (p2p && !*p2p && *blen2p) {
+        dolog("warning: !p2 && blen2=%ld\n", *blen2p);
+        *blen2p = 0;
     }
 
-    *p1p = p1;
-    *p2p = p2;
-    *blen1p = blen1;
-    *blen2p = blen2;
     return 0;
 
  fail:
     *p1p = NULL - 1;
-    *p2p = NULL - 1;
     *blen1p = -1;
-    *blen2p = -1;
+    if (p2p) {
+        *p2p = NULL - 1;
+        *blen2p = -1;
+    }
     return -1;
 }
 
@@ -242,7 +244,6 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
         goto fail0;
     }
 
-    ds->first_time = 1;
     obt_as.endianness = 0;
     audio_pcm_init_info (&hw->info, &obt_as);
 
@@ -252,15 +253,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
             bc.dwBufferBytes, hw->info.align + 1
             );
     }
+    hw->size_emul = bc.dwBufferBytes;
     hw->samples = bc.dwBufferBytes >> hw->info.shift;
     ds->s = s;
 
 #ifdef DEBUG_DSOUND
     dolog ("caps %ld, desc %ld\n",
            bc.dwBufferBytes, bd.dwBufferBytes);
-
-    dolog ("bufsize %d, freq %d, chan %d, fmt %d\n",
-           hw->bufsize, settings.freq, settings.nchannels, settings.fmt);
 #endif
     return 0;
 
@@ -276,3 +275,5 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
 #undef BUFPTR
 #undef FIELD
 #undef FIELD2
+#undef HWVOICE
+#undef DSOUNDVOICE
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 906cca3235..951152ecea 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -53,19 +53,11 @@ typedef struct {
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
-    DWORD old_pos;
-    int first_time;
     dsound *s;
-#ifdef DEBUG_DSOUND
-    DWORD old_ppos;
-    DWORD played;
-    DWORD mixed;
-#endif
 } DSoundVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
-    int first_time;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
     dsound *s;
 } DSoundVoiceIn;
@@ -243,11 +235,6 @@ static void GCC_FMT_ATTR (3, 4) dsound_logerr2 (
     dsound_log_hresult (hr);
 }
 
-static uint64_t usecs_to_bytes(struct audio_pcm_info *info, uint32_t usecs)
-{
-    return muldiv64(usecs, info->bytes_per_second, 1000000);
-}
-
 #ifdef DEBUG_DSOUND
 static void print_wave_format (WAVEFORMATEX *wfx)
 {
@@ -312,33 +299,6 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUREBUFFER dscb,
     return 0;
 }
 
-static void dsound_write_sample (HWVoiceOut *hw, uint8_t *dst, int dst_len)
-{
-    int src_len1 = dst_len;
-    int src_len2 = 0;
-    int pos = hw->rpos + dst_len;
-    struct st_sample *src1 = hw->mix_buf + hw->rpos;
-    struct st_sample *src2 = NULL;
-
-    if (pos > hw->samples) {
-        src_len1 = hw->samples - hw->rpos;
-        src2 = hw->mix_buf;
-        src_len2 = dst_len - src_len1;
-        pos = src_len2;
-    }
-
-    if (src_len1) {
-        hw->clip (dst, src1, src_len1);
-    }
-
-    if (src_len2) {
-        dst = advance (dst, src_len1 << hw->info.shift);
-        hw->clip (dst, src2, src_len2);
-    }
-
-    hw->rpos = pos % hw->samples;
-}
-
 static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
                                  dsound *s)
 {
@@ -350,7 +310,7 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
         dsb,
         &hw->info,
         0,
-        hw->samples << hw->info.shift,
+        hw->size_emul,
         &p1, &p2,
         &blen1, &blen2,
         1,
@@ -454,139 +414,51 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static size_t dsound_run_out(HWVoiceOut *hw, size_t live)
+static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
-    int err;
+    DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
+    LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
     HRESULT hr;
+    DWORD ppos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
+
+    hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get playback buffer position\n");
+        *size = 0;
+        return NULL;
+    }
+
+    req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
+    req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
+
+    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
+                          &act_size, NULL, false, ds->s);
+    if (err) {
+        dolog("Failed to lock buffer\n");
+        *size = 0;
+        return NULL;
+    }
+
+    *size = act_size;
+    return ret;
+}
+
+static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
+{
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
-    size_t len;
-    int hwshift;
-    DWORD blen1, blen2;
-    DWORD len1, len2;
-    DWORD decr;
-    DWORD wpos, ppos, old_pos;
-    LPVOID p1, p2;
-    size_t bufsize;
-    dsound *s = ds->s;
-    AudiodevDsoundOptions *dso = &s->dev->u.dsound;
+    int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
 
-    if (!dsb) {
-        dolog ("Attempt to run empty with playback buffer\n");
-        return 0;
-    }
-
-    hwshift = hw->info.shift;
-    bufsize = hw->samples << hwshift;
-
-    hr = IDirectSoundBuffer_GetCurrentPosition (
-        dsb,
-        &ppos,
-        ds->first_time ? &wpos : NULL
-        );
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get playback buffer position\n");
-        return 0;
-    }
-
-    len = live << hwshift;
-
-    if (ds->first_time) {
-        if (dso->latency) {
-            DWORD cur_blat;
-
-            cur_blat = audio_ring_dist (wpos, ppos, bufsize);
-            ds->first_time = 0;
-            old_pos = wpos;
-            old_pos +=
-                usecs_to_bytes(&hw->info, dso->latency) - cur_blat;
-            old_pos %= bufsize;
-            old_pos &= ~hw->info.align;
-        }
-        else {
-            old_pos = wpos;
-        }
-#ifdef DEBUG_DSOUND
-        ds->played = 0;
-        ds->mixed = 0;
-#endif
-    }
-    else {
-        if (ds->old_pos == ppos) {
-#ifdef DEBUG_DSOUND
-            dolog ("old_pos == ppos\n");
-#endif
-            return 0;
-        }
-
-#ifdef DEBUG_DSOUND
-        ds->played += audio_ring_dist (ds->old_pos, ppos, hw->bufsize);
-#endif
-        old_pos = ds->old_pos;
-    }
-
-    if ((old_pos < ppos) && ((old_pos + len) > ppos)) {
-        len = ppos - old_pos;
-    }
-    else {
-        if ((old_pos > ppos) && ((old_pos + len) > (ppos + bufsize))) {
-            len = bufsize - old_pos + ppos;
-        }
-    }
-
-    if (audio_bug(__func__, len < 0 || len > bufsize)) {
-        dolog ("len=%d bufsize=%d old_pos=%ld ppos=%ld\n",
-               len, bufsize, old_pos, ppos);
-        return 0;
-    }
-
-    len &= ~hw->info.align;
-    if (!len) {
-        return 0;
-    }
-
-#ifdef DEBUG_DSOUND
-    ds->old_ppos = ppos;
-#endif
-    err = dsound_lock_out (
-        dsb,
-        &hw->info,
-        old_pos,
-        len,
-        &p1, &p2,
-        &blen1, &blen2,
-        0,
-        s
-        );
     if (err) {
+        dolog("Failed to unlock buffer!!\n");
         return 0;
     }
+    hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
 
-    len1 = blen1 >> hwshift;
-    len2 = blen2 >> hwshift;
-    decr = len1 + len2;
-
-    if (p1 && len1) {
-        dsound_write_sample (hw, p1, len1);
-    }
-
-    if (p2 && len2) {
-        dsound_write_sample (hw, p2, len2);
-    }
-
-    dsound_unlock_out (dsb, p1, p2, blen1, blen2);
-    ds->old_pos = (old_pos + (decr << hwshift)) % bufsize;
-
-#ifdef DEBUG_DSOUND
-    ds->mixed += decr << hwshift;
-
-    dolog ("played %lu mixed %lu diff %ld sec %f\n",
-           ds->played,
-           ds->mixed,
-           ds->mixed - ds->played,
-           abs (ds->mixed - ds->played) / (double) hw->info.bytes_per_second);
-#endif
-    return decr;
+    return len;
 }
 
 static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -641,96 +513,49 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static size_t dsound_run_in(HWVoiceIn *hw)
+static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
 {
-    int err;
+    DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
+    LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
     HRESULT hr;
+    DWORD cpos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
+n
+    hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get capture buffer position\n");
+        *size = 0;
+        return NULL;
+    }
+
+    req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
+    req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
+
+    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
+                         &act_size, NULL, false, ds->s);
+    if (err) {
+        dolog("Failed to lock buffer\n");
+        *size = 0;
+        return NULL;
+    }
+
+    *size = act_size;
+    return ret;
+}
+
+static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
+{
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
-    size_t live, len, dead;
-    DWORD blen1, blen2;
-    DWORD len1, len2;
-    DWORD decr;
-    DWORD cpos, rpos;
-    LPVOID p1, p2;
-    int hwshift;
-    dsound *s = ds->s;
+    int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
 
-    if (!dscb) {
-        dolog ("Attempt to run without capture buffer\n");
-        return 0;
-    }
-
-    hwshift = hw->info.shift;
-
-    live = audio_pcm_hw_get_live_in (hw);
-    dead = hw->samples - live;
-    if (!dead) {
-        return 0;
-    }
-
-    hr = IDirectSoundCaptureBuffer_GetCurrentPosition (
-        dscb,
-        &cpos,
-        ds->first_time ? &rpos : NULL
-        );
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get capture buffer position\n");
-        return 0;
-    }
-
-    if (ds->first_time) {
-        ds->first_time = 0;
-        if (rpos & hw->info.align) {
-            ldebug ("warning: Misaligned capture read position %ld(%d)\n",
-                    rpos, hw->info.align);
-        }
-        hw->wpos = rpos >> hwshift;
-    }
-
-    if (cpos & hw->info.align) {
-        ldebug ("warning: Misaligned capture position %ld(%d)\n",
-                cpos, hw->info.align);
-    }
-    cpos >>= hwshift;
-
-    len = audio_ring_dist (cpos, hw->wpos, hw->samples);
-    if (!len) {
-        return 0;
-    }
-    len = MIN (len, dead);
-
-    err = dsound_lock_in (
-        dscb,
-        &hw->info,
-        hw->wpos << hwshift,
-        len << hwshift,
-        &p1,
-        &p2,
-        &blen1,
-        &blen2,
-        0,
-        s
-        );
     if (err) {
-        return 0;
+        dolog("Failed to unlock buffer!!\n");
+        return;
     }
-
-    len1 = blen1 >> hwshift;
-    len2 = blen2 >> hwshift;
-    decr = len1 + len2;
-
-    if (p1 && len1) {
-        hw->conv (hw->conv_buf + hw->wpos, p1, len1);
-    }
-
-    if (p2 && len2) {
-        hw->conv (hw->conv_buf, p2, len2);
-    }
-
-    dsound_unlock_in (dscb, p1, p2, blen1, blen2);
-    hw->wpos = (hw->wpos + decr) % hw->samples;
-    return decr;
+    hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
 }
 
 static void dsound_audio_fini (void *opaque)
@@ -846,12 +671,16 @@ static void *dsound_audio_init(Audiodev *dev)
 static struct audio_pcm_ops dsound_pcm_ops = {
     .init_out = dsound_init_out,
     .fini_out = dsound_fini_out,
-    .run_out  = dsound_run_out,
+    .write    = audio_generic_write,
+    .get_buffer_out = dsound_get_buffer_out,
+    .put_buffer_out = dsound_put_buffer_out,
     .ctl_out  = dsound_ctl_out,
 
     .init_in  = dsound_init_in,
     .fini_in  = dsound_fini_in,
-    .run_in   = dsound_run_in,
+    .read     = audio_generic_read,
+    .get_buffer_in = dsound_get_buffer_in,
+    .put_buffer_in = dsound_put_buffer_in,
     .ctl_in   = dsound_ctl_in
 };
 
-- 
2.20.1
