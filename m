Received: from eggs.gnu.org ([209.51.188.92]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul9-0004RG-Nr
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Sz-Qn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul4-00039l-EV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so9004925wrr.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:54 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:04 +0100
Message-Id: <c499257d4223bc814d45e175b9c4c51adb30e305.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 31/50] ossaudio: port to the new audio
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
 audio/ossaudio.c | 288 +++++++++++++++++------------------------------
 1 file changed, 104 insertions(+), 184 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c6d4086573..774a41fbf9 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -39,19 +39,15 @@
 
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
@@ -370,98 +366,87 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
     return -1;
 }
 
-static void oss_write_pending (OSSVoiceOut *oss)
+static size_t oss_get_available_bytes(OSSVoiceOut *oss)
 {
-    HWVoiceOut *hw = &oss->hw;
+    int err;
+    struct count_info cntinfo;
+    assert(oss->mmapped);
 
+    err = ioctl (oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
+    if (err < 0) {
+        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed\n");
+        return 0;
+    }
+
+    return audio_ring_dist(cntinfo.ptr, oss->hw.pos_emul, oss->hw.size_emul);
+}
+
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
+
+static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     if (oss->mmapped) {
-        return;
+        assert(buf == hw->buf_emul + hw->pos_emul && size < hw->size_emul);
+
+        hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
+        return size;
+    } else {
+        return audio_generic_put_buffer_out(hw, buf, size);
+    }
+}
+
+static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    size_t pos;
+
+    if (oss->mmapped) {
+        size_t total_len;
+        len = MIN(len, oss_get_available_bytes(oss));
+
+        total_len = len;
+        while (len) {
+            size_t to_copy = MIN(len, hw->size_emul - hw->pos_emul);
+            memcpy(hw->buf_emul + hw->pos_emul, buf, to_copy);
+
+            hw->pos_emul = (hw->pos_emul + to_copy) % hw->pos_emul;
+            buf += to_copy;
+            len -= to_copy;
+        }
+        return total_len;
     }
 
-    while (oss->pending) {
-        int samples_written;
+    pos = 0;
+    while (len) {
         ssize_t bytes_written;
-        int samples_till_end = hw->samples - oss->wpos;
-        int samples_to_write = MIN (oss->pending, samples_till_end);
-        int bytes_to_write = samples_to_write << hw->info.shift;
-        void *pcm = advance (oss->pcm_buf, oss->wpos << hw->info.shift);
+        void *pcm = advance(buf, pos);
 
-        bytes_written = write (oss->fd, pcm, bytes_to_write);
+        bytes_written = write(oss->fd, pcm, len);
         if (bytes_written < 0) {
             if (errno != EAGAIN) {
-                oss_logerr (errno, "failed to write %d bytes\n",
-                            bytes_to_write);
+                oss_logerr(errno, "failed to write %zu bytes\n",
+                           len);
             }
-            break;
-        }
-
-        if (bytes_written & hw->info.align) {
-            dolog ("misaligned write asked for %d, but got %zd\n",
-                   bytes_to_write, bytes_written);
-            return;
+            return pos;
         }
 
-        samples_written = bytes_written >> hw->info.shift;
-        oss->pending -= samples_written;
-        oss->wpos = (oss->wpos + samples_written) % hw->samples;
-        if (bytes_written - bytes_to_write) {
+        pos += bytes_written;
+        if (bytes_written < len) {
             break;
         }
+        len -= bytes_written;
     }
-}
-
-static size_t oss_run_out(HWVoiceOut *hw, size_t live)
-{
-    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
-    int err;
-    size_t decr;
-    struct audio_buf_info abinfo;
-    struct count_info cntinfo;
-    size_t bufsize;
-
-    bufsize = hw->samples << hw->info.shift;
-
-    if (oss->mmapped) {
-        int bytes, pos;
-
-        err = ioctl (oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
-        }
-
-        pos = hw->rpos << hw->info.shift;
-        bytes = audio_ring_dist (cntinfo.ptr, pos, bufsize);
-        decr = MIN (bytes >> hw->info.shift, live);
-    }
-    else {
-        err = ioctl (oss->fd, SNDCTL_DSP_GETOSPACE, &abinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
-        }
-
-        if (abinfo.bytes > bufsize) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            abinfo.bytes = bufsize;
-        }
-
-        if (abinfo.bytes < 0) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            return 0;
-        }
-
-        decr = MIN (abinfo.bytes >> hw->info.shift, live);
-        if (!decr) {
-            return 0;
-        }
-    }
-
-    decr = audio_pcm_hw_clip_out (hw, oss->pcm_buf, decr, oss->pending);
-    oss->pending += decr;
-    oss_write_pending (oss);
-
-    return decr;
+    return pos;
 }
 
 static void oss_fini_out (HWVoiceOut *hw)
@@ -472,18 +457,13 @@ static void oss_fini_out (HWVoiceOut *hw)
     ldebug ("oss_fini\n");
     oss_anal_close (&oss->fd);
 
-    if (oss->pcm_buf) {
-        if (oss->mmapped) {
-            err = munmap (oss->pcm_buf, hw->samples << hw->info.shift);
-            if (err) {
-                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
-                           oss->pcm_buf, hw->samples << hw->info.shift);
-            }
+    if (oss->mmapped && hw->buf_emul) {
+        err = munmap(hw->buf_emul, hw->size_emul);
+        if (err) {
+            oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+                       hw->buf_emul, hw->size_emul);
         }
-        else {
-            g_free (oss->pcm_buf);
-        }
-        oss->pcm_buf = NULL;
+        hw->buf_emul = NULL;
     }
 }
 
@@ -534,19 +514,20 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     oss->mmapped = 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        oss->pcm_buf = mmap (
+        hw->size_emul = hw->samples << hw->info.shift;
+        hw->buf_emul = mmap (
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
@@ -566,30 +547,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
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
@@ -617,7 +584,7 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
 
-            audio_pcm_info_clear_buf (&hw->info, oss->pcm_buf, hw->samples);
+            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
             trig = PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
@@ -691,13 +658,6 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
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
@@ -709,78 +669,36 @@ static void oss_fini_in (HWVoiceIn *hw)
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
+    size_t pos = 0;
 
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
-
-    for (i = 0; i < 2; ++i) {
+    while (len) {
         ssize_t nread;
 
-        if (bufs[i].len) {
-            void *p = advance (oss->pcm_buf, bufs[i].add << hwshift);
-            nread = read (oss->fd, p, bufs[i].len);
+        void *dst = advance(buf, pos);
+        nread = read(oss->fd, dst, len);
 
-            if (nread > 0) {
-                if (nread & hw->info.align) {
-                    dolog("warning: Misaligned read %zd (requested %zu), "
-                          "alignment %d\n", nread, bufs[i].add << hwshift,
-                          hw->info.align + 1);
-                }
-                read_samples += nread >> hwshift;
-                hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshift);
-            }
-
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
@@ -850,12 +768,14 @@ static void oss_audio_fini (void *opaque)
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
2.20.1
