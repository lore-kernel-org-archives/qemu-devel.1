Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFEC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1EA20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiqvfHdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1EA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyV9-0001K4-QI
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL3-0005bE-WC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL2-0003OR-Az
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL2-0003Ml-3m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fA3rv/QklGmUn/M7ln6HRVQ1uZk0hRyDqPt7+PnoKAk=;
 b=OiqvfHdUvHeanNh6kSJJ0UKu5ykgoDVK0CUwKOZHTrCvI3f6LzFKqdtBBvjqCBDzv2sabo
 zhBa1nXnzWFRkVf0Gzp/fObfLwVMf8cyoc+2sdcFe+3FzzU2EhghG0sEM+lMGzTJnXMRbj
 3AmJ8iT16cOYs4KSmOHcYRNwQy3c3Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-6IQcp8yXNHupX3UNWFul7g-1; Fri, 07 Feb 2020 02:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2DD71005513;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA008DC1B;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4BB2831F47; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] coreaudio: fix coreaudio playback
Date: Fri,  7 Feb 2020 08:45:56 +0100
Message-Id: <20200207074557.26073-12-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6IQcp8yXNHupX3UNWFul7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

There are reports that since commit 2ceb8240fa "coreaudio: port
to the new audio backend api" audio playback with CoreAudio is
broken. This patch reverts some parts the commit.

Because of changes in the audio subsystem the audio clip
function in v4.1.0 of coreaudio.c had to be moved to mixeng.c
and the generic buffer management code needed a hint about the
size of the float type.

This patch is based on a patch from Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 found=
 at
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.

Fixes: 2ceb8240fa "coreaudio: port to the new audio backend api"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200202140641.4737-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_template.h |  7 ++++++
 audio/mixeng.h         |  5 +++++
 audio/coreaudio.c      | 32 ++++++++--------------------
 audio/mixeng.c         | 48 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 3287d7075e6a..0336d2670cf6 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -276,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioStat=
e *s,
         goto err1;
     }
=20
+    if (s->dev->driver =3D=3D AUDIODEV_DRIVER_COREAUDIO) {
+#ifdef DAC
+        hw->clip =3D clip_natural_float_from_stereo;
+#else
+        hw->conv =3D conv_natural_float_to_stereo;
+#endif
+    } else
 #ifdef DAC
     hw->clip =3D mixeng_clip
 #else
diff --git a/audio/mixeng.h b/audio/mixeng.h
index 18e62c7c49e7..7ef61763e8f9 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -41,6 +41,11 @@ typedef void (f_sample) (void *dst, const struct st_samp=
le *src, int samples);
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
=20
+void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
+                                  int samples);
+void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,
+                                    int samples);
+
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
                   size_t *isamp, size_t *osamp);
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index c7a7196c2d53..e3620b274bd6 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -471,20 +471,6 @@ static OSStatus audioDeviceIOProc(
     return 0;
 }
=20
-static UInt32 coreaudio_get_flags(struct audio_pcm_info *info,
-                                  struct audsettings *as)
-{
-    UInt32 flags =3D info->sign ? kAudioFormatFlagIsSignedInteger : 0;
-    if (as->endianness) { /* 0 =3D little, 1 =3D big */
-        flags |=3D kAudioFormatFlagIsBigEndian;
-    }
-
-    if (flags =3D=3D 0) { /* must not be 0 */
-        flags =3D kAudioFormatFlagsAreAllClear;
-    }
-    return flags;
-}
-
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -496,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct au=
dsettings *as,
     Audiodev *dev =3D drv_opaque;
     AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
     int frames;
+    struct audsettings fake_as;
=20
     /* create mutex */
     err =3D pthread_mutex_init(&core->mutex, NULL);
@@ -504,6 +491,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct a=
udsettings *as,
         return -1;
     }
=20
+    /*
+     * The canonical audio format for CoreAudio on macOS is float. Current=
ly
+     * there is no generic code for AUDIO_FORMAT_F32 in qemu. Here we sele=
ct
+     * AUDIO_FORMAT_S32 instead because only the sample size has to match.
+     */
+    fake_as =3D *as;
+    as =3D &fake_as;
+    as->fmt =3D AUDIO_FORMAT_S32;
     audio_pcm_init_info (&hw->info, as);
=20
     status =3D coreaudio_get_voice(&core->outputDeviceID);
@@ -572,15 +567,6 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct a=
udsettings *as,
=20
     /* set Samplerate */
     core->outputStreamBasicDescription.mSampleRate =3D (Float64) as->freq;
-    core->outputStreamBasicDescription.mFormatID =3D kAudioFormatLinearPCM=
;
-    core->outputStreamBasicDescription.mFormatFlags =3D
-        coreaudio_get_flags(&hw->info, as);
-    core->outputStreamBasicDescription.mBytesPerPacket =3D
-        core->outputStreamBasicDescription.mBytesPerFrame =3D
-        hw->info.nchannels * hw->info.bits / 8;
-    core->outputStreamBasicDescription.mFramesPerPacket =3D 1;
-    core->outputStreamBasicDescription.mChannelsPerFrame =3D hw->info.ncha=
nnels;
-    core->outputStreamBasicDescription.mBitsPerChannel =3D hw->info.bits;
=20
     status =3D coreaudio_set_streamformat(core->outputDeviceID,
                                         &core->outputStreamBasicDescriptio=
n);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 2f5ba71381d4..16b646d48cdf 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,6 +267,54 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
     }
 };
=20
+void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
+                                  int samples)
+{
+    float *in =3D (float *)src;
+#ifndef FLOAT_MIXENG
+    const float scale =3D UINT_MAX;
+#endif
+
+    while (samples--) {
+#ifdef FLOAT_MIXENG
+        dst->l =3D *in++;
+        dst->r =3D *in++;
+#else
+        dst->l =3D *in++ * scale;
+        dst->r =3D *in++ * scale;
+#endif
+        dst++;
+    }
+}
+
+void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,
+                                    int samples)
+{
+    float *out =3D (float *)dst;
+#ifndef FLOAT_MIXENG
+#ifdef RECIPROCAL
+    const float scale =3D 1.f / UINT_MAX;
+#else
+    const float scale =3D UINT_MAX;
+#endif
+#endif
+
+    while (samples--) {
+#ifdef FLOAT_MIXENG
+        *out++ =3D src->l;
+        *out++ =3D src->r;
+#else
+#ifdef RECIPROCAL
+        *out++ =3D src->l * scale;
+        *out++ =3D src->r * scale;
+#else
+        *out++ =3D src->l / scale;
+        *out++ =3D src->r / scale;
+#endif
+#endif
+        src++;
+    }
+}
=20
 void audio_sample_to_uint64(void *samples, int pos,
                             uint64_t *left, uint64_t *right)
--=20
2.18.1


