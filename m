Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E751AECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B976321D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B976321D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDrx-0007jI-Dm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDjo-0007DM-LX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDjn-0002Wy-9d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjj-0002SU-JG; Thu, 17 Oct 2019 17:55:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDB01307D986;
 Thu, 17 Oct 2019 21:55:10 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2EC5D9DC;
 Thu, 17 Oct 2019 21:55:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 10/19] block: reverse order for reopen commits
Date: Thu, 17 Oct 2019 17:54:27 -0400
Message-Id: <20191017215436.14252-11-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 21:55:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's needed to fix reopening qcow2 with bitmaps to RW. Currently it
can't work, as qcow2 needs write access to file child, to mark bitmaps
in-image with IN_USE flag. But usually children goes after parents in
reopen queue and file child is still RO on qcow2 reopen commit. Reverse
reopen order to fix it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Max Reitz <mreitz@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Message-id: 20190927122355.7344-3-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 0347632c6c..cf312258a9 100644
--- a/block.c
+++ b/block.c
@@ -3486,10 +3486,16 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_que=
ue, Error **errp)
         bs_entry->perms_checked =3D true;
     }
=20
-    /* If we reach this point, we have success and just need to apply th=
e
-     * changes
+    /*
+     * If we reach this point, we have success and just need to apply th=
e
+     * changes.
+     *
+     * Reverse order is used to comfort qcow2 driver: on commit it need =
to write
+     * IN_USE flag to the image, to mark bitmaps in the image as invalid=
. But
+     * children are usually goes after parents in reopen-queue, so go fr=
om last
+     * to first element.
      */
-    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         bdrv_reopen_commit(&bs_entry->state);
     }
=20
--=20
2.21.0


