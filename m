Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC1DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AFD20708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzDN0i8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AFD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHiv-0005uQ-SS
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcB-0004JM-V0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcA-00033i-Qp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52591
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcA-00031a-Lk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TM4jM9Mqmd/WmtrFPjy3wXLYjWdFXzeHdwDDTFWk8Uk=;
 b=LzDN0i8d9PZ+F5JgBy3lqWi+ylAHGPAZ58pD2qA+hi1DBcEt392t7j0tyG+kek8G58cCA2
 UGFslc+rqvTCKiinb36DKlYijYosm6/y7y0QGFUqtkVu+F8IobN8OLE/U++l+9umdbWcEN
 7fVtFH+Lg9DxzLRdKr2JYpbVNUhONjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-0HVGktWTNBGa229sX_CK6g-1; Thu, 30 Jan 2020 16:44:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39E348C3D06;
 Thu, 30 Jan 2020 21:44:36 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D2AE77939;
 Thu, 30 Jan 2020 21:44:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/21] blockdev: Allow external snapshots everywhere
Date: Thu, 30 Jan 2020 22:44:11 +0100
Message-Id: <20200130214431.333510-2-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0HVGktWTNBGa229sX_CK6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
---
 blockdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4cd9a58d36..d47ed8e569 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1596,11 +1596,6 @@ static void external_snapshot_prepare(BlkActionState=
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
2.24.1


