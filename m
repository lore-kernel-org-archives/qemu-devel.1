Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546C620719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbIzRhVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546C620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnV6-0000YT-Ez
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnU5-0007WS-96
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnU4-0006gK-5w
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnU4-0006ft-1p
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKH+gnzqiUbJPgjeEmnTWF0F/bRzuMD4YCHrY2ck3S4=;
 b=DbIzRhVexfoMNpFNqN4+QB3Zu1dMXPgWFMEdCGK40RwCBR076OK5OkUN3Dexq9MzxDG99O
 38xIsARXsKzDhVuow8Ohnyd8CLJtmNFXkV8DmyjmiPbCDTyn8tFhFLoLDkr5twCrLadoC3
 Kr6ZFgR8XRy5cfr5VUJcGOE0W7wS3Xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-tvwDbPj3O5KfI0lpfg7u5A-1; Tue, 07 Apr 2020 08:37:37 -0400
X-MC-Unique: tvwDbPj3O5KfI0lpfg7u5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 491561007277;
 Tue,  7 Apr 2020 12:37:36 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B018E9B905;
 Tue,  7 Apr 2020 12:37:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/5] qemu-img: Report convert errors by bytes, not sectors
Date: Tue,  7 Apr 2020 14:37:24 +0200
Message-Id: <20200407123727.829933-3-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
References: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Eric Blake <eblake@redhat.com>

Various qemu-img commands are inconsistent on whether they report
status/errors in terms of bytes or sector offsets.  The latter is
confusing (especially as more places move to 4k block sizes), so let's
switch everything to just use bytes everywhere.  One iotest is
impacted.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200402135717.476398-1-eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 8 ++++----
 tests/qemu-iotests/244.out | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b167376bd7..821cbf610e 100644
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
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index e6f4dc7993..56329deb4b 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -33,7 +33,7 @@ Convert to compressed target with data file:
 Formatting 'TEST_DIR/t.IMGFMT.src', fmt=3DIMGFMT size=3D67108864
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: error while writing sector 0: Operation not supported
+qemu-img: error while writing at byte 0: Operation not supported
=20
 Convert uncompressed, then write compressed data manually:
 Images are identical.
--=20
2.25.1


