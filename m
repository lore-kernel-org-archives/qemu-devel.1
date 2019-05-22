Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDCC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5DA2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5DA2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUgo-0004XI-NA
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:06:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfE-0003aC-Gn
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUfC-0007nF-DX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTUf6-0007ay-Ed; Wed, 22 May 2019 13:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9F8F820E9;
	Wed, 22 May 2019 17:04:04 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E1E5600C0;
	Wed, 22 May 2019 17:04:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 22 May 2019 19:03:46 +0200
Message-Id: <20190522170352.12020-3-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
References: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 22 May 2019 17:04:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/8] block: Add bdrv_child_refresh_perms()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 15 +++++++++++++++
 block.c                   | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..e1f6d50b01 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1167,9 +1167,24 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState=
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
index 4c3902508d..02157e0652 100644
--- a/block.c
+++ b/block.c
@@ -2083,6 +2083,18 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t=
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
2.21.0


