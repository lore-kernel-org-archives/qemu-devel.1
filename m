Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D3C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A9B21E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoWLjt5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A9B21E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCHx-0001Xo-Ge
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9O-0007tr-5k
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9M-0002l8-Vp
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45960
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9M-0002kq-Pv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBxYyLElSLzboh8cesGsJMPgXDGU3wNgSyzMbJz9L+E=;
 b=IoWLjt5mrSodjPqzR57cgGzTt0joOdUT1c6znlxSoJSUeXJErGOtbTtv3zi7X/mOOi7cLz
 +/+UgrABdvZJFQrkj4oSKxtpbFwzE6oFW0V/thUUvpGUq8eLGRLn2gjh3SzBGcjP9o5wNf
 l/pAm7j883hRDkoxVL2QGCtqJHuJ+I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-kadYVi_PNMiRCla8N5kaKw-1; Mon, 11 Nov 2019 11:02:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7267B911E8;
 Mon, 11 Nov 2019 16:02:40 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24DA608FB;
 Mon, 11 Nov 2019 16:02:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 07/23] blkverify: Implement
 .bdrv_recurse_can_replace()
Date: Mon, 11 Nov 2019 17:02:00 +0100
Message-Id: <20191111160216.197086-8-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: kadYVi_PNMiRCla8N5kaKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 304b0a1368..0add3ab483 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -282,6 +282,20 @@ static bool blkverify_recurse_is_first_non_filter(Bloc=
kDriverState *bs,
     return bdrv_recurse_is_first_non_filter(s->test_file->bs, candidate);
 }
=20
+static bool blkverify_recurse_can_replace(BlockDriverState *bs,
+                                          BlockDriverState *to_replace)
+{
+    BDRVBlkverifyState *s =3D bs->opaque;
+
+    /*
+     * blkverify quits the whole qemu process if there is a mismatch
+     * between bs->file->bs and s->test_file->bs.  Therefore, we know
+     * know that both must match bs and we can recurse down to either.
+     */
+    return bdrv_recurse_can_replace(bs->file->bs, to_replace) ||
+           bdrv_recurse_can_replace(s->test_file->bs, to_replace);
+}
+
 static void blkverify_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s =3D bs->opaque;
@@ -328,6 +342,7 @@ static BlockDriver bdrv_blkverify =3D {
=20
     .is_filter                        =3D true,
     .bdrv_recurse_is_first_non_filter =3D blkverify_recurse_is_first_non_f=
ilter,
+    .bdrv_recurse_can_replace         =3D blkverify_recurse_can_replace,
 };
=20
 static void bdrv_blkverify_init(void)
--=20
2.23.0


