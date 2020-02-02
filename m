Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D0C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4732920658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPwQEA3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4732920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyL5F-0005Ls-9r
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 14:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyL4P-0004rq-GN
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyL4N-0001v2-6I
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:38:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iyL4M-0001rs-Qr
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 14:38:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id a6so15206208wrx.12
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5uF21rjYrP780LLyW9f0A0qZ+P+uAmT32UoBQPcGbiY=;
 b=cPwQEA3zcbMCYRELQyCiUq+pnWLGv9gWUpOjMRn9cC/++JGdgbt59+rPNrpaqGiwND
 EY7w6vxjOtCUjO9iU8KkSMkha11lC4SE++gy0l4KBWjVSnkequPQ2lOxNcQhpIwBv26H
 oWq4sbyLsv6nbhQDbFDWJh4RNx3Y9uWtIuSoZLpb6pVDWwd/DgQNmqjsiOUV9AXmykau
 PzbyoVGVbO9i32g2AI+bnojh5qYA+NGbc2MCtw1eaB77Vh6J5T5GWIXjJlsmg0IjXZCD
 oAJVUaZHHko5Kj9lBGvrXbYYz/lUbT6+mNGH8vAILf6RJxpWFRzS8Pg2fQ9cQPWWHfAx
 Dc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5uF21rjYrP780LLyW9f0A0qZ+P+uAmT32UoBQPcGbiY=;
 b=VJVBAm6I5/veBLQVRYbgjgpm55N4LE065ERlMJKUNfvycnvpZ61KOaVMktGrPwMW6w
 BURDfhYtEIBWoN5I6qQ9f7S1rYvBC0UZkthSSmKDt7vjsN6k1Q9VXx2nlYrZEySum1Tv
 MaR0GT6KLKXgyz0KZaE994q2Zo4Xqht84YlTWe30N2c8dyfhnHBzEOWflsawUATxuUlM
 Il5hZ0Cmy7jm8q5xHmUI9ESsN3W9SFiKkjYwNOByd6hdZ/u6opO0KuRx19ZkEwOLGU/f
 jCJYbMdP5HSj0z60t/ORsxVGK8tLOW07YWZnZg69ABtM9PlwIXfpGqedYW2Ef+NgouH9
 R8Og==
X-Gm-Message-State: APjAAAVDIG3MgoxsIymkUhqrpfpT+8XjR7zeu8Kng7Tdplhu7ZajKvAl
 vLFj/tNgZQD3fT1LiV0B7+kYknC5
X-Google-Smtp-Source: APXvYqwjvfkikoOGCesvuPlG8k83711XqhoZtZAQLMAUWnadwJg7YViFL45DN6/XupGHS3kuyfmgnw==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr12025699wrr.204.1580672288838; 
 Sun, 02 Feb 2020 11:38:08 -0800 (PST)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-48e2-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:48e2::5])
 by smtp.gmail.com with ESMTPSA id i204sm21159978wma.44.2020.02.02.11.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 11:38:08 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] audio: proper support for float samples in mixeng
Date: Sun,  2 Feb 2020 20:38:07 +0100
Message-Id: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds proper support for float samples in mixeng by adding a new
audio format for it.

Limitations: only native endianness is supported.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

This patch is meant to be applied on top of "[PATCH] coreaudio: fix coreaudio
playback" by Volker Rümelin, available at:
https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00114.html

For more information, please refer to that thread.

---
 qapi/audio.json        |  2 +-
 audio/audio_int.h      |  3 +-
 audio/audio_template.h | 41 ++++++++++++--------
 audio/mixeng.h         |  8 ++--
 audio/alsaaudio.c      | 17 ++++++++
 audio/audio.c          | 56 ++++++++++++++++++---------
 audio/coreaudio.c      |  7 +---
 audio/mixeng.c         | 88 ++++++++++++++++++++++++++----------------
 audio/paaudio.c        |  9 +++++
 audio/sdlaudio.c       | 28 ++++++++++++++
 10 files changed, 180 insertions(+), 79 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 83312b2339..d8c507cced 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -276,7 +276,7 @@
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
-  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
+  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
 
 ##
 # @AudiodevDriver:
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5ba2078346..cd92e48163 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -40,7 +40,8 @@ struct audio_callback {
 
 struct audio_pcm_info {
     int bits;
-    int sign;
+    bool is_signed;
+    bool is_float;
     int freq;
     int nchannels;
     int bytes_per_frame;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 0336d2670c..7013d3041f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -153,15 +153,23 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     sw->ratio = ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
 #endif
 
+    if (sw->info.is_float) {
 #ifdef DAC
-    sw->conv = mixeng_conv
+        sw->conv = mixeng_conv_float[sw->info.nchannels == 2];
 #else
-    sw->clip = mixeng_clip
+        sw->clip = mixeng_clip_float[sw->info.nchannels == 2];
 #endif
-        [sw->info.nchannels == 2]
-        [sw->info.sign]
-        [sw->info.swap_endianness]
-        [audio_bits_to_index (sw->info.bits)];
+    } else {
+#ifdef DAC
+        sw->conv = mixeng_conv
+#else
+        sw->clip = mixeng_clip
+#endif
+            [sw->info.nchannels == 2]
+            [sw->info.is_signed]
+            [sw->info.swap_endianness]
+            [audio_bits_to_index(sw->info.bits)];
+    }
 
     sw->name = g_strdup (name);
     err = glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
@@ -276,22 +284,23 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
         goto err1;
     }
 
-    if (s->dev->driver == AUDIODEV_DRIVER_COREAUDIO) {
+    if (hw->info.is_float) {
 #ifdef DAC
-        hw->clip = clip_natural_float_from_stereo;
+        hw->clip = mixeng_clip_float[hw->info.nchannels == 2];
 #else
-        hw->conv = conv_natural_float_to_stereo;
+        hw->conv = mixeng_conv_float[hw->info.nchannels == 2];
 #endif
-    } else
+    } else {
 #ifdef DAC
-    hw->clip = mixeng_clip
+        hw->clip = mixeng_clip
 #else
-    hw->conv = mixeng_conv
+        hw->conv = mixeng_conv
 #endif
-        [hw->info.nchannels == 2]
-        [hw->info.sign]
-        [hw->info.swap_endianness]
-        [audio_bits_to_index (hw->info.bits)];
+            [hw->info.nchannels == 2]
+            [hw->info.is_signed]
+            [hw->info.swap_endianness]
+            [audio_bits_to_index(hw->info.bits)];
+    }
 
     glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
 
diff --git a/audio/mixeng.h b/audio/mixeng.h
index 7ef61763e8..2dcd6df245 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -38,13 +38,13 @@ typedef struct st_sample st_sample;
 typedef void (t_sample) (struct st_sample *dst, const void *src, int samples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
 
+/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
-                                  int samples);
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src,
-                                    int samples);
+/* indices: [stereo] */
+extern t_sample *mixeng_conv_float[2];
+extern f_sample *mixeng_clip_float[2];
 
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index f37ce1ce85..768b896a93 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -307,6 +307,13 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
             return SND_PCM_FORMAT_U32_LE;
         }
 
+    case AUDIO_FORMAT_F32:
+        if (endianness) {
+            return SND_PCM_FORMAT_FLOAT_BE;
+        } else {
+            return SND_PCM_FORMAT_FLOAT_LE;
+        }
+
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
 #ifdef DEBUG_AUDIO
@@ -370,6 +377,16 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
         *fmt = AUDIO_FORMAT_U32;
         break;
 
+    case SND_PCM_FORMAT_FLOAT_LE:
+        *endianness = 0;
+        *fmt = AUDIO_FORMAT_F32;
+        break;
+
+    case SND_PCM_FORMAT_FLOAT_BE:
+        *endianness = 1;
+        *fmt = AUDIO_FORMAT_F32;
+        break;
+
     default:
         dolog ("Unrecognized audio format %d\n", alsafmt);
         return -1;
diff --git a/audio/audio.c b/audio/audio.c
index f63f39769a..53fdb42ec7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -218,6 +218,9 @@ static void audio_print_settings (struct audsettings *as)
     case AUDIO_FORMAT_U32:
         AUD_log (NULL, "U32");
         break;
+    case AUDIO_FORMAT_F32:
+        AUD_log (NULL, "F32");
+        break;
     default:
         AUD_log (NULL, "invalid(%d)", as->fmt);
         break;
@@ -252,6 +255,7 @@ static int audio_validate_settings (struct audsettings *as)
     case AUDIO_FORMAT_U16:
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
+    case AUDIO_FORMAT_F32:
         break;
     default:
         invalid = 1;
@@ -264,24 +268,28 @@ static int audio_validate_settings (struct audsettings *as)
 
 static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *as)
 {
-    int bits = 8, sign = 0;
+    int bits = 8;
+    bool is_signed = false, is_float = false;
 
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U8:
         break;
 
     case AUDIO_FORMAT_S16:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits = 16;
         break;
 
+    case AUDIO_FORMAT_F32:
+        is_float = true;
+        /* fall through */
     case AUDIO_FORMAT_S32:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits = 32;
@@ -292,33 +300,38 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
     }
     return info->freq == as->freq
         && info->nchannels == as->nchannels
-        && info->sign == sign
+        && info->is_signed == is_signed
+        && info->is_float == is_float
         && info->bits == bits
         && info->swap_endianness == (as->endianness != AUDIO_HOST_ENDIANNESS);
 }
 
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
 {
-    int bits = 8, sign = 0, mul;
+    int bits = 8, mul;
+    bool is_signed = false, is_float = false;
 
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U8:
         mul = 1;
         break;
 
     case AUDIO_FORMAT_S16:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits = 16;
         mul = 2;
         break;
 
+    case AUDIO_FORMAT_F32:
+        is_float = true;
+        /* fall through */
     case AUDIO_FORMAT_S32:
-        sign = 1;
+        is_signed = true;
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits = 32;
@@ -331,7 +344,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
 
     info->freq = as->freq;
     info->bits = bits;
-    info->sign = sign;
+    info->is_signed = is_signed;
+    info->is_float = is_float;
     info->nchannels = as->nchannels;
     info->bytes_per_frame = as->nchannels * mul;
     info->bytes_per_second = info->freq * info->bytes_per_frame;
@@ -344,7 +358,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
         return;
     }
 
-    if (info->sign) {
+    if (info->is_signed || info->is_float) {
         memset(buf, 0x00, len * info->bytes_per_frame);
     }
     else {
@@ -770,8 +784,9 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
 #ifdef DEBUG_AUDIO
 static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 {
-    dolog ("%s: bits %d, sign %d, freq %d, nchan %d\n",
-           cap, info->bits, info->sign, info->freq, info->nchannels);
+    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
+          cap, info->bits, info->is_signed, info->is_float, info->freq,
+          info->nchannels);
 }
 #endif
 
@@ -1837,11 +1852,15 @@ CaptureVoiceOut *AUD_add_capture(
 
         cap->buf = g_malloc0_n(hw->mix_buf->size, hw->info.bytes_per_frame);
 
-        hw->clip = mixeng_clip
-            [hw->info.nchannels == 2]
-            [hw->info.sign]
-            [hw->info.swap_endianness]
-            [audio_bits_to_index (hw->info.bits)];
+        if (hw->info.is_float) {
+            hw->clip = mixeng_clip_float[hw->info.nchannels == 2];
+        } else {
+            hw->clip = mixeng_clip
+                [hw->info.nchannels == 2]
+                [hw->info.is_signed]
+                [hw->info.swap_endianness]
+                [audio_bits_to_index(hw->info.bits)];
+        }
 
         QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
@@ -2080,6 +2099,7 @@ int audioformat_bytes_per_sample(AudioFormat fmt)
 
     case AUDIO_FORMAT_U32:
     case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_F32:
         return 4;
 
     case AUDIO_FORMAT__MAX:
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 0049db97fa..f1a009610c 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -491,14 +491,9 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
-    /*
-     * The canonical audio format for CoreAudio on macOS is float. Currently
-     * there is no generic code for AUDIO_FORMAT_F32 in qemu. Here we select
-     * AUDIO_FORMAT_S32 instead because only the sample size has to match.
-     */
     fake_as = *as;
     as = &fake_as;
-    as->fmt = AUDIO_FORMAT_S32;
+    as->fmt = AUDIO_FORMAT_F32;
     audio_pcm_init_info (&hw->info, as);
 
     status = coreaudio_get_voice(&core->outputDeviceID);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 16b646d48c..c14b0d874c 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,55 +267,77 @@ f_sample *mixeng_clip[2][2][2][3] = {
     }
 };
 
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
-                                  int samples)
+#ifdef FLOAT_MIXENG
+#define FLOAT_CONV_TO(x) (x)
+#define FLOAT_CONV_FROM(x) (x)
+#else
+static const float float_scale = UINT_MAX;
+#define FLOAT_CONV_TO(x) ((x) * float_scale)
+
+#ifdef RECIPROCAL
+static const float float_scale_reciprocal = 1.f / UINT_MAX;
+#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)
+#else
+#define FLOAT_CONV_FROM(x) ((x) / float_scale)
+#endif
+#endif
+
+static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
+                                       int samples)
 {
     float *in = (float *)src;
-#ifndef FLOAT_MIXENG
-    const float scale = UINT_MAX;
-#endif
 
     while (samples--) {
-#ifdef FLOAT_MIXENG
-        dst->l = *in++;
-        dst->r = *in++;
-#else
-        dst->l = *in++ * scale;
-        dst->r = *in++ * scale;
-#endif
+        dst->r = dst->l = FLOAT_CONV_TO(*in++);
+        dst++;
+    }
+}
+
+static void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
+                                         int samples)
+{
+    float *in = (float *)src;
+
+    while (samples--) {
+        dst->l = FLOAT_CONV_TO(*in++);
+        dst->r = FLOAT_CONV_TO(*in++);
         dst++;
     }
 }
 
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src,
-                                    int samples)
+t_sample *mixeng_conv_float[2] = {
+    conv_natural_float_to_mono,
+    conv_natural_float_to_stereo,
+};
+
+static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
+                                         int samples)
 {
     float *out = (float *)dst;
-#ifndef FLOAT_MIXENG
-#ifdef RECIPROCAL
-    const float scale = 1.f / UINT_MAX;
-#else
-    const float scale = UINT_MAX;
-#endif
-#endif
 
     while (samples--) {
-#ifdef FLOAT_MIXENG
-        *out++ = src->l;
-        *out++ = src->r;
-#else
-#ifdef RECIPROCAL
-        *out++ = src->l * scale;
-        *out++ = src->r * scale;
-#else
-        *out++ = src->l / scale;
-        *out++ = src->r / scale;
-#endif
-#endif
+        *out++ = FLOAT_CONV_FROM(src->l) + FLOAT_CONV_FROM(src->r);
+        src++;
+    }
+}
+
+static void clip_natural_float_from_stereo(
+    void *dst, const struct st_sample *src, int samples)
+{
+    float *out = (float *)dst;
+
+    while (samples--) {
+        *out++ = FLOAT_CONV_FROM(src->l);
+        *out++ = FLOAT_CONV_FROM(src->r);
         src++;
     }
 }
 
+f_sample *mixeng_clip_float[2] = {
+    clip_natural_float_from_mono,
+    clip_natural_float_from_stereo,
+};
+
 void audio_sample_to_uint64(void *samples, int pos,
                             uint64_t *left, uint64_t *right)
 {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index dbfe48c03a..1278c5a775 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -279,6 +279,9 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
     case AUDIO_FORMAT_U32:
         format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
         break;
+    case AUDIO_FORMAT_F32:
+        format = endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
+        break;
     default:
         dolog ("Internal logic error: Bad audio format %d\n", afmt);
         format = PA_SAMPLE_U8;
@@ -304,6 +307,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
     case PA_SAMPLE_S32LE:
         *endianness = 0;
         return AUDIO_FORMAT_S32;
+    case PA_SAMPLE_FLOAT32BE:
+        *endianness = 1;
+        return AUDIO_FORMAT_F32;
+    case PA_SAMPLE_FLOAT32LE:
+        *endianness = 0;
+        return AUDIO_FORMAT_F32;
     default:
         dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
         return AUDIO_FORMAT_U8;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 5c6bcfcb3e..6af1911db9 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -77,6 +77,14 @@ static int aud_to_sdlfmt (AudioFormat fmt)
     case AUDIO_FORMAT_U16:
         return AUDIO_U16LSB;
 
+    case AUDIO_FORMAT_S32:
+        return AUDIO_S32LSB;
+
+    /* no unsigned 32-bit support in SDL */
+
+    case AUDIO_FORMAT_F32:
+        return AUDIO_F32LSB;
+
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
 #ifdef DEBUG_AUDIO
@@ -119,6 +127,26 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
         *fmt = AUDIO_FORMAT_U16;
         break;
 
+    case AUDIO_S32LSB:
+        *endianness = 0;
+        *fmt = AUDIO_FORMAT_S32;
+        break;
+
+    case AUDIO_S32MSB:
+        *endianness = 1;
+        *fmt = AUDIO_FORMAT_S32;
+        break;
+
+    case AUDIO_F32LSB:
+        *endianness = 0;
+        *fmt = AUDIO_FORMAT_F32;
+        break;
+
+    case AUDIO_F32MSB:
+        *endianness = 1;
+        *fmt = AUDIO_FORMAT_F32;
+        break;
+
     default:
         dolog ("Unrecognized SDL audio format %d\n", sdlfmt);
         return -1;
-- 
2.25.0


