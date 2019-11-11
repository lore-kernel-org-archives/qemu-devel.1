Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA4C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C7921E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQRgXddf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7921E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCEV-0005T3-LO
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9E-0007gP-6d
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9C-0002hT-Vn
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9C-0002hH-SA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci3tBGhBQMbp9g6rpjNCLTiGWuLZL0KUEDcu2z4zqdk=;
 b=LQRgXddfS5l3HpDhZw4Ft1G4c6AGPrRLyQ4F4PB6BDRRwjLydTb8L98V7oU3MjxMMGVP8+
 NBxoOWSOOuiuc2EWSryOtCJiIkZtMhPEuWXspemOyN8oio2Jk+QROmPxCTIjdqFlPGlVq+
 uCiwHO7kRkR8vSbEZFsZjdQe4E5tqLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-qj3YBVAHMLqHfZVSPVcVEg-1; Mon, 11 Nov 2019 11:02:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F196D100550E;
 Mon, 11 Nov 2019 16:02:28 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 948806106C;
 Mon, 11 Nov 2019 16:02:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 03/23] block: Drop bdrv_is_first_non_filter()
Date: Mon, 11 Nov 2019 17:01:56 +0100
Message-Id: <20191111160216.197086-4-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qj3YBVAHMLqHfZVSPVcVEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is unused now.  (And it was ugly because it needed to explore all BDS
chains from the top.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c               | 26 --------------------------
 include/block/block.h |  1 -
 2 files changed, 27 deletions(-)

diff --git a/block.c b/block.c
index ae279ff21f..9b1049786a 100644
--- a/block.c
+++ b/block.c
@@ -6205,32 +6205,6 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverSta=
te *bs,
     return false;
 }
=20
-/* This function checks if the candidate is the first non filter bs down i=
t's
- * bs chain. Since we don't have pointers to parents it explore all bs cha=
ins
- * from the top. Some filters can choose not to pass down the recursion.
- */
-bool bdrv_is_first_non_filter(BlockDriverState *candidate)
-{
-    BlockDriverState *bs;
-    BdrvNextIterator it;
-
-    /* walk down the bs forest recursively */
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        bool perm;
-
-        /* try to recurse in this top level bs */
-        perm =3D bdrv_recurse_is_first_non_filter(bs, candidate);
-
-        /* candidate is the first non filter */
-        if (perm) {
-            bdrv_next_cleanup(&it);
-            return true;
-        }
-    }
-
-    return false;
-}
-
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **err=
p)
 {
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..8f6a0cad9c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -404,7 +404,6 @@ int bdrv_amend_options(BlockDriverState *bs_new, QemuOp=
ts *opts,
 /* external snapshots */
 bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
                                       BlockDriverState *candidate);
-bool bdrv_is_first_non_filter(BlockDriverState *candidate);
=20
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
--=20
2.23.0


