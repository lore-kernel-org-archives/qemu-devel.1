Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B11C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1636524655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1636524655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXIu-0001yr-WC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFY-0005uX-Dt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFT-0004Vu-Ls
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:49:57 -0500
Received: from mailout11.t-online.de ([194.25.134.85]:52744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iuXFT-0004VK-CI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:49:55 -0500
Received: from fwd40.aul.t-online.de (fwd40.aul.t-online.de [172.20.26.139])
 by mailout11.t-online.de (Postfix) with SMTP id 30954420CDFB;
 Thu, 23 Jan 2020 08:49:54 +0100 (CET)
Received: from linpower.localnet
 (VrguKZZOoh40tqYGygox7FLrBknOndn7kcFfFB18UsCLDaDN3qBd5ezq3imjsjEZ+1@[46.86.62.122])
 by fwd40.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iuXFR-1DOQNM0; Thu, 23 Jan 2020 08:49:53 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5ACA9200F62; Thu, 23 Jan 2020 08:49:43 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/9] audio: fix bug 1858488
Date: Thu, 23 Jan 2020 08:49:39 +0100
Message-Id: <20200123074943.6699-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: VrguKZZOoh40tqYGygox7FLrBknOndn7kcFfFB18UsCLDaDN3qBd5ezq3imjsjEZ+1
X-TOI-MSGID: c6c8b1db-2cc9-4b1d-8350-9a559601e7f8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.85
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/alsaaudio.c |  1 +
 audio/audio.c     | 58 ++++++++++++++++++++++++++-----------------------=
------
 audio/audio_int.h |  4 ++--
 audio/coreaudio.c |  7 +++++--
 audio/noaudio.c   |  1 +
 audio/ossaudio.c  | 10 ++++++++++
 audio/sdlaudio.c  |  7 +++++--
 audio/wavaudio.c  |  1 +
 8 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index f37ce1ce85..4ef26818be 100644
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
index 922e95011c..81822bfec9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1096,6 +1096,10 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw,=
 size_t live)
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
@@ -1412,6 +1416,28 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, vo=
id *buf, size_t size)
     hw->pending_emul -=3D size;
 }
=20
+void audio_generic_run_buffer_out(HWVoiceOut *hw)
+{
+    while (hw->pending_emul) {
+        size_t write_len, written;
+        ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
+
+        if (start < 0) {
+            start +=3D hw->size_emul;
+        }
+        assert(start >=3D 0 && start < hw->size_emul);
+
+        write_len =3D MIN(hw->pending_emul, hw->size_emul - start);
+
+        written =3D hw->pcm_ops->write(hw, hw->buf_emul + start, write_l=
en);
+        hw->pending_emul -=3D written;
+
+        if (written < write_len) {
+            break;
+        }
+    }
+}
+
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
@@ -1427,8 +1453,7 @@ void *audio_generic_get_buffer_out(HWVoiceOut *hw, =
size_t *size)
     return hw->buf_emul + hw->pos_emul;
 }
=20
-size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
-                                            size_t size)
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t si=
ze)
 {
     assert(buf =3D=3D hw->buf_emul + hw->pos_emul &&
            size + hw->pending_emul <=3D hw->size_emul);
@@ -1439,35 +1464,6 @@ size_t audio_generic_put_buffer_out_nowrite(HWVoic=
eOut *hw, void *buf,
     return size;
 }
=20
-size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t si=
ze)
-{
-    audio_generic_put_buffer_out_nowrite(hw, buf, size);
-
-    while (hw->pending_emul) {
-        size_t write_len, written;
-        ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
-        if (start < 0) {
-            start +=3D hw->size_emul;
-        }
-        assert(start >=3D 0 && start < hw->size_emul);
-
-        write_len =3D MIN(hw->pending_emul, hw->size_emul - start);
-
-        written =3D hw->pcm_ops->write(hw, hw->buf_emul + start, write_l=
en);
-        hw->pending_emul -=3D written;
-
-        if (written < write_len) {
-            break;
-        }
-    }
-
-    /*
-     * fake we have written everything. non-written data remain in pendi=
ng_emul,
-     * so we do not have to clip them multiple times
-     */
-    return size;
-}
-
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 {
     size_t dst_size, copy_size;
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5ba2078346..3c8e48b55b 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -152,6 +152,7 @@ struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque=
);
     void   (*fini_out)(HWVoiceOut *hw);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    void   (*run_buffer_out)(HWVoiceOut *hw);
     /*
      * get a buffer that after later can be passed to put_buffer_out; op=
tional
      * returns the buffer, and writes it's size to size (in bytes)
@@ -178,10 +179,9 @@ struct audio_pcm_ops {
=20
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_run_buffer_out(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
 size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t si=
ze);
-size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
-                                            size_t size);
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
=20
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 66f0f459cf..c7a7196c2d 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -411,7 +411,7 @@ static int coreaudio_unlock (coreaudioVoiceOut *core,=
 const char *fn_name)
     }
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *=
size),
                        (hw, size))
-COREAUDIO_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+COREAUDIO_WRAPPER_FUNC(put_buffer_out, size_t,
                        (HWVoiceOut *hw, void *buf, size_t size),
                        (hw, buf, size))
 COREAUDIO_WRAPPER_FUNC(write, size_t, (HWVoiceOut *hw, void *buf, size_t=
 size),
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
index ff99b253ff..05798ea210 100644
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
index c43faeeea4..4965084a5a 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -382,6 +382,15 @@ static size_t oss_get_available_bytes(OSSVoiceOut *o=
ss)
     return audio_ring_dist(cntinfo.ptr, oss->hw.pos_emul, oss->hw.size_e=
mul);
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
index 5c6bcfcb3e..c00e7d7845 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -227,7 +227,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, i=
nt len)
=20
 SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                  (hw, size), *size =3D 0, sdl_unlock)
-SDL_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+SDL_WRAPPER_FUNC(put_buffer_out, size_t,
                  (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, siz=
e),
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
index e46d834bd3..20e6853f85 100644
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
2.16.4


