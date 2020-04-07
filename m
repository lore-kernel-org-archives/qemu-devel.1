Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C92C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D14206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZaMIwLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D14206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkSL-0004Ud-PZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkR7-0002OU-Db
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkR5-0000h5-84
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkR3-0000dt-OK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NM3v1M7rRjav14bilItKEzeKQnAuvPJUdvO24hXCyXs=;
 b=YZaMIwLbtEe45EwixOEtwA8DRe6ORnko5SMiBp4WbPH5cBMrN8XOlvAgnNM2p7mZGO63tp
 kXlw8XLtwfLXzAaJXQTNsMe4gd4ZJhweux0Ni1AeDdV16buCATgTXYNiGuSzQ2djjMcDgt
 Zqfw6qxbs/Shwz1xFssT4uWHFAFE9VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-z5b4TgFlMpmWaR7RgW4ACw-1; Tue, 07 Apr 2020 05:22:15 -0400
X-MC-Unique: z5b4TgFlMpmWaR7RgW4ACw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8378017CE;
 Tue,  7 Apr 2020 09:22:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CA145C1BB;
 Tue,  7 Apr 2020 09:22:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 15DEF17511; Tue,  7 Apr 2020 11:22:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] dsoundaudio: fix "Could not lock capture buffer" warning
Date: Tue,  7 Apr 2020 11:22:04 +0200
Message-Id: <20200407092207.6079-3-kraxel@redhat.com>
In-Reply-To: <20200407092207.6079-1-kraxel@redhat.com>
References: <20200407092207.6079-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

IDirectSoundCaptureBuffer_Lock() fails on Windows when called
with len =3D 0. Return early from dsound_get_buffer_in() in this
case.

To reproduce the warning start a linux guest. In the guest
start Audacity and you will see a lot of "Could not lock
capture buffer" warnings.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200405075017.9901-2-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/dsoundaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 9e621c889954..a08d519cae6a 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -542,6 +542,11 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_=
t *size)
     req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
     req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
=20
+    if (req_size =3D=3D 0) {
+        *size =3D 0;
+        return NULL;
+    }
+
     err =3D dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, =
NULL,
                          &act_size, NULL, false, ds->s);
     if (err) {
--=20
2.18.2


