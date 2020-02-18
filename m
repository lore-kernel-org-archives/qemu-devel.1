Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD678C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9989B2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiHeYpNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9989B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35925 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43gF-00013e-QX
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Y6-0007xW-MR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Y5-0001fr-JK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Y5-0001fg-Ft
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEEHRsBXiWxwEA9dwZYsjKfkEWtOHlBrAbXlY3LEDC4=;
 b=DiHeYpNa5HdUoKUe1Kczr+JecZtw9DnXMph9RauNoxuJ/LAD8+Gp23fpwUOaFB/W1I4dtp
 6hjtTdP/rrOX5aZtBJ8jdg7GuWCfLJedtI00k5cFCjUiG2NAAt6+/V9BrwzeGzbp3oYmSL
 nvXGQ5acNNrvXUU2IglsPmvyvrjPIgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-FsNnekyEOuOx5waEDMV18g-1; Tue, 18 Feb 2020 09:08:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA8E8017DF;
 Tue, 18 Feb 2020 14:08:23 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7F3C19E9C;
 Tue, 18 Feb 2020 14:08:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/36] blkverify: Implement .bdrv_recurse_can_replace()
Date: Tue, 18 Feb 2020 15:07:10 +0100
Message-Id: <20200218140722.23876-25-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FsNnekyEOuOx5waEDMV18g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-8-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.20.1


