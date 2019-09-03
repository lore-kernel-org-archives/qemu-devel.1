Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E160B233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160B233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59GQ-0007NK-DX
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58ye-0002A4-OE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58yd-0006DS-BM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yX-00067X-5s; Tue, 03 Sep 2019 09:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DCFA18C8939;
 Tue,  3 Sep 2019 13:36:00 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F791001947;
 Tue,  3 Sep 2019 13:35:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:39 +0200
Message-Id: <20190903133553.6500-3-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 03 Sep 2019 13:36:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 02/16] block: fix permission update in
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


