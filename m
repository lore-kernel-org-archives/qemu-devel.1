Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D05CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093A521897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093A521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN4C-0001GH-CL
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMta-0006Ju-9I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtZ-00077u-0p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtY-00075l-P0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50F463082E03;
 Fri, 18 Oct 2019 07:41:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF615EE1D;
 Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 45B709B19; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] paaudio: get/put_buffer functions
Date: Fri, 18 Oct 2019 09:41:37 +0200
Message-Id: <20191018074144.24071-7-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 18 Oct 2019 07:41:54 +0000 (UTC)
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

This lets us avoid some buffer copying when using mixeng.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: d03d30138b9b5a9681cc90cbfbfec0a197cac88c.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 2cba492d8265..77cd0bc0d026 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -99,6 +99,59 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t =
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
@@ -137,6 +190,32 @@ unlock_and_fail:
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
@@ -701,11 +780,15 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
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


