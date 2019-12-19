Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED932465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED932465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii26E-00058P-ST
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ii25T-0004Zn-Ab
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ii25S-0000bV-7E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:07:55 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:54232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ii25R-0000UY-UR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:07:54 -0500
Received: from fwd13.aul.t-online.de (fwd13.aul.t-online.de [172.20.27.62])
 by mailout03.t-online.de (Postfix) with SMTP id 5020342A320C;
 Thu, 19 Dec 2019 21:07:52 +0100 (CET)
Received: from [192.168.211.200]
 (GD7AcuZrZhKODslQh75k-GKlCninl-DFx7aufMgAhtrGOegIiy71jnGYJEUxQ+Hwu3@[46.86.55.2])
 by fwd13.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ii25K-1F4MrY0; Thu, 19 Dec 2019 21:07:46 +0100
Subject: [PATCH 5/5] paaudio: wait until the recording stream is ready
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Message-ID: <b3fe6d20-2b68-0ac9-d1d2-52c217bb0b79@t-online.de>
Date: Thu, 19 Dec 2019 21:07:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: de-DE
X-ID: GD7AcuZrZhKODslQh75k-GKlCninl-DFx7aufMgAhtrGOegIiy71jnGYJEUxQ+Hwu3
X-TOI-MSGID: 09e120e7-5a6c-4bea-960f-31fe89364f37
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.81
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

Don't call pa_stream_peek before the recording stream is ready.

Information to reproduce the problem.

Start and stop Audacity in the guest several times because the
problem is racy.

libvirt log file:
-audiodev pa,id=3Daudio0,server=3Dlocalhost,out.latency=3D30000,
 out.mixing-engine=3Doff,in.mixing-engine=3Doff \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,
 resourcecontrol=3Ddeny \
-msg timestamp=3Don
: Domain id=3D4 is tainted: custom-argv
char device redirected to /dev/pts/1 (label charserial0)
audio: Device pcspk: audiodev default parameter is deprecated,
 please specify audiodev=3Daudio0
audio: Device hda: audiodev default parameter is deprecated,
 please specify audiodev=3Daudio0
pulseaudio: pa_stream_peek failed
pulseaudio: Reason: Bad state
pulseaudio: pa_stream_peek failed
pulseaudio: Reason: Bad state

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/paaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 03cf10bb3c..bb4150bc34 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -162,6 +162,10 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, si=
ze_t length)
=20
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
                     "pa_threaded_mainloop_lock failed\n");
+    if (pa_stream_get_state(p->stream) !=3D PA_STREAM_READY) {
+        /* wait for stream to become ready */
+        goto unlock;
+    }
=20
     while (total < length) {
         size_t l;
@@ -191,6 +195,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, siz=
e_t length)
         }
     }
=20
+unlock:
     pa_threaded_mainloop_unlock(c->mainloop);
     return total;
=20
--=20
2.16.4


