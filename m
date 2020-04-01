Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3186EC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6A52071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bySC6nvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6A52071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhmQ-0006sG-51
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJhjK-0001x5-Kr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJhjJ-00050j-Jl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJhjJ-00050O-FU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585764284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AZGsCZ+Ii2LBIuQXrhpkP053TVqrWqrmCZYsfgS9h4M=;
 b=bySC6nvL62Q8PwgbZqBGN5YiioI99RPAy0jOw5Gjsb/VLbF7h9hKR7tRr8XmfILSlEH/Jw
 aYQYz4pw+jW8uAA8sZi6S95XxTYAKzdeX8xVZku/JK2+1O2oLTdSfHFEnb8KErvzPHl8e5
 y9f42yZaDy0kd6fOZchZs0RFjlXXICs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-8IJROCREOqWlXFeBqyctfw-1; Wed, 01 Apr 2020 14:04:40 -0400
X-MC-Unique: 8IJROCREOqWlXFeBqyctfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70DB2DB21;
 Wed,  1 Apr 2020 18:04:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA8515D9CD;
 Wed,  1 Apr 2020 18:04:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2] qemu-img: Report convert errors by bytes,
 not sectors
Date: Wed,  1 Apr 2020 13:04:36 -0500
Message-Id: <20200401180436.298613-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various qemu-img commands are inconsistent on whether they report
status/errors in terms of bytes or sector offsets.  The latter is
confusing (especially as more places move to 4k block sizes), so let's
switch everything to just use bytes everywhere.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

- v2: fix printf formats [patchew]

 qemu-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b167376bd72e..821cbf610e5f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1924,8 +1924,8 @@ retry:
         if (status =3D=3D BLK_DATA && !copy_range) {
             ret =3D convert_co_read(s, sector_num, n, buf);
             if (ret < 0) {
-                error_report("error while reading sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
+                error_report("error while reading at byte %lld: %s",
+                             sector_num * BDRV_SECTOR_SIZE, strerror(-ret)=
);
                 s->ret =3D ret;
             }
         } else if (!s->min_sparse && status =3D=3D BLK_ZERO) {
@@ -1953,8 +1953,8 @@ retry:
                 ret =3D convert_co_write(s, sector_num, n, buf, status);
             }
             if (ret < 0) {
-                error_report("error while writing sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
+                error_report("error while writing at byte %lld: %s",
+                             sector_num * BDRV_SECTOR_SIZE, strerror(-ret)=
);
                 s->ret =3D ret;
             }
         }
--=20
2.26.0.rc2


