Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBCCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E1820684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpS1PqO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUAw-0000j0-KK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1itU8L-0006H6-AP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1itU8K-0006TV-CE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:18:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1itU8K-0006TE-8Z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T6o0reu1MwlfA8b6JlWyMZw91O1QvVuAUkVo2niYfxo=;
 b=CpS1PqO99F7KOicrZD9oRwrpW7Z9EtVO/qxMuC7uQsJIgdvgrgO0horD+B/zzj6vgygagQ
 ijiKJoI7OnsvrnbPM5ZaRGZDWo5JcYAaAjKpbh5Vx0kHt/342YxIlEQeC+HwxPuWqhH4/n
 wRUMEiQU/CvMd3rJYfgmbA0P2jtOGxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-jy0CzBM-MnCNXQmszNZp3Q-1; Mon, 20 Jan 2020 05:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61E02DB60;
 Mon, 20 Jan 2020 10:18:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFDEC5D9E1;
 Mon, 20 Jan 2020 10:18:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1DCA116E18; Mon, 20 Jan 2020 11:18:04 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio/oss: fix buffer pos calculation
Date: Mon, 20 Jan 2020 11:18:04 +0100
Message-Id: <20200120101804.29578-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jy0CzBM-MnCNXQmszNZp3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 3ba4066d085f ("ossaudio: port to the new audio backend api")
Reported-by: ziming zhang <ezrakiez@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/ossaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c43faeeea4aa..94564916fbf0 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -420,7 +420,7 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size=
_t len)
             size_t to_copy =3D MIN(len, hw->size_emul - hw->pos_emul);
             memcpy(hw->buf_emul + hw->pos_emul, buf, to_copy);
=20
-            hw->pos_emul =3D (hw->pos_emul + to_copy) % hw->pos_emul;
+            hw->pos_emul =3D (hw->pos_emul + to_copy) % hw->size_emul;
             buf +=3D to_copy;
             len -=3D to_copy;
         }
--=20
2.18.1


