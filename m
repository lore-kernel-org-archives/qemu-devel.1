Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DDC41514
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981DB21881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981DB21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gBP-00052b-FJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 14:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2g7q-0002a2-0A
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2g7n-0005Jm-RX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2g7l-0005Hq-Dh; Tue, 27 Aug 2019 14:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0C2A8980EA;
 Tue, 27 Aug 2019 18:23:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56D48600D1;
 Tue, 27 Aug 2019 18:23:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 27 Aug 2019 20:23:00 +0200
Message-Id: <20190827182313.25983-3-mreitz@redhat.com>
In-Reply-To: <20190827182313.25983-1-mreitz@redhat.com>
References: <20190827182313.25983-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 27 Aug 2019 18:23:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/15] block: fix permission update in
 bdrv_replace_node
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's wrong to OR shared permissions. It may lead to crash on further
permission updates.
Also, no needs to consider previously calculated permissions, as at
this point we already bind all new parents and bdrv_get_cumulative_perm
result is enough. So fix the bug by just set permissions by
bdrv_get_cumulative_perm result.

Bug was introduced in long ago 234ac1a9025, in 2.9.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190824100740.61635-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 874a29a983..5944124845 100644
--- a/block.c
+++ b/block.c
@@ -4165,7 +4165,6 @@ void bdrv_replace_node(BlockDriverState *from, Bloc=
kDriverState *to,
 {
     BdrvChild *c, *next;
     GSList *list =3D NULL, *p;
-    uint64_t old_perm, old_shared;
     uint64_t perm =3D 0, shared =3D BLK_PERM_ALL;
     int ret;
=20
@@ -4211,8 +4210,8 @@ void bdrv_replace_node(BlockDriverState *from, Bloc=
kDriverState *to,
         bdrv_unref(from);
     }
=20
-    bdrv_get_cumulative_perm(to, &old_perm, &old_shared);
-    bdrv_set_perm(to, old_perm | perm, old_shared | shared);
+    bdrv_get_cumulative_perm(to, &perm, &shared);
+    bdrv_set_perm(to, perm, shared);
=20
 out:
     g_slist_free(list);
--=20
2.21.0


