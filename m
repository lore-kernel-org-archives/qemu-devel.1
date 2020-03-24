Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0225C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFDA206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qg5jjSkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFDA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGndR-0001It-OV
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnZc-0004hx-NV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnZb-0007VJ-OB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnZb-0007V0-Kd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uivZlGw/PF880rbLriUotiKEjwGQJhiL5E+HnBH1sZU=;
 b=Qg5jjSkBxz+eoPx7B2SkHzVpgadFwv6jtYj14BEzRQjJ7sdqAja7knbiY26KwUhJmLETPg
 2E8Wzken19Bt5X/NDOj64evStCufe9hmazppRf05jeaPDT1d9wZteiTbcsGIND4uYxF0Mr
 sBW1uUQOQhYz6eLIWgNxDvEH6d90Xws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-0zejlRMwMhiRPoSrjN4lBg-1; Tue, 24 Mar 2020 13:42:41 -0400
X-MC-Unique: 0zejlRMwMhiRPoSrjN4lBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1197DBA3;
 Tue, 24 Mar 2020 17:42:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B06C410027A3;
 Tue, 24 Mar 2020 17:42:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] sheepdog: Consistently set bdrv_has_zero_init_truncate
Date: Tue, 24 Mar 2020 12:42:33 -0500
Message-Id: <20200324174233.1622067-5-eblake@redhat.com>
In-Reply-To: <20200324174233.1622067-1-eblake@redhat.com>
References: <20200324174233.1622067-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, Liu Yuan <namei.unix@gmail.com>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 mreitz@redhat.com
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
2.26.0.rc2


