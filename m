Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69531C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347172076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw80ocsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347172076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBg2-0002px-83
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBWo-0007pR-8d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUBUo-0003UG-52
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUBUn-0003T2-M7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXNnshdKbGUO0D3O9iDh9E78tDzNO/uFU6kR1rh1Phc=;
 b=Zw80ocsQDvXTAtunK4v/7A0iDRx/JqOngQLw4pyZMvaLvnRJomGHvC7nSVfwgeLqGQ9CIh
 igJ3qmlje0HFdIOrTaIekhgupXtH5l592wjO7FBOm7M/7jWtoitoZLNL5ZBvSuLDq1khFk
 fUv/rVujLxdc+yL7dM5d9DHso2ZlUMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-VV-d7FBBPVG_0BwQRbgcOw-1; Thu, 30 Apr 2020 11:53:01 -0400
X-MC-Unique: VV-d7FBBPVG_0BwQRbgcOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF96108BD0E;
 Thu, 30 Apr 2020 15:53:00 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C59E61983;
 Thu, 30 Apr 2020 15:52:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/15] raw-format: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Thu, 30 Apr 2020 17:52:23 +0200
Message-Id: <20200430155231.473156-8-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
References: <20200430155231.473156-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The raw format driver can simply forward the flag and let its bs->file
child take care of actually providing the zeros.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200424125448.63318-6-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/raw-format.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 3465c9a865..351f2d91c6 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverStat=
e *bs, int64_t offset,
=20
     s->size =3D offset;
     offset +=3D s->offset;
-    return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
+    return bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp=
);
 }
=20
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
@@ -445,6 +445,8 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
+    bs->supported_truncate_flags =3D bs->file->bs->supported_truncate_flag=
s &
+                                   BDRV_REQ_ZERO_WRITE;
=20
     if (bs->probed && !bdrv_is_read_only(bs)) {
         bdrv_refresh_filename(bs->file->bs);
--=20
2.25.3


