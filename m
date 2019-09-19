Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4290C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA47B21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsAs-0006eE-Bd
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArve-00052u-Ld
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArva-0000AU-Tv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArva-0000AD-Kr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE0763DE04;
 Thu, 19 Sep 2019 08:36:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA3005DA21;
 Thu, 19 Sep 2019 08:36:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8C91B9D31; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:07 +0200
Message-Id: <20190919083629.29998-5-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/26] dsoundaudio: port to the new audio
 backend api
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

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 0019bfb5ae50b0750b839460b5dbc1b3073f02e7.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/dsound_template.h |  47 +++---
 audio/dsoundaudio.c     | 329 ++++++++++------------------------------
 2 files changed, 103 insertions(+), 273 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 8ece870c9ef7..9f10b688df57 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -29,6 +29,8 @@
 #define BUFPTR LPDIRECTSOUNDCAPTUREBUFFER
 #define FIELD dsound_capture_buffer
 #define FIELD2 dsound_capture
+#define HWVOICE HWVoiceIn
+#define DSOUNDVOICE DSoundVoiceIn
 #else
 #define NAME "playback buffer"
 #define NAME2 "DirectSound"
@@ -37,6 +39,8 @@
 #define BUFPTR LPDIRECTSOUNDBUFFER
 #define FIELD dsound_buffer
 #define FIELD2 dsound
+#define HWVOICE HWVoiceOut
+#define DSOUNDVOICE DSoundVoiceOut
 #endif
=20
 static int glue (dsound_unlock_, TYPE) (
@@ -72,8 +76,6 @@ static int glue (dsound_lock_, TYPE) (
     )
 {
     HRESULT hr;
-    LPVOID p1 =3D NULL, p2 =3D NULL;
-    DWORD blen1 =3D 0, blen2 =3D 0;
     DWORD flag;
=20
 #ifdef DSBTYPE_IN
@@ -81,7 +83,7 @@ static int glue (dsound_lock_, TYPE) (
 #else
     flag =3D entire ? DSBLOCK_ENTIREBUFFER : 0;
 #endif
-    hr =3D glue(IFACE, _Lock)(buf, pos, len, &p1, &blen1, &p2, &blen2, f=
lag);
+    hr =3D glue(IFACE, _Lock)(buf, pos, len, p1p, blen1p, p2p, blen2p, f=
lag);
=20
     if (FAILED (hr)) {
 #ifndef DSBTYPE_IN
@@ -96,34 +98,34 @@ static int glue (dsound_lock_, TYPE) (
         goto fail;
     }
=20
-    if ((p1 && (blen1 & info->align)) || (p2 && (blen2 & info->align))) =
{
-        dolog ("DirectSound returned misaligned buffer %ld %ld\n",
-               blen1, blen2);
-        glue (dsound_unlock_, TYPE) (buf, p1, p2, blen1, blen2);
+    if ((p1p && *p1p && (*blen1p & info->align)) ||
+        (p2p && *p2p && (*blen2p & info->align))) {
+        dolog("DirectSound returned misaligned buffer %ld %ld\n",
+              *blen1p, *blen2p);
+        glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p=
,
+                                   blen2p ? *blen2p : 0);
         goto fail;
     }
=20
-    if (!p1 && blen1) {
-        dolog ("warning: !p1 && blen1=3D%ld\n", blen1);
-        blen1 =3D 0;
+    if (p1p && !*p1p && *blen1p) {
+        dolog("warning: !p1 && blen1=3D%ld\n", *blen1p);
+        *blen1p =3D 0;
     }
=20
-    if (!p2 && blen2) {
-        dolog ("warning: !p2 && blen2=3D%ld\n", blen2);
-        blen2 =3D 0;
+    if (p2p && !*p2p && *blen2p) {
+        dolog("warning: !p2 && blen2=3D%ld\n", *blen2p);
+        *blen2p =3D 0;
     }
=20
-    *p1p =3D p1;
-    *p2p =3D p2;
-    *blen1p =3D blen1;
-    *blen2p =3D blen2;
     return 0;
=20
  fail:
     *p1p =3D NULL - 1;
-    *p2p =3D NULL - 1;
     *blen1p =3D -1;
-    *blen2p =3D -1;
+    if (p2p) {
+        *p2p =3D NULL - 1;
+        *blen2p =3D -1;
+    }
     return -1;
 }
=20
@@ -242,7 +244,6 @@ static int dsound_init_out(HWVoiceOut *hw, struct aud=
settings *as,
         goto fail0;
     }
=20
-    ds->first_time =3D 1;
     obt_as.endianness =3D 0;
     audio_pcm_init_info (&hw->info, &obt_as);
=20
@@ -252,15 +253,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct a=
udsettings *as,
             bc.dwBufferBytes, hw->info.align + 1
             );
     }
+    hw->size_emul =3D bc.dwBufferBytes;
     hw->samples =3D bc.dwBufferBytes >> hw->info.shift;
     ds->s =3D s;
=20
 #ifdef DEBUG_DSOUND
     dolog ("caps %ld, desc %ld\n",
            bc.dwBufferBytes, bd.dwBufferBytes);
-
-    dolog ("bufsize %d, freq %d, chan %d, fmt %d\n",
-           hw->bufsize, settings.freq, settings.nchannels, settings.fmt)=
;
 #endif
     return 0;
=20
@@ -276,3 +275,5 @@ static int dsound_init_out(HWVoiceOut *hw, struct aud=
settings *as,
 #undef BUFPTR
 #undef FIELD
 #undef FIELD2
+#undef HWVOICE
+#undef DSOUNDVOICE
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 2fc118b795d0..9960247814c7 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -53,19 +53,11 @@ typedef struct {
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
-    DWORD old_pos;
-    int first_time;
     dsound *s;
-#ifdef DEBUG_DSOUND
-    DWORD old_ppos;
-    DWORD played;
-    DWORD mixed;
-#endif
 } DSoundVoiceOut;
=20
 typedef struct {
     HWVoiceIn hw;
-    int first_time;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
     dsound *s;
 } DSoundVoiceIn;
@@ -243,11 +235,6 @@ static void GCC_FMT_ATTR (3, 4) dsound_logerr2 (
     dsound_log_hresult (hr);
 }
=20
-static uint64_t usecs_to_bytes(struct audio_pcm_info *info, uint32_t use=
cs)
-{
-    return muldiv64(usecs, info->bytes_per_second, 1000000);
-}
-
 #ifdef DEBUG_DSOUND
 static void print_wave_format (WAVEFORMATEX *wfx)
 {
@@ -312,33 +299,6 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUR=
EBUFFER dscb,
     return 0;
 }
=20
-static void dsound_write_sample (HWVoiceOut *hw, uint8_t *dst, int dst_l=
en)
-{
-    int src_len1 =3D dst_len;
-    int src_len2 =3D 0;
-    int pos =3D hw->rpos + dst_len;
-    struct st_sample *src1 =3D hw->mix_buf + hw->rpos;
-    struct st_sample *src2 =3D NULL;
-
-    if (pos > hw->samples) {
-        src_len1 =3D hw->samples - hw->rpos;
-        src2 =3D hw->mix_buf;
-        src_len2 =3D dst_len - src_len1;
-        pos =3D src_len2;
-    }
-
-    if (src_len1) {
-        hw->clip (dst, src1, src_len1);
-    }
-
-    if (src_len2) {
-        dst =3D advance (dst, src_len1 << hw->info.shift);
-        hw->clip (dst, src2, src_len2);
-    }
-
-    hw->rpos =3D pos % hw->samples;
-}
-
 static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb=
,
                                  dsound *s)
 {
@@ -350,7 +310,7 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDI=
RECTSOUNDBUFFER dsb,
         dsb,
         &hw->info,
         0,
-        hw->samples << hw->info.shift,
+        hw->size_emul,
         &p1, &p2,
         &blen1, &blen2,
         1,
@@ -454,139 +414,51 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd=
, ...)
     return 0;
 }
=20
-static size_t dsound_run_out(HWVoiceOut *hw, size_t live)
+static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
-    int err;
+    DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
+    LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
     HRESULT hr;
+    DWORD ppos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
+
+    hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get playback buffer position\n");
+        *size =3D 0;
+        return NULL;
+    }
+
+    req_size =3D audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
+    req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
+
+    err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret=
, NULL,
+                          &act_size, NULL, false, ds->s);
+    if (err) {
+        dolog("Failed to lock buffer\n");
+        *size =3D 0;
+        return NULL;
+    }
+
+    *size =3D act_size;
+    return ret;
+}
+
+static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t le=
n)
+{
     DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
-    size_t len;
-    int hwshift;
-    DWORD blen1, blen2;
-    DWORD len1, len2;
-    DWORD decr;
-    DWORD wpos, ppos, old_pos;
-    LPVOID p1, p2;
-    size_t bufsize;
-    dsound *s =3D ds->s;
-    AudiodevDsoundOptions *dso =3D &s->dev->u.dsound;
+    int err =3D dsound_unlock_out(dsb, buf, NULL, len, 0);
=20
-    if (!dsb) {
-        dolog ("Attempt to run empty with playback buffer\n");
-        return 0;
-    }
-
-    hwshift =3D hw->info.shift;
-    bufsize =3D hw->samples << hwshift;
-
-    hr =3D IDirectSoundBuffer_GetCurrentPosition (
-        dsb,
-        &ppos,
-        ds->first_time ? &wpos : NULL
-        );
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get playback buffer position\n");
-        return 0;
-    }
-
-    len =3D live << hwshift;
-
-    if (ds->first_time) {
-        if (dso->latency) {
-            DWORD cur_blat;
-
-            cur_blat =3D audio_ring_dist (wpos, ppos, bufsize);
-            ds->first_time =3D 0;
-            old_pos =3D wpos;
-            old_pos +=3D
-                usecs_to_bytes(&hw->info, dso->latency) - cur_blat;
-            old_pos %=3D bufsize;
-            old_pos &=3D ~hw->info.align;
-        }
-        else {
-            old_pos =3D wpos;
-        }
-#ifdef DEBUG_DSOUND
-        ds->played =3D 0;
-        ds->mixed =3D 0;
-#endif
-    }
-    else {
-        if (ds->old_pos =3D=3D ppos) {
-#ifdef DEBUG_DSOUND
-            dolog ("old_pos =3D=3D ppos\n");
-#endif
-            return 0;
-        }
-
-#ifdef DEBUG_DSOUND
-        ds->played +=3D audio_ring_dist (ds->old_pos, ppos, hw->bufsize)=
;
-#endif
-        old_pos =3D ds->old_pos;
-    }
-
-    if ((old_pos < ppos) && ((old_pos + len) > ppos)) {
-        len =3D ppos - old_pos;
-    }
-    else {
-        if ((old_pos > ppos) && ((old_pos + len) > (ppos + bufsize))) {
-            len =3D bufsize - old_pos + ppos;
-        }
-    }
-
-    if (audio_bug(__func__, len > bufsize)) {
-        dolog("len=3D%zu bufsize=3D%zu old_pos=3D%ld ppos=3D%ld\n",
-              len, bufsize, old_pos, ppos);
-        return 0;
-    }
-
-    len &=3D ~hw->info.align;
-    if (!len) {
-        return 0;
-    }
-
-#ifdef DEBUG_DSOUND
-    ds->old_ppos =3D ppos;
-#endif
-    err =3D dsound_lock_out (
-        dsb,
-        &hw->info,
-        old_pos,
-        len,
-        &p1, &p2,
-        &blen1, &blen2,
-        0,
-        s
-        );
     if (err) {
+        dolog("Failed to unlock buffer!!\n");
         return 0;
     }
+    hw->pos_emul =3D (hw->pos_emul + len) % hw->size_emul;
=20
-    len1 =3D blen1 >> hwshift;
-    len2 =3D blen2 >> hwshift;
-    decr =3D len1 + len2;
-
-    if (p1 && len1) {
-        dsound_write_sample (hw, p1, len1);
-    }
-
-    if (p2 && len2) {
-        dsound_write_sample (hw, p2, len2);
-    }
-
-    dsound_unlock_out (dsb, p1, p2, blen1, blen2);
-    ds->old_pos =3D (old_pos + (decr << hwshift)) % bufsize;
-
-#ifdef DEBUG_DSOUND
-    ds->mixed +=3D decr << hwshift;
-
-    dolog ("played %lu mixed %lu diff %ld sec %f\n",
-           ds->played,
-           ds->mixed,
-           ds->mixed - ds->played,
-           abs (ds->mixed - ds->played) / (double) hw->info.bytes_per_se=
cond);
-#endif
-    return decr;
+    return len;
 }
=20
 static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -641,96 +513,49 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, .=
..)
     return 0;
 }
=20
-static size_t dsound_run_in(HWVoiceIn *hw)
+static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
 {
-    int err;
+    DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
+    LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
     HRESULT hr;
+    DWORD cpos, act_size;
+    size_t req_size;
+    int err;
+    void *ret;
+
+    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NUL=
L);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not get capture buffer position\n");
+        *size =3D 0;
+        return NULL;
+    }
+
+    req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
+    req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
+
+    err =3D dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret=
, NULL,
+                         &act_size, NULL, false, ds->s);
+    if (err) {
+        dolog("Failed to lock buffer\n");
+        *size =3D 0;
+        return NULL;
+    }
+
+    *size =3D act_size;
+    return ret;
+}
+
+static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
+{
     DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
-    size_t live, len, dead;
-    DWORD blen1, blen2;
-    DWORD len1, len2;
-    DWORD decr;
-    DWORD cpos, rpos;
-    LPVOID p1, p2;
-    int hwshift;
-    dsound *s =3D ds->s;
+    int err =3D dsound_unlock_in(dscb, buf, NULL, len, 0);
=20
-    if (!dscb) {
-        dolog ("Attempt to run without capture buffer\n");
-        return 0;
-    }
-
-    hwshift =3D hw->info.shift;
-
-    live =3D audio_pcm_hw_get_live_in (hw);
-    dead =3D hw->samples - live;
-    if (!dead) {
-        return 0;
-    }
-
-    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition (
-        dscb,
-        &cpos,
-        ds->first_time ? &rpos : NULL
-        );
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get capture buffer position\n");
-        return 0;
-    }
-
-    if (ds->first_time) {
-        ds->first_time =3D 0;
-        if (rpos & hw->info.align) {
-            ldebug ("warning: Misaligned capture read position %ld(%d)\n=
",
-                    rpos, hw->info.align);
-        }
-        hw->wpos =3D rpos >> hwshift;
-    }
-
-    if (cpos & hw->info.align) {
-        ldebug ("warning: Misaligned capture position %ld(%d)\n",
-                cpos, hw->info.align);
-    }
-    cpos >>=3D hwshift;
-
-    len =3D audio_ring_dist (cpos, hw->wpos, hw->samples);
-    if (!len) {
-        return 0;
-    }
-    len =3D MIN (len, dead);
-
-    err =3D dsound_lock_in (
-        dscb,
-        &hw->info,
-        hw->wpos << hwshift,
-        len << hwshift,
-        &p1,
-        &p2,
-        &blen1,
-        &blen2,
-        0,
-        s
-        );
     if (err) {
-        return 0;
+        dolog("Failed to unlock buffer!!\n");
+        return;
     }
-
-    len1 =3D blen1 >> hwshift;
-    len2 =3D blen2 >> hwshift;
-    decr =3D len1 + len2;
-
-    if (p1 && len1) {
-        hw->conv (hw->conv_buf + hw->wpos, p1, len1);
-    }
-
-    if (p2 && len2) {
-        hw->conv (hw->conv_buf, p2, len2);
-    }
-
-    dsound_unlock_in (dscb, p1, p2, blen1, blen2);
-    hw->wpos =3D (hw->wpos + decr) % hw->samples;
-    return decr;
+    hw->pos_emul =3D (hw->pos_emul + len) % hw->size_emul;
 }
=20
 static void dsound_audio_fini (void *opaque)
@@ -846,12 +671,16 @@ static void *dsound_audio_init(Audiodev *dev)
 static struct audio_pcm_ops dsound_pcm_ops =3D {
     .init_out =3D dsound_init_out,
     .fini_out =3D dsound_fini_out,
-    .run_out  =3D dsound_run_out,
+    .write    =3D audio_generic_write,
+    .get_buffer_out =3D dsound_get_buffer_out,
+    .put_buffer_out =3D dsound_put_buffer_out,
     .ctl_out  =3D dsound_ctl_out,
=20
     .init_in  =3D dsound_init_in,
     .fini_in  =3D dsound_fini_in,
-    .run_in   =3D dsound_run_in,
+    .read     =3D audio_generic_read,
+    .get_buffer_in =3D dsound_get_buffer_in,
+    .put_buffer_in =3D dsound_put_buffer_in,
     .ctl_in   =3D dsound_ctl_in
 };
=20
--=20
2.18.1


