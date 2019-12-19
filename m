Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7D3C2D0D4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A4A2467F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A4A2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii257-00043D-Q0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ii24G-0002kn-VG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ii24F-0003Po-HY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:06:40 -0500
Received: from mailout12.t-online.de ([194.25.134.22]:44240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ii24D-0003NL-PK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:06:39 -0500
Received: from fwd22.aul.t-online.de (fwd22.aul.t-online.de [172.20.26.127])
 by mailout12.t-online.de (Postfix) with SMTP id B7EE741AFDC5;
 Thu, 19 Dec 2019 21:06:35 +0100 (CET)
Received: from [192.168.211.200]
 (VUAwt-ZEQhwNXPnMw2O1Qyw1MSFReu12g51ON5DA-AVon5Sft86uNVO8SS2K-yygwM@[46.86.55.2])
 by fwd22.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ii24B-1NVevw0; Thu, 19 Dec 2019 21:06:35 +0100
Subject: [PATCH 4/5] paaudio: try to drain the recording stream
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Message-ID: <4c416617-26ce-f8ac-ac13-10b803308204@t-online.de>
Date: Thu, 19 Dec 2019 21:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: de-DE
X-ID: VUAwt-ZEQhwNXPnMw2O1Qyw1MSFReu12g51ON5DA-AVon5Sft86uNVO8SS2K-yygwM
X-TOI-MSGID: e612b01a-ca9d-4a36-96e7-e1f429f46cc0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.22
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 audio/paaudio.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index b831e0d6e9..03cf10bb3c 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -156,34 +156,43 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, s=
ize_t length)
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
+
+        if (!p->read_length) {
+            r =3D pa_stream_peek(p->stream, &p->read_data, &p->read_leng=
th);
+            CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
+                               "pa_stream_peek failed\n");
+            if (!p->read_length) {
+                /* buffer is empty */
+                break;
+            }
+        }
=20
-    l =3D MIN(p->read_length, length);
-    memcpy(data, p->read_data, l);
+        l =3D MIN(p->read_length, length - total);
+        memcpy((char *)data + total, p->read_data, l);
=20
-    p->read_data +=3D l;
-    p->read_length -=3D l;
+        p->read_data +=3D l;
+        p->read_length -=3D l;
+        total +=3D l;
=20
-    if (!p->read_length) {
-        r =3D pa_stream_drop(p->stream);
-        CHECK_SUCCESS_GOTO(c, r =3D=3D 0, unlock_and_fail,
-                           "pa_stream_drop failed\n");
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
2.16.4


