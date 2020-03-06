Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1076C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8AA2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHvWmpi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8AA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8uv-0003xH-Ok
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jA8ty-0003Vv-NY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jA8ts-00056A-EU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:04:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jA8ts-00054D-Ai
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583485447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JzA6zltuRXqG9mVlWv6KVNMKJq/OIb9HaK02b7II9lc=;
 b=FHvWmpi4mbXEary5BdUaaUP7z1o6wYC1zH+B+Zird8flrKW/RA+VMfaAl0mkjNBasYBMmS
 +VXVn+c18klGskmZlxv46SPDotSZ7cArn43dRRHMc8ti+T8M7eyvNradERu0Z5yqz8BQep
 2kqFTMBCro9WflOCpv+8k+yl4CFz0D0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-4fkIqenJP_uvrOq6Aj-blw-1; Fri, 06 Mar 2020 04:04:03 -0500
X-MC-Unique: 4fkIqenJP_uvrOq6Aj-blw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3728107ACCA;
 Fri,  6 Mar 2020 09:04:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C28A51001902;
 Fri,  6 Mar 2020 09:03:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D6829DB3; Fri,  6 Mar 2020 10:03:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Subject: [PATCH] sercon: vbe modeset is int 10h function 4f02 not 4f00
Date: Fri,  6 Mar 2020 10:03:21 +0100
Message-Id: <20200306090321.24811-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes console redirection for NetBSD primary bootloader.

https://bugs.launchpad.net/bugs/1743191
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/sercon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sercon.c b/src/sercon.c
index a5dadb7261af..66a1f2412e77 100644
--- a/src/sercon.c
+++ b/src/sercon.c
@@ -464,7 +464,7 @@ static void sercon_104f(struct bregs *regs)
         regs->ax =3D 0x0100;
     } else {
         // Disable sercon entry point on any vesa modeset
-        if (regs->al =3D=3D 0x00)
+        if (regs->al =3D=3D 0x02)
             SET_LOW(sercon_enable, 0);
     }
 }
--=20
2.18.2


