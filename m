Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD9EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73ED1218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ED1218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsMp-0003EN-MD
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvo-0005BU-QB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvd-0000ER-Ny
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvd-0000Cr-20
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1515A18CB8EA;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A26C1001B09;
 Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E2AFA9CAE; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:15 +0200
Message-Id: <20190919083629.29998-13-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/26] audio: unify input and output mixeng
 buffer management
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

Usage notes: hw->samples became hw->{mix,conv}_buf->size, except before
initialization (audio_pcm_hw_alloc_resources_*), hw->samples gives the
initial size of the STSampleBuffer.  The next commit tries to fix this
inconsistency.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: c79a75db0d6abf1d86332c6ed354e6254ed2305f.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h      |  12 ++--
 audio/audio_template.h |  19 +++----
 audio/audio.c          | 122 +++++++++++++++++++++--------------------
 audio/ossaudio.c       |   3 +-
 4 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index c76d7c39e84c..20021df9e8be 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -52,6 +52,11 @@ struct audio_pcm_info {
 typedef struct AudioState AudioState;
 typedef struct SWVoiceCap SWVoiceCap;
=20
+typedef struct STSampleBuffer {
+    size_t pos, size;
+    st_sample samples[];
+} STSampleBuffer;
+
 typedef struct HWVoiceOut {
     AudioState *s;
     int enabled;
@@ -60,11 +65,9 @@ typedef struct HWVoiceOut {
     struct audio_pcm_info info;
=20
     f_sample *clip;
-
-    size_t rpos;
     uint64_t ts_helper;
=20
-    struct st_sample *mix_buf;
+    STSampleBuffer *mix_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
=20
@@ -84,11 +87,10 @@ typedef struct HWVoiceIn {
=20
     t_sample *conv;
=20
-    size_t wpos;
     size_t total_samples_captured;
     uint64_t ts_helper;
=20
-    struct st_sample *conv_buf;
+    STSampleBuffer *conv_buf;
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
=20
diff --git a/audio/audio_template.h b/audio/audio_template.h
index ff4a173f1810..87c6d2d27102 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -76,16 +76,15 @@ static void glue (audio_pcm_hw_free_resources_, TYPE)=
 (HW *hw)
     HWBUF =3D NULL;
 }
=20
-static bool glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
+static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    HWBUF =3D audio_calloc(__func__, hw->samples, sizeof(struct st_sampl=
e));
-    if (!HWBUF) {
-        dolog("Could not allocate " NAME " buffer (%zu samples)\n",
-              hw->samples);
-        return false;
+    size_t samples =3D hw->samples;
+    if (audio_bug(__func__, samples =3D=3D 0)) {
+        dolog("Attempted to allocate empty buffer\n");
     }
=20
-    return true;
+    HWBUF =3D g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * sam=
ples);
+    HWBUF->size =3D samples;
 }
=20
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -104,7 +103,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE)=
 (SW *sw)
 {
     int samples;
=20
-    samples =3D ((int64_t) sw->hw->samples << 32) / sw->ratio;
+    samples =3D ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
=20
     sw->buf =3D audio_calloc(__func__, samples, sizeof(struct st_sample)=
);
     if (!sw->buf) {
@@ -280,9 +279,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
=20
-    if (!glue(audio_pcm_hw_alloc_resources_, TYPE)(hw)) {
-        goto err1;
-    }
+    glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
=20
     QLIST_INSERT_HEAD (&s->glue (hw_head_, TYPE), hw, entries);
     glue (s->nb_hw_voices_, TYPE) -=3D 1;
diff --git a/audio/audio.c b/audio/audio.c
index 435bcf20c139..ba07fb77dd4f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -544,8 +544,8 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw=
)
 static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live =3D hw->total_samples_captured - audio_pcm_hw_find_min_i=
n (hw);
-    if (audio_bug(__func__, live > hw->samples)) {
-        dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->conv_buf->size)) {
+        dolog("live=3D%zu hw->conv_buf->size=3D%zu\n", live, hw->conv_bu=
f->size);
         return 0;
     }
     return live;
@@ -554,17 +554,17 @@ static size_t audio_pcm_hw_get_live_in(HWVoiceIn *h=
w)
 static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t =
len)
 {
     size_t clipped =3D 0;
-    size_t pos =3D hw->rpos;
+    size_t pos =3D hw->mix_buf->pos;
=20
     while (len) {
-        st_sample *src =3D hw->mix_buf + pos;
+        st_sample *src =3D hw->mix_buf->samples + pos;
         uint8_t *dst =3D advance(pcm_buf, clipped << hw->info.shift);
-        size_t samples_till_end_of_buf =3D hw->samples - pos;
+        size_t samples_till_end_of_buf =3D hw->mix_buf->size - pos;
         size_t samples_to_clip =3D MIN(len, samples_till_end_of_buf);
=20
         hw->clip(dst, src, samples_to_clip);
=20
-        pos =3D (pos + samples_to_clip) % hw->samples;
+        pos =3D (pos + samples_to_clip) % hw->mix_buf->size;
         len -=3D samples_to_clip;
         clipped +=3D samples_to_clip;
     }
@@ -579,17 +579,17 @@ static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *s=
w)
     ssize_t live =3D hw->total_samples_captured - sw->total_hw_samples_a=
cquired;
     ssize_t rpos;
=20
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live < 0 || live > hw->conv_buf->size)) {
+        dolog("live=3D%zu hw->conv_buf->size=3D%zu\n", live, hw->conv_bu=
f->size);
         return 0;
     }
=20
-    rpos =3D hw->wpos - live;
+    rpos =3D hw->conv_buf->pos - live;
     if (rpos >=3D 0) {
         return rpos;
     }
     else {
-        return hw->samples + rpos;
+        return hw->conv_buf->size + rpos;
     }
 }
=20
@@ -599,11 +599,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void=
 *buf, size_t size)
     size_t samples, live, ret =3D 0, swlim, isamp, osamp, rpos, total =3D=
 0;
     struct st_sample *src, *dst =3D sw->buf;
=20
-    rpos =3D audio_pcm_sw_get_rpos_in (sw) % hw->samples;
+    rpos =3D audio_pcm_sw_get_rpos_in(sw) % hw->conv_buf->size;
=20
     live =3D hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live > hw->samples)) {
-        dolog("live_in=3D%zu hw->samples=3D%zu\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->conv_buf->size)) {
+        dolog("live_in=3D%zu hw->conv_buf->size=3D%zu\n", live, hw->conv=
_buf->size);
         return 0;
     }
=20
@@ -616,11 +616,11 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void=
 *buf, size_t size)
     swlim =3D MIN (swlim, samples);
=20
     while (swlim) {
-        src =3D hw->conv_buf + rpos;
-        if (hw->wpos > rpos) {
-            isamp =3D hw->wpos - rpos;
+        src =3D hw->conv_buf->samples + rpos;
+        if (hw->conv_buf->pos > rpos) {
+            isamp =3D hw->conv_buf->pos - rpos;
         } else {
-            isamp =3D hw->samples - rpos;
+            isamp =3D hw->conv_buf->size - rpos;
         }
=20
         if (!isamp) {
@@ -630,7 +630,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *=
buf, size_t size)
=20
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -=3D osamp;
-        rpos =3D (rpos + isamp) % hw->samples;
+        rpos =3D (rpos + isamp) % hw->conv_buf->size;
         dst +=3D osamp;
         ret +=3D osamp;
         total +=3D isamp;
@@ -678,8 +678,8 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *=
hw, int *nb_live)
     if (nb_live1) {
         size_t live =3D smin;
=20
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog("live=3D%zu hw->mix_buf->size=3D%zu\n", live, hw->mix_=
buf->size);
             return 0;
         }
         return live;
@@ -699,11 +699,11 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, vo=
id *buf, size_t size)
         return size;
     }
=20
-    hwsamples =3D sw->hw->samples;
+    hwsamples =3D sw->hw->mix_buf->size;
=20
     live =3D sw->total_hw_samples_mixed;
     if (audio_bug(__func__, live > hwsamples)) {
-        dolog("live=3D%zu hw->samples=3D%zu\n", live, hwsamples);
+        dolog("live=3D%zu hw->mix_buf->size=3D%zu\n", live, hwsamples);
         return 0;
     }
=20
@@ -714,7 +714,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void=
 *buf, size_t size)
         return 0;
     }
=20
-    wpos =3D (sw->hw->rpos + live) % hwsamples;
+    wpos =3D (sw->hw->mix_buf->pos + live) % hwsamples;
     samples =3D size >> sw->info.shift;
=20
     dead =3D hwsamples - live;
@@ -740,7 +740,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void=
 *buf, size_t size)
         st_rate_flow_mix (
             sw->rate,
             sw->buf + pos,
-            sw->hw->mix_buf + wpos,
+            sw->hw->mix_buf->samples + wpos,
             &isamp,
             &osamp
             );
@@ -868,7 +868,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size=
)
=20
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
 {
-    return sw->hw->samples << sw->hw->info.shift;
+    return sw->hw->mix_buf->size << sw->hw->info.shift;
 }
=20
 void AUD_set_active_out (SWVoiceOut *sw, int on)
@@ -969,8 +969,9 @@ static size_t audio_get_avail (SWVoiceIn *sw)
     }
=20
     live =3D sw->hw->total_samples_captured - sw->total_hw_samples_acqui=
red;
-    if (audio_bug(__func__, live > sw->hw->samples)) {
-        dolog("live=3D%zu sw->hw->samples=3D%zu\n", live, sw->hw->sample=
s);
+    if (audio_bug(__func__, live > sw->hw->conv_buf->size)) {
+        dolog("live=3D%zu sw->hw->conv_buf->size=3D%zu\n", live,
+              sw->hw->conv_buf->size);
         return 0;
     }
=20
@@ -993,12 +994,13 @@ static size_t audio_get_free(SWVoiceOut *sw)
=20
     live =3D sw->total_hw_samples_mixed;
=20
-    if (audio_bug(__func__, live > sw->hw->samples)) {
-        dolog("live=3D%zu sw->hw->samples=3D%zu\n", live, sw->hw->sample=
s);
+    if (audio_bug(__func__, live > sw->hw->mix_buf->size)) {
+        dolog("live=3D%zu sw->hw->mix_buf->size=3D%zu\n", live,
+              sw->hw->mix_buf->size);
         return 0;
     }
=20
-    dead =3D sw->hw->samples - live;
+    dead =3D sw->hw->mix_buf->size - live;
=20
 #ifdef DEBUG_OUT
     dolog ("%s: get_free live %d dead %d ret %" PRId64 "\n",
@@ -1023,12 +1025,12 @@ static void audio_capture_mix_and_clear(HWVoiceOu=
t *hw, size_t rpos,
=20
             n =3D samples;
             while (n) {
-                size_t till_end_of_hw =3D hw->samples - rpos2;
+                size_t till_end_of_hw =3D hw->mix_buf->size - rpos2;
                 size_t to_write =3D MIN(till_end_of_hw, n);
                 size_t bytes =3D to_write << hw->info.shift;
                 size_t written;
=20
-                sw->buf =3D hw->mix_buf + rpos2;
+                sw->buf =3D hw->mix_buf->samples + rpos2;
                 written =3D audio_pcm_sw_write (sw, NULL, bytes);
                 if (written - bytes) {
                     dolog("Could not mix %zu bytes into a capture "
@@ -1037,14 +1039,14 @@ static void audio_capture_mix_and_clear(HWVoiceOu=
t *hw, size_t rpos,
                     break;
                 }
                 n -=3D to_write;
-                rpos2 =3D (rpos2 + to_write) % hw->samples;
+                rpos2 =3D (rpos2 + to_write) % hw->mix_buf->size;
             }
         }
     }
=20
-    n =3D MIN(samples, hw->samples - rpos);
-    mixeng_clear(hw->mix_buf + rpos, n);
-    mixeng_clear(hw->mix_buf, samples - n);
+    n =3D MIN(samples, hw->mix_buf->size - rpos);
+    mixeng_clear(hw->mix_buf->samples + rpos, n);
+    mixeng_clear(hw->mix_buf->samples, samples - n);
 }
=20
 static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
@@ -1056,7 +1058,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, =
size_t live)
         void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
         if (!buf) {
             /* retrying will likely won't help, drop everything. */
-            hw->rpos =3D (hw->rpos + live) % hw->samples;
+            hw->mix_buf->pos =3D (hw->mix_buf->pos + live) % hw->mix_buf=
->size;
             return clipped + live;
         }
=20
@@ -1067,7 +1069,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, =
size_t live)
=20
         live -=3D proc;
         clipped +=3D proc;
-        hw->rpos =3D (hw->rpos + proc) % hw->samples;
+        hw->mix_buf->pos =3D (hw->mix_buf->pos + proc) % hw->mix_buf->si=
ze;
=20
         if (proc =3D=3D 0 || proc < decr) {
             break;
@@ -1091,8 +1093,8 @@ static void audio_run_out (AudioState *s)
             live =3D 0;
         }
=20
-        if (audio_bug(__func__, live > hw->samples)) {
-            dolog ("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->mix_buf->size)) {
+            dolog("live=3D%zu hw->mix_buf->size=3D%zu\n", live, hw->mix_=
buf->size);
             continue;
         }
=20
@@ -1123,13 +1125,13 @@ static void audio_run_out (AudioState *s)
             continue;
         }
=20
-        prev_rpos =3D hw->rpos;
+        prev_rpos =3D hw->mix_buf->pos;
         played =3D audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
-        if (audio_bug(__func__, hw->rpos >=3D hw->samples)) {
-            dolog("hw->rpos=3D%zu hw->samples=3D%zu played=3D%zu\n",
-                  hw->rpos, hw->samples, played);
-            hw->rpos =3D 0;
+        if (audio_bug(__func__, hw->mix_buf->pos >=3D hw->mix_buf->size)=
) {
+            dolog("hw->mix_buf->pos=3D%zu hw->mix_buf->size=3D%zu played=
=3D%zu\n",
+                  hw->mix_buf->pos, hw->mix_buf->size, played);
+            hw->mix_buf->pos =3D 0;
         }
=20
 #ifdef DEBUG_OUT
@@ -1186,6 +1188,7 @@ static void audio_run_out (AudioState *s)
 static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
 {
     size_t conv =3D 0;
+    STSampleBuffer *conv_buf =3D hw->conv_buf;
=20
     while (samples) {
         size_t proc;
@@ -1199,10 +1202,10 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, =
size_t samples)
         }
=20
         proc =3D MIN(size >> hw->info.shift,
-                   hw->samples - hw->wpos);
+                   conv_buf->size - conv_buf->pos);
=20
-        hw->conv(hw->conv_buf + hw->wpos, buf, proc);
-        hw->wpos =3D (hw->wpos + proc) % hw->samples;
+        hw->conv(conv_buf->samples + conv_buf->pos, buf, proc);
+        conv_buf->pos =3D (conv_buf->pos + proc) % conv_buf->size;
=20
         samples -=3D proc;
         conv +=3D proc;
@@ -1222,9 +1225,10 @@ static void audio_run_in (AudioState *s)
=20
         if (replay_mode !=3D REPLAY_MODE_PLAY) {
             captured =3D audio_pcm_hw_run_in(
-                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
+                hw, hw->conv_buf->size - audio_pcm_hw_get_live_in(hw));
         }
-        replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples)=
;
+        replay_audio_in(&captured, hw->conv_buf->samples, &hw->conv_buf-=
>pos,
+                        hw->conv_buf->size);
=20
         min =3D audio_pcm_hw_find_min_in (hw);
         hw->total_samples_captured +=3D captured - min;
@@ -1255,14 +1259,14 @@ static void audio_run_capture (AudioState *s)
         SWVoiceOut *sw;
=20
         captured =3D live =3D audio_pcm_hw_get_live_out (hw, NULL);
-        rpos =3D hw->rpos;
+        rpos =3D hw->mix_buf->pos;
         while (live) {
-            size_t left =3D hw->samples - rpos;
+            size_t left =3D hw->mix_buf->size - rpos;
             size_t to_capture =3D MIN(live, left);
             struct st_sample *src;
             struct capture_callback *cb;
=20
-            src =3D hw->mix_buf + rpos;
+            src =3D hw->mix_buf->samples + rpos;
             hw->clip (cap->buf, src, to_capture);
             mixeng_clear (src, to_capture);
=20
@@ -1270,10 +1274,10 @@ static void audio_run_capture (AudioState *s)
                 cb->ops.capture (cb->opaque, cap->buf,
                                  to_capture << hw->info.shift);
             }
-            rpos =3D (rpos + to_capture) % hw->samples;
+            rpos =3D (rpos + to_capture) % hw->mix_buf->size;
             live -=3D to_capture;
         }
-        hw->rpos =3D rpos;
+        hw->mix_buf->pos =3D rpos;
=20
         for (sw =3D hw->sw_head.lh_first; sw; sw =3D sw->entries.le_next=
) {
             if (!sw->active && sw->empty) {
@@ -1321,7 +1325,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, si=
ze_t *size)
     ssize_t start;
=20
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size =3D hw->samples << hw->info.shift;
+        size_t calc_size =3D hw->conv_buf->size << hw->info.shift;
         hw->buf_emul =3D g_malloc(calc_size);
         hw->size_emul =3D calc_size;
         hw->pos_emul =3D hw->pending_emul =3D 0;
@@ -1357,7 +1361,7 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, voi=
d *buf, size_t size)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        size_t calc_size =3D hw->samples << hw->info.shift;
+        size_t calc_size =3D hw->mix_buf->size << hw->info.shift;
=20
         hw->buf_emul =3D g_malloc(calc_size);
         hw->size_emul =3D calc_size;
@@ -1764,11 +1768,11 @@ CaptureVoiceOut *AUD_add_capture(
=20
         /* XXX find a more elegant way */
         hw->samples =3D 4096 * 4;
-        hw->mix_buf =3D g_new0(struct st_sample, hw->samples);
+        audio_pcm_hw_alloc_resources_out(hw);
=20
         audio_pcm_init_info (&hw->info, as);
=20
-        cap->buf =3D g_malloc0_n(hw->samples, 1 << hw->info.shift);
+        cap->buf =3D g_malloc0_n(hw->mix_buf->size, 1 << hw->info.shift)=
;
=20
         hw->clip =3D mixeng_clip
             [hw->info.nchannels =3D=3D 2]
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 278251270691..76c082d5e2a5 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -585,7 +585,8 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
=20
-            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->sample=
s);
+            audio_pcm_info_clear_buf(
+                &hw->info, hw->buf_emul, hw->mix_buf->size);
             trig =3D PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
--=20
2.18.1


