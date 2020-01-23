Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52126C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293A224655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293A224655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXKx-0004bO-5m
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFa-0005yF-Fg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFZ-0004fu-G8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:02 -0500
Received: from mailout10.t-online.de ([194.25.134.21]:51690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iuXFZ-0004cw-9s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:01 -0500
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de [172.20.26.152])
 by mailout10.t-online.de (Postfix) with SMTP id 67E89415E823;
 Thu, 23 Jan 2020 08:49:58 +0100 (CET)
Received: from linpower.localnet
 (TlKvyEZTYhur9DAPGEYWKidjGj6J0KObIIHEdW-kC4SbcWks057M-zzpxngbDOSZgo@[46.86.62.122])
 by fwd10.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iuXFP-1KaRhg0; Thu, 23 Jan 2020 08:49:51 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 58C6A200F54; Thu, 23 Jan 2020 08:49:43 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/9] audio: prevent SIGSEGV in AUD_get_buffer_size_out
Date: Thu, 23 Jan 2020 08:49:38 +0100
Message-Id: <20200123074943.6699-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: TlKvyEZTYhur9DAPGEYWKidjGj6J0KObIIHEdW-kC4SbcWks057M-zzpxngbDOSZgo
X-TOI-MSGID: 8551bd31-6fca-49ca-a085-88876a6ea7fb
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.21
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

With audiodev parameter out.mixing-engine=3Doff hw->mix_buf is
NULL. This leads to a segmentation fault in
AUD_get_buffer_size_out. This patch reverts a small part of
dc88e38fa7 "audio: unify input and output mixeng buffer
management".

To reproduce the problem start qemu with
-soundhw adlib -audiodev pa,id=3Daudio0,out.mixing-engine=3Doff

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index bf0f01e17f..922e95011c 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -878,9 +878,9 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size=
)
     }
 }
=20
-int AUD_get_buffer_size_out (SWVoiceOut *sw)
+int AUD_get_buffer_size_out(SWVoiceOut *sw)
 {
-    return sw->hw->mix_buf->size * sw->hw->info.bytes_per_frame;
+    return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
=20
 void AUD_set_active_out (SWVoiceOut *sw, int on)
--=20
2.16.4


