Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B87217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNAWbMt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B87217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgpg-00043H-Bk
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgde-0003pN-2B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdd-0001qy-0G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdc-0001pR-SN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHAUWzt6avoVW6phXiYyG8JK8L6KH9qBvSRszB9uNBQ=;
 b=iNAWbMt9nAW5z3LFrxwvAKso9HdRtzsXkqGalAyGqU/zRRah+G3m4mg4SadoLvwVtYOVyB
 /dr6R2wcbYbJJm7TZ+H7CA0++PgTN54aA3sxKlYoxC6osxS8hv5ZKw0gxaEhLXFpW7mqGp
 XP8kLPHbBA4TVPjdvNX4WU0YOUBrXQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-HShPvbFqO5CaL9WDFue_ZA-1; Thu, 06 Feb 2020 07:52:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 776CA800D6C;
 Thu,  6 Feb 2020 12:52:05 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C11E60BF7;
 Thu,  6 Feb 2020 12:52:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/17] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
Date: Thu,  6 Feb 2020 13:51:30 +0100
Message-Id: <20200206125132.594625-16-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HShPvbFqO5CaL9WDFue_ZA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This replaces all remaining instances in the qcow2 code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: b5f74b606c2d9873b12d29acdb7fd498029c4025.1579374329.git.berto@i=
galia.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ff257d1a6c..ef96606f8d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3272,7 +3272,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options=
, Error **errp)
=20
     /* Validate options and set default values */
     if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
-        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        error_setg(errp, "Image size must be a multiple of %u bytes",
+                   (unsigned) BDRV_SECTOR_SIZE);
         ret =3D -EINVAL;
         goto out;
     }
@@ -3946,8 +3947,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
         return -ENOTSUP;
     }
=20
-    if (offset & 511) {
-        error_setg(errp, "The new size must be a multiple of 512");
+    if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "The new size must be a multiple of %u",
+                   (unsigned) BDRV_SECTOR_SIZE);
         return -EINVAL;
     }
=20
--=20
2.24.1


