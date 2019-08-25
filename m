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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E176B20578
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyLhndUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E176B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xYy-0002mP-H6
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXB-00015I-B3
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xX7-0004jP-FS
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:37 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xX6-0004j7-Ur
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:33 -0400
Received: by mail-qt1-x844.google.com with SMTP id j15so15881678qtl.13
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsFbVbnzFgbhGTlJO3RN2ZVezjNNoFZHyoBdxLEeg6E=;
 b=XyLhndUFC0nEnUyomkOtn434lZtq+Jbufz/Nej+PgeUUj1pOhlJVnhgiaUg+QGZ1oT
 qE7ffwtPuruwvMII+LvVwU/fqlRtKKL4SUV6z4w+rFUyf7x54P5+ke3MOcDyluTiswU+
 VJkt723ZKGaPeCkCzHY20aLd5uz+qrbzGrH9vtiUbhE7ZWEMRGeOepThJmKyt7OfJEf6
 sYCre9S+Zn+KCavu+Vdzdlyuoc81SfIpN5MVfxLzhuf1cWfiXan+Py6xhd1vWhdFfF5k
 5p0XnfsXXoBeEbXNKsG4QZ/M6Ut34ra0SQi/mJj0hkCLBbRB3N8W/+b+mAizV9ZG2tZp
 jm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsFbVbnzFgbhGTlJO3RN2ZVezjNNoFZHyoBdxLEeg6E=;
 b=hjw0AHbzbiTGGzWSXc8REgaN+45xTfvpS6poW7cBy9trXrUSkJzM6InWWJ4dOpunvi
 ggcumIx0BHUlSpJnVFivcaQEe/AculDBczXGSP6mHKuZUQYEqyLr9Z6u47xP04QJI6Mr
 5VbKF8J/KpAg2LK0hTjmvgaeNNudBbL7sj9eKp2bbNBmWY2jnCGvVOZPMbiQXvp5suM7
 elqeT/a/l+GyMu5mUeKcGUHT7sd8KnQ3Ezvo0Ee3EEy1ctkH2c/jCXZVooQ9wrAL43T5
 qGa6d2XoonWt4CYVuX2JMiT6LiDA6X2vTyHz1yEfVo7NAz/y0n7owkwhCkejZtEWEIqo
 5q8Q==
X-Gm-Message-State: APjAAAWjXc5kPcrido2AXtpbP3Fthvta4eKMpiyN2iVwZblTcAV1zH9F
 1kmWih3VOK/4oq4kM2ZHrT6STfdggdM=
X-Google-Smtp-Source: APXvYqwLfHK1tksMp2XqbC9hwlthudRVNHMCgZQ7NTHLdFn1qChEGc192vN1fwiGyO8Dv/V4kH9gJA==
X-Received: by 2002:a0c:e1cd:: with SMTP id v13mr12498509qvl.245.1566758792238; 
 Sun, 25 Aug 2019 11:46:32 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:32 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:03 +0200
Message-Id: <cdc0b2dba8d610ed0078e5116ac4f5a5a688d530.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH 01/25] audio: api for mixeng code free backends
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
 audio/audio_int.h      |  41 ++++++--
 audio/audio_template.h |   1 +
 audio/audio.c          | 211 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 245 insertions(+), 8 deletions(-)

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
 
-    int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
-    void (*fini_in) (HWVoiceIn *hw);
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
diff --git a/audio/audio.c b/audio/audio.c
index 7d715332c9..0dfcfeaf06 100644
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
-- 
2.22.0


