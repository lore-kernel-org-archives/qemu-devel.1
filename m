Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C1EC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16D321907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16D321907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAs8M-00033d-Cl
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvo-0005BR-PS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArve-0000Fe-EX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvd-0000Da-Jw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 689033083392;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C1035D9CD;
 Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F212F9CAF; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:16 +0200
Message-Id: <20190919083629.29998-14-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/26] audio: common rate control code for timer
 based outputs
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

This commit removes the ad-hoc rate-limiting code from noaudio and
wavaudio, and replaces them with a (slightly modified) code from
spiceaudio.  This way multiple write calls (for example when the
circular buffer wraps around) do not cause problems.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 431af275a903b435f44fffa94896dbfd5bd4ecce.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h  |  9 ++++++++
 audio/audio.c      | 30 +++++++++++++++++++++++++++
 audio/noaudio.c    | 49 ++++++++++++++++++++------------------------
 audio/spiceaudio.c | 51 ++++++++--------------------------------------
 audio/wavaudio.c   | 21 +++++++++----------
 5 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20021df9e8be..778615ccafa4 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -242,6 +242,15 @@ void *audio_calloc (const char *funcname, int nmemb,=
 size_t size);
=20
 void audio_run(AudioState *s, const char *msg);
=20
+typedef struct RateCtl {
+    int64_t start_ticks;
+    int64_t bytes_sent;
+} RateCtl;
+
+void audio_rate_start(RateCtl *rate);
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail);
+
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
 #define VOICE_VOLUME 3
diff --git a/audio/audio.c b/audio/audio.c
index ba07fb77dd4f..fab1e3571838 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2051,3 +2051,33 @@ const char *audio_get_id(QEMUSoundCard *card)
         return "";
     }
 }
+
+void audio_rate_start(RateCtl *rate)
+{
+    memset(rate, 0, sizeof(RateCtl));
+    rate->start_ticks =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
+                            size_t bytes_avail)
+{
+    int64_t now;
+    int64_t ticks;
+    int64_t bytes;
+    int64_t samples;
+    size_t ret;
+
+    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    ticks =3D now - rate->start_ticks;
+    bytes =3D muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SE=
COND);
+    samples =3D (bytes - rate->bytes_sent) >> info->shift;
+    if (samples < 0 || samples > 65536) {
+        AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)\n", =
samples);
+        audio_rate_start(rate);
+        samples =3D 0;
+    }
+
+    ret =3D MIN(samples << info->shift, bytes_avail);
+    rate->bytes_sent +=3D ret;
+    return ret;
+}
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b054fd225b66..9f1cc67df942 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -33,33 +33,27 @@
=20
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceOut;
=20
 typedef struct NoVoiceIn {
     HWVoiceIn hw;
-    int64_t old_ticks;
+    RateCtl rate;
 } NoVoiceIn;
=20
 static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no =3D (NoVoiceOut *) hw;
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-
-    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks =3D now - no->old_ticks;
-    bytes =3D muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER=
_SECOND);
-
-    no->old_ticks =3D now;
-    return MIN(len, bytes);
+    return audio_rate_get_bytes(&hw->info, &no->rate, len);
 }
=20
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv=
_opaque)
 {
+    NoVoiceOut *no =3D (NoVoiceOut *) hw;
+
     audio_pcm_init_info (&hw->info, as);
     hw->samples =3D 1024;
+    audio_rate_start(&no->rate);
     return 0;
 }
=20
@@ -70,15 +64,21 @@ static void no_fini_out (HWVoiceOut *hw)
=20
 static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceOut *no =3D (NoVoiceOut *) hw;
+
+    if (cmd =3D=3D VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
=20
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_o=
paque)
 {
+    NoVoiceIn *no =3D (NoVoiceIn *) hw;
+
     audio_pcm_init_info (&hw->info, as);
     hw->samples =3D 1024;
+    audio_rate_start(&no->rate);
     return 0;
 }
=20
@@ -89,25 +89,20 @@ static void no_fini_in (HWVoiceIn *hw)
=20
 static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    size_t to_clear;
     NoVoiceIn *no =3D (NoVoiceIn *) hw;
+    int64_t bytes =3D audio_rate_get_bytes(&hw->info, &no->rate, size);
=20
-    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks =3D now - no->old_ticks;
-    int64_t bytes =3D
-        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECON=
D);
-
-    no->old_ticks =3D now;
-    to_clear =3D MIN(bytes, size);
-
-    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift)=
;
-    return to_clear;
+    audio_pcm_info_clear_buf(&hw->info, buf, bytes >> hw->info.shift);
+    return bytes;
 }
=20
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    NoVoiceIn *no =3D (NoVoiceIn *) hw;
+
+    if (cmd =3D=3D VOICE_ENABLE) {
+        audio_rate_start(&no->rate);
+    }
     return 0;
 }
=20
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index ff4e4dcbb022..4ce4f94c6dca 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -40,15 +40,10 @@
 #define LINE_IN_SAMPLES (256 * 4)
 #endif
=20
-typedef struct SpiceRateCtl {
-    int64_t               start_ticks;
-    int64_t               bytes_sent;
-} SpiceRateCtl;
-
 typedef struct SpiceVoiceOut {
     HWVoiceOut            hw;
     SpicePlaybackInstance sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
     uint32_t              *frame;
     uint32_t              fpos;
@@ -58,7 +53,7 @@ typedef struct SpiceVoiceOut {
 typedef struct SpiceVoiceIn {
     HWVoiceIn             hw;
     SpiceRecordInstance   sin;
-    SpiceRateCtl          rate;
+    RateCtl               rate;
     int                   active;
 } SpiceVoiceIn;
=20
@@ -89,32 +84,6 @@ static void spice_audio_fini (void *opaque)
     /* nothing */
 }
=20
-static void rate_start (SpiceRateCtl *rate)
-{
-    memset (rate, 0, sizeof (*rate));
-    rate->start_ticks =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-}
-
-static int rate_get_samples (struct audio_pcm_info *info, SpiceRateCtl *=
rate)
-{
-    int64_t now;
-    int64_t ticks;
-    int64_t bytes;
-    int64_t samples;
-
-    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    ticks =3D now - rate->start_ticks;
-    bytes =3D muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SE=
COND);
-    samples =3D (bytes - rate->bytes_sent) >> info->shift;
-    if (samples < 0 || samples > 65536) {
-        error_report("Resetting rate control (%" PRId64 " samples)", sam=
ples);
-        rate_start(rate);
-        samples =3D 0;
-    }
-    rate->bytes_sent +=3D samples << info->shift;
-    return samples;
-}
-
 /* playback */
=20
 static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
@@ -154,7 +123,6 @@ static void line_out_fini (HWVoiceOut *hw)
 static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
 {
     SpiceVoiceOut *out =3D container_of(hw, SpiceVoiceOut, hw);
-    size_t decr;
=20
     if (!out->frame) {
         spice_server_playback_get_buffer(&out->sin, &out->frame, &out->f=
size);
@@ -162,12 +130,10 @@ static void *line_out_get_buffer(HWVoiceOut *hw, si=
ze_t *size)
     }
=20
     if (out->frame) {
-        decr =3D rate_get_samples(&hw->info, &out->rate);
-        decr =3D MIN(out->fsize - out->fpos, decr);
-
-        *size =3D decr << hw->info.shift;
+        *size =3D audio_rate_get_bytes(
+            &hw->info, &out->rate, (out->fsize - out->fpos) << hw->info.=
shift);
     } else {
-        rate_start(&out->rate);
+        audio_rate_start(&out->rate);
     }
     return out->frame + out->fpos;
 }
@@ -197,7 +163,7 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...=
)
             break;
         }
         out->active =3D 1;
-        rate_start (&out->rate);
+        audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
         break;
     case VOICE_DISABLE:
@@ -273,8 +239,7 @@ static void line_in_fini (HWVoiceIn *hw)
 static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
-    uint64_t delta_samp =3D rate_get_samples(&hw->info, &in->rate);
-    uint64_t to_read =3D MIN(len >> 2, delta_samp);
+    uint64_t to_read =3D audio_rate_get_bytes(&hw->info, &in->rate, len)=
 >> 2;
     size_t ready =3D spice_server_record_get_samples(&in->sin, buf, to_r=
ead);
=20
     /* XXX: do we need this? */
@@ -296,7 +261,7 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
             break;
         }
         in->active =3D 1;
-        rate_start (&in->rate);
+        audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
         break;
     case VOICE_DISABLE:
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 7816097db8f9..cb2783e82ac6 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -35,21 +35,15 @@
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
-    int64_t old_ticks;
+    RateCtl rate;
     int total_samples;
 } WAVVoiceOut;
=20
 static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
-    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    int64_t ticks =3D now - wav->old_ticks;
-    int64_t bytes =3D
-        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECON=
D);
-
-    bytes =3D MIN(bytes, len);
-    bytes =3D bytes >> hw->info.shift << hw->info.shift;
-    wav->old_ticks =3D now;
+    int64_t bytes =3D audio_rate_get_bytes(&hw->info, &wav->rate, len);
+    assert(bytes >> hw->info.shift << hw->info.shift =3D=3D bytes);
=20
     if (bytes && fwrite(buf, bytes, 1, wav->f) !=3D 1) {
         dolog("wav_write_out: fwrite of %zu bytes failed\nReaons: %s\n",
@@ -130,6 +124,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audset=
tings *as,
                strerror(errno));
         return -1;
     }
+
+    audio_rate_start(&wav->rate);
     return 0;
 }
=20
@@ -179,8 +175,11 @@ static void wav_fini_out (HWVoiceOut *hw)
=20
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
-    (void) hw;
-    (void) cmd;
+    WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
+
+    if (cmd =3D=3D VOICE_ENABLE) {
+        audio_rate_start(&wav->rate);
+    }
     return 0;
 }
=20
--=20
2.18.1


