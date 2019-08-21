Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D60C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D9B2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9B2332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MOE-0004Ut-Px
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MBM-0003wk-OW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MBL-00058C-GD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MBL-00057h-8p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9644410F23E1;
 Wed, 21 Aug 2019 08:41:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E15791001959;
 Wed, 21 Aug 2019 08:41:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 15A1B31E94; Wed, 21 Aug 2019 10:41:14 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:41:09 +0200
Message-Id: <20190821084113.1840-12-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-1-kraxel@redhat.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 21 Aug 2019 08:41:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/15] audio: do not run each backend in
 audio_run
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

audio_run is called manually by alsa and oss backends when polling.
In this case only the requesting backend should be run, not all of them.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 10221fcea2028fa18d95cf531526ffe3b1d9b21a.1566168923.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h |  2 +-
 audio/alsaaudio.c |  7 +++++--
 audio/audio.c     | 14 +++++---------
 audio/ossaudio.c  | 12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9f01f6ad002c..7e00c1332e16 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -221,7 +221,7 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_=
buf,
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
=20
-void audio_run (const char *msg);
+void audio_run(AudioState *s, const char *msg);
=20
 #define VOICE_ENABLE 1
 #define VOICE_DISABLE 2
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 6b9e0f06af47..3daa7c8f8f02 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -39,6 +39,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
+    AudioState *s;
 };
=20
 typedef struct ALSAVoiceOut {
@@ -199,11 +200,11 @@ static void alsa_poll_handler (void *opaque)
         break;
=20
     case SND_PCM_STATE_PREPARED:
-        audio_run ("alsa run (prepared)");
+        audio_run(hlp->s, "alsa run (prepared)");
         break;
=20
     case SND_PCM_STATE_RUNNING:
-        audio_run ("alsa run (running)");
+        audio_run(hlp->s, "alsa run (running)");
         break;
=20
     default:
@@ -749,6 +750,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
         return -1;
     }
=20
+    alsa->pollhlp.s =3D hw->s;
     alsa->handle =3D handle;
     alsa->dev =3D dev;
     return 0;
@@ -850,6 +852,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
         return -1;
     }
=20
+    alsa->pollhlp.s =3D hw->s;
     alsa->handle =3D handle;
     alsa->dev =3D dev;
     return 0;
diff --git a/audio/audio.c b/audio/audio.c
index 38267695f788..bc9ac25c08ea 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -837,7 +837,7 @@ static void audio_timer (void *opaque)
     }
     s->timer_last =3D now;
=20
-    audio_run("timer");
+    audio_run(s, "timer");
     audio_reset_timer(s);
 }
=20
@@ -1239,15 +1239,11 @@ static void audio_run_capture (AudioState *s)
     }
 }
=20
-void audio_run (const char *msg)
+void audio_run(AudioState *s, const char *msg)
 {
-    AudioState *s;
-
-    QTAILQ_FOREACH(s, &audio_states, list) {
-        audio_run_out(s);
-        audio_run_in(s);
-        audio_run_capture(s);
-    }
+    audio_run_out(s);
+    audio_run_in(s);
+    audio_run_capture(s);
=20
 #ifdef DEBUG_POLL
     {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 29139ef1f5cd..456fba748064 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -110,28 +110,28 @@ static void oss_anal_close (int *fdp)
=20
 static void oss_helper_poll_out (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_out");
+    AudioState *s =3D opaque;
+    audio_run(s, "oss_poll_out");
 }
=20
 static void oss_helper_poll_in (void *opaque)
 {
-    (void) opaque;
-    audio_run ("oss_poll_in");
+    AudioState *s =3D opaque;
+    audio_run(s, "oss_poll_in");
 }
=20
 static void oss_poll_out (HWVoiceOut *hw)
 {
     OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
=20
-    qemu_set_fd_handler (oss->fd, NULL, oss_helper_poll_out, NULL);
+    qemu_set_fd_handler(oss->fd, NULL, oss_helper_poll_out, hw->s);
 }
=20
 static void oss_poll_in (HWVoiceIn *hw)
 {
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
=20
-    qemu_set_fd_handler (oss->fd, oss_helper_poll_in, NULL, NULL);
+    qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
=20
 static int oss_write (SWVoiceOut *sw, void *buf, int len)
--=20
2.18.1


