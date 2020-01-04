Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27FC32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623E4215A4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623E4215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1infUM-00033L-Bq
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 04:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infT9-0001ng-VC
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infT8-0007K7-S5
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:39 -0500
Received: from mailout04.t-online.de ([194.25.134.18]:36306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1infT8-0007DX-HE
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:38 -0500
Received: from fwd12.aul.t-online.de (fwd12.aul.t-online.de [172.20.26.241])
 by mailout04.t-online.de (Postfix) with SMTP id 203DB41904F8;
 Sat,  4 Jan 2020 10:11:37 +0100 (CET)
Received: from linpower.localnet
 (S93r+EZ-rh-NNDYjO-bIx-zLrYiS54V1ea7AhDvk1yee-NeM98CGnSyInM5z20RgXm@[46.86.52.107])
 by fwd12.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1infT0-3tz2O00; Sat, 4 Jan 2020 10:11:30 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 25102202790; Sat,  4 Jan 2020 10:11:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 4/5] paaudio: try to drain the recording stream
Date: Sat,  4 Jan 2020 10:11:21 +0100
Message-Id: <20200104091122.13971-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
References: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: S93r+EZ-rh-NNDYjO-bIx-zLrYiS54V1ea7AhDvk1yee-NeM98CGnSyInM5z20RgXm
X-TOI-MSGID: 3d60a767-2304-4d89-9883-635d1e7acd36
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.18
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
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
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
index 7db1dc15f0..b23274550e 100644
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


