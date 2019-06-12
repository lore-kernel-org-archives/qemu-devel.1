Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38986C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108F1208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108F1208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBgJ-0002C9-Bb
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBS5-0007Uf-GE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBS2-0007e7-NH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBRx-0007Ug-7d; Wed, 12 Jun 2019 18:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 916FB2CE945;
 Wed, 12 Jun 2019 22:10:27 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 229DB60185;
 Wed, 12 Jun 2019 22:10:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:30 +0200
Message-Id: <20190612221004.2317-9-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 22:10:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 08/42] block: bdrv_set_backing_hd() is about
 bs->backing
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_set_backing_hd() is a function that explicitly cares about the
bs->backing child.  Highlight that in its description and use
child_bs(bs->backing) instead of backing_bs(bs) to make it more obvious.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 64d6190984..8438b0699e 100644
--- a/block.c
+++ b/block.c
@@ -2417,7 +2417,7 @@ static bool bdrv_inherits_from_recursive(BlockDrive=
rState *child,
 }
=20
 /*
- * Sets the backing file link of a BDS. A new reference is created; call=
ers
+ * Sets the bs->backing link of a BDS. A new reference is created; calle=
rs
  * which don't need their own reference any more must call bdrv_unref().
  */
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing=
_hd,
@@ -2426,7 +2426,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
     bool update_inherits_from =3D bdrv_chain_contains(bs, backing_hd) &&
         bdrv_inherits_from_recursive(backing_hd, bs);
=20
-    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
+    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)) {
         return;
     }
=20
--=20
2.21.0


