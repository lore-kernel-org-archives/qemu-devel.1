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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1AC4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0D4216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+579QBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D4216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74tG-0002nY-Iw
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dt-0005SE-Ti
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dq-0005nq-Le
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:41 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74do-0005m9-9R
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:37 -0400
Received: by mail-qt1-x843.google.com with SMTP id g13so13418228qtj.4
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y7iHNMJr/K6vEM5IKPVSAJe6YZjvyzTOTmHMWROPW74=;
 b=g+579QBZnvGvE5/CXnkPJO0JS1CSt+g4pelOO9MBryqv8cdK/MriXk8WP123VS7LjC
 IkX7v83mQtibP1wxSmfCmHvdH3rU3d01nVNEvTw8uQCLKPicBRJgSL79HDRTR0p9meSJ
 xzLA7rkxAUnKjRE4xrL75OEmg+XirMl8Y5HH6WSqJgNHMNWpPI9wqqonOi2z2F3lcAKu
 ggTdJjw9y2WbffNvC/TFe5Vdo/YMR1Da1E1uGmQ6tPEEpXEAbsvhHAKHZ9OqX3uo+mnx
 2xqUBYfpjNibSTRhZIXsEj7+/czXfJvJ5EoQdholBGC74TkUcNZVffoU0aR+KjPX8DEa
 ZgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y7iHNMJr/K6vEM5IKPVSAJe6YZjvyzTOTmHMWROPW74=;
 b=ctKIq1I0eHeRWjVZeyDBcjcYNdOGViwK63ZyOGQ07nyx6SG+RIBka7rC74MKqW8Xja
 rZ6RskKP0oYU4UyhG1pMn5Z2AgMf1OZLpG3wiZnnQP2CJENlb4x9OpnHdi6Mh49Rd24y
 3TySYDeQ7GgDwoZ5G7V5jhDaPjcUzeACQ6qwgHZJwu0PRrF8EAQ9llgamex29efVyVJx
 zVr7/qrYL+AC27ofYW4E6nvKSNNGuklozt8wIg712RStYrd4vqR216iN17yHHDBKGz5F
 T6zljvbl5Rw8MT2/oMbwSHfEf1pARQi3myKA2lPtG1xlNrfRrvEa5Pg+yZep4upA8kuX
 H1Gg==
X-Gm-Message-State: APjAAAWNKvCqr8xfS5H23iqwJSYEaZtE28DubbpzeVt22Y5RX9gB7dyx
 astKwhIc3HrWzso69CqU+5YPMRWz
X-Google-Smtp-Source: APXvYqzyf1o7tH1x2ehU8kDdAy+bDoDSQtu2zeSLm0lX1AZDUqxey0IaIvIjmGdk+CZcRSbgr5YMBA==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr19222964qtm.312.1567977754246; 
 Sun, 08 Sep 2019 14:22:34 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:34 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:06 +0200
Message-Id: <caa2b1e42f3d033c2cabf7d47f07c408eb9434ab.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v2 06/24] ossaudio: port to the new audio
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
 audio/ossaudio.c | 272 +++++++++++++++++------------------------------
 1 file changed, 96 insertions(+), 176 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 1696933688..2782512706 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -40,19 +40,15 @@
 
 typedef struct OSSVoiceOut {
     HWVoiceOut hw;
-    void *pcm_buf;
     int fd;
-    int wpos;
     int nfrags;
     int fragsize;
     int mmapped;
-    int pending;
     Audiodev *dev;
 } OSSVoiceOut;
 
 typedef struct OSSVoiceIn {
     HWVoiceIn hw;
-    void *pcm_buf;
     int fd;
     int nfrags;
     int fragsize;
@@ -371,98 +367,87 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
     return -1;
 }
 
-static void oss_write_pending (OSSVoiceOut *oss)
+static size_t oss_get_available_bytes(OSSVoiceOut *oss)
 {
-    HWVoiceOut *hw = &oss->hw;
+    int err;
+    struct count_info cntinfo;
+    assert(oss->mmapped);
 
-    if (oss->mmapped) {
-        return;
+    err = ioctl(oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
+    if (err < 0) {
+        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed\n");
+        return 0;
     }
 
-    while (oss->pending) {
-        int samples_written;
-        ssize_t bytes_written;
-        int samples_till_end = hw->samples - oss->wpos;
-        int samples_to_write = MIN (oss->pending, samples_till_end);
-        int bytes_to_write = samples_to_write << hw->info.shift;
-        void *pcm = advance (oss->pcm_buf, oss->wpos << hw->info.shift);
+    return audio_ring_dist(cntinfo.ptr, oss->hw.pos_emul, oss->hw.size_emul);
+}
 
-        bytes_written = write (oss->fd, pcm, bytes_to_write);
-        if (bytes_written < 0) {
-            if (errno != EAGAIN) {
-                oss_logerr (errno, "failed to write %d bytes\n",
-                            bytes_to_write);
-            }
-            break;
-        }
+static void *oss_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    if (oss->mmapped) {
+        *size = MIN(oss_get_available_bytes(oss), hw->size_emul - hw->pos_emul);
+        return hw->buf_emul + hw->pos_emul;
+    } else {
+        return audio_generic_get_buffer_out(hw, size);
+    }
+}
 
-        if (bytes_written & hw->info.align) {
-            dolog ("misaligned write asked for %d, but got %zd\n",
-                   bytes_to_write, bytes_written);
-            return;
-        }
+static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    if (oss->mmapped) {
+        assert(buf == hw->buf_emul + hw->pos_emul && size < hw->size_emul);
 
-        samples_written = bytes_written >> hw->info.shift;
-        oss->pending -= samples_written;
-        oss->wpos = (oss->wpos + samples_written) % hw->samples;
-        if (bytes_written - bytes_to_write) {
-            break;
-        }
+        hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
+        return size;
+    } else {
+        return audio_generic_put_buffer_out(hw, buf, size);
     }
 }
 
-static size_t oss_run_out(HWVoiceOut *hw, size_t live)
+static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
-    int err;
-    size_t decr;
-    struct audio_buf_info abinfo;
-    struct count_info cntinfo;
-    size_t bufsize;
-
-    bufsize = hw->samples << hw->info.shift;
+    size_t pos;
 
     if (oss->mmapped) {
-        int bytes, pos;
+        size_t total_len;
+        len = MIN(len, oss_get_available_bytes(oss));
 
-        err = ioctl (oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
-        }
+        total_len = len;
+        while (len) {
+            size_t to_copy = MIN(len, hw->size_emul - hw->pos_emul);
+            memcpy(hw->buf_emul + hw->pos_emul, buf, to_copy);
 
-        pos = hw->rpos << hw->info.shift;
-        bytes = audio_ring_dist (cntinfo.ptr, pos, bufsize);
-        decr = MIN (bytes >> hw->info.shift, live);
-    }
-    else {
-        err = ioctl (oss->fd, SNDCTL_DSP_GETOSPACE, &abinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
+            hw->pos_emul = (hw->pos_emul + to_copy) % hw->pos_emul;
+            buf += to_copy;
+            len -= to_copy;
         }
+        return total_len;
+    }
 
-        if (abinfo.bytes > bufsize) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            abinfo.bytes = bufsize;
-        }
+    pos = 0;
+    while (len) {
+        ssize_t bytes_written;
+        void *pcm = advance(buf, pos);
 
-        if (abinfo.bytes < 0) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            return 0;
+        bytes_written = write(oss->fd, pcm, len);
+        if (bytes_written < 0) {
+            if (errno != EAGAIN) {
+                oss_logerr(errno, "failed to write %zu bytes\n",
+                           len);
+            }
+            return pos;
         }
 
-        decr = MIN (abinfo.bytes >> hw->info.shift, live);
-        if (!decr) {
-            return 0;
+        pos += bytes_written;
+        if (bytes_written < len) {
+            break;
         }
+        len -= bytes_written;
     }
-
-    decr = audio_pcm_hw_clip_out (hw, oss->pcm_buf, decr, oss->pending);
-    oss->pending += decr;
-    oss_write_pending (oss);
-
-    return decr;
+    return pos;
 }
 
 static void oss_fini_out (HWVoiceOut *hw)
@@ -473,18 +458,13 @@ static void oss_fini_out (HWVoiceOut *hw)
     ldebug ("oss_fini\n");
     oss_anal_close (&oss->fd);
 
-    if (oss->pcm_buf) {
-        if (oss->mmapped) {
-            err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
-            if (err) {
-                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
-                           oss->pcm_buf, hw->samples << hw->info.shift);
-            }
-        }
-        else {
-            g_free (oss->pcm_buf);
+    if (oss->mmapped && hw->buf_emul) {
+        err = munmap(hw->buf_emul, hw->size_emul);
+        if (err) {
+            oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+                       hw->buf_emul, hw->size_emul);
         }
-        oss->pcm_buf = NULL;
+        hw->buf_emul = NULL;
     }
 }
 
@@ -535,19 +515,20 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     oss->mmapped = 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        oss->pcm_buf = mmap (
+        hw->size_emul = hw->samples << hw->info.shift;
+        hw->buf_emul = mmap(
             NULL,
-            hw->samples << hw->info.shift,
+            hw->size_emul,
             PROT_READ | PROT_WRITE,
             MAP_SHARED,
             fd,
             0
             );
-        if (oss->pcm_buf == MAP_FAILED) {
+        if (hw->buf_emul == MAP_FAILED) {
             oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
-                       hw->samples << hw->info.shift);
-        }
-        else {
+                       hw->size_emul);
+            hw->buf_emul = NULL;
+        } else {
             int err;
             int trig = 0;
             if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
@@ -567,30 +548,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
             }
 
             if (!oss->mmapped) {
-                err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
+                err = munmap(hw->buf_emul, hw->size_emul);
                 if (err) {
                     oss_logerr(errno, "Failed to unmap buffer %p size %zu\n",
-                               oss->pcm_buf, hw->samples << hw->info.shift);
+                               hw->buf_emul, hw->size_emul);
                 }
+                hw->buf_emul = NULL;
             }
         }
     }
 
-    if (!oss->mmapped) {
-        oss->pcm_buf = audio_calloc(__func__,
-                                    hw->samples,
-                                    1 << hw->info.shift);
-        if (!oss->pcm_buf) {
-            dolog (
-                "Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
-                hw->samples,
-                1 << hw->info.shift
-                );
-            oss_anal_close (&fd);
-            return -1;
-        }
-    }
-
     oss->fd = fd;
     oss->dev = dev;
     return 0;
@@ -618,7 +585,7 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
 
-            audio_pcm_info_clear_buf (&hw->info, oss->pcm_buf, hw->samples);
+            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
             trig = PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
@@ -692,13 +659,6 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
-    oss->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!oss->pcm_buf) {
-        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
-              hw->samples, 1 << hw->info.shift);
-        oss_anal_close (&fd);
-        return -1;
-    }
 
     oss->fd = fd;
     oss->dev = dev;
@@ -710,78 +670,36 @@ static void oss_fini_in (HWVoiceIn *hw)
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
 
     oss_anal_close (&oss->fd);
-
-    g_free(oss->pcm_buf);
-    oss->pcm_buf = NULL;
 }
 
-static size_t oss_run_in(HWVoiceIn *hw)
+static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
-    int hwshift = hw->info.shift;
-    int i;
-    size_t live = audio_pcm_hw_get_live_in (hw);
-    size_t dead = hw->samples - live;
-    size_t read_samples = 0;
-    struct {
-        size_t add;
-        size_t len;
-    } bufs[2] = {
-        { .add = hw->wpos, .len = 0 },
-        { .add = 0,        .len = 0 }
-    };
-
-    if (!dead) {
-        return 0;
-    }
-
-    if (hw->wpos + dead > hw->samples) {
-        bufs[0].len = (hw->samples - hw->wpos) << hwshift;
-        bufs[1].len = (dead - (hw->samples - hw->wpos)) << hwshift;
-    }
-    else {
-        bufs[0].len = dead << hwshift;
-    }
+    size_t pos = 0;
 
-    for (i = 0; i < 2; ++i) {
+    while (len) {
         ssize_t nread;
 
-        if (bufs[i].len) {
-            void *p = advance (oss->pcm_buf, bufs[i].add << hwshift);
-            nread = read (oss->fd, p, bufs[i].len);
-
-            if (nread > 0) {
-                if (nread & hw->info.align) {
-                    dolog("warning: Misaligned read %zd (requested %zu), "
-                          "alignment %d\n", nread, bufs[i].add << hwshift,
-                          hw->info.align + 1);
-                }
-                read_samples += nread >> hwshift;
-                hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshift);
-            }
+        void *dst = advance(buf, pos);
+        nread = read(oss->fd, dst, len);
 
-            if (bufs[i].len - nread) {
-                if (nread == -1) {
-                    switch (errno) {
-                    case EINTR:
-                    case EAGAIN:
-                        break;
-                    default:
-                        oss_logerr(
-                            errno,
-                            "Failed to read %zu bytes of audio (to %p)\n",
-                            bufs[i].len, p
-                            );
-                        break;
-                    }
-                }
+        if (nread == -1) {
+            switch (errno) {
+            case EINTR:
+            case EAGAIN:
+                break;
+            default:
+                oss_logerr(errno, "Failed to read %zu bytes of audio (to %p)\n",
+                           len, dst);
                 break;
             }
         }
+
+        pos += nread;
+        len -= nread;
     }
 
-    hw->wpos = (hw->wpos + read_samples) % hw->samples;
-    return read_samples;
+    return pos;
 }
 
 static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -845,12 +763,14 @@ static void oss_audio_fini (void *opaque)
 static struct audio_pcm_ops oss_pcm_ops = {
     .init_out = oss_init_out,
     .fini_out = oss_fini_out,
-    .run_out  = oss_run_out,
+    .write    = oss_write,
+    .get_buffer_out = oss_get_buffer_out,
+    .put_buffer_out = oss_put_buffer_out,
     .ctl_out  = oss_ctl_out,
 
     .init_in  = oss_init_in,
     .fini_in  = oss_fini_in,
-    .run_in   = oss_run_in,
+    .read     = oss_read,
     .ctl_in   = oss_ctl_in
 };
 
-- 
2.23.0


