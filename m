Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C90C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEA020673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEA020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeGn-0000hK-25
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeB7-0003ZU-Pw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB5-0000ql-0h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB4-0000q5-O8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11D72315C000;
 Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65B2A5C1B2;
 Tue, 24 Sep 2019 06:19:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9D0A89D75; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] audio: api for mixeng code free backends
Date: Tue, 24 Sep 2019 08:19:38 +0200
Message-Id: <20190924061951.27916-4-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
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

This will make it possible to skip mixeng with audio playback and
recording, allowing us to free ourselves from the limitations of the
current mixeng (stereo, int64 samples only).  In this case, HW and SW
voices will be essentially the same, for every SW voice we will create
a HW voice, since we can no longer mix multiple voices together.

Some backends expect us to call a function when we have data ready
write()/read() style, while others provide a buffer and expects us to
directly write/read it, so for optimal performance audio_pcm_ops provide
methods for both cases.  Previously backends asked mixeng for more data
in run_out/run_it, now instead mixeng or the frontends will call the
backends, so that's why two sets of functions required.  audio.c
contains glue code between the two styles, so backends only ever have to
implement one style and frontends are free to call whichever is more
convenient for them.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 15a33c03a62228922d851f7324c52f73cb8d2414.1568927990.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h      |  41 ++++++--
 audio/audio_template.h |   1 +
 audio/audio.c          | 216 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 250 insertions(+), 8 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index a674c5374a06..8fb1ca8a8d0f 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -65,6 +65,8 @@ typedef struct HWVoiceOut {
     uint64_t ts_helper;
=20
     struct st_sample *mix_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
=20
     size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
@@ -87,6 +89,8 @@ typedef struct HWVoiceIn {
     uint64_t ts_helper;
=20
     struct st_sample *conv_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
=20
     size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
@@ -147,17 +151,42 @@ struct audio_driver {
 };
=20
 struct audio_pcm_ops {
-    int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_o=
paque);
-    void (*fini_out)(HWVoiceOut *hw);
+    int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque=
);
+    void   (*fini_out)(HWVoiceOut *hw);
     size_t (*run_out)(HWVoiceOut *hw, size_t live);
-    int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    /*
+     * get a buffer that after later can be passed to put_buffer_out; op=
tional
+     * returns the buffer, and writes it's size to size (in bytes)
+     * this is unrelated to the above buffer_size_out function
+     */
+    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
+    /*
+     * put back the buffer returned by get_buffer_out; optional
+     * buf must be equal the pointer returned by get_buffer_out,
+     * size may be smaller
+     */
+    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
+    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
=20
-    int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_op=
aque);
-    void (*fini_in) (HWVoiceIn *hw);
+    int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque)=
;
+    void   (*fini_in) (HWVoiceIn *hw);
     size_t (*run_in)(HWVoiceIn *hw);
-    int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
+    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
+    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
+    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
=20
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t si=
ze);
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size);
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
+
 struct capture_callback {
     struct audio_capture_ops ops;
     void *opaque;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 2562bf5f0062..ff4a173f1810 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -71,6 +71,7 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioStat=
e *s,
=20
 static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 {
+    g_free(hw->buf_emul);
     g_free (HWBUF);
     HWBUF =3D NULL;
 }
diff --git a/audio/audio.c b/audio/audio.c
index e99fcd0694e9..e29a1e15eb30 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -573,6 +573,25 @@ size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *p=
cm_buf,
     return clipped;
 }
=20
+static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t=
 len)
+{
+    size_t clipped =3D 0;
+    size_t pos =3D hw->rpos;
+
+    while (len) {
+        st_sample *src =3D hw->mix_buf + pos;
+        uint8_t *dst =3D advance(pcm_buf, clipped << hw->info.shift);
+        size_t samples_till_end_of_buf =3D hw->samples - pos;
+        size_t samples_to_clip =3D MIN(len, samples_till_end_of_buf);
+
+        hw->clip(dst, src, samples_to_clip);
+
+        pos =3D (pos + samples_to_clip) % hw->samples;
+        len -=3D samples_to_clip;
+        clipped +=3D samples_to_clip;
+    }
+}
+
 /*
  * Soft voice (capture)
  */
@@ -1050,6 +1069,36 @@ static void audio_capture_mix_and_clear(HWVoiceOut=
 *hw, size_t rpos,
     mixeng_clear(hw->mix_buf, samples - n);
 }
=20
+static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
+{
+    size_t clipped =3D 0;
+
+    while (live) {
+        size_t size, decr, proc;
+        void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
+        if (!buf) {
+            /* retrying will likely won't help, drop everything. */
+            hw->rpos =3D (hw->rpos + live) % hw->samples;
+            return clipped + live;
+        }
+
+        decr =3D MIN(size >> hw->info.shift, live);
+        audio_pcm_hw_clip_out2(hw, buf, decr);
+        proc =3D hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.s=
hift) >>
+            hw->info.shift;
+
+        live -=3D proc;
+        clipped +=3D proc;
+        hw->rpos =3D (hw->rpos + proc) % hw->samples;
+
+        if (proc =3D=3D 0 || proc < decr) {
+            break;
+        }
+    }
+
+    return clipped;
+}
+
 static void audio_run_out (AudioState *s)
 {
     HWVoiceOut *hw =3D NULL;
@@ -1097,7 +1146,11 @@ static void audio_run_out (AudioState *s)
         }
=20
         prev_rpos =3D hw->rpos;
-        played =3D hw->pcm_ops->run_out (hw, live);
+        if (hw->pcm_ops->run_out) {
+            played =3D hw->pcm_ops->run_out(hw, live);
+        } else {
+            played =3D audio_pcm_hw_run_out(hw, live);
+        }
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >=3D hw->samples)) {
             dolog("hw->rpos=3D%zu hw->samples=3D%zu played=3D%zu\n",
@@ -1156,6 +1209,35 @@ static void audio_run_out (AudioState *s)
     }
 }
=20
+static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
+{
+    size_t conv =3D 0;
+
+    while (samples) {
+        size_t proc;
+        size_t size =3D samples << hw->info.shift;
+        void *buf =3D hw->pcm_ops->get_buffer_in(hw, &size);
+
+        assert((size & hw->info.align) =3D=3D 0);
+        if (size =3D=3D 0) {
+            hw->pcm_ops->put_buffer_in(hw, buf, size);
+            break;
+        }
+
+        proc =3D MIN(size >> hw->info.shift,
+                   hw->samples - hw->wpos);
+
+        hw->conv(hw->conv_buf + hw->wpos, buf, proc);
+        hw->wpos =3D (hw->wpos + proc) % hw->samples;
+
+        samples -=3D proc;
+        conv +=3D proc;
+        hw->pcm_ops->put_buffer_in(hw, buf, proc << hw->info.shift);
+    }
+
+    return conv;
+}
+
 static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw =3D NULL;
@@ -1165,7 +1247,12 @@ static void audio_run_in (AudioState *s)
         size_t captured =3D 0, min;
=20
         if (replay_mode !=3D REPLAY_MODE_PLAY) {
-            captured =3D hw->pcm_ops->run_in(hw);
+            if (hw->pcm_ops->run_in) {
+                captured =3D hw->pcm_ops->run_in(hw);
+            } else {
+                captured =3D audio_pcm_hw_run_in(
+                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
+            }
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples)=
;
=20
@@ -1259,12 +1346,137 @@ void audio_run(AudioState *s, const char *msg)
 #endif
 }
=20
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    ssize_t start;
+
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size =3D hw->samples << hw->info.shift;
+        hw->buf_emul =3D g_malloc(calc_size);
+        hw->size_emul =3D calc_size;
+        hw->pos_emul =3D hw->pending_emul =3D 0;
+    }
+
+    while (hw->pending_emul < hw->size_emul) {
+        size_t read_len =3D MIN(hw->size_emul - hw->pos_emul,
+                              hw->size_emul - hw->pending_emul);
+        size_t read =3D hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emu=
l,
+                                        read_len);
+        hw->pending_emul +=3D read;
+        if (read < read_len) {
+            break;
+        }
+    }
+
+    start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
+    if (start < 0) {
+        start +=3D hw->size_emul;
+    }
+    assert(start >=3D 0 && start < hw->size_emul);
+
+    *size =3D MIN(hw->pending_emul, hw->size_emul - start);
+    return hw->buf_emul + start;
+}
+
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    assert(size <=3D hw->pending_emul);
+    hw->pending_emul -=3D size;
+}
+
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size =3D hw->samples << hw->info.shift;
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
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size)
+{
+    assert(buf =3D=3D hw->buf_emul + hw->pos_emul &&
+           size + hw->pending_emul <=3D hw->size_emul);
+
+    hw->pending_emul +=3D size;
+    hw->pos_emul =3D (hw->pos_emul + size) % hw->size_emul;
+
+    return size;
+}
+
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t si=
ze)
+{
+    audio_generic_put_buffer_out_nowrite(hw, buf, size);
+
+    while (hw->pending_emul) {
+        size_t write_len, written;
+        ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
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
+
+    /*
+     * fake we have written everything. non-written data remain in pendi=
ng_emul,
+     * so we do not have to clip them multiple times
+     */
+    return size;
+}
+
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst =3D hw->pcm_ops->get_buffer_out(hw, &dst_size);
+    copy_size =3D MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    return hw->pcm_ops->put_buffer_out(hw, buf, copy_size);
+}
+
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst =3D hw->pcm_ops->get_buffer_in(hw, &dst_size);
+    copy_size =3D MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    hw->pcm_ops->put_buffer_in(hw, buf, copy_size);
+    return copy_size;
+}
+
+
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
 {
     s->drv_opaque =3D drv->init(dev);
=20
     if (s->drv_opaque) {
+        if (!drv->pcm_ops->get_buffer_in) {
+            drv->pcm_ops->get_buffer_in =3D audio_generic_get_buffer_in;
+            drv->pcm_ops->put_buffer_in =3D audio_generic_put_buffer_in;
+        }
+        if (!drv->pcm_ops->get_buffer_out) {
+            drv->pcm_ops->get_buffer_out =3D audio_generic_get_buffer_ou=
t;
+            drv->pcm_ops->put_buffer_out =3D audio_generic_put_buffer_ou=
t;
+        }
+
         audio_init_nb_voices_out(s, drv);
         audio_init_nb_voices_in(s, drv);
         s->drv =3D drv;
--=20
2.18.1


