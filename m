Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE76C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A26220856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjfiyDGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A26220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCKm-0005AI-0Q
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9L-0007pb-Il
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9K-0002kI-9f
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9K-0002kA-51
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1v7i5SHUOGNmsZ/v/MshgeRxWVOaV5oHiAq5a4o24E=;
 b=bjfiyDGnhdL8rS+IvrI6sCfKsXKNA76B0zGYPrXm9dDQNDuD8nIIuWJ9IqwUb0R3K3M9Zo
 lh23DQ7PxxM+7CUTlCcahCCcejQXt21MRDYIkQEyaH0KTHWleQkf1ZeZBeJSquGCrIqgLe
 BE/lgRu93mXAKI0h6k1AUQC7bkH97eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-aGxf9YByOraTu5KyR0fMJw-1; Mon, 11 Nov 2019 11:02:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A0C800C72;
 Mon, 11 Nov 2019 16:02:37 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D05AF608FB;
 Mon, 11 Nov 2019 16:02:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 06/23] block: Add bdrv_recurse_can_replace()
Date: Mon, 11 Nov 2019 17:01:59 +0100
Message-Id: <20191111160216.197086-7-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aGxf9YByOraTu5KyR0fMJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
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
---
 block.c                   | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/block.c b/block.c
index 9b1049786a..de53addeb0 100644
--- a/block.c
+++ b/block.c
@@ -6205,6 +6205,44 @@ bool bdrv_recurse_is_first_non_filter(BlockDriverSta=
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
index dd033d0b37..75f03dcc38 100644
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
@@ -1264,6 +1271,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, =
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
2.23.0


