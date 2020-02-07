Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE7C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C77217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItZh+x2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C77217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyMo-0007Vy-2G
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL4-0005bu-Gc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL2-0003OV-AQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL2-0003Mn-4k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpodeLoHODTT0Fe0A8ysMj+Un2s73OUY//UHNY5Mkks=;
 b=ItZh+x2Rh5q3AiJuoHveQV8CXZYfwbDl6ECeiVDSG32+pM0xJau3fW9M8zOOC85aBkmvvd
 FglnRLXxKRk9NX60NcT4mVKA6xjheXKtilv9+MjEhGRhCZQDanXopPPuzLpkVbqGt5ztVz
 3tX9O8zYkU4oL3B/mQI99WCCBGx9kVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-8DSf46FcPf6CyruaIyb5ww-1; Fri, 07 Feb 2020 02:46:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEAFC10054E3;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 101EA60BF7;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1AC0131EC0; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] audio: fix bug 1858488
Date: Fri,  7 Feb 2020 08:45:51 +0100
Message-Id: <20200207074557.26073-7-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8DSf46FcPf6CyruaIyb5ww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The combined generic buffer management code and buffer run out
code in function audio_generic_put_buffer_out has a problematic
behaviour. A few hundred milliseconds after playback starts the
mixing buffer and the generic buffer are nearly full and the
following pattern can be seen.

On first call of audio_pcm_hw_run_out the buffer run code in
audio_generic_put_buffer_out writes some data to the audio
hardware but the generic buffer will fill faster and is full
when audio_pcm_hw_run_out returns. This is because emulated
audio devices can produce playback data at a higher rate than
the audio backend hardware consumes this data.

On next call of audio_pcm_hw_run_out the buffer run code in
audio_generic_put_buffer_out writes some data to the audio
hardware but no audio data is transferred to the generic buffer
because the buffer is already full.

Then the pattern repeats. For the emulated audio device this
looks like the audio timer period has doubled.

This patch splits the combined generic buffer management code
and buffer run out code and calls the buffer run out code after
buffer management code to break this pattern.

The bug report is for the wav audio backend. But the problem is
not limited to this backend. All audio backends which use the
audio_generic_put_buffer_out function show this problem.

Buglink: https://bugs.launchpad.net/qemu/+bug/1858488
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-5-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h |  4 +--
 audio/alsaaudio.c |  1 +
 audio/audio.c     | 64 ++++++++++++++++++++++-------------------------
 audio/coreaudio.c |  7 ++++--
 audio/noaudio.c   |  1 +
 audio/ossaudio.c  | 10 ++++++++
 audio/sdlaudio.c  |  7 ++++--
 audio/wavaudio.c  |  1 +
 8 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5ba20783463a..3c8e48b55b1c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -152,6 +152,7 @@ struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    void   (*run_buffer_out)(HWVoiceOut *hw);
     /*
      * get a buffer that after later can be passed to put_buffer_out; opti=
onal
      * returns the buffer, and writes it's size to size (in bytes)
@@ -178,10 +179,9 @@ struct audio_pcm_ops {
=20
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_run_buffer_out(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
 size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size=
);
-size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
-                                            size_t size);
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
=20
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index f37ce1ce8570..4ef26818be57 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -906,6 +906,7 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
     .init_out =3D alsa_init_out,
     .fini_out =3D alsa_fini_out,
     .write    =3D alsa_write,
+    .run_buffer_out =3D audio_generic_run_buffer_out,
     .enable_out =3D alsa_enable_out,
=20
     .init_in  =3D alsa_init_in,
diff --git a/audio/audio.c b/audio/audio.c
index 12ed318813f4..b686429203d6 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1097,6 +1097,10 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, s=
ize_t live)
         }
     }
=20
+    if (hw->pcm_ops->run_buffer_out) {
+        hw->pcm_ops->run_buffer_out(hw);
+    }
+
     return clipped;
 }
=20
@@ -1413,40 +1417,12 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, voi=
d *buf, size_t size)
     hw->pending_emul -=3D size;
 }
=20
-void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
+void audio_generic_run_buffer_out(HWVoiceOut *hw)
 {
-    if (unlikely(!hw->buf_emul)) {
-        size_t calc_size =3D hw->mix_buf->size * hw->info.bytes_per_frame;
-
-        hw->buf_emul =3D g_malloc(calc_size);
-        hw->size_emul =3D calc_size;
-        hw->pos_emul =3D hw->pending_emul =3D 0;
-    }
-
-    *size =3D MIN(hw->size_emul - hw->pending_emul,
-                hw->size_emul - hw->pos_emul);
-    return hw->buf_emul + hw->pos_emul;
-}
-
-size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
-                                            size_t size)
-{
-    assert(buf =3D=3D hw->buf_emul + hw->pos_emul &&
-           size + hw->pending_emul <=3D hw->size_emul);
-
-    hw->pending_emul +=3D size;
-    hw->pos_emul =3D (hw->pos_emul + size) % hw->size_emul;
-
-    return size;
-}
-
-size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size=
)
-{
-    audio_generic_put_buffer_out_nowrite(hw, buf, size);
-
     while (hw->pending_emul) {
         size_t write_len, written;
         ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
+
         if (start < 0) {
             start +=3D hw->size_emul;
         }
@@ -1461,11 +1437,31 @@ size_t audio_generic_put_buffer_out(HWVoiceOut *hw,=
 void *buf, size_t size)
             break;
         }
     }
+}
+
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size =3D hw->mix_buf->size * hw->info.bytes_per_frame;
+
+        hw->buf_emul =3D g_malloc(calc_size);
+        hw->size_emul =3D calc_size;
+        hw->pos_emul =3D hw->pending_emul =3D 0;
+    }
+
+    *size =3D MIN(hw->size_emul - hw->pending_emul,
+                hw->size_emul - hw->pos_emul);
+    return hw->buf_emul + hw->pos_emul;
+}
+
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size=
)
+{
+    assert(buf =3D=3D hw->buf_emul + hw->pos_emul &&
+           size + hw->pending_emul <=3D hw->size_emul);
+
+    hw->pending_emul +=3D size;
+    hw->pos_emul =3D (hw->pos_emul + size) % hw->size_emul;
=20
-    /*
-     * fake we have written everything. non-written data remain in pending=
_emul,
-     * so we do not have to clip them multiple times
-     */
     return size;
 }
=20
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 66f0f459cf09..c7a7196c2d53 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -411,7 +411,7 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, c=
onst char *fn_name)
     }
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *si=
ze),
                        (hw, size))
-COREAUDIO_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+COREAUDIO_WRAPPER_FUNC(put_buffer_out, size_t,
                        (HWVoiceOut *hw, void *buf, size_t size),
                        (hw, buf, size))
 COREAUDIO_WRAPPER_FUNC(write, size_t, (HWVoiceOut *hw, void *buf, size_t s=
ize),
@@ -687,9 +687,12 @@ static void coreaudio_audio_fini (void *opaque)
 static struct audio_pcm_ops coreaudio_pcm_ops =3D {
     .init_out =3D coreaudio_init_out,
     .fini_out =3D coreaudio_fini_out,
+  /* wrapper for audio_generic_write */
     .write    =3D coreaudio_write,
+  /* wrapper for audio_generic_get_buffer_out */
     .get_buffer_out =3D coreaudio_get_buffer_out,
-    .put_buffer_out =3D coreaudio_put_buffer_out_nowrite,
+  /* wrapper for audio_generic_put_buffer_out */
+    .put_buffer_out =3D coreaudio_put_buffer_out,
     .enable_out =3D coreaudio_enable_out
 };
=20
diff --git a/audio/noaudio.c b/audio/noaudio.c
index ff99b253ff0b..05798ea21032 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -118,6 +118,7 @@ static struct audio_pcm_ops no_pcm_ops =3D {
     .init_out =3D no_init_out,
     .fini_out =3D no_fini_out,
     .write    =3D no_write,
+    .run_buffer_out =3D audio_generic_run_buffer_out,
     .enable_out =3D no_enable_out,
=20
     .init_in  =3D no_init_in,
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 94564916fbf0..576b5b5b2021 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -382,6 +382,15 @@ static size_t oss_get_available_bytes(OSSVoiceOut *oss=
)
     return audio_ring_dist(cntinfo.ptr, oss->hw.pos_emul, oss->hw.size_emu=
l);
 }
=20
+static void oss_run_buffer_out(HWVoiceOut *hw)
+{
+    OSSVoiceOut *oss =3D (OSSVoiceOut *)hw;
+
+    if (!oss->mmapped) {
+        audio_generic_run_buffer_out(hw);
+    }
+}
+
 static void *oss_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
@@ -748,6 +757,7 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
     .init_out =3D oss_init_out,
     .fini_out =3D oss_fini_out,
     .write    =3D oss_write,
+    .run_buffer_out =3D oss_run_buffer_out,
     .get_buffer_out =3D oss_get_buffer_out,
     .put_buffer_out =3D oss_put_buffer_out,
     .enable_out =3D oss_enable_out,
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 5c6bcfcb3e9d..c00e7d784523 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -227,7 +227,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int=
 len)
=20
 SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                  (hw, size), *size =3D 0, sdl_unlock)
-SDL_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+SDL_WRAPPER_FUNC(put_buffer_out, size_t,
                  (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size)=
,
                  /*nothing*/, sdl_unlock_and_post)
 SDL_WRAPPER_FUNC(write, size_t,
@@ -320,9 +320,12 @@ static void sdl_audio_fini (void *opaque)
 static struct audio_pcm_ops sdl_pcm_ops =3D {
     .init_out =3D sdl_init_out,
     .fini_out =3D sdl_fini_out,
+  /* wrapper for audio_generic_write */
     .write    =3D sdl_write,
+  /* wrapper for audio_generic_get_buffer_out */
     .get_buffer_out =3D sdl_get_buffer_out,
-    .put_buffer_out =3D sdl_put_buffer_out_nowrite,
+  /* wrapper for audio_generic_put_buffer_out */
+    .put_buffer_out =3D sdl_put_buffer_out,
     .enable_out =3D sdl_enable_out,
 };
=20
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index e46d834bd3af..20e6853f8586 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -197,6 +197,7 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
     .init_out =3D wav_init_out,
     .fini_out =3D wav_fini_out,
     .write    =3D wav_write_out,
+    .run_buffer_out =3D audio_generic_run_buffer_out,
     .enable_out =3D wav_enable_out,
 };
=20
--=20
2.18.1


