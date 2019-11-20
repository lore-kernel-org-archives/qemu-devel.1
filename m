Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1571C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA64E2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEai6lSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA64E2230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQd5-0001sc-RU
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXQaF-0006Mk-Jy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXQaE-0000sO-Hp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXQaE-0000s5-Ec
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574258629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvE56udzdiFxJQ+oY8narTyNFfDLyHm1vvqTbdJj7/E=;
 b=VEai6lSiGZiSfk4dxDUL1YUMQF4vevAGcXq2cEgcvrBVZgRaNRk52KGG+V/GBvsKZCxlTq
 WYnTlyfSc6ImGjUdnexFC384kAHNMkF6eaaVwyJQATy+OSYEHCZTlpExS12pXG8hScLJ+m
 o14H5y32SZR8PwXWYAkySgaLZNNvKQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Y_ReeR6MNnSO7bts3Al6TA-1; Wed, 20 Nov 2019 09:03:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 211561005502;
 Wed, 20 Nov 2019 14:03:45 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D099C60493;
 Wed, 20 Nov 2019 14:03:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/6] block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
Date: Wed, 20 Nov 2019 15:03:14 +0100
Message-Id: <20191120140319.1505-2-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-1-kwolf@redhat.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y_ReeR6MNnSO7bts3Al6TA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_co_do_pwrite_zeroes() can already cope with maximum request sizes
by calling the driver in a loop until everything is done. Make the small
remaining change that is necessary to let it accept a 64 bit byte count.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index f75777f5ea..003f4ea38c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,7 +42,7 @@
=20
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags);
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags);
=20
 static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ign=
ore,
                                       bool ignore_bds_parents)
@@ -1730,7 +1730,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child=
,
 }
=20
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     BlockDriver *drv =3D bs->drv;
     QEMUIOVector qiov;
@@ -1760,7 +1760,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
     assert(max_write_zeroes >=3D bs->bl.request_alignment);
=20
     while (bytes > 0 && !ret) {
-        int num =3D bytes;
+        int num =3D MIN(bytes, BDRV_REQUEST_MAX_BYTES);
=20
         /* Align request.  Block drivers can expect the "bulk" of the requ=
est
          * to be aligned, and that unaligned requests do not cross cluster
--=20
2.20.1


