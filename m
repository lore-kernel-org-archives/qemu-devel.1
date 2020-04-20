Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6177C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B187420735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INhNHaIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B187420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWbZ-00019E-Oz
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60844 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQWXc-0004LW-Lg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:57 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQWXY-0004cH-G3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQWXW-0004ZE-R2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL7UBIhvoG/wLPQSUq9KSKO3TPT+U79RqGcRCCVcc7g=;
 b=INhNHaIUTj0fiB2ImK6btfKzZqQLi6kUmHLRCKXiqqco2miB3vMrxijj0+W24y1t7zrCLU
 vk+D4y0Uu3cwqOv9JHgwkbl7tWqZ2wKjQKMduJhPKkl961wDu3LCRwzOYzoppEBb4qNYwe
 cMlX/H8JL8Z3Knpl1yy8aRLFSg7rd1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-rxm_UCPHPYycpYcbGqtobg-1; Mon, 20 Apr 2020 09:32:43 -0400
X-MC-Unique: rxm_UCPHPYycpYcbGqtobg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5343A801F9B;
 Mon, 20 Apr 2020 13:32:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0F79118DF5;
 Mon, 20 Apr 2020 13:32:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 5/9] raw-format: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Mon, 20 Apr 2020 15:32:10 +0200
Message-Id: <20200420133214.28921-6-kwolf@redhat.com>
In-Reply-To: <20200420133214.28921-1-kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The raw format driver can simply forward the flag and let its bs->file
child take care of actually providing the zeros.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/raw-format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 3465c9a865..ab69ac46d3 100644
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
@@ -445,6 +445,7 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
     bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
=20
     if (bs->probed && !bdrv_is_read_only(bs)) {
         bdrv_refresh_filename(bs->file->bs);
--=20
2.20.1


