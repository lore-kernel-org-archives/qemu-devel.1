Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D566C352A4
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676F2217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF9aRD/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676F2217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyMo-0007Y9-Ij
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL8-0005hi-So
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL7-0003em-NO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL7-0003e0-J8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ha7Y+IThuifoP3I+jYys2llQLtKXQQEQ9+hhsIhZJT8=;
 b=SF9aRD/lAB5qhw6EMRcyiEieF8e5EOKkvInL8ijH+eNCu2b3l1FZM9wW5jgHDPdXOU0MRH
 l1ykItg/akv+jyxDVVxOlR5+yW7Q8hbu3n/bII97tnvuN0gPJQGpaTzvzeiMkAvTnMcQIO
 kl1Gzmw2d8owUWh9/RWsJWPBO6r/3ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-VSoMkhc9NqaQSyRx8whHRw-1; Fri, 07 Feb 2020 02:46:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F17DDB66;
 Fri,  7 Feb 2020 07:46:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34B978BE25;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3F02331F3B; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] audio/dsound: fix invalid parameters error
Date: Fri,  7 Feb 2020 08:45:55 +0100
Message-Id: <20200207074557.26073-11-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VSoMkhc9NqaQSyRx8whHRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: K=?UTF-8?B?xZE=?=v=?UTF-8?B?w6E=?=g=?UTF-8?B?w7M=?=@redhat.com, 
 =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is called
with zero length.  Also, hw->pos_emul handling was incorrect when
calling this function for the first time.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
Reported-by: KJ Liew <liewkj@yahoo.com>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Message-id: fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.i=
CE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/dsound_template.h |  1 +
 audio/audio.c           |  6 ++----
 audio/dsoundaudio.c     | 27 +++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 7a15f91ce563..9c5ce625ab91 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
         goto fail0;
     }
=20
+    ds->first_time =3D true;
     obt_as.endianness =3D 0;
     audio_pcm_init_info (&hw->info, &obt_as);
=20
diff --git a/audio/audio.c b/audio/audio.c
index f9859408f340..3bfd808bc6f1 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, s=
ize_t live)
     while (live) {
         size_t size, decr, proc;
         void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
-        if (!buf) {
-            /* retrying will likely won't help, drop everything. */
-            hw->mix_buf->pos =3D (hw->mix_buf->pos + live) % hw->mix_buf->=
size;
-            return clipped + live;
+        if (!buf || size =3D=3D 0) {
+            break;
         }
=20
         decr =3D MIN(size / hw->info.bytes_per_frame, live);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index c265c0094b9f..bd57082a8dce 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -53,12 +53,14 @@ typedef struct {
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
+    bool first_time;
     dsound *s;
 } DSoundVoiceOut;
=20
 typedef struct {
     HWVoiceIn hw;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
+    bool first_time;
     dsound *s;
 } DSoundVoiceIn;
=20
@@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, si=
ze_t *size)
     DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
     HRESULT hr;
-    DWORD ppos, act_size;
+    DWORD ppos, wpos, act_size;
     size_t req_size;
     int err;
     void *ret;
=20
-    hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
+    hr =3D IDirectSoundBuffer_GetCurrentPosition(
+        dsb, &ppos, ds->first_time ? &wpos : NULL);
     if (FAILED(hr)) {
         dsound_logerr(hr, "Could not get playback buffer position\n");
         *size =3D 0;
         return NULL;
     }
=20
+    if (ds->first_time) {
+        hw->pos_emul =3D wpos;
+        ds->first_time =3D false;
+    }
+
     req_size =3D audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
     req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
=20
+    if (req_size =3D=3D 0) {
+        *size =3D 0;
+        return NULL;
+    }
+
     err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, =
NULL,
                           &act_size, NULL, false, ds->s);
     if (err) {
@@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size=
_t *size)
     DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
     HRESULT hr;
-    DWORD cpos, act_size;
+    DWORD cpos, rpos, act_size;
     size_t req_size;
     int err;
     void *ret;
=20
-    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NULL)=
;
+    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(
+        dscb, &cpos, ds->first_time ? &rpos : NULL);
     if (FAILED(hr)) {
         dsound_logerr(hr, "Could not get capture buffer position\n");
         *size =3D 0;
         return NULL;
     }
=20
+    if (ds->first_time) {
+        hw->pos_emul =3D rpos;
+        ds->first_time =3D false;
+    }
+
     req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
     req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
=20
--=20
2.18.1


