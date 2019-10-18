Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A81CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4FD21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4FD21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMz6-0003Wf-Lw
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtY-0006HR-3o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-000741-Dg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtV-00071j-2y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B623CC044CDA;
 Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 662D45D9CC;
 Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 69CAD9AF5; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] audio: replace shift in audio_pcm_info with
 bytes_per_frame
Date: Fri, 18 Oct 2019 09:41:39 +0200
Message-Id: <20191018074144.24071-9-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

The bit shifting trick worked because the number of bytes per frame was
always a power-of-two (since QEMU only supports mono, stereo and 8, 16
and 32 bit samples).  But if we want to add support for surround sound,
this no longer holds true.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 1351fd9bcce0ff20d81850c5292722194329de02.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h       |  3 +-
 audio/dsound_template.h | 10 +++---
 audio/alsaaudio.c       | 11 +++---
 audio/audio.c           | 74 ++++++++++++++++++++---------------------
 audio/coreaudio.c       |  4 +--
 audio/dsoundaudio.c     |  4 +--
 audio/noaudio.c         |  2 +-
 audio/ossaudio.c        | 14 ++++----
 audio/spiceaudio.c      |  3 +-
 audio/wavaudio.c        |  6 ++--
 10 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9176db249b23..5ba20783463a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -43,8 +43,7 @@ struct audio_pcm_info {
     int sign;
     int freq;
     int nchannels;
-    int align;
-    int shift;
+    int bytes_per_frame;
     int bytes_per_second;
     int swap_endianness;
 };
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 9f10b688df57..7a15f91ce563 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -98,8 +98,8 @@ static int glue (dsound_lock_, TYPE) (
         goto fail;
     }
=20
-    if ((p1p && *p1p && (*blen1p & info->align)) ||
-        (p2p && *p2p && (*blen2p & info->align))) {
+    if ((p1p && *p1p && (*blen1p % info->bytes_per_frame)) ||
+        (p2p && *p2p && (*blen2p % info->bytes_per_frame))) {
         dolog("DirectSound returned misaligned buffer %ld %ld\n",
               *blen1p, *blen2p);
         glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p=
,
@@ -247,14 +247,14 @@ static int dsound_init_out(HWVoiceOut *hw, struct a=
udsettings *as,
     obt_as.endianness =3D 0;
     audio_pcm_init_info (&hw->info, &obt_as);
=20
-    if (bc.dwBufferBytes & hw->info.align) {
+    if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
         dolog (
             "GetCaps returned misaligned buffer size %ld, alignment %d\n=
",
-            bc.dwBufferBytes, hw->info.align + 1
+            bc.dwBufferBytes, hw->info.bytes_per_frame
             );
     }
     hw->size_emul =3D bc.dwBufferBytes;
-    hw->samples =3D bc.dwBufferBytes >> hw->info.shift;
+    hw->samples =3D bc.dwBufferBytes / hw->info.bytes_per_frame;
     ds->s =3D s;
=20
 #ifdef DEBUG_DSOUND
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index cfe42284a6aa..eddf013a537c 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -602,7 +602,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, s=
ize_t len)
 {
     ALSAVoiceOut *alsa =3D (ALSAVoiceOut *) hw;
     size_t pos =3D 0;
-    size_t len_frames =3D len >> hw->info.shift;
+    size_t len_frames =3D len / hw->info.bytes_per_frame;
=20
     while (len_frames) {
         char *src =3D advance(buf, pos);
@@ -648,7 +648,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, s=
ize_t len)
             }
         }
=20
-        pos +=3D written << hw->info.shift;
+        pos +=3D written * hw->info.bytes_per_frame;
         if (written < len_frames) {
             break;
         }
@@ -802,7 +802,8 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, siz=
e_t len)
         void *dst =3D advance(buf, pos);
         snd_pcm_sframes_t nread;
=20
-        nread =3D snd_pcm_readi(alsa->handle, dst, len >> hw->info.shift=
);
+        nread =3D snd_pcm_readi(
+            alsa->handle, dst, len / hw->info.bytes_per_frame);
=20
         if (nread <=3D 0) {
             switch (nread) {
@@ -828,8 +829,8 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, siz=
e_t len)
             }
         }
=20
-        pos +=3D nread << hw->info.shift;
-        len -=3D nread << hw->info.shift;
+        pos +=3D nread * hw->info.bytes_per_frame;
+        len -=3D nread * hw->info.bytes_per_frame;
     }
=20
     return pos;
diff --git a/audio/audio.c b/audio/audio.c
index f1c145dfcdeb..c00f4deddd3d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -299,12 +299,13 @@ static int audio_pcm_info_eq (struct audio_pcm_info=
 *info, struct audsettings *a
=20
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as)
 {
-    int bits =3D 8, sign =3D 0, shift =3D 0;
+    int bits =3D 8, sign =3D 0, mul;
=20
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         sign =3D 1;
     case AUDIO_FORMAT_U8:
+        mul =3D 1;
         break;
=20
     case AUDIO_FORMAT_S16:
@@ -312,7 +313,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
         /* fall through */
     case AUDIO_FORMAT_U16:
         bits =3D 16;
-        shift =3D 1;
+        mul =3D 2;
         break;
=20
     case AUDIO_FORMAT_S32:
@@ -320,7 +321,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
         /* fall through */
     case AUDIO_FORMAT_U32:
         bits =3D 32;
-        shift =3D 2;
+        mul =3D 4;
         break;
=20
     default:
@@ -331,9 +332,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
     info->bits =3D bits;
     info->sign =3D sign;
     info->nchannels =3D as->nchannels;
-    info->shift =3D (as->nchannels =3D=3D 2) + shift;
-    info->align =3D (1 << info->shift) - 1;
-    info->bytes_per_second =3D info->freq << info->shift;
+    info->bytes_per_frame =3D as->nchannels * mul;
+    info->bytes_per_second =3D info->freq * info->bytes_per_frame;
     info->swap_endianness =3D (as->endianness !=3D AUDIO_HOST_ENDIANNESS=
);
 }
=20
@@ -344,26 +344,25 @@ void audio_pcm_info_clear_buf (struct audio_pcm_inf=
o *info, void *buf, int len)
     }
=20
     if (info->sign) {
-        memset (buf, 0x00, len << info->shift);
+        memset(buf, 0x00, len * info->bytes_per_frame);
     }
     else {
         switch (info->bits) {
         case 8:
-            memset (buf, 0x80, len << info->shift);
+            memset(buf, 0x80, len * info->bytes_per_frame);
             break;
=20
         case 16:
             {
                 int i;
                 uint16_t *p =3D buf;
-                int shift =3D info->nchannels - 1;
                 short s =3D INT16_MAX;
=20
                 if (info->swap_endianness) {
                     s =3D bswap16 (s);
                 }
=20
-                for (i =3D 0; i < len << shift; i++) {
+                for (i =3D 0; i < len * info->nchannels; i++) {
                     p[i] =3D s;
                 }
             }
@@ -373,14 +372,13 @@ void audio_pcm_info_clear_buf (struct audio_pcm_inf=
o *info, void *buf, int len)
             {
                 int i;
                 uint32_t *p =3D buf;
-                int shift =3D info->nchannels - 1;
                 int32_t s =3D INT32_MAX;
=20
                 if (info->swap_endianness) {
                     s =3D bswap32 (s);
                 }
=20
-                for (i =3D 0; i < len << shift; i++) {
+                for (i =3D 0; i < len * info->nchannels; i++) {
                     p[i] =3D s;
                 }
             }
@@ -558,7 +556,7 @@ static void audio_pcm_hw_clip_out(HWVoiceOut *hw, voi=
d *pcm_buf, size_t len)
=20
     while (len) {
         st_sample *src =3D hw->mix_buf->samples + pos;
-        uint8_t *dst =3D advance(pcm_buf, clipped << hw->info.shift);
+        uint8_t *dst =3D advance(pcm_buf, clipped * hw->info.bytes_per_f=
rame);
         size_t samples_till_end_of_buf =3D hw->mix_buf->size - pos;
         size_t samples_to_clip =3D MIN(len, samples_till_end_of_buf);
=20
@@ -607,7 +605,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *=
buf, size_t size)
         return 0;
     }
=20
-    samples =3D size >> sw->info.shift;
+    samples =3D size / sw->info.bytes_per_frame;
     if (!live) {
         return 0;
     }
@@ -642,7 +640,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *=
buf, size_t size)
=20
     sw->clip (buf, sw->buf, ret);
     sw->total_hw_samples_acquired +=3D total;
-    return ret << sw->info.shift;
+    return ret * sw->info.bytes_per_frame;
 }
=20
 /*
@@ -715,7 +713,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void=
 *buf, size_t size)
     }
=20
     wpos =3D (sw->hw->mix_buf->pos + live) % hwsamples;
-    samples =3D size >> sw->info.shift;
+    samples =3D size / sw->info.bytes_per_frame;
=20
     dead =3D hwsamples - live;
     swlim =3D ((int64_t) dead << 32) / sw->ratio;
@@ -759,13 +757,13 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, vo=
id *buf, size_t size)
     dolog (
         "%s: write size %zu ret %zu total sw %zu\n",
         SW_NAME (sw),
-        size >> sw->info.shift,
+        size / sw->info.bytes_per_frame,
         ret,
         sw->total_hw_samples_mixed
         );
 #endif
=20
-    return ret << sw->info.shift;
+    return ret * sw->info.bytes_per_frame;
 }
=20
 #ifdef DEBUG_AUDIO
@@ -882,7 +880,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size=
)
=20
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
 {
-    return sw->hw->mix_buf->size << sw->hw->info.shift;
+    return sw->hw->mix_buf->size * sw->hw->info.bytes_per_frame;
 }
=20
 void AUD_set_active_out (SWVoiceOut *sw, int on)
@@ -998,10 +996,10 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     ldebug (
         "%s: get_avail live %d ret %" PRId64 "\n",
         SW_NAME (sw),
-        live, (((int64_t) live << 32) / sw->ratio) << sw->info.shift
+        live, (((int64_t) live << 32) / sw->ratio) * sw->info.bytes_per_=
frame
         );
=20
-    return (((int64_t) live << 32) / sw->ratio) << sw->info.shift;
+    return (((int64_t) live << 32) / sw->ratio) * sw->info.bytes_per_fra=
me;
 }
=20
 static size_t audio_get_free(SWVoiceOut *sw)
@@ -1025,10 +1023,11 @@ static size_t audio_get_free(SWVoiceOut *sw)
 #ifdef DEBUG_OUT
     dolog ("%s: get_free live %d dead %d ret %" PRId64 "\n",
            SW_NAME (sw),
-           live, dead, (((int64_t) dead << 32) / sw->ratio) << sw->info.=
shift);
+           live, dead, (((int64_t) dead << 32) / sw->ratio) *
+           sw->info.bytes_per_frame);
 #endif
=20
-    return (((int64_t) dead << 32) / sw->ratio) << sw->info.shift;
+    return (((int64_t) dead << 32) / sw->ratio) * sw->info.bytes_per_fra=
me;
 }
=20
 static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
@@ -1047,7 +1046,7 @@ static void audio_capture_mix_and_clear(HWVoiceOut =
*hw, size_t rpos,
             while (n) {
                 size_t till_end_of_hw =3D hw->mix_buf->size - rpos2;
                 size_t to_write =3D MIN(till_end_of_hw, n);
-                size_t bytes =3D to_write << hw->info.shift;
+                size_t bytes =3D to_write * hw->info.bytes_per_frame;
                 size_t written;
=20
                 sw->buf =3D hw->mix_buf->samples + rpos2;
@@ -1082,10 +1081,11 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw=
, size_t live)
             return clipped + live;
         }
=20
-        decr =3D MIN(size >> hw->info.shift, live);
+        decr =3D MIN(size / hw->info.bytes_per_frame, live);
         audio_pcm_hw_clip_out(hw, buf, decr);
-        proc =3D hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.s=
hift) >>
-            hw->info.shift;
+        proc =3D hw->pcm_ops->put_buffer_out(hw, buf,
+                                           decr * hw->info.bytes_per_fra=
me) /
+            hw->info.bytes_per_frame;
=20
         live -=3D proc;
         clipped +=3D proc;
@@ -1234,16 +1234,16 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, =
size_t samples)
=20
     while (samples) {
         size_t proc;
-        size_t size =3D samples << hw->info.shift;
+        size_t size =3D samples * hw->info.bytes_per_frame;
         void *buf =3D hw->pcm_ops->get_buffer_in(hw, &size);
=20
-        assert((size & hw->info.align) =3D=3D 0);
+        assert(size % hw->info.bytes_per_frame =3D=3D 0);
         if (size =3D=3D 0) {
             hw->pcm_ops->put_buffer_in(hw, buf, size);
             break;
         }
=20
-        proc =3D MIN(size >> hw->info.shift,
+        proc =3D MIN(size / hw->info.bytes_per_frame,
                    conv_buf->size - conv_buf->pos);
=20
         hw->conv(conv_buf->samples + conv_buf->pos, buf, proc);
@@ -1251,7 +1251,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, si=
ze_t samples)
=20
         samples -=3D proc;
         conv +=3D proc;
-        hw->pcm_ops->put_buffer_in(hw, buf, proc << hw->info.shift);
+        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_fr=
ame);
     }
=20
     return conv;
@@ -1325,7 +1325,7 @@ static void audio_run_capture (AudioState *s)
=20
             for (cb =3D cap->cb_head.lh_first; cb; cb =3D cb->entries.le=
_next) {
                 cb->ops.capture (cb->opaque, cap->buf,
-                                 to_capture << hw->info.shift);
+                                 to_capture * hw->info.bytes_per_frame);
             }
             rpos =3D (rpos + to_capture) % hw->mix_buf->size;
             live -=3D to_capture;
@@ -1378,7 +1378,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, si=
ze_t *size)
     ssize_t start;
=20
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size =3D hw->conv_buf->size << hw->info.shift;
+        size_t calc_size =3D hw->conv_buf->size * hw->info.bytes_per_fra=
me;
         hw->buf_emul =3D g_malloc(calc_size);
         hw->size_emul =3D calc_size;
         hw->pos_emul =3D hw->pending_emul =3D 0;
@@ -1414,7 +1414,7 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, voi=
d *buf, size_t size)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size =3D hw->mix_buf->size << hw->info.shift;
+        size_t calc_size =3D hw->mix_buf->size * hw->info.bytes_per_fram=
e;
=20
         hw->buf_emul =3D g_malloc(calc_size);
         hw->size_emul =3D calc_size;
@@ -1833,7 +1833,7 @@ CaptureVoiceOut *AUD_add_capture(
=20
         audio_pcm_init_info (&hw->info, as);
=20
-        cap->buf =3D g_malloc0_n(hw->mix_buf->size, 1 << hw->info.shift)=
;
+        cap->buf =3D g_malloc0_n(hw->mix_buf->size, hw->info.bytes_per_f=
rame);
=20
         hw->clip =3D mixeng_clip
             [hw->info.nchannels =3D=3D 2]
@@ -2153,14 +2153,14 @@ size_t audio_rate_get_bytes(struct audio_pcm_info=
 *info, RateCtl *rate,
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks =3D now - rate->start_ticks;
     bytes =3D muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SE=
COND);
-    samples =3D (bytes - rate->bytes_sent) >> info->shift;
+    samples =3D (bytes - rate->bytes_sent) / info->bytes_per_frame;
     if (samples < 0 || samples > 65536) {
         AUD_log(NULL, "Resetting rate control (%" PRId64 " samples)\n", =
samples);
         audio_rate_start(rate);
         samples =3D 0;
     }
=20
-    ret =3D MIN(samples << info->shift, bytes_avail);
+    ret =3D MIN(samples * info->bytes_per_frame, bytes_avail);
     rate->bytes_sent +=3D ret;
     return ret;
 }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 1427c9f622d9..66f0f459cf09 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -440,7 +440,7 @@ static OSStatus audioDeviceIOProc(
     }
=20
     frameCount =3D core->audioDevicePropertyBufferFrameSize;
-    pending_frames =3D hw->pending_emul >> hw->info.shift;
+    pending_frames =3D hw->pending_emul / hw->info.bytes_per_frame;
=20
     /* if there are not enough samples, set signal and return */
     if (pending_frames < frameCount) {
@@ -449,7 +449,7 @@ static OSStatus audioDeviceIOProc(
         return 0;
     }
=20
-    len =3D frameCount << hw->info.shift;
+    len =3D frameCount * hw->info.bytes_per_frame;
     while (len) {
         size_t write_len;
         ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index d4a4757445b0..c265c0094b9f 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -320,8 +320,8 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDI=
RECTSOUNDBUFFER dsb,
         return;
     }
=20
-    len1 =3D blen1 >> hw->info.shift;
-    len2 =3D blen2 >> hw->info.shift;
+    len1 =3D blen1 / hw->info.bytes_per_frame;
+    len2 =3D blen2 / hw->info.bytes_per_frame;
=20
 #ifdef DEBUG_DSOUND
     dolog ("clear %p,%ld,%ld %p,%ld,%ld\n",
diff --git a/audio/noaudio.c b/audio/noaudio.c
index ec8a287f3689..ff99b253ff0b 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -91,7 +91,7 @@ static size_t no_read(HWVoiceIn *hw, void *buf, size_t =
size)
     NoVoiceIn *no =3D (NoVoiceIn *) hw;
     int64_t bytes =3D audio_rate_get_bytes(&hw->info, &no->rate, size);
=20
-    audio_pcm_info_clear_buf(&hw->info, buf, bytes >> hw->info.shift);
+    audio_pcm_info_clear_buf(&hw->info, buf, bytes / hw->info.bytes_per_=
frame);
     return bytes;
 }
=20
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0c4451e972de..c43faeeea4aa 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -506,16 +506,16 @@ static int oss_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
     oss->nfrags =3D obt.nfrags;
     oss->fragsize =3D obt.fragsize;
=20
-    if (obt.nfrags * obt.fragsize & hw->info.align) {
+    if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
         dolog ("warning: Misaligned DAC buffer, size %d, alignment %d\n"=
,
-               obt.nfrags * obt.fragsize, hw->info.align + 1);
+               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
=20
-    hw->samples =3D (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    hw->samples =3D (obt.nfrags * obt.fragsize) / hw->info.bytes_per_fra=
me;
=20
     oss->mmapped =3D 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        hw->size_emul =3D hw->samples << hw->info.shift;
+        hw->size_emul =3D hw->samples * hw->info.bytes_per_frame;
         hw->buf_emul =3D mmap(
             NULL,
             hw->size_emul,
@@ -644,12 +644,12 @@ static int oss_init_in(HWVoiceIn *hw, struct audset=
tings *as, void *drv_opaque)
     oss->nfrags =3D obt.nfrags;
     oss->fragsize =3D obt.fragsize;
=20
-    if (obt.nfrags * obt.fragsize & hw->info.align) {
+    if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
         dolog ("warning: Misaligned ADC buffer, size %d, alignment %d\n"=
,
-               obt.nfrags * obt.fragsize, hw->info.align + 1);
+               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
=20
-    hw->samples =3D (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    hw->samples =3D (obt.nfrags * obt.fragsize) / hw->info.bytes_per_fra=
me;
=20
     oss->fd =3D fd;
     oss->dev =3D dev;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6ed7f7a79e39..b6b5da4812f2 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -131,7 +131,8 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size=
_t *size)
=20
     if (out->frame) {
         *size =3D audio_rate_get_bytes(
-            &hw->info, &out->rate, (out->fsize - out->fpos) << hw->info.=
shift);
+            &hw->info, &out->rate,
+            (out->fsize - out->fpos) * hw->info.bytes_per_frame);
     } else {
         audio_rate_start(&out->rate);
     }
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 47efdc1b1eab..e46d834bd3af 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -43,14 +43,14 @@ static size_t wav_write_out(HWVoiceOut *hw, void *buf=
, size_t len)
 {
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
     int64_t bytes =3D audio_rate_get_bytes(&hw->info, &wav->rate, len);
-    assert(bytes >> hw->info.shift << hw->info.shift =3D=3D bytes);
+    assert(bytes % hw->info.bytes_per_frame =3D=3D 0);
=20
     if (bytes && fwrite(buf, bytes, 1, wav->f) !=3D 1) {
         dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason=
: %s\n",
               bytes, strerror(errno));
     }
=20
-    wav->total_samples +=3D bytes >> hw->info.shift;
+    wav->total_samples +=3D bytes / hw->info.bytes_per_frame;
     return bytes;
 }
=20
@@ -134,7 +134,7 @@ static void wav_fini_out (HWVoiceOut *hw)
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
     uint8_t rlen[4];
     uint8_t dlen[4];
-    uint32_t datalen =3D wav->total_samples << hw->info.shift;
+    uint32_t datalen =3D wav->total_samples * hw->info.bytes_per_frame;
     uint32_t rifflen =3D datalen + 36;
=20
     if (!wav->f) {
--=20
2.18.1


