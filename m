Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCDC17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E2A2196E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQOdIj49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E2A2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCF1-0006MC-00
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9g-00086u-MN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9a-0002rA-P4
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9Z-0002qi-8k
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twVsBJ1nTiS7APsE0cYdUcRoL6m6H4xxbgEn76Lc0nM=;
 b=ZQOdIj49q/b45UxXnq6uJCs/MimEj7hgCLaszx7SOHjZSFV9rAknpErs6E60D0aHbTou1v
 WvpfZ30glPMZxIS8Rc1/JsvT+UqRxPZFTWT0xFsEV1eKbz+TiPmQaIK47jhd0XkZsprO4Y
 xmExIGSCza8EBMs85u+YQcFms86Uu7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-NG-rArKoNnmFOz6kQclKpg-1; Mon, 11 Nov 2019 11:02:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC9581005500;
 Mon, 11 Nov 2019 16:02:52 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40A3B28D18;
 Mon, 11 Nov 2019 16:02:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 11/23] block: Use bdrv_recurse_can_replace()
Date: Mon, 11 Nov 2019 17:02:04 +0100
Message-Id: <20191111160216.197086-12-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NG-rArKoNnmFOz6kQclKpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
index de53addeb0..7608f21570 100644
--- a/block.c
+++ b/block.c
@@ -6243,6 +6243,17 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs,
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
                                         const char *node_name, Error **err=
p)
 {
@@ -6267,8 +6278,11 @@ BlockDriverState *check_to_replace_node(BlockDriverS=
tate *parent_bs,
      * Another benefit is that this tests exclude backing files which are
      * blocked by the backing blockers.
      */
-    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
-        error_setg(errp, "Only top most non filter can be replaced");
+    if (!bdrv_recurse_can_replace(parent_bs, to_replace_bs)) {
+        error_setg(errp, "Cannot replace '%s' by a node mirrored from '%s'=
, "
+                   "because it cannot be guaranteed that doing so would no=
t "
+                   "lead to an abrupt change of visible data",
+                   node_name, parent_bs->node_name);
         to_replace_bs =3D NULL;
         goto out;
     }
--=20
2.23.0


