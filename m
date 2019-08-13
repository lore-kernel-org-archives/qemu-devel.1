Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D9CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05C320673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05C320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUvx-0007XW-4N
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUp1-0001EF-VF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUoz-0005AL-PC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUoy-00058X-NV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED6CF300413C;
 Tue, 13 Aug 2019 11:18:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2815A82493;
 Tue, 13 Aug 2019 11:18:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7ED679D2B; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:18:02 +0200
Message-Id: <20190813111809.3141-9-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 11:18:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/15] paaudio: properly disconnect streams in
 fini_*
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Currently this needs a workaround due to bug #247 in pulseaudio.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: d1085ec6129416705b2cb65737e510ec9ffec508.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24d98b344a37..1d68173636ed 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -685,6 +685,27 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
     return -1;
 }
=20
+static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
+{
+    int err;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+    /*
+     * wait until actually connects. workaround pa bug #247
+     * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/247
+     */
+    while (pa_stream_get_state(stream) =3D=3D PA_STREAM_CREATING) {
+        pa_threaded_mainloop_wait(c->mainloop);
+    }
+
+    err =3D pa_stream_disconnect(stream);
+    if (err !=3D 0) {
+        dolog("Failed to disconnect! err=3D%d\n", err);
+    }
+    pa_stream_unref(stream);
+    pa_threaded_mainloop_unlock(c->mainloop);
+}
+
 static void qpa_fini_out (HWVoiceOut *hw)
 {
     void *ret;
@@ -696,7 +717,7 @@ static void qpa_fini_out (HWVoiceOut *hw)
     audio_pt_join(&pa->pt, &ret, __func__);
=20
     if (pa->stream) {
-        pa_stream_unref (pa->stream);
+        qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream =3D NULL;
     }
=20
@@ -716,7 +737,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
     audio_pt_join(&pa->pt, &ret, __func__);
=20
     if (pa->stream) {
-        pa_stream_unref (pa->stream);
+        qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream =3D NULL;
     }
=20
--=20
2.18.1


