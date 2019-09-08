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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB12C4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5720921907
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcChDqJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5720921907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74gG-0007Bd-Nu
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dq-0005Op-5b
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dm-0005mB-O1
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:37 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dl-0005kR-Al
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:33 -0400
Received: by mail-qt1-x844.google.com with SMTP id j10so13799321qtp.8
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P1Yx/dZ4rieO/0gJLGQ3xdgMx3pyBcyEnZuiP7yaO78=;
 b=gcChDqJxRVfycP6KDb41yNEmL+C9AteDt5VX5SI11waqW+cxPmrdGRZpUD2NynG5S4
 pyQ8ibhbS7+LK2V7R+z9gq0fGqqvL/7UJOp5IFc1oMqN4OvERflRzVPp3YP5Fwtes4VP
 x55XPLErtTR5XJPjHCRKuARud4/mm1M5B3DKiMg1zaMdsm2ngNoyQVMVVJAuh34rS86X
 l0hs3hIw1JPRwamxu2i4cFn78BNr5PK2vWMOqu8MMI5Biakl4DqDRK9DmWwMZTWsr07X
 NLoZQpGTG/aENN58RK30NGHky7HtISWTpW1YAWjxgv2gMCrkjDS6/jvtUna3Hkm6OXRb
 k76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P1Yx/dZ4rieO/0gJLGQ3xdgMx3pyBcyEnZuiP7yaO78=;
 b=jTZD9aQ/MUFyCXLRVZFawfiiZrasjPD0sWCtOg/wtzUD7ADeK9Rtj+e+wAO0ZVaozI
 BIftZwJiqoI21yo0NAOlMWnU9CdLVifpx8Aq/G6FZecfSh6CMMFYzoJwWiJ/Z7sH24D0
 QQR9Y1q2li+yHdk1BQXOX1PD+zcfYy1jrS95fZCs7+/f8rrPznRebdVgBtlVarLj3Hoj
 0mhxJrwE6e1Q+/dTFN8XBKmJM45NgmUw4MC2fkvQoRsHMFlUNOuQKPnhvzHauXr+iFKR
 KvDNwcSY8irAG6JzdtZkQp6yLdGU2NuHIq//L8Z9Ejdprg/ZUXVWn56YE23CC+ymvrk0
 N+KA==
X-Gm-Message-State: APjAAAW9AFuvi9CaYQP0li426A0onB9ZjLTbSYv11yk2KdM+97KPAU2V
 zwAaejY8X1T/nNuL98cEafMfA2XA
X-Google-Smtp-Source: APXvYqwt98odPSHTjaIx9p4s9l9uAWYjvipU3QZvKOedJt6K2igOPXJKLM9Rrag3CUA93POXdRtpjQ==
X-Received: by 2002:ac8:5458:: with SMTP id d24mr19529919qtq.54.1567977751303; 
 Sun, 08 Sep 2019 14:22:31 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:31 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:03 +0200
Message-Id: <8f5919244f4edf49abacc0de8c8e133ebda570fd.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v2 03/24] coreaudio: port to the new audio
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


