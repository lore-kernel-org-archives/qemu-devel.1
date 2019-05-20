Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03634C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141121721
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D141121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSl4z-0006vG-3A
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:24:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwv-0008KP-0e
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwu-0003c0-21
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwm-0003M6-MF; Mon, 20 May 2019 12:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 971F13001C73;
	Mon, 20 May 2019 16:15:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF4F05C2F3;
	Mon, 20 May 2019 16:15:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:37 +0200
Message-Id: <20190520161453.30723-9-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 16:15:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/24] block: Make
 bdrv_attach/detach_aio_context() static
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit b97511c7bc8, there is no reason for block drivers any more
to call these functions (see the function comment in block_int.h). They
are now just internal helper functions for bdrv_set_aio_context()
and can be made static.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 21 ---------------------
 block.c                   |  6 +++---
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index b150c5f047..aa2c638b02 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -965,27 +965,6 @@ void bdrv_parse_filename_strip_prefix(const char *fi=
lename, const char *prefix,
 void bdrv_add_before_write_notifier(BlockDriverState *bs,
                                     NotifierWithReturn *notifier);
=20
-/**
- * bdrv_detach_aio_context:
- *
- * May be called from .bdrv_detach_aio_context() to detach children from=
 the
- * current #AioContext.  This is only needed by block drivers that manag=
e their
- * own children.  Both ->file and ->backing are automatically handled an=
d
- * block drivers should not call this function on them explicitly.
- */
-void bdrv_detach_aio_context(BlockDriverState *bs);
-
-/**
- * bdrv_attach_aio_context:
- *
- * May be called from .bdrv_attach_aio_context() to attach children to t=
he new
- * #AioContext.  This is only needed by block drivers that manage their =
own
- * children.  Both ->file and ->backing are automatically handled and bl=
ock
- * drivers should not call this function on them explicitly.
- */
-void bdrv_attach_aio_context(BlockDriverState *bs,
-                             AioContext *new_context);
-
 /**
  * bdrv_add_aio_context_notifier:
  *
diff --git a/block.c b/block.c
index 8ff6ab1152..b2f71142a5 100644
--- a/block.c
+++ b/block.c
@@ -5676,7 +5676,7 @@ static void bdrv_do_remove_aio_context_notifier(Bdr=
vAioNotifier *ban)
     g_free(ban);
 }
=20
-void bdrv_detach_aio_context(BlockDriverState *bs)
+static void bdrv_detach_aio_context(BlockDriverState *bs)
 {
     BdrvAioNotifier *baf, *baf_tmp;
     BdrvChild *child;
@@ -5708,8 +5708,8 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
     bs->aio_context =3D NULL;
 }
=20
-void bdrv_attach_aio_context(BlockDriverState *bs,
-                             AioContext *new_context)
+static void bdrv_attach_aio_context(BlockDriverState *bs,
+                                    AioContext *new_context)
 {
     BdrvAioNotifier *ban, *ban_tmp;
     BdrvChild *child;
--=20
2.20.1


