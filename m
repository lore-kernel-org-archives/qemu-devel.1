Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6585C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1AD20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpDlm6aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1AD20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aJf-0000i4-Bt
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7d-0005y6-4b
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7b-0001xK-Ih
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:45 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7b-0001xC-CG
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:43 -0400
Received: by mail-ed1-x541.google.com with SMTP id g12so5559714eds.6
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P1Yx/dZ4rieO/0gJLGQ3xdgMx3pyBcyEnZuiP7yaO78=;
 b=SpDlm6aOx60ZNNYoMDHN0RdDvqSzLV1SkAYsoj8AiEFeBrzcH/Gl/bP7ujTQMX77lT
 fsP8CPUmI0XQKn41svTMOgqEocJxaQTbMty1w3D1nzt2x+pK9PsOawsl7ALaYbh3Xw0s
 mNkitxr4E2UZIOGeHhptbDFIJh9e6TAHduLwqOum7gzC/W3H4cJT9k/WrZYf05isQtI4
 pv9ZC0BtYvb/a+yJ+8goIZX4q8fQoOKsb6Mu75e7vStdQhMsgI0BydPDXkmVOiD31nTY
 Uxu4rF0oQWT4I/uMmXbFW4MyMwqNFx6Jx2O9ggBnSGmJGtZyVSU15sGH2v+pVmyH0AtW
 BJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P1Yx/dZ4rieO/0gJLGQ3xdgMx3pyBcyEnZuiP7yaO78=;
 b=aKoE5z60ncTT6o+xW0+daT055iuOp5colFAYpkecnMXTc9WC9ikro88skRhasQhvsr
 gsnqP25Ep6DkrvkTsANn9pZxLr4u2F2TXfcc8zwCXez5+cGELkzMNQQ2dr07Ci+CL8p1
 so+QOJeMn04LbTw0ShXNda9Qlf/1gfoTyaYhAJHQGw2M9OSkeQ0bjmLS88HGh7ANc5jG
 l+oVDYc91rsCN04WGgvdu53YjyJjxg1uH49ZIsQSkHaQrFFkx9gGl+ZUin5SpWzp0iW3
 I2QZRJKgKWcPrmrGyzEFpxRhy5yj1X0DOTl/SfIvaJdNRtWMU7WTKT2z1qL/1OzZ8mpH
 uPDA==
X-Gm-Message-State: APjAAAVrHwE8y6c7Z7DZUKlW9mvr8Z26LpEm1EibJmTXs8SZXL+5kIU2
 gS5Jr50UWcacnYRi6YXcEV+bGIVV
X-Google-Smtp-Source: APXvYqwMIaJRN2CztljPdRwO77ENwMB9297JKVM3XB41K13/StznmXHvqyoNuF2WG8jGLr+9a7tVCA==
X-Received: by 2002:a17:906:81d9:: with SMTP id
 e25mr48463538ejx.37.1568575421769; 
 Sun, 15 Sep 2019 12:23:41 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:41 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:19 +0200
Message-Id: <60d68c051ed180c7315f7cdd6084b58b6fc9bb6d.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: [Qemu-devel] [PATCH v3 03/24] coreaudio: port to the new audio
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
 audio/coreaudio.c | 130 ++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index d1be58b40a..5cde42f982 100644
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
-    }
+        write_len = MIN(MIN(hw->pending_emul, len),
+                        hw->size_emul - start);
 
-    rpos = (rpos + frameCount) % hw->samples;
-    core->decr += frameCount;
-    core->rpos = rpos;
+        memcpy(out, hw->buf_emul + start, write_len);
+        hw->pending_emul -= write_len;
+        len -= write_len;
+        out += write_len;
+    }
 
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
2.23.0


