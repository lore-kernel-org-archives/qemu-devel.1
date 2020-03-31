Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 22:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0089D20787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 22:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrQCO01G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0089D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJPKW-0002G2-4a
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 18:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJPJV-0001Tz-6Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJPJT-0006TG-Ft
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:24:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJPJT-0006QX-9L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 18:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585693490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cvv9qtpWPxzjfehLV//hxvpa5k198iHLFgl0waVWh/o=;
 b=DrQCO01GoAMkoADVKDdgPmWymGjK1GuhTtiapt6n0N7/44zuFLNMD6gzMXIVIqJaVqlHGl
 s0jwKQYemFvwNpQasUtXeL4TwBhujTYwBzUH1IpU0m+dCCcEVoR/vLLqc3vbtCTrMmv1d1
 EGagImLhglvU1TFOYJ1vTwA9ZGcvlIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-E2lzXSHINSuIgOzsOr1c8w-1; Tue, 31 Mar 2020 18:24:48 -0400
X-MC-Unique: E2lzXSHINSuIgOzsOr1c8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015BB1034B20;
 Tue, 31 Mar 2020 22:24:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1869B194BB;
 Tue, 31 Mar 2020 22:24:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] qemu-img: Report convert errors by bytes, not sectors
Date: Tue, 31 Mar 2020 17:24:42 -0500
Message-Id: <20200331222442.273158-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
---

Noticed while investigating https://bugzilla.redhat.com/1819240

By the way, I found it odd that even without --salvage, qemu-img
convert will process up to 8 EIO failures (based on its default
coroutine depth of 8) before finally exiting, rather than quitting
immediately on the first EIO failure.

 qemu-img.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b167376bd72e..77219e25b33b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1924,8 +1924,9 @@ retry:
         if (status =3D=3D BLK_DATA && !copy_range) {
             ret =3D convert_co_read(s, sector_num, n, buf);
             if (ret < 0) {
-                error_report("error while reading sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
+                error_report("error while reading at byte %" PRId64
+                             ": %s", sector_num * BDRV_SECTOR_SIZE,
+                             strerror(-ret));
                 s->ret =3D ret;
             }
         } else if (!s->min_sparse && status =3D=3D BLK_ZERO) {
@@ -1953,8 +1954,9 @@ retry:
                 ret =3D convert_co_write(s, sector_num, n, buf, status);
             }
             if (ret < 0) {
-                error_report("error while writing sector %" PRId64
-                             ": %s", sector_num, strerror(-ret));
+                error_report("error while writing at byte %" PRId64
+                             ": %s", sector_num * BDRV_SECTOR_SIZE,
+                             strerror(-ret));
                 s->ret =3D ret;
             }
         }
--=20
2.26.0.rc2


