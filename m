Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92060C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E42021741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO4feOEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E42021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyMj-0007Kn-HD
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL3-0005as-QF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyL2-0003Q6-LN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyL2-0003O6-G3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EecObiBUnF2X4g2+0vLllqQlzF5WUiqA+3VlWEDtW7M=;
 b=TO4feOEchrCTvIo80g7GuYUVYpSIUSqebmHqlRcngohqn5Hlhu+EZWPvIDUgEj0yw75hDu
 L5V+txAOManRtGudQ/EKtJjWpmeVmzNfbkP8nRwvBtvwp319qB31L9/5dE1vSEJ3gkIs0B
 JfQuoQUHQ/WnKPn8X4hmDHXUWjUMAuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-BV6AbAnuPSS_dk1eJL_YFw-1; Fri, 07 Feb 2020 02:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7E88189F76B;
 Fri,  7 Feb 2020 07:46:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2889A1001281;
 Fri,  7 Feb 2020 07:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2309331F06; Fri,  7 Feb 2020 08:45:58 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] ossaudio: prevent SIGSEGV in oss_enable_out
Date: Fri,  7 Feb 2020 08:45:52 +0100
Message-Id: <20200207074557.26073-8-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BV6AbAnuPSS_dk1eJL_YFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

With audiodev parameter out.mixing-engine=3Doff hw->mix_buf is
NULL. This patch reverts a small part of dc88e38fa7 "audio:
unify input and output mixeng buffer management".

To reproduce the problem start qemu with
-audiodev oss,id=3Daudio0,try-mmap=3Don,out.mixing-engine=3Doff

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-6-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/ossaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 576b5b5b2021..39a6fc09e5df 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -592,7 +592,7 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
             return;
         }
=20
-        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->siz=
e);
+        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->samples);
         trig =3D PCM_ENABLE_OUTPUT;
         if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr(errno,
--=20
2.18.1


