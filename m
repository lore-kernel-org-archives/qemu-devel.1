Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29AC32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07650215A4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07650215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1infUP-00038F-15
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 04:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infTC-0001qR-5o
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infTA-0007TL-R2
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:42 -0500
Received: from mailout12.t-online.de ([194.25.134.22]:33140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1infTA-0007NT-Jc
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:40 -0500
Received: from fwd21.aul.t-online.de (fwd21.aul.t-online.de [172.20.27.66])
 by mailout12.t-online.de (Postfix) with SMTP id 30B6A41E652F;
 Sat,  4 Jan 2020 10:11:39 +0100 (CET)
Received: from linpower.localnet
 (EZWeFBZfghF69dEMnIqJRorvOHbAgVQGZh4eOH2FBL4NRM7JDnFHVw+xIron87bgSS@[46.86.52.107])
 by fwd21.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1infT2-0fp5CC0; Sat, 4 Jan 2020 10:11:32 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 2723E202791; Sat,  4 Jan 2020 10:11:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 5/5] paaudio: wait until the recording stream is ready
Date: Sat,  4 Jan 2020 10:11:22 +0100
Message-Id: <20200104091122.13971-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
References: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: EZWeFBZfghF69dEMnIqJRorvOHbAgVQGZh4eOH2FBL4NRM7JDnFHVw+xIron87bgSS
X-TOI-MSGID: adab2745-9ac0-43f4-9e76-d06ad377268a
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
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
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
index b23274550e..dbfe48c03a 100644
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


