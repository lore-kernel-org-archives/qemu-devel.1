Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED16DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BF421D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BF421D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDwY-0005lA-HE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDk0-0007Vm-JQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDjz-0002fF-9z
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjw-0002dc-Kd; Thu, 17 Oct 2019 17:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CEB7C89F30E;
 Thu, 17 Oct 2019 21:55:23 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E24665D9CA;
 Thu, 17 Oct 2019 21:55:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 13/19] block/qcow2-bitmap: drop
 qcow2_reopen_bitmaps_rw_hint()
Date: Thu, 17 Oct 2019 17:54:30 -0400
Message-Id: <20191017215436.14252-14-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 17 Oct 2019 21:55:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The function is unused, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190927122355.7344-6-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  2 --
 block/qcow2-bitmap.c | 15 +--------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 0f3d9b088e..23a9898a54 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -740,8 +740,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *b=
s, BdrvCheckResult *res,
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                                 Error **errp);
-int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_upda=
ted,
-                                 Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **=
errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 6dfc083548..ebc1afccd3 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1102,8 +1102,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(Blo=
ckDriverState *bs,
     return list;
 }
=20
-int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_upda=
ted,
-                                 Error **errp)
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     Qcow2BitmapList *bm_list;
@@ -1111,10 +1110,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState =
*bs, bool *header_updated,
     GSList *ro_dirty_bitmaps =3D NULL;
     int ret =3D 0;
=20
-    if (header_updated !=3D NULL) {
-        *header_updated =3D false;
-    }
-
     if (s->nb_bitmaps =3D=3D 0) {
         /* No bitmaps - nothing to do */
         return 0;
@@ -1156,9 +1151,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *=
bs, bool *header_updated,
             error_setg_errno(errp, -ret, "Can't update bitmap directory"=
);
             goto out;
         }
-        if (header_updated !=3D NULL) {
-            *header_updated =3D true;
-        }
         g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
=20
@@ -1169,11 +1161,6 @@ out:
     return ret;
 }
=20
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
-{
-    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
-}
-
 /* Checks to see if it's safe to resize bitmaps */
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp)
 {
--=20
2.21.0


