Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BCC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E27820679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E27820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUsW-00018U-My
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUp8-0001HS-TO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUp7-0005Ex-5k
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUp6-0005EO-F0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABDDF30A0101;
 Tue, 13 Aug 2019 11:18:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E17177EEA0;
 Tue, 13 Aug 2019 11:18:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF3739CA9; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:18:06 +0200
Message-Id: <20190813111809.3141-13-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 11:18:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/15] audio: remove read and write pcm_ops
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

They just called audio_pcm_sw_read/write anyway, so it makes no sense
to have them too.  (The noaudio's read is the only exception, but it
should work with the generic code too.)

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 07e99c2877870cb486a07881a77d3ce0bc594daa.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h   |  5 -----
 audio/alsaaudio.c   | 12 ------------
 audio/audio.c       |  8 ++++----
 audio/coreaudio.c   |  6 ------
 audio/dsoundaudio.c | 12 ------------
 audio/noaudio.c     | 19 -------------------
 audio/ossaudio.c    | 12 ------------
 audio/paaudio.c     | 12 ------------
 audio/sdlaudio.c    |  6 ------
 audio/spiceaudio.c  | 12 ------------
 audio/wavaudio.c    |  6 ------
 11 files changed, 4 insertions(+), 106 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 7e00c1332e16..003b7ab8cc6b 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -150,13 +150,11 @@ struct audio_pcm_ops {
     int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_o=
paque);
     void (*fini_out)(HWVoiceOut *hw);
     int  (*run_out) (HWVoiceOut *hw, int live);
-    int  (*write)   (SWVoiceOut *sw, void *buf, int size);
     int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
=20
     int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_op=
aque);
     void (*fini_in) (HWVoiceIn *hw);
     int  (*run_in)  (HWVoiceIn *hw);
-    int  (*read)    (SWVoiceIn *sw, void *buf, int size);
     int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
=20
@@ -210,11 +208,8 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
=20
-int  audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int len);
 int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
=20
-int  audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int len);
-
 int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
                            int live, int pending);
=20
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3daa7c8f8f02..e9e3a4819c82 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -270,11 +270,6 @@ static int alsa_poll_in (HWVoiceIn *hw)
     return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
 }
=20
-static int alsa_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
@@ -988,11 +983,6 @@ static int alsa_run_in (HWVoiceIn *hw)
     return read_samples;
 }
=20
-static int alsa_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
@@ -1076,13 +1066,11 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
     .init_out =3D alsa_init_out,
     .fini_out =3D alsa_fini_out,
     .run_out  =3D alsa_run_out,
-    .write    =3D alsa_write,
     .ctl_out  =3D alsa_ctl_out,
=20
     .init_in  =3D alsa_init_in,
     .fini_in  =3D alsa_fini_in,
     .run_in   =3D alsa_run_in,
-    .read     =3D alsa_read,
     .ctl_in   =3D alsa_ctl_in,
 };
=20
diff --git a/audio/audio.c b/audio/audio.c
index 07b35ffa0351..254499dfa13d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -594,7 +594,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     }
 }
=20
-int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
+static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
 {
     HWVoiceIn *hw =3D sw->hw;
     int samples, live, ret =3D 0, swlim, isamp, osamp, rpos, total =3D 0=
;
@@ -696,7 +696,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw,=
 int *nb_live)
 /*
  * Soft voice (playback)
  */
-int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
+static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
 {
     int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim,=
 blck;
     int ret =3D 0, pos =3D 0, total =3D 0;
@@ -854,7 +854,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
         return 0;
     }
=20
-    return sw->hw->pcm_ops->write(sw, buf, size);
+    return audio_pcm_sw_write(sw, buf, size);
 }
=20
 int AUD_read (SWVoiceIn *sw, void *buf, int size)
@@ -869,7 +869,7 @@ int AUD_read (SWVoiceIn *sw, void *buf, int size)
         return 0;
     }
=20
-    return sw->hw->pcm_ops->read(sw, buf, size);
+    return audio_pcm_sw_read(sw, buf, size);
 }
=20
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index f0ab4014a85d..091fe84a343a 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -489,11 +489,6 @@ static OSStatus audioDeviceIOProc(
     return 0;
 }
=20
-static int coreaudio_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -692,7 +687,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops =3D {
     .init_out =3D coreaudio_init_out,
     .fini_out =3D coreaudio_fini_out,
     .run_out  =3D coreaudio_run_out,
-    .write    =3D coreaudio_write,
     .ctl_out  =3D coreaudio_ctl_out
 };
=20
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 07260f881eaa..11594c3095bf 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,11 +454,6 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, =
...)
     return 0;
 }
=20
-static int dsound_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int dsound_run_out (HWVoiceOut *hw, int live)
 {
     int err;
@@ -645,11 +640,6 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ..=
.)
     return 0;
 }
=20
-static int dsound_read (SWVoiceIn *sw, void *buf, int len)
-{
-    return audio_pcm_sw_read (sw, buf, len);
-}
-
 static int dsound_run_in (HWVoiceIn *hw)
 {
     int err;
@@ -856,13 +846,11 @@ static struct audio_pcm_ops dsound_pcm_ops =3D {
     .init_out =3D dsound_init_out,
     .fini_out =3D dsound_fini_out,
     .run_out  =3D dsound_run_out,
-    .write    =3D dsound_write,
     .ctl_out  =3D dsound_ctl_out,
=20
     .init_in  =3D dsound_init_in,
     .fini_in  =3D dsound_fini_in,
     .run_in   =3D dsound_run_in,
-    .read     =3D dsound_read,
     .ctl_in   =3D dsound_ctl_in
 };
=20
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 14a0e4ab29f4..cbb02d9e49a7 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -61,11 +61,6 @@ static int no_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
=20
-static int no_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write(sw, buf, len);
-}
-
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv=
_opaque)
 {
     audio_pcm_init_info (&hw->info, as);
@@ -118,18 +113,6 @@ static int no_run_in (HWVoiceIn *hw)
     return samples;
 }
=20
-static int no_read (SWVoiceIn *sw, void *buf, int size)
-{
-    /* use custom code here instead of audio_pcm_sw_read() to avoid
-     * useless resampling/mixing */
-    int samples =3D size >> sw->info.shift;
-    int total =3D sw->hw->total_samples_captured - sw->total_hw_samples_=
acquired;
-    int to_clear =3D MIN (samples, total);
-    sw->total_hw_samples_acquired +=3D total;
-    audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
-    return to_clear << sw->info.shift;
-}
-
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     (void) hw;
@@ -151,13 +134,11 @@ static struct audio_pcm_ops no_pcm_ops =3D {
     .init_out =3D no_init_out,
     .fini_out =3D no_fini_out,
     .run_out  =3D no_run_out,
-    .write    =3D no_write,
     .ctl_out  =3D no_ctl_out,
=20
     .init_in  =3D no_init_in,
     .fini_in  =3D no_fini_in,
     .run_in   =3D no_run_in,
-    .read     =3D no_read,
     .ctl_in   =3D no_ctl_in
 };
=20
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 456fba748064..b99edbec176f 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -134,11 +134,6 @@ static void oss_poll_in (HWVoiceIn *hw)
     qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
=20
-static int oss_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int aud_to_ossfmt (AudioFormat fmt, int endianness)
 {
     switch (fmt) {
@@ -788,11 +783,6 @@ static int oss_run_in (HWVoiceIn *hw)
     return read_samples;
 }
=20
-static int oss_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
@@ -855,13 +845,11 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
     .init_out =3D oss_init_out,
     .fini_out =3D oss_fini_out,
     .run_out  =3D oss_run_out,
-    .write    =3D oss_write,
     .ctl_out  =3D oss_ctl_out,
=20
     .init_in  =3D oss_init_in,
     .fini_in  =3D oss_fini_in,
     .run_in   =3D oss_run_in,
-    .read     =3D oss_read,
     .ctl_in   =3D oss_ctl_in
 };
=20
diff --git a/audio/paaudio.c b/audio/paaudio.c
index c8ae1a6eca01..efb72ced30aa 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -295,11 +295,6 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
=20
-static int qpa_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 /* capture */
 static void *qpa_thread_in (void *arg)
 {
@@ -388,11 +383,6 @@ static int qpa_run_in (HWVoiceIn *hw)
     return incr;
 }
=20
-static int qpa_read (SWVoiceIn *sw, void *buf, int len)
-{
-    return audio_pcm_sw_read (sw, buf, len);
-}
-
 static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness=
)
 {
     int format;
@@ -1016,13 +1006,11 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
     .init_out =3D qpa_init_out,
     .fini_out =3D qpa_fini_out,
     .run_out  =3D qpa_run_out,
-    .write    =3D qpa_write,
     .ctl_out  =3D qpa_ctl_out,
=20
     .init_in  =3D qpa_init_in,
     .fini_in  =3D qpa_fini_in,
     .run_in   =3D qpa_run_in,
-    .read     =3D qpa_read,
     .ctl_in   =3D qpa_ctl_in
 };
=20
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 42f7614124c6..c7fd487e0ed3 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -217,11 +217,6 @@ static void sdl_callback (void *opaque, Uint8 *buf, =
int len)
     }
 }
=20
-static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int sdl_run_out (HWVoiceOut *hw, int live)
 {
     int decr;
@@ -342,7 +337,6 @@ static struct audio_pcm_ops sdl_pcm_ops =3D {
     .init_out =3D sdl_init_out,
     .fini_out =3D sdl_fini_out,
     .run_out  =3D sdl_run_out,
-    .write    =3D sdl_write_out,
     .ctl_out  =3D sdl_ctl_out,
 };
=20
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6f4a0558f86d..6e7f13cffab5 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -193,11 +193,6 @@ static int line_out_run (HWVoiceOut *hw, int live)
     return decr;
 }
=20
-static int line_out_write (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
 {
     SpiceVoiceOut *out =3D container_of (hw, SpiceVoiceOut, hw);
@@ -326,11 +321,6 @@ static int line_in_run (HWVoiceIn *hw)
     return num_samples;
 }
=20
-static int line_in_read (SWVoiceIn *sw, void *buf, int size)
-{
-    return audio_pcm_sw_read (sw, buf, size);
-}
-
 static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
 {
     SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
@@ -378,13 +368,11 @@ static struct audio_pcm_ops audio_callbacks =3D {
     .init_out =3D line_out_init,
     .fini_out =3D line_out_fini,
     .run_out  =3D line_out_run,
-    .write    =3D line_out_write,
     .ctl_out  =3D line_out_ctl,
=20
     .init_in  =3D line_in_init,
     .fini_in  =3D line_in_fini,
     .run_in   =3D line_in_run,
-    .read     =3D line_in_read,
     .ctl_in   =3D line_in_ctl,
 };
=20
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index bbf3f3b3462f..17ab921cef85 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -84,11 +84,6 @@ static int wav_run_out (HWVoiceOut *hw, int live)
     return decr;
 }
=20
-static int wav_write_out (SWVoiceOut *sw, void *buf, int len)
-{
-    return audio_pcm_sw_write (sw, buf, len);
-}
-
 /* VICE code: Store number as little endian. */
 static void le_store (uint8_t *buf, uint32_t val, int len)
 {
@@ -240,7 +235,6 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
     .init_out =3D wav_init_out,
     .fini_out =3D wav_fini_out,
     .run_out  =3D wav_run_out,
-    .write    =3D wav_write_out,
     .ctl_out  =3D wav_ctl_out,
 };
=20
--=20
2.18.1


