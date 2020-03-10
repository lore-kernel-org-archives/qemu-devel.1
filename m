Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7E8C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8FA2468C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzbaiN4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8FA2468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdGk-00080b-KR
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDn-0003JJ-6o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDl-0008Rm-GS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDl-0008PC-7m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOnoj0mP/wAEFUKJfLVvn9R5KJAWSJxFlIyhNUUyJY0=;
 b=MzbaiN4qdomMKYJNh8sSGrRWMA2OJqNXlCzdK99L8IpKyu6N//TOjrlqfDvOnTZT/Dlcx4
 VVCShrBkpHz3HBXccCiqCGFcjWuRgsacdecNhixYgAYvYfMxbkyAFj5/SbZO39dsZs5Q1G
 cGSYGxd9Uwjl5JE8wWKiScPZKbo4ieE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-AkzJYc4VP7OCG0TefFs7-A-1; Tue, 10 Mar 2020 07:38:46 -0400
X-MC-Unique: AkzJYc4VP7OCG0TefFs7-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2C45100550E;
 Tue, 10 Mar 2020 11:38:45 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D702C87B2F;
 Tue, 10 Mar 2020 11:38:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/7] block: Fix cross-AioContext blockdev-snapshot
Date: Tue, 10 Mar 2020 12:38:29 +0100
Message-Id: <20200310113831.27293-6-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

external_snapshot_prepare() tries to move the overlay to the AioContext
of the backing file (the snapshotted node). However, it's possible that
this doesn't work, but the backing file can instead be moved to the
overlay's AioContext (e.g. opening the backing chain for a mirror
target).

bdrv_append() already indirectly uses bdrv_attach_node(), which takes
care to move nodes to make sure they use the same AioContext and which
tries both directions.

So the problem has a simple fix: Just delete the unnecessary extra
bdrv_try_set_aio_context() call in external_snapshot_prepare() and
instead assert in bdrv_append() that both nodes were indeed moved to the
same AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c    |  1 +
 blockdev.c | 16 ----------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/block.c b/block.c
index 79a5a2770f..8fc7b56937 100644
--- a/block.c
+++ b/block.c
@@ -4365,6 +4365,7 @@ void bdrv_replace_node(BlockDriverState *from, BlockD=
riverState *to,
     bdrv_ref(from);
=20
     assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context());
+    assert(bdrv_get_aio_context(from) =3D=3D bdrv_get_aio_context(to));
     bdrv_drained_begin(from);
=20
     /* Put all parents into @list and calculate their cumulative permissio=
ns */
diff --git a/blockdev.c b/blockdev.c
index bba0e9775b..95a0b53d57 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1500,9 +1500,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,
                              DO_UPCAST(ExternalSnapshotState, common, comm=
on);
     TransactionAction *action =3D common->action;
     AioContext *aio_context;
-    AioContext *old_context;
     uint64_t perm, shared;
-    int ret;
=20
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
      * purpose but a different set of parameters */
@@ -1638,20 +1636,6 @@ static void external_snapshot_prepare(BlkActionState=
 *common,
         goto out;
     }
=20
-    /* Honor bdrv_try_set_aio_context() context acquisition requirements. =
*/
-    old_context =3D bdrv_get_aio_context(state->new_bs);
-    aio_context_release(aio_context);
-    aio_context_acquire(old_context);
-
-    ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
-
-    aio_context_release(old_context);
-    aio_context_acquire(aio_context);
-
-    if (ret < 0) {
-        goto out;
-    }
-
     /* This removes our old bs and adds the new bs. This is an operation t=
hat
      * can fail, so we need to do it in .prepare; undoing it for abort is
      * always possible. */
--=20
2.20.1


