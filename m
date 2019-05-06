Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD3C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32542206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32542206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjhS-0001sm-I2
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:54:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjav-0004T7-2H
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjau-0001zc-0t
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNjar-0001w9-MD; Mon, 06 May 2019 15:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07876356EA;
	Mon,  6 May 2019 19:48:09 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E39C5F9D2;
	Mon,  6 May 2019 19:48:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 21:47:48 +0200
Message-Id: <20190506194753.12464-3-mreitz@redhat.com>
In-Reply-To: <20190506194753.12464-1-mreitz@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 06 May 2019 19:48:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/7] block: Add bdrv_child_refresh_perms()
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a block node uses bdrv_child_try_set_perm() to change the permission
it takes on its child, the result may be very short-lived.  If anything
makes the block layer recalculate the permissions internally, it will
invoke the node driver's .bdrv_child_perm() implementation.  The
permission/shared permissions masks that returns will then override the
values previously passed to bdrv_child_try_set_perm().

If drivers want a child edge to have specific values for the
permissions/shared permissions mask, it must return them in
.bdrv_child_perm().  Consequentially, there is no need for them to pass
the same values to bdrv_child_try_set_perm() then: It is better to have
a function that invokes .bdrv_child_perm() and calls
bdrv_child_try_set_perm() with the result.  This patch adds such a
function under the name of bdrv_child_refresh_perms().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 15 +++++++++++++++
 block.c                   | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 94d45c9708..5522e58201 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1184,9 +1184,24 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState=
 *child_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
=20
+/**
+ * Sets a BdrvChild's permissions.  Avoid if the parent is a BDS; use
+ * bdrv_child_refresh_perms() instead and make the parent's
+ * .bdrv_child_perm() implementation return the correct values.
+ */
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared=
,
                             Error **errp);
=20
+/**
+ * Calls bs->drv->bdrv_child_perm() and updates the child's permission
+ * masks with the result.
+ * Drivers should invoke this function whenever an event occurs that
+ * makes their .bdrv_child_perm() implementation return different
+ * values than before, but which will not result in the block layer
+ * automatically refreshing the permissions.
+ */
+int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error *=
*errp);
+
 /* Default implementation for BlockDriver.bdrv_child_perm() that can be =
used by
  * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RE=
SIZE to
  * all children */
diff --git a/block.c b/block.c
index 7dc8fe289a..fb6f0c48ae 100644
--- a/block.c
+++ b/block.c
@@ -2048,6 +2048,18 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t=
 perm, uint64_t shared,
     return 0;
 }
=20
+int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error *=
*errp)
+{
+    uint64_t parent_perms, parent_shared;
+    uint64_t perms, shared;
+
+    bdrv_get_cumulative_perm(bs, &parent_perms, &parent_shared);
+    bdrv_child_perm(bs, c->bs, c, c->role, NULL, parent_perms, parent_sh=
ared,
+                    &perms, &shared);
+
+    return bdrv_child_try_set_perm(c, perms, shared, errp);
+}
+
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
                                BlockReopenQueue *reopen_queue,
--=20
2.20.1


