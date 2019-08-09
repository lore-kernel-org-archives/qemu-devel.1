Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF8C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BB420C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BB420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7eQ-000197-QV
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xa-0001uG-Rg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XZ-0004Ek-Om
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XX-0004DN-97; Fri, 09 Aug 2019 12:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9820D88309;
 Fri,  9 Aug 2019 16:14:50 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 352035C29A;
 Fri,  9 Aug 2019 16:14:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:43 +0200
Message-Id: <20190809161407.11920-19-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 09 Aug 2019 16:14:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 18/42] block: Use CAFs in
 bdrv_refresh_filename()
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

bdrv_refresh_filename() and the kind of related bdrv_dirname() should
look to the primary child when they wish to copy the underlying file's
filename.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 064cc99857..a467b175c6 100644
--- a/block.c
+++ b/block.c
@@ -6432,6 +6432,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 {
     BlockDriver *drv =3D bs->drv;
     BdrvChild *child;
+    BlockDriverState *primary_child_bs;
     QDict *opts;
     bool backing_overridden;
     bool generate_json_filename; /* Whether our default implementation s=
hould
@@ -6500,20 +6501,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     qobject_unref(bs->full_open_options);
     bs->full_open_options =3D opts;
=20
+    primary_child_bs =3D bdrv_primary_bs(bs);
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file =
name
          * information before refreshing it */
         bs->exact_filename[0] =3D '\0';
=20
         drv->bdrv_refresh_filename(bs);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file=
 */
+    } else if (primary_child_bs) {
+        /*
+         * Try to reconstruct valid information from the underlying
+         * file -- this only works for format nodes (filter nodes
+         * cannot be probed and as such must be selected by the user
+         * either through an options dict, or through a special
+         * filename which the filter driver must construct in its
+         * .bdrv_refresh_filename() implementation).
+         */
=20
         bs->exact_filename[0] =3D '\0';
=20
         /*
          * We can use the underlying file's filename if:
          * - it has a filename,
+         * - the current BDS is not a filter,
          * - the file is a protocol BDS, and
          * - opening that file (as this BDS's format) will automatically=
 create
          *   the BDS tree we have right now, that is:
@@ -6522,11 +6533,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   - no non-file child of this BDS has been overridden by the =
user
          *   Both of these conditions are represented by generate_json_f=
ilename.
          */
-        if (bs->file->bs->exact_filename[0] &&
-            bs->file->bs->drv->bdrv_file_open &&
-            !generate_json_filename)
+        if (primary_child_bs->exact_filename[0] &&
+            primary_child_bs->drv->bdrv_file_open &&
+            !drv->is_filter && !generate_json_filename)
         {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
+            strcpy(bs->exact_filename, primary_child_bs->exact_filename)=
;
         }
     }
=20
@@ -6543,6 +6554,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
+    BlockDriverState *child_bs;
=20
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
@@ -6553,8 +6565,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **er=
rp)
         return drv->bdrv_dirname(bs, errp);
     }
=20
-    if (bs->file) {
-        return bdrv_dirname(bs->file->bs, errp);
+    child_bs =3D bdrv_primary_bs(bs);
+    if (child_bs) {
+        return bdrv_dirname(child_bs, errp);
     }
=20
     bdrv_refresh_filename(bs);
--=20
2.21.0


