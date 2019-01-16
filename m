Received: from eggs.gnu.org ([209.51.188.92]:58148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul3-0004M2-BB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukx-0003GA-WC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjuku-00036U-1Z
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:57 -0500
Received: by mail-wr1-x442.google.com with SMTP id u4so8967667wrp.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:52 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:01 +0100
Message-Id: <49e0438fd738f019fa5b96941afe40ff247b132e.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 28/50] coreaudio: port to the new audio
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
 audio/coreaudio.c | 130 ++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 646aea06a0..e32c5b62fd 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,9 +43,6 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
-    size_t live;
-    size_t decr;
-    size_t rpos;
 } coreaudioVoiceOut;
 
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6
@@ -397,31 +394,29 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, const char *fn_name)
     return 0;
 }
 
-static size_t coreaudio_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
-
-    if (coreaudio_lock (core, "coreaudio_run_out")) {
-        return 0;
+#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
+    static ret_type glue(coreaudio_, name)args_decl             \
+    {                                                           \
+        coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;     \
+        ret_type ret;                                           \
+                                                                \
+        if (coreaudio_lock(core, "coreaudio_" #name)) {         \
+            return 0;                                           \
+        }                                                       \
+                                                                \
+        ret = glue(audio_generic_, name)args;                   \
+                                                                \
+        coreaudio_unlock(core, "coreaudio_" #name);             \
+        return ret;                                             \
     }
-
-    if (core->decr > live) {
-        ldebug ("core->decr %d live %d core->live %d\n",
-                core->decr,
-                live,
-                core->live);
-    }
-
-    decr = MIN (core->decr, live);
-    core->decr -= decr;
-
-    core->live = live - decr;
-    hw->rpos = core->rpos;
-
-    coreaudio_unlock (core, "coreaudio_run_out");
-    return decr;
-}
+COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
+                       (hw, size))
+COREAUDIO_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+                       (HWVoiceOut *hw, void *buf, size_t size),
+                       (hw, buf, size))
+COREAUDIO_WRAPPER_FUNC(write, size_t, (HWVoiceOut *hw, void *buf, size_t size),
+                       (hw, buf, size))
+#undef COREAUDIO_WRAPPER_FUNC
 
 /* callback to feed audiooutput buffer */
 static OSStatus audioDeviceIOProc(
@@ -433,19 +428,11 @@ static OSStatus audioDeviceIOProc(
     const AudioTimeStamp* inOutputTime,
     void* hwptr)
 {
-    UInt32 frame, frameCount;
-    float *out = outOutputData->mBuffers[0].mData;
+    UInt32 frameCount, pending_frames;
+    void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
-    int rpos, live;
-    struct st_sample *src;
-#ifndef FLOAT_MIXENG
-#ifdef RECIPROCAL
-    const float scale = 1.f / UINT_MAX;
-#else
-    const float scale = UINT_MAX;
-#endif
-#endif
+    size_t len;
 
     if (coreaudio_lock (core, "audioDeviceIOProc")) {
         inInputTime = 0;
@@ -453,42 +440,51 @@ static OSStatus audioDeviceIOProc(
     }
 
     frameCount = core->audioDevicePropertyBufferFrameSize;
-    live = core->live;
+    pending_frames = hw->pending_emul >> hw->info.shift;
 
     /* if there are not enough samples, set signal and return */
-    if (live < frameCount) {
+    if (pending_frames < frameCount) {
         inInputTime = 0;
         coreaudio_unlock (core, "audioDeviceIOProc(empty)");
         return 0;
     }
 
-    rpos = core->rpos;
-    src = hw->mix_buf + rpos;
+    len = frameCount << hw->info.shift;
+    while (len) {
+        size_t write_len;
+        ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start += hw->size_emul;
+        }
+        assert(start >= 0 && start < hw->size_emul);
 
-    /* fill buffer */
-    for (frame = 0; frame < frameCount; frame++) {
-#ifdef FLOAT_MIXENG
-        *out++ = src[frame].l; /* left channel */
-        *out++ = src[frame].r; /* right channel */
-#else
-#ifdef RECIPROCAL
-        *out++ = src[frame].l * scale; /* left channel */
-        *out++ = src[frame].r * scale; /* right channel */
-#else
-        *out++ = src[frame].l / scale; /* left channel */
-        *out++ = src[frame].r / scale; /* right channel */
-#endif
-#endif
+        write_len = MIN(MIN(hw->pending_emul, len),
+                        hw->size_emul - start);
+
+        memcpy(out, hw->buf_emul + start, write_len);
+        hw->pending_emul -= write_len;
+        len -= write_len;
+        out += write_len;
     }
 
-    rpos = (rpos + frameCount) % hw->samples;
-    core->decr += frameCount;
-    core->rpos = rpos;
-
     coreaudio_unlock (core, "audioDeviceIOProc");
     return 0;
 }
 
+static UInt32 coreaudio_get_flags(struct audio_pcm_info *info,
+                                  struct audsettings *as)
+{
+    UInt32 flags = info->sign ? kAudioFormatFlagIsSignedInteger : 0;
+    if (as->endianness) { /* 0 = little, 1 = big */
+        flags |= kAudioFormatFlagIsBigEndian;
+    }
+
+    if (flags == 0) { /* must not be 0 */
+        flags = kAudioFormatFlagsAreAllClear;
+    }
+    return flags;
+}
+
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -576,6 +572,16 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     /* set Samplerate */
     core->outputStreamBasicDescription.mSampleRate = (Float64) as->freq;
+    core->outputStreamBasicDescription.mFormatID = kAudioFormatLinearPCM;
+    core->outputStreamBasicDescription.mFormatFlags =
+        coreaudio_get_flags(&hw->info, as);
+    core->outputStreamBasicDescription.mBytesPerPacket =
+        core->outputStreamBasicDescription.mBytesPerFrame =
+        hw->info.nchannels * hw->info.bits / 8;
+    core->outputStreamBasicDescription.mFramesPerPacket = 1;
+    core->outputStreamBasicDescription.mChannelsPerFrame = hw->info.nchannels;
+    core->outputStreamBasicDescription.mBitsPerChannel = hw->info.bits;
+
     status = coreaudio_set_streamformat(core->outputDeviceID,
                                         &core->outputStreamBasicDescription);
     if (status != kAudioHardwareNoError) {
@@ -686,7 +692,9 @@ static void coreaudio_audio_fini (void *opaque)
 static struct audio_pcm_ops coreaudio_pcm_ops = {
     .init_out = coreaudio_init_out,
     .fini_out = coreaudio_fini_out,
-    .run_out  = coreaudio_run_out,
+    .write    = coreaudio_write,
+    .get_buffer_out = coreaudio_get_buffer_out,
+    .put_buffer_out = coreaudio_put_buffer_out_nowrite,
     .ctl_out  = coreaudio_ctl_out
 };
 
-- 
2.20.1
