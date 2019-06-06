Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3632520868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3632520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYy4t-0007Jh-RU
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hYxlW-0004fI-Ie
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hYxLI-0000D0-LW
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hYxLE-0007tP-KQ; Thu, 06 Jun 2019 14:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63E6159467;
 Thu,  6 Jun 2019 18:42:12 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-177.bos.redhat.com [10.18.17.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43CAC5C2E6;
 Thu,  6 Jun 2019 18:42:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 14:41:59 -0400
Message-Id: <20190606184159.979-6-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
References: <20190606184159.979-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 06 Jun 2019 18:42:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/5] block/qcow2-bitmap: Count queued bitmaps
 towards directory_size
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to the previous commit, we need to also keep a ledger of the
additional directory size burden that we've not yet committed so we can
reject new additions sooner instead of later.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  1 +
 block/qcow2-bitmap.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ebf60ac236..5aff97eb9c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -318,6 +318,7 @@ typedef struct BDRVQcow2State {
=20
     uint32_t nb_bitmaps;
     uint32_t nb_queued_bitmaps;
+    uint32_t queued_directory_size;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
=20
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 7193c66787..b103fab362 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1405,16 +1405,23 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bitm=
apList *bm_list,
 static int qcow2_remove_queued_dirty_bitmap(
     BlockDriverState *bs, const char *name, Error **errp)
 {
+    uint32_t size_delta;
     BDRVQcow2State *s =3D bs->opaque;
     BdrvDirtyBitmap *bitmap =3D bdrv_find_dirty_bitmap(bs, name);
+
     if (!bitmap) {
         error_setg(errp, "Node '%s' has no stored or enqueued bitmap '%s=
'",
                    bdrv_get_node_name(bs), name);
         return -ENOENT;
     }
+
+    size_delta =3D calc_dir_entry_size(strlen(name), 0);
     assert(s->nb_queued_bitmaps > 0);
     assert(bdrv_dirty_bitmap_get_persistence(bitmap));
+    assert(s->queued_directory_size >=3D size_delta);
+
     s->nb_queued_bitmaps -=3D 1;
+    s->queued_directory_size -=3D size_delta;
=20
     return 0;
 }
@@ -1561,6 +1568,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
         goto fail;
     }
     s->nb_queued_bitmaps =3D 0;
+    s->queued_directory_size =3D 0;
=20
     /* Bitmap directory was successfully updated, so, old data can be dr=
opped.
      * TODO it is better to reuse these clusters */
@@ -1636,6 +1644,7 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriverSt=
ate *bs,
     const char *name =3D bdrv_dirty_bitmap_name(bitmap);
     uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
     uint32_t nb_bitmaps;
+    uint32_t size_delta;
     int ret =3D 0;
=20
     if (s->qcow_version < 3) {
@@ -1666,7 +1675,8 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriverSt=
ate *bs,
         goto fail;
     }
=20
-    if (s->bitmap_directory_size + calc_dir_entry_size(strlen(name), 0) =
>
+    size_delta =3D calc_dir_entry_size(strlen(name), 0);
+    if (s->bitmap_directory_size + s->queued_directory_size + size_delta=
 >
         QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
     {
         error_setg(errp, "Not enough space in the bitmap directory");
@@ -1687,6 +1697,7 @@ int qcow2_add_persistent_dirty_bitmap(BlockDriverSt=
ate *bs,
     }
=20
     s->nb_queued_bitmaps +=3D 1;
+    s->queued_directory_size +=3D size_delta;
=20
     return 0;
 fail:
--=20
2.20.1


