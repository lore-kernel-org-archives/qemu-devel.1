Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036AC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6F021907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWjKuTLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6F021907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB43Q-0001GG-EJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uh-0002gy-1T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ud-0000YH-S4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3ud-0000XW-H5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r3so4622391wrj.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/3hgkV2+/v9H8hK3ryAoNU2NcM+2uuhTDg4UcFZG3ac=;
 b=dWjKuTLQlpB6JcFQA7WYfoyQOfjFqwdtV6CvIEIRVEU6EcCrDCH6sxh8p0o1ReM7aq
 1jwOazJHWTPX+nLkp0ajgDPa8ddG+ZZVGpnn2vOrdT3aCtjAWn8BAyUtZtMuwMw6IuYk
 j0ssYmIL0KbtgRbxvED2tiiVcsjGiF4bzZwCtK9XxKw+tEzDp6B0SvigejWd/noGes9R
 5jETtcB2ujrGlef7qz8fmUm9KfNevs5ZpFX8NQj2dywQme9hhagvLdgIWVJKBCHtlCfn
 R30m4y5Am1ITO8EA0nQ6tauoycfPadPgqqhKI/gArlFv+gRRT87mCPKJG3pbPJuKWh2O
 JA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/3hgkV2+/v9H8hK3ryAoNU2NcM+2uuhTDg4UcFZG3ac=;
 b=sdsHtlSgjMuIDWosM9N381z94k7tH7eyuhpZpa6DIBVEicccaPKS0lszAjz2vd0dFU
 3XbkD2ntmxJXmU6EDyhCaykGh+G/0hPp5qMO+PykJNsL5WrI6k9tF1fFZTFLRDJZCZHr
 8T+bKXn9LijMJSxFgzLB6DiT++9FX9Bz+dUCizke/wOhAZ5ydC8BgS4PRVFEEBlJh+Em
 SRNaNRAN773JdjlaVN6xs5YsftPFdWkvd14R4A+YyAfyQNLcOQ3Rq8OITJGvJ9+pvxId
 PYE4vm4uzL8AM/0EWnnhfb5NZYBLPL+GfEP/WJaVf8LbW/o1a2VDJLosKszEuZDoIHQp
 renQ==
X-Gm-Message-State: APjAAAVU5h93zW+qdM4nULw4XzBtqClIszZcWFk318ppBFP3IHROm06k
 24VV2Pn3Wq6Wuslm9pEIUXLtwr0A
X-Google-Smtp-Source: APXvYqy5s56OHSphimwqHW4tdmo/IwqgAdTOGi+L3VGwUxWSXdp0xuVf6frIo6KUVb2aykMzTChNvQ==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr8568988wrg.74.1568928265891; 
 Thu, 19 Sep 2019 14:24:25 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:25 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/24] dsoundaudio: port to the new audio backend api
Date: Thu, 19 Sep 2019 23:24:12 +0200
Message-Id: <2ca925ab551ea832c930fc2db213a9e73d8dab7f.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/dsound_template.h |  47 ++++---
 audio/dsoundaudio.c     | 305 +++++++++-------------------------------
 2 files changed, 91 insertions(+), 261 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 8ece870c9e..9f10b688df 100644
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
-        dolog ("DirectSound returned misaligned buffer %ld %ld\n",
-               blen1, blen2);
-        glue (dsound_unlock_, TYPE) (buf, p1, p2, blen1, blen2);
+    if ((p1p && *p1p && (*blen1p & info->align)) ||
+        (p2p && *p2p && (*blen2p & info->align))) {
+        dolog("DirectSound returned misaligned buffer %ld %ld\n",
+              *blen1p, *blen2p);
+        glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p,
+                                   blen2p ? *blen2p : 0);
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
index 2fc118b795..9960247814 100644
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
-    HRESULT hr;
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
-
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
+    HRESULT hr;
+    DWORD ppos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
 
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
+    hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get playback buffer position\n");
+        *size = 0;
+        return NULL;
     }
-    else {
-        if (ds->old_pos == ppos) {
-#ifdef DEBUG_DSOUND
-            dolog ("old_pos == ppos\n");
-#endif
-            return 0;
-        }
 
-#ifdef DEBUG_DSOUND
-        ds->played += audio_ring_dist (ds->old_pos, ppos, hw->bufsize);
-#endif
-        old_pos = ds->old_pos;
-    }
+    req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
+    req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
-    if ((old_pos < ppos) && ((old_pos + len) > ppos)) {
-        len = ppos - old_pos;
-    }
-    else {
-        if ((old_pos > ppos) && ((old_pos + len) > (ppos + bufsize))) {
-            len = bufsize - old_pos + ppos;
-        }
+    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
+                          &act_size, NULL, false, ds->s);
+    if (err) {
+        dolog("Failed to lock buffer\n");
+        *size = 0;
+        return NULL;
     }
 
-    if (audio_bug(__func__, len > bufsize)) {
-        dolog("len=%zu bufsize=%zu old_pos=%ld ppos=%ld\n",
-              len, bufsize, old_pos, ppos);
-        return 0;
-    }
+    *size = act_size;
+    return ret;
+}
 
-    len &= ~hw->info.align;
-    if (!len) {
-        return 0;
-    }
+static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
+{
+    DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
+    LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
+    int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
 
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
-    HRESULT hr;
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
-
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
+    HRESULT hr;
+    DWORD cpos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
 
-    if (cpos & hw->info.align) {
-        ldebug ("warning: Misaligned capture position %ld(%d)\n",
-                cpos, hw->info.align);
+    hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get capture buffer position\n");
+        *size = 0;
+        return NULL;
     }
-    cpos >>= hwshift;
 
-    len = audio_ring_dist (cpos, hw->wpos, hw->samples);
-    if (!len) {
-        return 0;
-    }
-    len = MIN (len, dead);
+    req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
+    req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
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
+    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
+                         &act_size, NULL, false, ds->s);
     if (err) {
-        return 0;
+        dolog("Failed to lock buffer\n");
+        *size = 0;
+        return NULL;
     }
 
-    len1 = blen1 >> hwshift;
-    len2 = blen2 >> hwshift;
-    decr = len1 + len2;
+    *size = act_size;
+    return ret;
+}
 
-    if (p1 && len1) {
-        hw->conv (hw->conv_buf + hw->wpos, p1, len1);
-    }
+static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
+{
+    DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
+    LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
+    int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
 
-    if (p2 && len2) {
-        hw->conv (hw->conv_buf, p2, len2);
+    if (err) {
+        dolog("Failed to unlock buffer!!\n");
+        return;
     }
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
2.23.0


