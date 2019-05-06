Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00010C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C932820830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C932820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhNl-0003s2-1z
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:26:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFs-0005VO-RZ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFr-0004uC-PN
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFo-0004px-4e; Mon, 06 May 2019 13:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72A66D571A;
	Mon,  6 May 2019 17:18:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38EB110027C6;
	Mon,  6 May 2019 17:18:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:17:58 +0200
Message-Id: <20190506171805.14236-4-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 06 May 2019 17:18:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/10] block: Move recursion to
 bdrv_set_aio_context()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having two recursions, in bdrv_attach_aio_context() and in
bdrv_detach_aio_context(), just having one recursion is enough. Said
functions are only about a single node now.

It is important that the recursion doesn't happen between detaching and
attaching a context to the current node because the nested call will
drain the node, and draining with a NULL context would segfault.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 00332c1eb4..e36c72e297 100644
--- a/block.c
+++ b/block.c
@@ -5680,7 +5680,6 @@ static void bdrv_do_remove_aio_context_notifier(Bdr=
vAioNotifier *ban)
 static void bdrv_detach_aio_context(BlockDriverState *bs)
 {
     BdrvAioNotifier *baf, *baf_tmp;
-    BdrvChild *child;
=20
     assert(!bs->walking_aio_notifiers);
     bs->walking_aio_notifiers =3D true;
@@ -5699,9 +5698,6 @@ static void bdrv_detach_aio_context(BlockDriverStat=
e *bs)
     if (bs->drv && bs->drv->bdrv_detach_aio_context) {
         bs->drv->bdrv_detach_aio_context(bs);
     }
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_detach_aio_context(child->bs);
-    }
=20
     if (bs->quiesce_counter) {
         aio_enable_external(bs->aio_context);
@@ -5713,7 +5709,6 @@ static void bdrv_attach_aio_context(BlockDriverStat=
e *bs,
                                     AioContext *new_context)
 {
     BdrvAioNotifier *ban, *ban_tmp;
-    BdrvChild *child;
=20
     if (bs->quiesce_counter) {
         aio_disable_external(new_context);
@@ -5721,9 +5716,6 @@ static void bdrv_attach_aio_context(BlockDriverStat=
e *bs,
=20
     bs->aio_context =3D new_context;
=20
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_attach_aio_context(child->bs, new_context);
-    }
     if (bs->drv && bs->drv->bdrv_attach_aio_context) {
         bs->drv->bdrv_attach_aio_context(bs, new_context);
     }
@@ -5745,11 +5737,18 @@ static void bdrv_attach_aio_context(BlockDriverSt=
ate *bs,
  * the same as the current context of bs). */
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
+    BdrvChild *child;
+
     if (bdrv_get_aio_context(bs) =3D=3D new_context) {
         return;
     }
=20
     bdrv_drained_begin(bs);
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_set_aio_context(child->bs, new_context);
+    }
+
     bdrv_detach_aio_context(bs);
=20
     /* This function executes in the old AioContext so acquire the new o=
ne in
--=20
2.20.1


