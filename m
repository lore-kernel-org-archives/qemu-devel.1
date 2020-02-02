Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE70C3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 14:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C28820643
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 14:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C28820643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFuF-0004fz-H0
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 09:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iyFth-0004C5-0v
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iyFtf-0005dX-EB
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:06:48 -0500
Received: from mailout10.t-online.de ([194.25.134.21]:59780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iyFtf-0005aP-4Z
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 09:06:47 -0500
Received: from fwd18.aul.t-online.de (fwd18.aul.t-online.de [172.20.26.244])
 by mailout10.t-online.de (Postfix) with SMTP id 8464341A7B68;
 Sun,  2 Feb 2020 15:06:45 +0100 (CET)
Received: from linpower.localnet
 (X7U0oGZLohwsko9f04fZu69nFPHZxsegQjw56Kgmer3Gsbe5823GxpOk43zYqUDgZ7@[93.236.154.40])
 by fwd18.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iyFta-3ch9kG0; Sun, 2 Feb 2020 15:06:42 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id F17E32000A0; Sun,  2 Feb 2020 15:06:41 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Programmingkid <programmingkidx@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] coreaudio: fix coreaudio playback
Date: Sun,  2 Feb 2020 15:06:41 +0100
Message-Id: <20200202140641.4737-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
References: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: X7U0oGZLohwsko9f04fZu69nFPHZxsegQjw56Kgmer3Gsbe5823GxpOk43zYqUDgZ7
X-TOI-MSGID: dc913e5d-277b-471e-a3f7-818cec686527
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.21
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
Cc: qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are reports that since commit 2ceb8240fa "coreaudio: port
to the new audio backend api" audio playback with CoreAudio is
broken. This patch reverts some parts the commit.

Because of changes in the audio subsystem the audio clip
function in v4.1.0 of coreaudio.c had to be moved to mixeng.c
and the generic buffer management code needed a hint about the
size of the float type.

This patch is based on a patch from Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 fou=
nd at
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.

Fixes: 2ceb8240fa "coreaudio: port to the new audio backend api"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio_template.h |  7 +++++++
 audio/coreaudio.c      | 32 +++++++++-----------------------
 audio/mixeng.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 audio/mixeng.h         |  5 +++++
 4 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 3287d7075e..0336d2670c 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -276,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSt=
ate *s,
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
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 66f0f459cf..0049db97fa 100644
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
@@ -496,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as,
     Audiodev *dev =3D drv_opaque;
     AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
     int frames;
+    struct audsettings fake_as;
=20
     /* create mutex */
     err =3D pthread_mutex_init(&core->mutex, NULL);
@@ -504,6 +491,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct=
 audsettings *as,
         return -1;
     }
=20
+    /*
+     * The canonical audio format for CoreAudio on macOS is float. Curre=
ntly
+     * there is no generic code for AUDIO_FORMAT_F32 in qemu. Here we se=
lect
+     * AUDIO_FORMAT_S32 instead because only the sample size has to matc=
h.
+     */
+    fake_as =3D *as;
+    as =3D &fake_as;
+    as->fmt =3D AUDIO_FORMAT_S32;
     audio_pcm_init_info (&hw->info, as);
=20
     status =3D coreaudio_get_voice(&core->outputDeviceID);
@@ -572,15 +567,6 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct=
 audsettings *as,
=20
     /* set Samplerate */
     core->outputStreamBasicDescription.mSampleRate =3D (Float64) as->fre=
q;
-    core->outputStreamBasicDescription.mFormatID =3D kAudioFormatLinearP=
CM;
-    core->outputStreamBasicDescription.mFormatFlags =3D
-        coreaudio_get_flags(&hw->info, as);
-    core->outputStreamBasicDescription.mBytesPerPacket =3D
-        core->outputStreamBasicDescription.mBytesPerFrame =3D
-        hw->info.nchannels * hw->info.bits / 8;
-    core->outputStreamBasicDescription.mFramesPerPacket =3D 1;
-    core->outputStreamBasicDescription.mChannelsPerFrame =3D hw->info.nc=
hannels;
-    core->outputStreamBasicDescription.mBitsPerChannel =3D hw->info.bits=
;
=20
     status =3D coreaudio_set_streamformat(core->outputDeviceID,
                                         &core->outputStreamBasicDescript=
ion);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 2f5ba71381..16b646d48c 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,6 +267,54 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
     }
 };
=20
+void conv_natural_float_to_stereo(struct st_sample *dst, const void *src=
,
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
+void clip_natural_float_from_stereo(void *dst, const struct st_sample *s=
rc,
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
diff --git a/audio/mixeng.h b/audio/mixeng.h
index 18e62c7c49..7ef61763e8 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -41,6 +41,11 @@ typedef void (f_sample) (void *dst, const struct st_sa=
mple *src, int samples);
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
=20
+void conv_natural_float_to_stereo(struct st_sample *dst, const void *src=
,
+                                  int samples);
+void clip_natural_float_from_stereo(void *dst, const struct st_sample *s=
rc,
+                                    int samples);
+
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
                   size_t *isamp, size_t *osamp);
--=20
2.16.4


