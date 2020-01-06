Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A8C33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1547720731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak2h9KSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRvp-0006Aq-TR
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsF-0000sN-Il
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsE-0000sd-JS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsE-0000rl-Fi
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TW5bcEK2mcJf++KaE2c3KEtsJTZNzjVIEZEEOKxkiYE=;
 b=Ak2h9KShJLInJDnItTR/OC0nK8SiVwcpgArD41leGsDSv0ocQ3RgPjYgtxpr+nybr+OPnl
 kNaksqQiaztvjmUij7PGWFF6U2DklGYEpVv/jrHHI359ZFqeHqqtmCk2oWuVPizXgrFRNJ
 G+kuYjWf0HDd8NvpD+7+DIR+RpWytd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-MAczsVmoOsiymzpbPNrUsQ-1; Mon, 06 Jan 2020 07:52:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ED731800D53;
 Mon,  6 Jan 2020 12:52:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 112D584FE2;
 Mon,  6 Jan 2020 12:52:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B9C9E31E9A; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] audio: fix integer overflow
Date: Mon,  6 Jan 2020 13:52:36 +0100
Message-Id: <20200106125236.24132-7-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
References: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MAczsVmoOsiymzpbPNrUsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Tell the compiler to do a 32bit * 32bit -> 64bit multiplication
because period_ticks is a 64bit variable. The overflow occurs
for audio timer periods larger than 4294967us.

Fixes: be1092afa0 "audio: fix audio timer rate conversion bug"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 8893a235-66a8-8fbe-7d95-862e29da90b1@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 56fae5504710..abea027fdf69 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1738,7 +1738,7 @@ static AudioState *audio_init(Audiodev *dev, const ch=
ar *name)
     if (dev->timer_period <=3D 0) {
         s->period_ticks =3D 1;
     } else {
-        s->period_ticks =3D dev->timer_period * SCALE_US;
+        s->period_ticks =3D dev->timer_period * (int64_t)SCALE_US;
     }
=20
     e =3D qemu_add_vm_change_state_handler (audio_vm_change_state_handler,=
 s);
--=20
2.18.1


