Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C8C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B4421973
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkAw5+iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B4421973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWto-00059j-9x
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWrA-0000aB-14
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr9-00067o-G9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37555
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWr9-000640-1v
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oR44ko9tgAkAbcKyKiOtRNeKfJpiYH4oHkf4nr0f+PY=;
 b=RkAw5+iCcq50/ThPyW/GoeOeAzteEnFSlR9X88FcUxwMGu0fh6Vqsj3drdmxO0gTlWLuKn
 p5twJHNLNaINh4dYMs+dkPOTrHdSa04SAVaTvpyulJ3T6hBiBCfY3hN3pLKU5oFAtn6jKc
 nqzFfO4MzAHPPMk/GPx6HQKhjlfmHZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-N4SFO4rLOcOTLoB2ZF3zfg-1; Tue, 28 Apr 2020 16:29:21 -0400
X-MC-Unique: N4SFO4rLOcOTLoB2ZF3zfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFAB9107ACF3;
 Tue, 28 Apr 2020 20:29:20 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC7C55C1D4;
 Tue, 28 Apr 2020 20:29:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Tue, 28 Apr 2020 15:29:01 -0500
Message-Id: <20200428202905.770727-6-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, Liu Yuan <namei.unix@gmail.com>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our .bdrv_has_zero_init_truncate always returns 1 because sheepdog
always 0-fills; we can use that same knowledge to implement
BDRV_REQ_ZERO_WRITE by ignoring it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/sheepdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index ef0a6e743e27..26fd22c7f07d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1654,6 +1654,7 @@ static int sd_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
     memcpy(&s->inode, buf, sizeof(s->inode));

     bs->total_sectors =3D s->inode.vdi_size / BDRV_SECTOR_SIZE;
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
     pstrcpy(s->name, sizeof(s->name), vdi);
     qemu_co_mutex_init(&s->lock);
     qemu_co_mutex_init(&s->queue_lock);
--=20
2.26.2


