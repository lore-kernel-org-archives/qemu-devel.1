Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE446C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D1420673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D1420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeKb-0004QS-68
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeB9-0003au-Fq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB7-0000rv-5C
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB6-0000rL-Me
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3C4C18CB8E9;
 Tue, 24 Sep 2019 06:19:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D1A1001947;
 Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3AFF9CBB; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] wavaudio: port to the new audio backend api
Date: Tue, 24 Sep 2019 08:19:47 +0200
Message-Id: <20190924061951.27916-13-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 24 Sep 2019 06:19:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kővágó@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: eede77aeb9c17b379948b0b6d2ac10f45d74fa62.1568927990.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/wavaudio.c | 54 ++++++++----------------------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index b6eeeb4e26ef..78af2f1338d2 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -36,52 +36,28 @@ typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
     int64_t old_ticks;
-    void *pcm_buf;
     int total_samples;
 } WAVVoiceOut;
=20
-static size_t wav_run_out(HWVoiceOut *hw, size_t live)
+static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
-    size_t rpos, decr, samples;
-    uint8_t *dst;
-    struct st_sample *src;
     int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     int64_t ticks =3D now - wav->old_ticks;
     int64_t bytes =3D
         muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECON=
D);
=20
-    if (bytes > INT_MAX) {
-        samples =3D INT_MAX >> hw->info.shift;
-    }
-    else {
-        samples =3D bytes >> hw->info.shift;
-    }
-
+    bytes =3D MIN(bytes, len);
+    bytes =3D bytes >> hw->info.shift << hw->info.shift;
     wav->old_ticks =3D now;
-    decr =3D MIN (live, samples);
-    samples =3D decr;
-    rpos =3D hw->rpos;
-    while (samples) {
-        int left_till_end_samples =3D hw->samples - rpos;
-        int convert_samples =3D MIN (samples, left_till_end_samples);
=20
-        src =3D hw->mix_buf + rpos;
-        dst =3D advance (wav->pcm_buf, rpos << hw->info.shift);
-
-        hw->clip (dst, src, convert_samples);
-        if (fwrite (dst, convert_samples << hw->info.shift, 1, wav->f) !=
=3D 1) {
-            dolog ("wav_run_out: fwrite of %d bytes failed\nReaons: %s\n=
",
-                   convert_samples << hw->info.shift, strerror (errno));
-        }
-
-        rpos =3D (rpos + convert_samples) % hw->samples;
-        samples -=3D convert_samples;
-        wav->total_samples +=3D convert_samples;
+    if (bytes && fwrite(buf, bytes, 1, wav->f) !=3D 1) {
+        dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason=
: %s\n",
+              bytes, strerror(errno));
     }
=20
-    hw->rpos =3D rpos;
-    return decr;
+    wav->total_samples +=3D bytes >> hw->info.shift;
+    return bytes;
 }
=20
 /* VICE code: Store number as little endian. */
@@ -137,13 +113,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
=20
     hw->samples =3D 1024;
-    wav->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
-    if (!wav->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        return -1;
-    }
-
     le_store (hdr + 22, hw->info.nchannels, 2);
     le_store (hdr + 24, hw->info.freq, 4);
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
@@ -153,8 +122,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     if (!wav->f) {
         dolog ("Failed to open wave file `%s'\nReason: %s\n",
                wav_path, strerror(errno));
-        g_free (wav->pcm_buf);
-        wav->pcm_buf =3D NULL;
         return -1;
     }
=20
@@ -208,9 +175,6 @@ static void wav_fini_out (HWVoiceOut *hw)
                wav->f, strerror (errno));
     }
     wav->f =3D NULL;
-
-    g_free (wav->pcm_buf);
-    wav->pcm_buf =3D NULL;
 }
=20
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -234,7 +198,7 @@ static void wav_audio_fini (void *opaque)
 static struct audio_pcm_ops wav_pcm_ops =3D {
     .init_out =3D wav_init_out,
     .fini_out =3D wav_fini_out,
-    .run_out  =3D wav_run_out,
+    .write    =3D wav_write_out,
     .ctl_out  =3D wav_ctl_out,
 };
=20
--=20
2.18.1


