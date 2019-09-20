Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA22BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12D020882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12D020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL5X-0006Ci-Vn
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpU-0000a7-40
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpQ-0004Hb-7s
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpN-0004Ct-Nq; Fri, 20 Sep 2019 11:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 103DD30615C1;
 Fri, 20 Sep 2019 15:28:09 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B2505C1B5;
 Fri, 20 Sep 2019 15:28:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 01/22] blockdev: Allow external snapshots everywhere
Date: Fri, 20 Sep 2019 17:27:43 +0200
Message-Id: <20190920152804.12875-2-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 15:28:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no good reason why we would allow external snapshots only on
the first non-filter node in a chain.  Parent BDSs should not care
whether their child is replaced by a snapshot.  (If they do care, they
should announce that via freezing the chain, which is checked in
bdrv_append() through bdrv_set_backing_hd().)

Before we had bdrv_is_first_non_filter() here (since 212a5a8f095), there
was a special function bdrv_check_ext_snapshot() that allowed snapshots
by default, but block drivers could override this.  Only blkverify did
so, however.

It is not clear to me why blkverify would do so; maybe just so that the
testee block driver would not be replaced.  The introducing commit
f6186f49e2c does not explain why.  Maybe because 08b24cfe376 would have
been the correct solution?  (Which adds a .supports_backing check.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index f89e48fc79..b62b33dc03 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1596,11 +1596,6 @@ static void external_snapshot_prepare(BlkActionSta=
te *common,
         }
     }
=20
-    if (!bdrv_is_first_non_filter(state->old_bs)) {
-        error_setg(errp, QERR_FEATURE_DISABLED, "snapshot");
-        goto out;
-    }
-
     if (action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SY=
NC) {
         BlockdevSnapshotSync *s =3D action->u.blockdev_snapshot_sync.dat=
a;
         const char *format =3D s->has_format ? s->format : "qcow2";
--=20
2.21.0


