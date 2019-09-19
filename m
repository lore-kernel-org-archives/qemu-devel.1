Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1650EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB701217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB701217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAs3Z-0006RV-AD
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvf-00053w-Eh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvd-0000Ds-0f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvc-0000CS-Jp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A9D4305FC56;
 Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 852DE5D9CC;
 Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B76549CAA; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:11 +0200
Message-Id: <20190919083629.29998-9-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/26] sdlaudio: port to the new audio backend
 api
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
Message-id: 3e95a57a0663f1f4464cd3515e252628791c971e.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/sdlaudio.c | 87 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 14b11f033521..f7ac8cd10188 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -41,8 +41,6 @@
=20
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    size_t live;
-    size_t decr;
 } SDLVoiceOut;
=20
 static struct SDLAudioState {
@@ -184,62 +182,59 @@ static void sdl_callback (void *opaque, Uint8 *buf,=
 int len)
     SDLVoiceOut *sdl =3D opaque;
     SDLAudioState *s =3D &glob_sdl;
     HWVoiceOut *hw =3D &sdl->hw;
-    size_t samples =3D len >> hw->info.shift;
-    size_t to_mix, decr;
=20
-    if (s->exit || !sdl->live) {
+    if (s->exit) {
         return;
     }
=20
     /* dolog ("in callback samples=3D%zu live=3D%zu\n", samples, sdl->li=
ve); */
=20
-    to_mix =3D MIN(samples, sdl->live);
-    decr =3D to_mix;
-    while (to_mix) {
-        size_t chunk =3D MIN(to_mix, hw->samples - hw->rpos);
-        struct st_sample *src =3D hw->mix_buf + hw->rpos;
-
-        /* dolog ("in callback to_mix %zu, chunk %zu\n", to_mix, chunk);=
 */
-        hw->clip(buf, src, chunk);
-        hw->rpos =3D (hw->rpos + chunk) % hw->samples;
-        to_mix -=3D chunk;
-        buf +=3D chunk << hw->info.shift;
+    while (hw->pending_emul && len) {
+        size_t write_len;
+        ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start +=3D hw->size_emul;
+        }
+        assert(start >=3D 0 && start < hw->size_emul);
+
+        write_len =3D MIN(MIN(hw->pending_emul, len),
+                        hw->size_emul - start);
+
+        memcpy(buf, hw->buf_emul + start, write_len);
+        hw->pending_emul -=3D write_len;
+        len -=3D write_len;
+        buf +=3D write_len;
     }
-    samples -=3D decr;
-    sdl->live -=3D decr;
-    sdl->decr +=3D decr;
-
-    /* dolog ("done len=3D%zu\n", len); */
=20
-    /* SDL2 does not clear the remaining buffer for us, so do it on our =
own */
-    if (samples) {
-        memset(buf, 0, samples << hw->info.shift);
+    /* clear remaining buffer that we couldn't fill with data */
+    if (len) {
+        memset(buf, 0, len);
     }
 }
=20
-static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    SDLVoiceOut *sdl =3D (SDLVoiceOut *) hw;
-
-    SDL_LockAudio();
-
-    if (sdl->decr > live) {
-        ldebug ("sdl->decr %d live %d sdl->live %d\n",
-                sdl->decr,
-                live,
-                sdl->live);
+#define SDL_WRAPPER_FUNC(name, ret_type, args_decl, args, fail, unlock) =
\
+    static ret_type glue(sdl_, name)args_decl                           =
\
+    {                                                                   =
\
+        ret_type ret;                                                   =
\
+                                                                        =
\
+        SDL_LockAudio();                                                =
\
+                                                                        =
\
+        ret =3D glue(audio_generic_, name)args;                         =
  \
+                                                                        =
\
+        SDL_UnlockAudio();                                              =
\
+        return ret;                                                     =
\
     }
=20
-    decr =3D MIN (sdl->decr, live);
-    sdl->decr -=3D decr;
+SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
+                 (hw, size), *size =3D 0, sdl_unlock)
+SDL_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, siz=
e),
+                 /*nothing*/, sdl_unlock_and_post)
+SDL_WRAPPER_FUNC(write, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, siz=
e),
+                 /*nothing*/, sdl_unlock_and_post)
=20
-    sdl->live =3D live;
-
-    SDL_UnlockAudio();
-
-    return decr;
-}
+#undef SDL_WRAPPER_FUNC
=20
 static void sdl_fini_out (HWVoiceOut *hw)
 {
@@ -336,7 +331,9 @@ static void sdl_audio_fini (void *opaque)
 static struct audio_pcm_ops sdl_pcm_ops =3D {
     .init_out =3D sdl_init_out,
     .fini_out =3D sdl_fini_out,
-    .run_out  =3D sdl_run_out,
+    .write    =3D sdl_write,
+    .get_buffer_out =3D sdl_get_buffer_out,
+    .put_buffer_out =3D sdl_put_buffer_out_nowrite,
     .ctl_out  =3D sdl_ctl_out,
 };
=20
--=20
2.18.1


