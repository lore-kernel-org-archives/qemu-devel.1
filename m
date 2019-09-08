Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB4C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720EE216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzq8bdwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720EE216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74nn-0005jA-8u
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dq-0005Or-7H
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dm-0005lz-LW
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:37 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dj-0005jO-9X
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:33 -0400
Received: by mail-qk1-x742.google.com with SMTP id d26so11180243qkk.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wafGSmkLugWXlyLf1f4CvCAyPcCKgKWJOEm04ViOd+M=;
 b=jzq8bdwmNefNTHjdzILrxgYpRh2xVPG0hr3o9SUIclQ01caN1dtd2PtClSSkdyUyY2
 ESmOudNsX2XRgn+EoLMZGzF+HqL6p0lOE6kxflS3A4Q50/WBkYSNksX/YE9SLQQLYoeD
 rnYbcl19Taj11Fa8SK9dTls3ZlRpyz1caTznW+6DOdQUhKQ7ak/EAOAFSo5NVwoDKZD4
 HEaE4rO/4RFS+6sTtpeOrzXUTkmHXxqmvUwD8F2y1mCSYOIWH8amj/lJ+SwYutFzhGvX
 67LFoFbGcGfuhpChSQNCi+oUP3gjFQm1vd1Ln8gLK9rntBd2miXoY02LDVT/TK+ccOoH
 VXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wafGSmkLugWXlyLf1f4CvCAyPcCKgKWJOEm04ViOd+M=;
 b=JJb+bPAaFW/PtvC8eyassKVspf2vratYsKK14b2pNiLP6CGJYXXyVHH1uvie3gryrW
 1LWaN0v59EnSi338Vw94/eWziQN9Y2vok3p7AjM35OOnMfOxY30VviqkahqrAjduvE5w
 6gUhzkfhV0Gk+oYq1EZPv7Sr/9BKEvvDbg0lv1DqPVV6ONmEHLiEhmpF3uaVwkSFvVfb
 ltuat8P4CkVN8185+w9iRsnUjSFtpwEsI1vNDt0u6ZcpIbKtHeoBd3pVTPWmNyt9oEtM
 h5kSZLqyeNk6XFBsBDLghbyDFQpPb9EqgGvqhiXY262Ydrda5NdislVb8yUmomnjrY4D
 f3/A==
X-Gm-Message-State: APjAAAXN+6IzEqBC0OGJknE1+6HfD6cGnVewPZmR7F/v0sflzqRly77U
 LtQ9MO8RQfpKHJu7jyz1XZ3gFBh2
X-Google-Smtp-Source: APXvYqzwPonpZynJIC6xZv5EarDeYhIkZwdrKhmgw29W7bW50+UNdJ9/xZV8bRHIkIH4sHUh0cYW8A==
X-Received: by 2002:a37:aa8b:: with SMTP id
 t133mr18960996qke.406.1567977749148; 
 Sun, 08 Sep 2019 14:22:29 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:28 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:01 +0200
Message-Id: <da2d161cd25b264c2960faa8ac429b2a3c1d3763.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v2 01/24] audio: api for mixeng code free
 backends
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

This will make it possible to skip mixeng with audio playback and
recording, allowing us to free ourselves from the limitations of the
current mixeng (stereo, int64 samples only).  In this case, HW and SW
voices will be essentially the same, for every SW voice we will create
a HW voice, since we can no longer mix multiple voices together.

Some backends expect us to call a function when we have data ready
write()/read() style, while others provide a buffer and expects us to
directly write/read it, so for optimal performance audio_pcm_ops provide
methods for both cases.  Previously backends asked mixeng for more data
in run_out/run_it, now instead mixeng or the frontends will call the
backends, so that's why two sets of functions required.  audio.c
contains glue code between the two styles, so backends only ever have to
implement one style and frontends are free to call whichever is more
convenient for them.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c          | 211 ++++++++++++++++++++++++++++++++++++++++-
 audio/audio_int.h      |  43 +++++++--
 audio/audio_template.h |   1 +
 3 files changed, 246 insertions(+), 9 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index e99fcd0694..f5a5942da9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -573,6 +573,25 @@ size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
     return clipped;
 }
 
+static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t len)
+{
+    size_t clipped = 0;
+    size_t pos = hw->rpos;
+
+    while (len) {
+        st_sample *src = hw->mix_buf + pos;
+        uint8_t *dst = advance(pcm_buf, clipped << hw->info.shift);
+        size_t samples_till_end_of_buf = hw->samples - pos;
+        size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
+
+        hw->clip(dst, src, samples_to_clip);
+
+        pos = (pos + samples_to_clip) % hw->samples;
+        len -= samples_to_clip;
+        clipped += samples_to_clip;
+    }
+}
+
 /*
  * Soft voice (capture)
  */
@@ -1050,6 +1069,31 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
     mixeng_clear(hw->mix_buf, samples - n);
 }
 
+static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
+{
+    size_t clipped = 0;
+
+    while (live) {
+        size_t size, decr, proc;
+        void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
+
+        decr = MIN(size >> hw->info.shift, live);
+        audio_pcm_hw_clip_out2(hw, buf, decr);
+        proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
+            hw->info.shift;
+
+        live -= proc;
+        clipped += proc;
+        hw->rpos = (hw->rpos + proc) % hw->samples;
+
+        if (proc == 0 || proc < decr) {
+            break;
+        }
+    }
+
+    return clipped;
+}
+
 static void audio_run_out (AudioState *s)
 {
     HWVoiceOut *hw = NULL;
@@ -1097,7 +1141,11 @@ static void audio_run_out (AudioState *s)
         }
 
         prev_rpos = hw->rpos;
-        played = hw->pcm_ops->run_out (hw, live);
+        if (hw->pcm_ops->run_out) {
+            played = hw->pcm_ops->run_out(hw, live);
+        } else {
+            played = audio_pcm_hw_run_out(hw, live);
+        }
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
@@ -1156,6 +1204,35 @@ static void audio_run_out (AudioState *s)
     }
 }
 
+static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
+{
+    size_t conv = 0;
+
+    while (samples) {
+        size_t proc;
+        size_t size = samples << hw->info.shift;
+        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
+
+        assert((size & hw->info.align) == 0);
+        if (size == 0) {
+            hw->pcm_ops->put_buffer_in(hw, buf, size);
+            break;
+        }
+
+        proc = MIN(size >> hw->info.shift,
+                   hw->samples - hw->wpos);
+
+        hw->conv(hw->conv_buf + hw->wpos, buf, proc);
+        hw->wpos = (hw->wpos + proc) % hw->samples;
+
+        samples -= proc;
+        conv += proc;
+        hw->pcm_ops->put_buffer_in(hw, buf, proc << hw->info.shift);
+    }
+
+    return conv;
+}
+
 static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
@@ -1165,7 +1242,12 @@ static void audio_run_in (AudioState *s)
         size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
-            captured = hw->pcm_ops->run_in(hw);
+            if (hw->pcm_ops->run_in) {
+                captured = hw->pcm_ops->run_in(hw);
+            } else {
+                captured = audio_pcm_hw_run_in(
+                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
+            }
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
@@ -1259,12 +1341,137 @@ void audio_run(AudioState *s, const char *msg)
 #endif
 }
 
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    ssize_t start;
+
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size = hw->samples << hw->info.shift;
+        hw->buf_emul = g_malloc(calc_size);
+        hw->size_emul = calc_size;
+        hw->pos_emul = hw->pending_emul = 0;
+    }
+
+    while (hw->pending_emul < hw->size_emul) {
+        size_t read_len = MIN(hw->size_emul - hw->pos_emul,
+                              hw->size_emul - hw->pending_emul);
+        size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
+                                        read_len);
+        hw->pending_emul += read;
+        if (read < read_len) {
+            break;
+        }
+    }
+
+    start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+    if (start < 0) {
+        start += hw->size_emul;
+    }
+    assert(start >= 0 && start < hw->size_emul);
+
+    *size = MIN(hw->pending_emul, hw->size_emul - start);
+    return hw->buf_emul + start;
+}
+
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    assert(size <= hw->pending_emul);
+    hw->pending_emul -= size;
+}
+
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size = hw->samples << hw->info.shift;
+
+        hw->buf_emul = g_malloc(calc_size);
+        hw->size_emul = calc_size;
+        hw->pos_emul = hw->pending_emul = 0;
+    }
+
+    *size = MIN(hw->size_emul - hw->pending_emul,
+                hw->size_emul - hw->pos_emul);
+    return hw->buf_emul + hw->pos_emul;
+}
+
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size)
+{
+    assert(buf == hw->buf_emul + hw->pos_emul &&
+           size + hw->pending_emul <= hw->size_emul);
+
+    hw->pending_emul += size;
+    hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
+
+    return size;
+}
+
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    audio_generic_put_buffer_out_nowrite(hw, buf, size);
+
+    while (hw->pending_emul) {
+        size_t write_len, written;
+        ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start += hw->size_emul;
+        }
+        assert(start >= 0 && start < hw->size_emul);
+
+        write_len = MIN(hw->pending_emul, hw->size_emul - start);
+
+        written = hw->pcm_ops->write(hw, hw->buf_emul + start, write_len);
+        hw->pending_emul -= written;
+
+        if (written < write_len) {
+            break;
+        }
+    }
+
+    /*
+     * fake we have written everything. non-written data remain in pending_emul,
+     * so we do not have to clip them multiple times
+     */
+    return size;
+}
+
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
+    copy_size = MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    return hw->pcm_ops->put_buffer_out(hw, buf, copy_size);
+}
+
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst = hw->pcm_ops->get_buffer_in(hw, &dst_size);
+    copy_size = MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    hw->pcm_ops->put_buffer_in(hw, buf, copy_size);
+    return copy_size;
+}
+
+
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
 {
     s->drv_opaque = drv->init(dev);
 
     if (s->drv_opaque) {
+        if (!drv->pcm_ops->get_buffer_in) {
+            drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
+            drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
+        }
+        if (!drv->pcm_ops->get_buffer_out) {
+            drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
+            drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
+        }
+
         audio_init_nb_voices_out(s, drv);
         audio_init_nb_voices_in(s, drv);
         s->drv = drv;
diff --git a/audio/audio_int.h b/audio/audio_int.h
index a674c5374a..8fb1ca8a8d 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -65,6 +65,8 @@ typedef struct HWVoiceOut {
     uint64_t ts_helper;
 
     struct st_sample *mix_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
 
     size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
@@ -87,6 +89,8 @@ typedef struct HWVoiceIn {
     uint64_t ts_helper;
 
     struct st_sample *conv_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
 
     size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
@@ -147,17 +151,42 @@ struct audio_driver {
 };
 
 struct audio_pcm_ops {
-    int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
-    void (*fini_out)(HWVoiceOut *hw);
+    int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
+    void   (*fini_out)(HWVoiceOut *hw);
     size_t (*run_out)(HWVoiceOut *hw, size_t live);
-    int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
-
-    int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
-    void (*fini_in) (HWVoiceIn *hw);
+    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    /*
+     * get a buffer that after later can be passed to put_buffer_out; optional
+     * returns the buffer, and writes it's size to size (in bytes)
+     * this is unrelated to the above buffer_size_out function
+     */
+    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
+    /*
+     * put back the buffer returned by get_buffer_out; optional
+     * buf must be equal the pointer returned by get_buffer_out,
+     * size may be smaller
+     */
+    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
+    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+
+    int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
+    void   (*fini_in) (HWVoiceIn *hw);
     size_t (*run_in)(HWVoiceIn *hw);
-    int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
+    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
+    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
+    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
 
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size);
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
+
 struct capture_callback {
     struct audio_capture_ops ops;
     void *opaque;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 2562bf5f00..ff4a173f18 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -71,6 +71,7 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
 
 static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 {
+    g_free(hw->buf_emul);
     g_free (HWBUF);
     HWBUF = NULL;
 }
-- 
2.23.0


