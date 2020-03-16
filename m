Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1115CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F74206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnmsEWBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F74206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxes-0004y5-UH
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHi-0003q0-NI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHh-0005Mi-IB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHh-0005Jb-Cz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+BOl0amfKr7UXhgG4Q7Xq9HkrFNXXEvNrFeurKand0=;
 b=QnmsEWBWL9E9Q5v+amVr+ScmWDP4BsjifSb1VU9F24DAsNTuO3dnaTEee8BxF1hY3ARkcH
 ColM++kMnBU3HKZOfEevliGqRTgC6EZEKC3j5khVpk8snJTY05HoESC/YxMUEm++65gBK3
 m86+ydX3dzfPoaD/1HNlBCWMWxbOrcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-RlI9FaEZMueS5TZE10qkew-1; Mon, 16 Mar 2020 17:28:25 -0400
X-MC-Unique: RlI9FaEZMueS5TZE10qkew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB410149CC
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:24 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7C3B19C4F;
 Mon, 16 Mar 2020 21:28:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/61] ui/curses: Make control_characters[] array const
Date: Mon, 16 Mar 2020 22:26:55 +0100
Message-Id: <1584394048-44994-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

As we only use this array as input, make it const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/curses.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 3a1b714..3bafc10 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -529,7 +529,7 @@ static void font_setup(void)
      * Control characters are normally non-printable, but VGA does have
      * well-known glyphs for them.
      */
-    static uint16_t control_characters[0x20] =3D {
+    static const uint16_t control_characters[0x20] =3D {
       0x0020,
       0x263a,
       0x263b,
--=20
1.8.3.1



