Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB6C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBE720857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FonE+P2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBE720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdQX-0002fT-Sm
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMX-00058K-7b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMW-0005uY-OE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMW-0005rv-8G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3M8gFD7q8+zUQWZdLRN5ey4Zf9++3rM48FFVh4uyw7A=;
 b=FonE+P2dHh+tWbdc6kjPmVk8zQhGe26ix/2yihbovyNwfO4V+2qjEINLxGVBbovp1HaX40
 +m8vX0C2OrNT0Hck1b4mDc7m2zRNNB0KZ1I+75gidM+QA/EsbmFQptXJ0b6miAX04Jmufx
 64pS4/T+HlwimxqDSwStMjptsHRgMzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-q-77FQhnNFWxxxTdWCxNNw-1; Thu, 23 Apr 2020 11:01:51 -0400
X-MC-Unique: q-77FQhnNFWxxxTdWCxNNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D121100CCC2;
 Thu, 23 Apr 2020 15:01:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF0660E1C;
 Thu, 23 Apr 2020 15:01:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 06/10] file-posix: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Thu, 23 Apr 2020 17:01:23 +0200
Message-Id: <20200423150127.142609-7-kwolf@redhat.com>
In-Reply-To: <20200423150127.142609-1-kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
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

For regular files, we always get BDRV_REQ_ZERO_WRITE behaviour from the
OS, so we can advertise the flag and just ignore it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 53f475ed61..1dca220a81 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -702,6 +702,10 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,
 #endif
=20
     bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK=
;
+    if (S_ISREG(st.st_mode)) {
+        /* When extending regular files, we get zeros from the OS */
+        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
+    }
     ret =3D 0;
 fail:
     if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
--=20
2.25.3


