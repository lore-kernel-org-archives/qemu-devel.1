Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCC5208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCC5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL2d-0003UL-Pn
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpy-00011H-4b
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpu-0004a4-7o
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpl-0004VY-4E; Fri, 20 Sep 2019 11:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A5223086228;
 Fri, 20 Sep 2019 15:28:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E66BC100194E;
 Fri, 20 Sep 2019 15:28:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 11/22] block: Use bdrv_recurse_can_replace()
Date: Fri, 20 Sep 2019 17:27:53 +0200
Message-Id: <20190920152804.12875-12-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 15:28:32 +0000 (UTC)
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

Let check_to_replace_node() use the more specialized
bdrv_recurse_can_replace() instead of
bdrv_recurse_is_first_non_filter(), which is too restrictive.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index a2deca4ac9..02177bde9a 100644
--- a/block.c
+++ b/block.c
@@ -6244,6 +6244,17 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs=
,
     return false;
 }
=20
+/*
+ * Check whether the given @node_name can be replaced by a node that
+ * has the same data as @parent_bs.  If so, return @node_name's BDS;
+ * NULL otherwise.
+ *
+ * @node_name must be a (recursive) *child of @parent_bs (or this
+ * function will return NULL).
+ *
+ * The result (whether the node can be replaced or not) is only valid
+ * for as long as no graph changes occur.
+ */
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **e=
rrp)
 {
@@ -6268,8 +6279,11 @@ BlockDriverState *check_to_replace_node(BlockDrive=
rState *parent_bs,
      * Another benefit is that this tests exclude backing files which ar=
e
      * blocked by the backing blockers.
      */
-    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
-        error_setg(errp, "Only top most non filter can be replaced");
+    if (!bdrv_recurse_can_replace(parent_bs, to_replace_bs)) {
+        error_setg(errp, "Cannot replace '%s' by a node mirrored from '%=
s', "
+                   "because it cannot be guaranteed that doing so would =
not "
+                   "lead to an abrupt change of visible data",
+                   node_name, parent_bs->node_name);
         to_replace_bs =3D NULL;
         goto out;
     }
--=20
2.21.0


