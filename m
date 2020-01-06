Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE1320731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1F6QFJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE1320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRvp-0006Az-4D
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsH-0000v2-3n
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsF-0000tT-HZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsF-0000sq-DX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YtNgYh0UiNRf7SRbxWfm1Y/56HrjV3yGhYAdEcgxHeA=;
 b=Z1F6QFJAhFkaClAfQVJHMV78a13IyA8c+KRk3H/Bj4OoD/L7FbI8oTYireQ0ZhqU4DWejX
 PyCIFOjO0PHeCZPPQ4P5pDihB93TvwTq2tNGH72k27qU6EH9Y5ZRicIbhkrluY+HZbxhfM
 JZV41j5rxVZIusNB3paM5K9tZJ/kv5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-0g2Bz-1YMnydK69Km5suvg-1; Mon, 06 Jan 2020 07:52:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 805EB107ACC4;
 Mon,  6 Jan 2020 12:52:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8471460251;
 Mon,  6 Jan 2020 12:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A02C631E46; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] paaudio: drop recording stream in qpa_fini_in
Date: Mon,  6 Jan 2020 13:52:33 +0100
Message-Id: <20200106125236.24132-4-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
References: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0g2Bz-1YMnydK69Km5suvg-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Every call to pa_stream_peek which returns a data length > 0
should have a corresponding pa_stream_drop. A call to qpa_read
does not necessarily call pa_stream_drop immediately after a
call to pa_stream_peek. Test in qpa_fini_in if a last
pa_stream_drop is needed.

This prevents following messages in the libvirt log file after
a recording stream gets closed and a new one opened.

pulseaudio: pa_stream_drop failed
pulseaudio: Reason: Bad state
pulseaudio: pa_stream_drop failed
pulseaudio: Reason: Bad state

To reproduce start qemu with
-audiodev pa,id=3Daudio0,in.mixing-engine=3Doff
and in the guest start and stop Audacity several times.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200104091122.13971-3-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 55a91f898073..7db1dc15f09e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -536,7 +536,6 @@ static void qpa_simple_disconnect(PAConnection *c, pa_s=
tream *stream)
 {
     int err;
=20
-    pa_threaded_mainloop_lock(c->mainloop);
     /*
      * wait until actually connects. workaround pa bug #247
      * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/247
@@ -550,7 +549,6 @@ static void qpa_simple_disconnect(PAConnection *c, pa_s=
tream *stream)
         dolog("Failed to disconnect! err=3D%d\n", err);
     }
     pa_stream_unref(stream);
-    pa_threaded_mainloop_unlock(c->mainloop);
 }
=20
 static void qpa_fini_out (HWVoiceOut *hw)
@@ -558,8 +556,12 @@ static void qpa_fini_out (HWVoiceOut *hw)
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
     if (pa->stream) {
-        qpa_simple_disconnect(pa->g->conn, pa->stream);
+        PAConnection *c =3D pa->g->conn;
+
+        pa_threaded_mainloop_lock(c->mainloop);
+        qpa_simple_disconnect(c, pa->stream);
         pa->stream =3D NULL;
+        pa_threaded_mainloop_unlock(c->mainloop);
     }
 }
=20
@@ -568,8 +570,20 @@ static void qpa_fini_in (HWVoiceIn *hw)
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
     if (pa->stream) {
-        qpa_simple_disconnect(pa->g->conn, pa->stream);
+        PAConnection *c =3D pa->g->conn;
+
+        pa_threaded_mainloop_lock(c->mainloop);
+        if (pa->read_length) {
+            int r =3D pa_stream_drop(pa->stream);
+            if (r) {
+                qpa_logerr(pa_context_errno(c->context),
+                           "pa_stream_drop failed\n");
+            }
+            pa->read_length =3D 0;
+        }
+        qpa_simple_disconnect(c, pa->stream);
         pa->stream =3D NULL;
+        pa_threaded_mainloop_unlock(c->mainloop);
     }
 }
=20
--=20
2.18.1


