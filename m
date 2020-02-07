Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81152C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4F221741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McvPdSTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4F221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyOL-0001yt-Gi
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyKz-0005Vh-PU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyKy-0003By-OY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyKy-00039u-Kn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yJoHoeww5CZP41g7EJohjfO6yEatHkoysqf8+F30mE=;
 b=McvPdSTaUvSptD6BBgN/0nSkg8Wtq4RBnjU5ikCXNTAjrovuZj5+phxpYZMpc7FhqMrG05
 M3zqQ34oBs/C2UmMwCfp5U/a+6E9Efc21yolS7YJbi1V/Se17u6y3JGmEZSqhyS8PPehHg
 OXJ9vc6JgWZu8MZ3deOxqfAOmILYkcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-DE_SNCUvP-mrnyC-G7dVHw-1; Fri, 07 Feb 2020 02:46:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900EA800D5F
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 07:46:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2358BE25;
 Fri,  7 Feb 2020 07:45:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA4759AB9; Fri,  7 Feb 2020 08:45:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] audio/oss: fix buffer pos calculation
Date: Fri,  7 Feb 2020 08:45:46 +0100
Message-Id: <20200207074557.26073-2-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DE_SNCUvP-mrnyC-G7dVHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 3ba4066d085f ("ossaudio: port to the new audio backend api")
Reported-by: ziming zhang <ezrakiez@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200120101804.29578-1-kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


