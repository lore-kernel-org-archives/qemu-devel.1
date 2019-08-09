Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6ACC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AF72086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AF72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Zo-0007Mc-Dd
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7XS-0001PC-7O
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7XR-00049i-1A
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:14:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7XO-000484-9K; Fri, 09 Aug 2019 12:14:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 912AE30BC9C6;
 Fri,  9 Aug 2019 16:14:41 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2DA5D6A5;
 Fri,  9 Aug 2019 16:14:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:39 +0200
Message-Id: <20190809161407.11920-15-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 09 Aug 2019 16:14:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 14/42] block: Use CAFs when working with
 backing chains
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

Use child access functions when iterating through backing chains so
filters do not break the chain.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 86b84bea21..42abbaf0ba 100644
--- a/block.c
+++ b/block.c
@@ -4376,7 +4376,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
 }
=20
 /*
- * Finds the image layer in the chain that has 'bs' as its backing file.
+ * Finds the image layer in the chain that has 'bs' (or a filter on
+ * top of it) as its backing file.
  *
  * active is the current topmost image.
  *
@@ -4388,11 +4389,18 @@ int bdrv_change_backing_file(BlockDriverState *bs=
,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs)
 {
-    while (active && bs !=3D backing_bs(active)) {
-        active =3D backing_bs(active);
+    bs =3D bdrv_skip_rw_filters(bs);
+    active =3D bdrv_skip_rw_filters(active);
+
+    while (active) {
+        BlockDriverState *next =3D bdrv_backing_chain_next(active);
+        if (bs =3D=3D next) {
+            return active;
+        }
+        active =3D next;
     }
=20
-    return active;
+    return NULL;
 }
=20
 /* Given a BDS, searches for the base layer. */
@@ -4544,9 +4552,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
      * other intermediate nodes have been dropped.
      * If 'top' is an implicit node (e.g. "commit_top") we should skip
      * it because no one inherits from it. We use explicit_top for that.=
 */
-    while (explicit_top && explicit_top->implicit) {
-        explicit_top =3D backing_bs(explicit_top);
-    }
+    explicit_top =3D bdrv_skip_implicit_filters(explicit_top);
     update_inherits_from =3D bdrv_inherits_from_recursive(base, explicit=
_top);
=20
     /* success - we can delete the intermediate states, and link top->ba=
se */
@@ -5014,7 +5020,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device=
,
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
     while (top && top !=3D base) {
-        top =3D backing_bs(top);
+        top =3D bdrv_filtered_bs(top);
     }
=20
     return top !=3D NULL;
@@ -5253,7 +5259,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDri=
verState *bs,
=20
     is_protocol =3D path_has_protocol(backing_file);
=20
-    for (curr_bs =3D bs; curr_bs->backing; curr_bs =3D curr_bs->backing-=
>bs) {
+    /*
+     * Being largely a legacy function, skip any filters here
+     * (because filters do not have normal filenames, so they cannot
+     * match anyway; and allowing json:{} filenames is a bit out of
+     * scope).
+     */
+    for (curr_bs =3D bdrv_skip_rw_filters(bs);
+         bdrv_filtered_cow_child(curr_bs) !=3D NULL;
+         curr_bs =3D bdrv_backing_chain_next(curr_bs))
+    {
+        BlockDriverState *bs_below =3D bdrv_backing_chain_next(curr_bs);
=20
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
@@ -5261,7 +5277,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
             char *backing_file_full_ret;
=20
             if (strcmp(backing_file, curr_bs->backing_file) =3D=3D 0) {
-                retval =3D curr_bs->backing->bs;
+                retval =3D bs_below;
                 break;
             }
             /* Also check against the full backing filename for the imag=
e */
@@ -5271,7 +5287,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
                 bool equal =3D strcmp(backing_file, backing_file_full_re=
t) =3D=3D 0;
                 g_free(backing_file_full_ret);
                 if (equal) {
-                    retval =3D curr_bs->backing->bs;
+                    retval =3D bs_below;
                     break;
                 }
             }
@@ -5297,7 +5313,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
             g_free(filename_tmp);
=20
             if (strcmp(backing_file_full, filename_full) =3D=3D 0) {
-                retval =3D curr_bs->backing->bs;
+                retval =3D bs_below;
                 break;
             }
         }
--=20
2.21.0


