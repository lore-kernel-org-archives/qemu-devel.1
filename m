Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D7F214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP2JcZRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D7F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaNB-0004vX-9z
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLc-0002ld-8q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLb-0004SP-7C
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLb-0004Rd-1Y
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAXHXGHUzOtsBvmo26uXaYT7Dh6K1j22oz09jejpdqU=;
 b=LP2JcZRSw7BFQWTaDOJd9zTVwP5ZfWYO2lsoLMhfmSn0Zy28DajLmIBog6p7hs3hC8m8Xe
 iEii1SoXjIf5vWlFYS5EtMDxqAIZixeqtVnOUA8ezH9fUpj5lrs3VdX3bx8cQhhC/++Z1Z
 OoSA6lvrYhHFjO4PWA2z0Pb092fFgRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-v79gN-BqM_2enLWrON2g6g-1; Fri, 31 Jan 2020 12:44:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0ED107ACC4;
 Fri, 31 Jan 2020 17:44:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA6DB811E3;
 Fri, 31 Jan 2020 17:44:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] sheepdog: Consistently set bdrv_has_zero_init_truncate
Date: Fri, 31 Jan 2020 11:44:27 -0600
Message-Id: <20200131174436.2961874-9-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: v79gN-BqM_2enLWrON2g6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 mreitz@redhat.com, david.edmondson@oracle.com, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_int.h claims that .bdrv_has_zero_init must return 0 if
.bdrv_has_zero_init_truncate does likewise; but this is violated if
only the former callback is provided if .bdrv_co_truncate also exists.
When adding the latter callback, it was mistakenly added to only one
of the three possible sheepdog instantiations.

Fixes: 1dcaf527
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/sheepdog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index cfa84338a2d6..522c16a93676 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3269,6 +3269,7 @@ static BlockDriver bdrv_sheepdog_tcp =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3307,6 +3308,7 @@ static BlockDriver bdrv_sheepdog_unix =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
--=20
2.24.1


