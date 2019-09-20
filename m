Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F1C4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B50921835
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B50921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL2X-0003KE-N9
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpg-0000jE-2m
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpe-0004Qx-QV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpa-0004NW-EX; Fri, 20 Sep 2019 11:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9754718C4270;
 Fri, 20 Sep 2019 15:28:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 301835C1B5;
 Fri, 20 Sep 2019 15:28:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 06/22] block: Add bdrv_recurse_can_replace()
Date: Fri, 20 Sep 2019 17:27:48 +0200
Message-Id: <20190920152804.12875-7-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 15:28:20 +0000 (UTC)
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

After a couple of follow-up patches, this function will replace
bdrv_recurse_is_first_non_filter() in check_to_replace_node().

bdrv_recurse_is_first_non_filter() is both not sufficiently specific for
check_to_replace_node() (it allows cases that should not be allowed,
like replacing child nodes of quorum with dissenting data that have more
parents than just quorum), and it is too restrictive (it is perfectly
fine to replace filters).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 10 ++++++++++
 block.c                   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5fd4f17d93..0be7d12f04 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -103,6 +103,13 @@ struct BlockDriver {
      */
     bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
                                              BlockDriverState *candidate=
);
+    /*
+     * Return true if @to_replace can be replaced by a BDS with the
+     * same data as @bs without it affecting @bs's behavior (that is,
+     * without it being visible to @bs's parents).
+     */
+    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
+                                     BlockDriverState *to_replace);
=20
     int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *file=
name);
     int (*bdrv_probe_device)(const char *filename);
@@ -1254,6 +1261,9 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
=20
+bool bdrv_recurse_can_replace(BlockDriverState *bs,
+                              BlockDriverState *to_replace);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
diff --git a/block.c b/block.c
index 7d99ca692c..a2deca4ac9 100644
--- a/block.c
+++ b/block.c
@@ -6206,6 +6206,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverS=
tate *bs,
     return false;
 }
=20
+/*
+ * This function checks whether the given @to_replace is allowed to be
+ * replaced by a node that always shows the same data as @bs.  This is
+ * used for example to verify whether the mirror job can replace
+ * @to_replace by the target mirrored from @bs.
+ * To be replaceable, @bs and @to_replace may either be guaranteed to
+ * always show the same data (because they are only connected through
+ * filters), or some driver may allow replacing one of its children
+ * because it can guarantee that this child's data is not visible at
+ * all (for example, for dissenting quorum children that have no other
+ * parents).
+ */
+bool bdrv_recurse_can_replace(BlockDriverState *bs,
+                              BlockDriverState *to_replace)
+{
+    if (!bs || !bs->drv) {
+        return false;
+    }
+
+    if (bs =3D=3D to_replace) {
+        return true;
+    }
+
+    /* For filters, we can recurse on our own */
+    if (bs->drv->is_filter) {
+        BdrvChild *child =3D bs->file ?: bs->backing;
+        return bdrv_recurse_can_replace(child->bs, to_replace);
+    }
+
+    /* See what the driver can do */
+    if (bs->drv->bdrv_recurse_can_replace) {
+        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
+    }
+
+    /* Safe default */
+    return false;
+}
+
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **e=
rrp)
 {
--=20
2.21.0


