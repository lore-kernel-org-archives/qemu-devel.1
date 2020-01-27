Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B128CC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8484C22527
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HM+tp6CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484C22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8ei-0005he-LU
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cb-0002My-S1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cZ-0002vb-FH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cZ-0002ut-9d
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgYVzUu7uSw5ID+mth66811eFcWviQoHdDvyj1J4PM0=;
 b=HM+tp6CDokDBqBn44csHaANmJhJCb/7J4+SvObIN0PPRDgtsH4bsatpJ1SEB4x7iEItijS
 L6Ue+evod+oUZKVXbgG2laQ3M9xzngjmnKK5GNPO7pk7fG3AC4L5G0o9g6w/+G+Vq+xffO
 SZtfOn/hUVqcchgNmj/oJYjDuieE/Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-QXSuOeqMNCq3ZQL4amIrYA-1; Mon, 27 Jan 2020 12:56:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86AB01882CC9;
 Mon, 27 Jan 2020 17:56:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9146F863C0;
 Mon, 27 Jan 2020 17:56:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/13] block/backup: fix memory leak in bdrv_backup_top_append()
Date: Mon, 27 Jan 2020 18:55:57 +0100
Message-Id: <20200127175559.18173-12-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QXSuOeqMNCq3ZQL4amIrYA-1
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

From: Eiichi Tsukata <devel@etsukata.com>

bdrv_open_driver() allocates bs->opaque according to drv->instance_size.
There is no need to allocate it and overwrite opaque in
bdrv_backup_top_append().

Reproducer:

  $ QTEST_QEMU_BINARY=3D./x86_64-softmmu/qemu-system-x86_64 valgrind -q --l=
eak-check=3Dfull tests/test-replication -p /replication/secondary/start
  =3D=3D29792=3D=3D 24 bytes in 1 blocks are definitely lost in loss record=
 52 of 226
  =3D=3D29792=3D=3D    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
  =3D=3D29792=3D=3D    by 0x4B07CE0: g_malloc0 (in /usr/lib64/libglib-2.0.s=
o.0.6000.7)
  =3D=3D29792=3D=3D    by 0x12BAB9: bdrv_open_driver (block.c:1289)
  =3D=3D29792=3D=3D    by 0x12BEA9: bdrv_new_open_driver (block.c:1359)
  =3D=3D29792=3D=3D    by 0x1D15CB: bdrv_backup_top_append (backup-top.c:19=
0)
  =3D=3D29792=3D=3D    by 0x1CC11A: backup_job_create (backup.c:439)
  =3D=3D29792=3D=3D    by 0x1CD542: replication_start (replication.c:544)
  =3D=3D29792=3D=3D    by 0x1401B9: replication_start_all (replication.c:52=
)
  =3D=3D29792=3D=3D    by 0x128B50: test_secondary_start (test-replication.=
c:427)
  ...

Fixes: 7df7868b9640 ("block: introduce backup-top filter driver")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index b8d863ff08..9aed2eb4c0 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -196,7 +196,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSta=
te *source,
     }
=20
     top->total_sectors =3D source->total_sectors;
-    top->opaque =3D state =3D g_new0(BDRVBackupTopState, 1);
+    state =3D top->opaque;
=20
     bdrv_ref(target);
     state->target =3D bdrv_attach_child(top, target, "target", &child_file=
, errp);
--=20
2.20.1


