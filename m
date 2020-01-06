Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD99C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9012072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwk/iMBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9012072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRtj-0002Vf-Gn
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsC-0000qF-Lk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsB-0000oh-Kk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsB-0000my-FM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUKfZuNd1Qu2lKoFCCnXZ06t/YR98pMi3balpjSIsSo=;
 b=Jwk/iMBrck5d2WAVbA7Bv2KYzaRSsCtOu5z6silLz4aXeoFy88VZ88Vts57hqSieZP/495
 sMqzGs3kQEEvYoBpbiRiTODlzT+oR6lys8OJ1nWlPEQkoxWDffCJWfDQ/edkAEz/i0kZAz
 Vy1rLboWBRAt+8WDHFA3Y9nAHO3oJYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-yI2feI0yMZuuG6khj3vIMQ-1; Mon, 06 Jan 2020 07:52:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D390800D4E;
 Mon,  6 Jan 2020 12:52:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83FEB5C57C;
 Mon,  6 Jan 2020 12:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A8B7831E49; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] paaudio: try to drain the recording stream
Date: Mon,  6 Jan 2020 13:52:34 +0100
Message-Id: <20200106125236.24132-5-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
References: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yI2feI0yMZuuG6khj3vIMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

There is no guarantee a single call to pa_stream_peek every
timer_period microseconds can read a recording stream faster
than the data gets produced at the source. Let qpa_read try to
drain the recording stream.

To reproduce the problem:

Start qemu with -audiodev pa,id=3Daudio0,in.mixing-engine=3Doff

On the host connect the qemu recording stream to the monitor of
a hardware output device. While the problem can also be seen
with a hardware input device, it's obvious with the monitor of
a hardware output device.

In the guest start audio recording with audacity and notice the
slow recording data rate.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200104091122.13971-4-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 7db1dc15f09e..b23274550e1c 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -156,34 +156,43 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, siz=
e_t length)
 {
     PAVoiceIn *p =3D (PAVoiceIn *) hw;
     PAConnection *c =3D p->g->conn;
-    size_t l;
-    int r;
+    size_t total =3D 0;
=20
     pa_threaded_mainloop_lock(c->mainloop);
=20
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
                     "pa_threaded_mainloop_lock failed\n");
=20
-    if (!p->read_length) {
-        r =3D pa_stream_peek(p->stream, &p->read_data, &p->read_length);
-        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
-                           "pa_stream_peek failed\n");
-    }
+    while (total < length) {
+        size_t l;
+        int r;
=20
-    l =3D MIN(p->read_length, length);
-    memcpy(data, p->read_data, l);
+        if (!p->read_length) {
+            r =3D pa_stream_peek(p->stream, &p->read_data, &p->read_length=
);
+            CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                               "pa_stream_peek failed\n");
+            if (!p->read_length) {
+                /* buffer is empty */
+                break;
+            }
+        }
=20
-    p->read_data +=3D l;
-    p->read_length -=3D l;
+        l =3D MIN(p->read_length, length - total);
+        memcpy((char *)data + total, p->read_data, l);
=20
-    if (!p->read_length) {
-        r =3D pa_stream_drop(p->stream);
-        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
-                           "pa_stream_drop failed\n");
+        p->read_data +=3D l;
+        p->read_length -=3D l;
+        total +=3D l;
+
+        if (!p->read_length) {
+            r =3D pa_stream_drop(p->stream);
+            CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                               "pa_stream_drop failed\n");
+        }
     }
=20
     pa_threaded_mainloop_unlock(c->mainloop);
-    return l;
+    return total;
=20
 unlock_and_fail:
     pa_threaded_mainloop_unlock(c->mainloop);
--=20
2.18.1


