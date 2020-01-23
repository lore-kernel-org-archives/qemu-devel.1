Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F61C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2B024655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2B024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXMU-000692-CQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFd-00061d-R3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1iuXFc-0004j0-UB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:05 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:50686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1iuXFc-0004hu-OE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:50:04 -0500
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout03.t-online.de (Postfix) with SMTP id CAC18426D4ED;
 Thu, 23 Jan 2020 08:50:02 +0100 (CET)
Received: from linpower.localnet
 (bdOpmsZawhWbFhK9XojQt-0+cJTgGNpHSj4-Vdy8o65QU2oaeQz3Suo1r9mdc4wwHq@[46.86.62.122])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iuXFU-12fW7M0; Thu, 23 Jan 2020 08:49:56 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5CBB8200F75; Thu, 23 Jan 2020 08:49:43 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 6/9] ossaudio: prevent SIGSEGV in oss_enable_out
Date: Thu, 23 Jan 2020 08:49:40 +0100
Message-Id: <20200123074943.6699-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
References: <1e29e1d3-b59b-fcd6-cdff-a680bcdbffa4@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: bdOpmsZawhWbFhK9XojQt-0+cJTgGNpHSj4-Vdy8o65QU2oaeQz3Suo1r9mdc4wwHq
X-TOI-MSGID: ca8aec17-591c-475c-b00f-b6ac2ae58548
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With audiodev parameter out.mixing-engine=3Doff hw->mix_buf is
NULL. This patch reverts a small part of dc88e38fa7 "audio:
unify input and output mixeng buffer management".

To reproduce the problem start qemu with
-audiodev oss,id=3Daudio0,try-mmap=3Don,out.mixing-engine=3Doff

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/ossaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 4965084a5a..6a3b78b381 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -592,7 +592,7 @@ static void oss_enable_out(HWVoiceOut *hw, bool enabl=
e)
             return;
         }
=20
-        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->s=
ize);
+        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
         trig =3D PCM_ENABLE_OUTPUT;
         if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr(errno,
--=20
2.16.4


