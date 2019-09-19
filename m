Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0DBC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CC9217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CC9217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iArxx-0007Jd-Ki
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvk-00059K-Ar
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArve-0000G9-RH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArve-0000Dx-8K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB70618C8935;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6104100197A;
 Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 36B5B9CBB; Thu, 19 Sep 2019 10:36:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:20 +0200
Message-Id: <20190919083629.29998-18-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/26] paaudio: get/put_buffer functions
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

This lets us avoid some buffer copying when using mixeng.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 4554ff54ad04f706ad0e9af87fe07650fd6d9ac1.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index ed31f863f7fe..6ccdf3141598 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -98,6 +98,59 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t =
x)
         }                                                               =
\
     } while (0)
=20
+static void *qpa_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    PAVoiceIn *p =3D (PAVoiceIn *) hw;
+    PAConnection *c =3D p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    if (!p->read_length) {
+        r =3D pa_stream_peek(p->stream, &p->read_data, &p->read_length);
+        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                           "pa_stream_peek failed\n");
+    }
+
+    *size =3D MIN(p->read_length, *size);
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return (void *) p->read_data;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size =3D 0;
+    return NULL;
+}
+
+static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    PAVoiceIn *p =3D (PAVoiceIn *) hw;
+    PAConnection *c =3D p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    assert(buf =3D=3D p->read_data && size <=3D p->read_length);
+
+    p->read_data +=3D size;
+    p->read_length -=3D size;
+
+    if (size && !p->read_length) {
+        r =3D pa_stream_drop(p->stream);
+        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock, "pa_stream_drop failed=
\n");
+    }
+
+unlock:
+    pa_threaded_mainloop_unlock(c->mainloop);
+}
+
 static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
 {
     PAVoiceIn *p =3D (PAVoiceIn *) hw;
@@ -136,6 +189,32 @@ unlock_and_fail:
     return 0;
 }
=20
+static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    PAVoiceOut *p =3D (PAVoiceOut *) hw;
+    PAConnection *c =3D p->g->conn;
+    void *ret;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    *size =3D -1;
+    r =3D pa_stream_begin_write(p->stream, &ret, size);
+    CHECK_SUCCESS_GOTO(c, r >=3D 0, unlock_and_fail,
+                       "pa_stream_begin_write failed\n");
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return ret;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size =3D 0;
+    return NULL;
+}
+
 static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
 {
     PAVoiceOut *p =3D (PAVoiceOut *) hw;
@@ -698,11 +777,15 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
     .init_out =3D qpa_init_out,
     .fini_out =3D qpa_fini_out,
     .write    =3D qpa_write,
+    .get_buffer_out =3D qpa_get_buffer_out,
+    .put_buffer_out =3D qpa_write, /* pa handles it */
     .volume_out =3D qpa_volume_out,
=20
     .init_in  =3D qpa_init_in,
     .fini_in  =3D qpa_fini_in,
     .read     =3D qpa_read,
+    .get_buffer_in =3D qpa_get_buffer_in,
+    .put_buffer_in =3D qpa_put_buffer_in,
     .volume_in =3D qpa_volume_in
 };
=20
--=20
2.18.1


