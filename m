Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6818FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23439206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qThblphM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23439206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xeg-0001Ho-7P
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXD-00017L-IO
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXB-0004la-Dz
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:39 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:42150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXB-0004kv-8j
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:37 -0400
Received: by mail-qk1-x732.google.com with SMTP id 201so12427519qkm.9
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eMC5GNoz9Tou9bjuYvqH2LwJguvCHeEe4Zoh87uHMy4=;
 b=qThblphM1Fvz3Sz0hY0Aac1dONQ8yfVOahMsZVn4kYui8oxzpNw3bpl2DhRsiRTjH2
 byvRgY4eVXLiAlZAg08RPHfhx4P2ibI2W7Ik9P+8tOcZI+N+fbagTmhvCM1hApagV3cr
 I/dp1wBa0H5J92d8behDHCJTNFxExHhHLsTL4tn4YwlFXctTn4M8aVQ/y5JpfJexiYOx
 1U22JYFvCXS+utV9eszrYyjxpiVCKUlwojWPjl+tgUxMfMdoowRcCiMqRya+eCCSZKzc
 7jFMcGfGd4Z5O9bbf6gpRqkLegdIyY6l1TIQ+W9AdPkoLzF5H/uMZjMfK/zCawlSYJXr
 8rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eMC5GNoz9Tou9bjuYvqH2LwJguvCHeEe4Zoh87uHMy4=;
 b=O/XwuYUE5RKG0WXskHKxG9bucqw7LfXHaHvfyn2OYnyATsHZo6LvXzk2ssvvlvxBzc
 nZfJcDbG3s7vayeaO+7EQcelQfxkIQbReX/55kllcBniZuPRk0zxHZS2EmOO3gWdaqYq
 39sK/D2N3yIMrNj4HolgjdLZurXQfNAtW5VmRQiEW9iIU14liy9+v6Gn1D11uRtMhP0R
 MrG2g+5UVzXkWtk27jTfcZIk+USQhgBdZZ3BoVfJhhl1/a2R+QDVncR1ExxYot9ZcqKh
 x2febo32GhADtuZ92uubWM8Lur5ygQG90VTyDmPpP0Q4FatnRW8K83vk7rnTVeTJ3Z0x
 uDWw==
X-Gm-Message-State: APjAAAWLU2R+cLdyw8eaoCqiZz4Hzm4bjRBidAkuDODKx/S0Ia/AJux6
 XmFK1GC+CkS4ukCZM5TuteiJe1U0/7o=
X-Google-Smtp-Source: APXvYqyGN7VQZ4612UGzhVfCjXULQHdf9x6ttf3odLIOTM2x+yL6Ez4drlZQWo8CNay2aROvjehavQ==
X-Received: by 2002:a37:9bc4:: with SMTP id
 d187mr13256681qke.150.1566758796106; 
 Sun, 25 Aug 2019 11:46:36 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:35 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:06 +0200
Message-Id: <8506c4f128a6f182c9e7fa99f9111021f02c97f5.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::732
Subject: [Qemu-devel] [PATCH 04/25] dsoundaudio: port to the new audio
 backend api
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
 audio/dsound_template.h |  47 +++---
 audio/dsoundaudio.c     | 329 ++++++++++------------------------------
 2 files changed, 103 insertions(+), 273 deletions(-)

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
index 2fc118b795..96693a97e5 100644
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
-    if (audio_bug(__func__, len > bufsize)) {
-        dolog("len=%zu bufsize=%zu old_pos=%ld ppos=%ld\n",
-              len, bufsize, old_pos, ppos);
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
2.22.0


