Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE5C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31BF20673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeGU-0000aS-LU
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeB7-0003ZV-SL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB5-0000qs-2u
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB4-0000qC-QD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 258E318CB8E8;
 Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62E281001947;
 Tue, 24 Sep 2019 06:19:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A643A9C84; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] alsaaudio: port to the new audio backend api
Date: Tue, 24 Sep 2019 08:19:39 +0200
Message-Id: <20190924061951.27916-5-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
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
Message-id: ab9768e73dfe7b7305bd6a51629846e0d77622a5.1568927990.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/alsaaudio.c | 308 +++++++++++++---------------------------------
 1 file changed, 83 insertions(+), 225 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 591344dccd1f..19124d09d845 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -44,9 +44,6 @@ struct pollhlp {
=20
 typedef struct ALSAVoiceOut {
     HWVoiceOut hw;
-    int wpos;
-    int pending;
-    void *pcm_buf;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
     Audiodev *dev;
@@ -55,7 +52,6 @@ typedef struct ALSAVoiceOut {
 typedef struct ALSAVoiceIn {
     HWVoiceIn hw;
     snd_pcm_t *handle;
-    void *pcm_buf;
     struct pollhlp pollhlp;
     Audiodev *dev;
 } ALSAVoiceIn;
@@ -602,102 +598,64 @@ static int alsa_open(bool in, struct alsa_params_r=
eq *req,
     return -1;
 }
=20
-static snd_pcm_sframes_t alsa_get_avail (snd_pcm_t *handle)
-{
-    snd_pcm_sframes_t avail;
-
-    avail =3D snd_pcm_avail_update (handle);
-    if (avail < 0) {
-        if (avail =3D=3D -EPIPE) {
-            if (!alsa_recover (handle)) {
-                avail =3D snd_pcm_avail_update (handle);
-            }
-        }
-
-        if (avail < 0) {
-            alsa_logerr (avail,
-                         "Could not obtain number of available frames\n"=
);
-            return -1;
-        }
-    }
-
-    return avail;
-}
-
-static void alsa_write_pending (ALSAVoiceOut *alsa)
-{
-    HWVoiceOut *hw =3D &alsa->hw;
-
-    while (alsa->pending) {
-        int left_till_end_samples =3D hw->samples - alsa->wpos;
-        int len =3D MIN (alsa->pending, left_till_end_samples);
-        char *src =3D advance (alsa->pcm_buf, alsa->wpos << hw->info.shi=
ft);
-
-        while (len) {
-            snd_pcm_sframes_t written;
-
-            written =3D snd_pcm_writei (alsa->handle, src, len);
-
-            if (written <=3D 0) {
-                switch (written) {
-                case 0:
-                    trace_alsa_wrote_zero(len);
-                    return;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames=
\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_xrun_out();
-                    continue;
-
-                case -ESTRPIPE:
-                    /* stream is suspended and waiting for an
-                       application recovery */
-                    if (alsa_resume (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames=
\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_resume_out();
-                    continue;
-
-                case -EAGAIN:
-                    return;
-
-                default:
-                    alsa_logerr (written, "Failed to write %d frames fro=
m %p\n",
-                                 len, src);
-                    return;
-                }
-            }
-
-            alsa->wpos =3D (alsa->wpos + written) % hw->samples;
-            alsa->pending -=3D written;
-            len -=3D written;
-        }
-    }
-}
-
-static size_t alsa_run_out(HWVoiceOut *hw, size_t live)
+static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     ALSAVoiceOut *alsa =3D (ALSAVoiceOut *) hw;
-    size_t decr;
-    snd_pcm_sframes_t avail;
+    size_t pos =3D 0;
+    size_t len_frames =3D len >> hw->info.shift;
=20
-    avail =3D alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of available playback frames\n");
-        return 0;
+    while (len_frames) {
+        char *src =3D advance(buf, pos);
+        snd_pcm_sframes_t written;
+
+        written =3D snd_pcm_writei(alsa->handle, src, len_frames);
+
+        if (written <=3D 0) {
+            switch (written) {
+            case 0:
+                trace_alsa_wrote_zero(len_frames);
+                return pos;
+
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_xrun_out();
+                continue;
+
+            case -ESTRPIPE:
+                /*
+                 * stream is suspended and waiting for an application
+                 * recovery
+                 */
+                if (alsa_resume(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_resume_out();
+                continue;
+
+            case -EAGAIN:
+                return pos;
+
+            default:
+                alsa_logerr(written, "Failed to write %zu frames from %p=
\n",
+                            len, src);
+                return pos;
+            }
+        }
+
+        pos +=3D written << hw->info.shift;
+        if (written < len_frames) {
+            break;
+        }
+        len_frames -=3D written;
     }
=20
-    decr =3D MIN (live, avail);
-    decr =3D audio_pcm_hw_clip_out (hw, alsa->pcm_buf, decr, alsa->pendi=
ng);
-    alsa->pending +=3D decr;
-    alsa_write_pending (alsa);
-    return decr;
+    return pos;
 }
=20
 static void alsa_fini_out (HWVoiceOut *hw)
@@ -706,9 +664,6 @@ static void alsa_fini_out (HWVoiceOut *hw)
=20
     ldebug ("alsa_fini\n");
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf =3D NULL;
 }
=20
 static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
@@ -737,14 +692,6 @@ static int alsa_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D obt.samples;
=20
-    alsa->pcm_buf =3D audio_calloc(__func__, obt.samples, 1 << hw->info.=
shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes=
)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s =3D hw->s;
     alsa->handle =3D handle;
     alsa->dev =3D dev;
@@ -839,14 +786,6 @@ static int alsa_init_in(HWVoiceIn *hw, struct audset=
tings *as, void *drv_opaque)
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples =3D obt.samples;
=20
-    alsa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.=
shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes=
)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s =3D hw->s;
     alsa->handle =3D handle;
     alsa->dev =3D dev;
@@ -858,129 +797,48 @@ static void alsa_fini_in (HWVoiceIn *hw)
     ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
=20
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf =3D NULL;
 }
=20
-static size_t alsa_run_in(HWVoiceIn *hw)
+static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
-    int hwshift =3D hw->info.shift;
-    int i;
-    size_t live =3D audio_pcm_hw_get_live_in (hw);
-    size_t dead =3D hw->samples - live;
-    size_t decr;
-    struct {
-        size_t add;
-        size_t len;
-    } bufs[2] =3D {
-        { .add =3D hw->wpos, .len =3D 0 },
-        { .add =3D 0,        .len =3D 0 }
-    };
-    snd_pcm_sframes_t avail;
-    snd_pcm_uframes_t read_samples =3D 0;
+    size_t pos =3D 0;
=20
-    if (!dead) {
-        return 0;
-    }
-
-    avail =3D alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of captured frames\n");
-        return 0;
-    }
-
-    if (!avail) {
-        snd_pcm_state_t state;
-
-        state =3D snd_pcm_state (alsa->handle);
-        switch (state) {
-        case SND_PCM_STATE_PREPARED:
-            avail =3D hw->samples;
-            break;
-        case SND_PCM_STATE_SUSPENDED:
-            /* stream is suspended and waiting for an application recove=
ry */
-            if (alsa_resume (alsa->handle)) {
-                dolog ("Failed to resume suspended input stream\n");
-                return 0;
-            }
-            trace_alsa_resume_in();
-            break;
-        default:
-            trace_alsa_no_frames(state);
-            return 0;
-        }
-    }
-
-    decr =3D MIN(dead, avail);
-    if (!decr) {
-        return 0;
-    }
-
-    if (hw->wpos + decr > hw->samples) {
-        bufs[0].len =3D (hw->samples - hw->wpos);
-        bufs[1].len =3D (decr - (hw->samples - hw->wpos));
-    }
-    else {
-        bufs[0].len =3D decr;
-    }
-
-    for (i =3D 0; i < 2; ++i) {
-        void *src;
-        struct st_sample *dst;
+    while (len) {
+        void *dst =3D advance(buf, pos);
         snd_pcm_sframes_t nread;
-        snd_pcm_uframes_t len;
=20
-        len =3D bufs[i].len;
+        nread =3D snd_pcm_readi(alsa->handle, dst, len >> hw->info.shift=
);
=20
-        src =3D advance (alsa->pcm_buf, bufs[i].add << hwshift);
-        dst =3D hw->conv_buf + bufs[i].add;
+        if (nread <=3D 0) {
+            switch (nread) {
+            case 0:
+                trace_alsa_read_zero(len);
+                return pos;;
=20
-        while (len) {
-            nread =3D snd_pcm_readi (alsa->handle, src, len);
-
-            if (nread <=3D 0) {
-                switch (nread) {
-                case 0:
-                    trace_alsa_read_zero(len);
-                    goto exit;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (nread, "Failed to read %ld frames\n=
", len);
-                        goto exit;
-                    }
-                    trace_alsa_xrun_in();
-                    continue;
-
-                case -EAGAIN:
-                    goto exit;
-
-                default:
-                    alsa_logerr (
-                        nread,
-                        "Failed to read %ld frames from %p\n",
-                        len,
-                        src
-                        );
-                    goto exit;
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(nread, "Failed to read %zu frames\n", le=
n);
+                    return pos;
                 }
+                trace_alsa_xrun_in();
+                continue;
+
+            case -EAGAIN:
+                return pos;
+
+            default:
+                alsa_logerr(nread, "Failed to read %zu frames to %p\n",
+                            len, dst);
+                return pos;;
             }
-
-            hw->conv (dst, src, nread);
-
-            src =3D advance (src, nread << hwshift);
-            dst +=3D nread;
-
-            read_samples +=3D nread;
-            len -=3D nread;
         }
+
+        pos +=3D nread << hw->info.shift;
+        len -=3D nread << hw->info.shift;
     }
=20
- exit:
-    hw->wpos =3D (hw->wpos + read_samples) % hw->samples;
-    return read_samples;
+    return pos;
 }
=20
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -1065,12 +923,12 @@ static void alsa_audio_fini (void *opaque)
 static struct audio_pcm_ops alsa_pcm_ops =3D {
     .init_out =3D alsa_init_out,
     .fini_out =3D alsa_fini_out,
-    .run_out  =3D alsa_run_out,
+    .write    =3D alsa_write,
     .ctl_out  =3D alsa_ctl_out,
=20
     .init_in  =3D alsa_init_in,
     .fini_in  =3D alsa_fini_in,
-    .run_in   =3D alsa_run_in,
+    .read     =3D alsa_read,
     .ctl_in   =3D alsa_ctl_in,
 };
=20
--=20
2.18.1


