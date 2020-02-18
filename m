Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B0C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EE421D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRHq9VU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EE421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43du-0004Z9-A7
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xx-0007Um-BI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xw-0001Yz-7D
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xw-0001Yj-2d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8Md0x14UjaweuuaHfsB7Kl/vSv+NPI3OnXqts0iVnA=;
 b=hRHq9VU99xewey8qFGKCKGwLCGA3rfK4vDhqODazpzBRWnwgD7EnREAQVuIxgmlcwlhGAB
 nrERB6/C8pUPpud+eGMkuC200og5xkNiRcNAuBvFkGhfMIK1wxBPwteRJO6dvVn6ZQDqy5
 6ZdFN3tyjreDIrNKR+sP7RP4DJnAY2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-QjLdp11tO5qvb7f3zs2v0A-1; Tue, 18 Feb 2020 09:08:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F811005516;
 Tue, 18 Feb 2020 14:08:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D703019E9C;
 Tue, 18 Feb 2020 14:08:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/36] blockdev: Allow external snapshots everywhere
Date: Tue, 18 Feb 2020 15:07:04 +0100
Message-Id: <20200218140722.23876-19-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QjLdp11tO5qvb7f3zs2v0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-2-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 374189a426..d83bb2beda 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1592,11 +1592,6 @@ static void external_snapshot_prepare(BlkActionState=
 *common,
         }
     }
=20
-    if (!bdrv_is_first_non_filter(state->old_bs)) {
-        error_setg(errp, QERR_FEATURE_DISABLED, "snapshot");
-        goto out;
-    }
-
     if (action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC=
) {
         BlockdevSnapshotSync *s =3D action->u.blockdev_snapshot_sync.data;
         const char *format =3D s->has_format ? s->format : "qcow2";
--=20
2.20.1


