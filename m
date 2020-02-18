Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B0C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63F72173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3rVkjco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40Gu-000844-0I
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40Dn-0001Hm-RJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Dm-0007Ny-CF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Dm-0007Nf-72
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDmr9dxLhKqzcnPEfIoo4QRCiihKM20kv8WdUr/XucY=;
 b=U3rVkjcozYRDwPMrc0vEnLeUR/GyWYhtkNWyVECBU/KiqQX4wvwffEMEgV1xuNxHRs0ppX
 dKLKyKWAJFL0zdTaBwGbi/KgivuWdypoYIGTz0v5OhezvgPbpETZem5nkbbSzPd4gFHaVJ
 T700YH5dscPgVwRAeQIpvX0gddf4Xns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338--STIPRxVONGfUREyvsYY_Q-1; Tue, 18 Feb 2020 05:35:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E8E0800D48;
 Tue, 18 Feb 2020 10:35:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 814428CCC5;
 Tue, 18 Feb 2020 10:35:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 06/19] block: Add bdrv_recurse_can_replace()
Date: Tue, 18 Feb 2020 11:34:41 +0100
Message-Id: <20200218103454.296704-7-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -STIPRxVONGfUREyvsYY_Q-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/block.c b/block.c
index f6731fa9be..553ccff216 100644
--- a/block.c
+++ b/block.c
@@ -6235,6 +6235,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverSta=
te *bs,
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
+    /* See what the driver can do */
+    if (bs->drv->bdrv_recurse_can_replace) {
+        return bs->drv->bdrv_recurse_can_replace(bs, to_replace);
+    }
+
+    /* For filters without an own implementation, we can recurse on our ow=
n */
+    if (bs->drv->is_filter) {
+        BdrvChild *child =3D bs->file ?: bs->backing;
+        return bdrv_recurse_can_replace(child->bs, to_replace);
+    }
+
+    /* Safe default */
+    return false;
+}
+
 BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
                                         const char *node_name, Error **err=
p)
 {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 640fb82c78..eaefac210e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -102,6 +102,13 @@ struct BlockDriver {
      */
     bool (*bdrv_recurse_is_first_non_filter)(BlockDriverState *bs,
                                              BlockDriverState *candidate);
+    /*
+     * Return true if @to_replace can be replaced by a BDS with the
+     * same data as @bs without it affecting @bs's behavior (that is,
+     * without it being visible to @bs's parents).
+     */
+    bool (*bdrv_recurse_can_replace)(BlockDriverState *bs,
+                                     BlockDriverState *to_replace);
=20
     int (*bdrv_probe)(const uint8_t *buf, int buf_size, const char *filena=
me);
     int (*bdrv_probe_device)(const char *filename);
@@ -1263,6 +1270,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, =
BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
=20
+bool bdrv_recurse_can_replace(BlockDriverState *bs,
+                              BlockDriverState *to_replace);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
--=20
2.24.1


