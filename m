Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D95C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59972073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNkfBsiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59972073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTa8-0000hn-Sc
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTWJ-0003wK-9G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTWI-0002x9-6C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTWI-0002wv-2q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585233005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWQfoyRMi2UB6tSfDv5ZcVme4G4SuLgZNeD3/Fu/LIY=;
 b=SNkfBsiC6F2dXutdvj9VdDpS7wz0s7JNH4lCjLAUgQZ3SGjt8NP+CwmcJ5BGD55BMi5HfN
 qCTuIFvxx2gpollf1hqfU9G8y/acFnDdeNZ5jz3SS8Wyg6aD0/TvwL5825Ko1Wtg4tSWl0
 V9vNRWMRMZv+Uun038+WvkDcM80a4f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-hRcMrsSROhmf-hyMxP1Nzg-1; Thu, 26 Mar 2020 10:30:01 -0400
X-MC-Unique: hRcMrsSROhmf-hyMxP1Nzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E9A710509E1;
 Thu, 26 Mar 2020 14:30:00 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F745D9CD;
 Thu, 26 Mar 2020 14:29:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/10] sheepdog: Consistently set bdrv_has_zero_init_truncate
Date: Thu, 26 Mar 2020 15:29:30 +0100
Message-Id: <20200326142933.625037-8-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

block_int.h claims that .bdrv_has_zero_init must return 0 if
.bdrv_has_zero_init_truncate does likewise; but this is violated if
only the former callback is provided if .bdrv_co_truncate also exists.
When adding the latter callback, it was mistakenly added to only one
of the three possible sheepdog instantiations.

Fixes: 1dcaf527
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200324174233.1622067-5-eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/sheepdog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index a8a7e32a41..59f7ebb171 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3271,6 +3271,7 @@ static BlockDriver bdrv_sheepdog_tcp =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
@@ -3309,6 +3310,7 @@ static BlockDriver bdrv_sheepdog_unix =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
--=20
2.25.1


