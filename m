Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F0C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051FB21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8CdIMYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051FB21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyOa-0002E4-67
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL7-0005fy-9g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL5-0003ZJ-4U
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL4-0003YT-VM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2yf5HmBL42PNmZYSgdA+64xYABc3davfMjfR45osHw=;
 b=F8CdIMYINf01S1v3T/oQrR6BSKtd4DLNnSg2DaKB6Mh7dXJSiQYf41GULGIFEu3BsHoff4
 aNqkLfGXFK8DemhMJYrSbE+vRXpQf/02nOqXGQZfD0VHm7WSkHsy0tPUPCf1kVyx9keT4a
 0emnOx36vF7djKxBMV6j+vOxNUGx7Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-5g9CZL2CPHGp_TKpEHBR9A-1; Fri, 07 Feb 2020 02:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BCD1005513;
 Fri,  7 Feb 2020 07:46:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 452DB89F02;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 616EC31F5D; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] audio: proper support for float samples in mixeng
Date: Fri,  7 Feb 2020 08:45:57 +0100
Message-Id: <20200207074557.26073-13-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5g9CZL2CPHGp_TKpEHBR9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: K=?UTF-8?B?xZE=?=v=?UTF-8?B?w6E=?=g=?UTF-8?B?w7M=?=@redhat.com, 
 =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

This adds proper support for float samples in mixeng by adding a new
audio format for it.

Limitations: only native endianness is supported.  None of the virtual
sound cards support float samples (it looks like most of them only
support 8 and 16 bit, only hda supports 32 bit), it is only used for the
audio backends (i.e. host side).

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-id: 8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.i=
CE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h      |  3 +-
 audio/audio_template.h | 41 ++++++++++++--------
 audio/mixeng.h         |  8 ++--
 audio/alsaaudio.c      | 17 ++++++++
 audio/audio.c          | 56 ++++++++++++++++++---------
 audio/coreaudio.c      |  7 +---
 audio/mixeng.c         | 88 ++++++++++++++++++++++++++----------------
 audio/paaudio.c        |  9 +++++
 audio/sdlaudio.c       | 28 ++++++++++++++
 qapi/audio.json        |  2 +-
 10 files changed, 180 insertions(+), 79 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3c8e48b55b1c..4775857bf245 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -40,7 +40,8 @@ struct audio_callback {
=20
 struct audio_pcm_info {
     int bits;
-    int sign;
+    bool is_signed;
+    bool is_float;
     int freq;
     int nchannels;
     int bytes_per_frame;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 0336d2670cf6..7013d3041f91 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -153,15 +153,23 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     sw->ratio =3D ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
 #endif
=20
+    if (sw->info.is_float) {
 #ifdef DAC
-    sw->conv =3D mixeng_conv
+        sw->conv =3D mixeng_conv_float[sw->info.nchannels =3D=3D 2];
 #else
-    sw->clip =3D mixeng_clip
+        sw->clip =3D mixeng_clip_float[sw->info.nchannels =3D=3D 2];
 #endif
-        [sw->info.nchannels =3D=3D 2]
-        [sw->info.sign]
-        [sw->info.swap_endianness]
-        [audio_bits_to_index (sw->info.bits)];
+    } else {
+#ifdef DAC
+        sw->conv =3D mixeng_conv
+#else
+        sw->clip =3D mixeng_clip
+#endif
+            [sw->info.nchannels =3D=3D 2]
+            [sw->info.is_signed]
+            [sw->info.swap_endianness]
+            [audio_bits_to_index(sw->info.bits)];
+    }
=20
     sw->name =3D g_strdup (name);
     err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
@@ -276,22 +284,23 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
         goto err1;
     }
=20
-    if (s->dev->driver =3D=3D AUDIODEV_DRIVER_COREAUDIO) {
+    if (hw->info.is_float) {
 #ifdef DAC
-        hw->clip =3D clip_natural_float_from_stereo;
+        hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=3D 2];
 #else
-        hw->conv =3D conv_natural_float_to_stereo;
+        hw->conv =3D mixeng_conv_float[hw->info.nchannels =3D=3D 2];
 #endif
-    } else
+    } else {
 #ifdef DAC
-    hw->clip =3D mixeng_clip
+        hw->clip =3D mixeng_clip
 #else
-    hw->conv =3D mixeng_conv
+        hw->conv =3D mixeng_conv
 #endif
-        [hw->info.nchannels =3D=3D 2]
-        [hw->info.sign]
-        [hw->info.swap_endianness]
-        [audio_bits_to_index (hw->info.bits)];
+            [hw->info.nchannels =3D=3D 2]
+            [hw->info.is_signed]
+            [hw->info.swap_endianness]
+            [audio_bits_to_index(hw->info.bits)];
+    }
=20
     glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
=20
diff --git a/audio/mixeng.h b/audio/mixeng.h
index 7ef61763e8f9..2dcd6df24561 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -38,13 +38,13 @@ typedef struct st_sample st_sample;
 typedef void (t_sample) (struct st_sample *dst, const void *src, int sampl=
es);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int sampl=
es);
=20
+/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
=20
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
-                                  int samples);
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,
-                                    int samples);
+/* indices: [stereo] */
+extern t_sample *mixeng_conv_float[2];
+extern f_sample *mixeng_clip_float[2];
=20
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 4ef26818be57..a23a5a0b60a1 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -307,6 +307,13 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat fm=
t, int endianness)
             return SND_PCM_FORMAT_U32_LE;
         }
=20
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
@@ -370,6 +377,16 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, A=
udioFormat *fmt,
         *fmt =3D AUDIO_FORMAT_U32;
         break;
=20
+    case SND_PCM_FORMAT_FLOAT_LE:
+        *endianness =3D 0;
+        *fmt =3D AUDIO_FORMAT_F32;
+        break;
+
+    case SND_PCM_FORMAT_FLOAT_BE:
+        *endianness =3D 1;
+        *fmt =3D AUDIO_FORMAT_F32;
+        break;
+
     default:
         dolog ("Unrecognized audio format %d\n", alsafmt);
         return -1;
diff --git a/audio/audio.c b/audio/audio.c
index 3bfd808bc6f1..9ac9a20c41ba 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -218,6 +218,9 @@ static void audio_print_settings (struct audsettings *a=
s)
     case AUDIO_FORMAT_U32:
         AUD_log (NULL, "U32");
         break;
+    case AUDIO_FORMAT_F32:
+        AUD_log (NULL, "F32");
+        break;
     default:
         AUD_log (NULL, "invalid(%d)", as->fmt);
         break;
@@ -252,6 +255,7 @@ static int audio_validate_settings (struct audsettings =
*as)
     case AUDIO_FORMAT_U16:
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
+    case AUDIO_FORMAT_F32:
         break;
     default:
         invalid =3D 1;
@@ -264,24 +268,28 @@ static int audio_validate_settings (struct audsetting=
s *as)
=20
 static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsetti=
ngs *as)
 {
-    int bits =3D 8, sign =3D 0;
+    int bits =3D 8;
+    bool is_signed =3D false, is_float =3D false;
=20
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U8:
         break;
=20
     case AUDIO_FORMAT_S16:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits =3D 16;
         break;
=20
+    case AUDIO_FORMAT_F32:
+        is_float =3D true;
+        /* fall through */
     case AUDIO_FORMAT_S32:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits =3D 32;
@@ -292,33 +300,38 @@ static int audio_pcm_info_eq (struct audio_pcm_info *=
info, struct audsettings *a
     }
     return info->freq =3D=3D as->freq
         && info->nchannels =3D=3D as->nchannels
-        && info->sign =3D=3D sign
+        && info->is_signed =3D=3D is_signed
+        && info->is_float =3D=3D is_float
         && info->bits =3D=3D bits
         && info->swap_endianness =3D=3D (as->endianness !=3D AUDIO_HOST_EN=
DIANNESS);
 }
=20
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings =
*as)
 {
-    int bits =3D 8, sign =3D 0, mul;
+    int bits =3D 8, mul;
+    bool is_signed =3D false, is_float =3D false;
=20
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U8:
         mul =3D 1;
         break;
=20
     case AUDIO_FORMAT_S16:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits =3D 16;
         mul =3D 2;
         break;
=20
+    case AUDIO_FORMAT_F32:
+        is_float =3D true;
+        /* fall through */
     case AUDIO_FORMAT_S32:
-        sign =3D 1;
+        is_signed =3D true;
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits =3D 32;
@@ -331,7 +344,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info, =
struct audsettings *as)
=20
     info->freq =3D as->freq;
     info->bits =3D bits;
-    info->sign =3D sign;
+    info->is_signed =3D is_signed;
+    info->is_float =3D is_float;
     info->nchannels =3D as->nchannels;
     info->bytes_per_frame =3D as->nchannels * mul;
     info->bytes_per_second =3D info->freq * info->bytes_per_frame;
@@ -344,7 +358,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *i=
nfo, void *buf, int len)
         return;
     }
=20
-    if (info->sign) {
+    if (info->is_signed || info->is_float) {
         memset(buf, 0x00, len * info->bytes_per_frame);
     }
     else {
@@ -770,8 +784,9 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *=
buf, size_t size)
 #ifdef DEBUG_AUDIO
 static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *=
info)
 {
-    dolog ("%s: bits %d, sign %d, freq %d, nchan %d\n",
-           cap, info->bits, info->sign, info->freq, info->nchannels);
+    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
+          cap, info->bits, info->is_signed, info->is_float, info->freq,
+          info->nchannels);
 }
 #endif
=20
@@ -1832,11 +1847,15 @@ CaptureVoiceOut *AUD_add_capture(
=20
         cap->buf =3D g_malloc0_n(hw->mix_buf->size, hw->info.bytes_per_fra=
me);
=20
-        hw->clip =3D mixeng_clip
-            [hw->info.nchannels =3D=3D 2]
-            [hw->info.sign]
-            [hw->info.swap_endianness]
-            [audio_bits_to_index (hw->info.bits)];
+        if (hw->info.is_float) {
+            hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=3D 2];
+        } else {
+            hw->clip =3D mixeng_clip
+                [hw->info.nchannels =3D=3D 2]
+                [hw->info.is_signed]
+                [hw->info.swap_endianness]
+                [audio_bits_to_index(hw->info.bits)];
+        }
=20
         QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
         QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
@@ -2075,6 +2094,7 @@ int audioformat_bytes_per_sample(AudioFormat fmt)
=20
     case AUDIO_FORMAT_U32:
     case AUDIO_FORMAT_S32:
+    case AUDIO_FORMAT_F32:
         return 4;
=20
     case AUDIO_FORMAT__MAX:
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index e3620b274bd6..4b4365660fcf 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -491,14 +491,9 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct a=
udsettings *as,
         return -1;
     }
=20
-    /*
-     * The canonical audio format for CoreAudio on macOS is float. Current=
ly
-     * there is no generic code for AUDIO_FORMAT_F32 in qemu. Here we sele=
ct
-     * AUDIO_FORMAT_S32 instead because only the sample size has to match.
-     */
     fake_as =3D *as;
     as =3D &fake_as;
-    as->fmt =3D AUDIO_FORMAT_S32;
+    as->fmt =3D AUDIO_FORMAT_F32;
     audio_pcm_init_info (&hw->info, as);
=20
     status =3D coreaudio_get_voice(&core->outputDeviceID);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 16b646d48cdf..c14b0d874ce5 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,55 +267,77 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
     }
 };
=20
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
-                                  int samples)
+#ifdef FLOAT_MIXENG
+#define FLOAT_CONV_TO(x) (x)
+#define FLOAT_CONV_FROM(x) (x)
+#else
+static const float float_scale =3D UINT_MAX;
+#define FLOAT_CONV_TO(x) ((x) * float_scale)
+
+#ifdef RECIPROCAL
+static const float float_scale_reciprocal =3D 1.f / UINT_MAX;
+#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)
+#else
+#define FLOAT_CONV_FROM(x) ((x) / float_scale)
+#endif
+#endif
+
+static void conv_natural_float_to_mono(struct st_sample *dst, const void *=
src,
+                                       int samples)
 {
     float *in =3D (float *)src;
-#ifndef FLOAT_MIXENG
-    const float scale =3D UINT_MAX;
-#endif
=20
     while (samples--) {
-#ifdef FLOAT_MIXENG
-        dst->l =3D *in++;
-        dst->r =3D *in++;
-#else
-        dst->l =3D *in++ * scale;
-        dst->r =3D *in++ * scale;
-#endif
+        dst->r =3D dst->l =3D FLOAT_CONV_TO(*in++);
+        dst++;
+    }
+}
+
+static void conv_natural_float_to_stereo(struct st_sample *dst, const void=
 *src,
+                                         int samples)
+{
+    float *in =3D (float *)src;
+
+    while (samples--) {
+        dst->l =3D FLOAT_CONV_TO(*in++);
+        dst->r =3D FLOAT_CONV_TO(*in++);
         dst++;
     }
 }
=20
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,
-                                    int samples)
+t_sample *mixeng_conv_float[2] =3D {
+    conv_natural_float_to_mono,
+    conv_natural_float_to_stereo,
+};
+
+static void clip_natural_float_from_mono(void *dst, const struct st_sample=
 *src,
+                                         int samples)
 {
     float *out =3D (float *)dst;
-#ifndef FLOAT_MIXENG
-#ifdef RECIPROCAL
-    const float scale =3D 1.f / UINT_MAX;
-#else
-    const float scale =3D UINT_MAX;
-#endif
-#endif
=20
     while (samples--) {
-#ifdef FLOAT_MIXENG
-        *out++ =3D src->l;
-        *out++ =3D src->r;
-#else
-#ifdef RECIPROCAL
-        *out++ =3D src->l * scale;
-        *out++ =3D src->r * scale;
-#else
-        *out++ =3D src->l / scale;
-        *out++ =3D src->r / scale;
-#endif
-#endif
+        *out++ =3D FLOAT_CONV_FROM(src->l) + FLOAT_CONV_FROM(src->r);
+        src++;
+    }
+}
+
+static void clip_natural_float_from_stereo(
+    void *dst, const struct st_sample *src, int samples)
+{
+    float *out =3D (float *)dst;
+
+    while (samples--) {
+        *out++ =3D FLOAT_CONV_FROM(src->l);
+        *out++ =3D FLOAT_CONV_FROM(src->r);
         src++;
     }
 }
=20
+f_sample *mixeng_clip_float[2] =3D {
+    clip_natural_float_from_mono,
+    clip_natural_float_from_stereo,
+};
+
 void audio_sample_to_uint64(void *samples, int pos,
                             uint64_t *left, uint64_t *right)
 {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 8f37c6185161..b05208469831 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -277,6 +277,9 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat afm=
t, int endianness)
     case AUDIO_FORMAT_U32:
         format =3D endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
         break;
+    case AUDIO_FORMAT_F32:
+        format =3D endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
+        break;
     default:
         dolog ("Internal logic error: Bad audio format %d\n", afmt);
         format =3D PA_SAMPLE_U8;
@@ -302,6 +305,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fm=
t, int *endianness)
     case PA_SAMPLE_S32LE:
         *endianness =3D 0;
         return AUDIO_FORMAT_S32;
+    case PA_SAMPLE_FLOAT32BE:
+        *endianness =3D 1;
+        return AUDIO_FORMAT_F32;
+    case PA_SAMPLE_FLOAT32LE:
+        *endianness =3D 0;
+        return AUDIO_FORMAT_F32;
     default:
         dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
         return AUDIO_FORMAT_U8;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index c00e7d784523..21b7a0484bec 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -77,6 +77,14 @@ static int aud_to_sdlfmt (AudioFormat fmt)
     case AUDIO_FORMAT_U16:
         return AUDIO_U16LSB;
=20
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
@@ -119,6 +127,26 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt,=
 int *endianness)
         *fmt =3D AUDIO_FORMAT_U16;
         break;
=20
+    case AUDIO_S32LSB:
+        *endianness =3D 0;
+        *fmt =3D AUDIO_FORMAT_S32;
+        break;
+
+    case AUDIO_S32MSB:
+        *endianness =3D 1;
+        *fmt =3D AUDIO_FORMAT_S32;
+        break;
+
+    case AUDIO_F32LSB:
+        *endianness =3D 0;
+        *fmt =3D AUDIO_FORMAT_F32;
+        break;
+
+    case AUDIO_F32MSB:
+        *endianness =3D 1;
+        *fmt =3D AUDIO_FORMAT_F32;
+        break;
+
     default:
         dolog ("Unrecognized SDL audio format %d\n", sdlfmt);
         return -1;
diff --git a/qapi/audio.json b/qapi/audio.json
index 83312b23391e..d8c507ccedae 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -276,7 +276,7 @@
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
-  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
+  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
=20
 ##
 # @AudiodevDriver:
--=20
2.18.1


