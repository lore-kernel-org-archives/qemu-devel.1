Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA90C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FB920731
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpuUE2bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FB920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWsP-0002dX-6T
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr1-0000ET-3Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr0-0005kP-Jn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWr0-0005iX-6H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJ+p/tqLELPqYN/8ikEj31uiPglzD75NYSwEpqgn92s=;
 b=YpuUE2bQQW02LWhYNSkPk2tYJyyvkifKWUR2IQBtfc0p6kJ5Bu2pwXOs23v8xb3jORlvYE
 WUSVPZ9if9WaPQyx0plLjfT3OFlhJcF8MZZ3QdC738NTUmypM1r5zeRvIrfFOclUx6Zuj5
 E2ThKNS+IeZQpAbym65CTrSMvFHfK4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-GLn_P-S2N6usvhjDhbpiyg-1; Tue, 28 Apr 2020 16:29:15 -0400
X-MC-Unique: GLn_P-S2N6usvhjDhbpiyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B15800D24;
 Tue, 28 Apr 2020 20:29:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 673425C221;
 Tue, 28 Apr 2020 20:29:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] file-win32: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Tue, 28 Apr 2020 15:28:58 -0500
Message-Id: <20200428202905.770727-3-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using bdrv_file, .bdrv_has_zero_init_truncate always returns 1;
therefore, we can behave just like file-posix, and always implement
BDRV_REQ_ZERO_WRITE by ignoring it since the OS gives it to us for
free (note that file-posix.c had to use an 'if' because it shared code
between regular files and block devices, but in file-win32.c,
bdrv_host_device uses a separate .bdrv_file_open).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-win32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/file-win32.c b/block/file-win32.c
index a6b0dda5c302..fa569685d8bc 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -408,6 +408,9 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
         win32_aio_attach_aio_context(s->aio, bdrv_get_aio_context(bs));
     }

+    /* When extending regular files, we get zeros from the OS */
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
+
     ret =3D 0;
 fail:
     qemu_opts_del(opts);
--=20
2.26.2


