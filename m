Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A2C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DA3208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DA3208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBlX-00005H-BK
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBSE-0007qR-At
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBSC-0007ks-UG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBS9-0007id-VX; Wed, 12 Jun 2019 18:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E9518F927;
 Wed, 12 Jun 2019 22:10:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B8B60BF0;
 Wed, 12 Jun 2019 22:10:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:09:37 +0200
Message-Id: <20190612221004.2317-16-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 22:10:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 15/42] block: Re-evaluate backing file
 handling in reopen
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

Reopening a node's backing child needs a bit of special handling because
the "backing" child has different defaults than all other children
(among other things).  Adding filter support here is a bit more
difficult than just using the child access functions.  In fact, we often
have to directly use bs->backing because these functions are about the
"backing" child (which may or may not be the COW backing file).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 505b3e9a01..db2759c10d 100644
--- a/block.c
+++ b/block.c
@@ -3542,17 +3542,39 @@ static int bdrv_reopen_parse_backing(BDRVReopenSt=
ate *reopen_state,
         }
     }
=20
+    /*
+     * Ensure that @bs can really handle backing files, because we are
+     * about to give it one (or swap the existing one)
+     */
+    if (bs->drv->is_filter) {
+        /* Filters always have a file or a backing child */
+        if (!bs->backing) {
+            error_setg(errp, "'%s' is a %s filter node that does not sup=
port a "
+                       "backing child", bs->node_name, bs->drv->format_n=
ame);
+            return -EINVAL;
+        }
+    } else if (!bs->drv->supports_backing) {
+        error_setg(errp, "Driver '%s' of node '%s' does not support back=
ing "
+                   "files", bs->drv->format_name, bs->node_name);
+        return -EINVAL;
+    }
+
     /*
      * Find the "actual" backing file by skipping all links that point
      * to an implicit node, if any (e.g. a commit filter node).
+     * We cannot use any of the bdrv_skip_*() functions here because
+     * those return the first explicit node, while we are looking for
+     * its overlay here.
      */
     overlay_bs =3D bs;
-    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
-        overlay_bs =3D backing_bs(overlay_bs);
+    while (bdrv_filtered_bs(overlay_bs) &&
+           bdrv_filtered_bs(overlay_bs)->implicit)
+    {
+        overlay_bs =3D bdrv_filtered_bs(overlay_bs);
     }
=20
     /* If we want to replace the backing file we need some extra checks =
*/
-    if (new_backing_bs !=3D backing_bs(overlay_bs)) {
+    if (new_backing_bs !=3D bdrv_filtered_bs(overlay_bs)) {
         /* Check for implicit nodes between bs and its backing file */
         if (bs !=3D overlay_bs) {
             error_setg(errp, "Cannot change backing link if '%s' has "
@@ -3560,8 +3582,8 @@ static int bdrv_reopen_parse_backing(BDRVReopenStat=
e *reopen_state,
             return -EPERM;
         }
         /* Check if the backing link that we want to replace is frozen *=
/
-        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_=
bs),
-                                         errp)) {
+        if (bdrv_is_backing_chain_frozen(overlay_bs,
+                                         child_bs(overlay_bs->backing), =
errp)) {
             return -EPERM;
         }
         reopen_state->replace_backing_bs =3D true;
@@ -3712,7 +3734,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_sta=
te, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[=
0])) {
+        (reopen_state->bs->backing || reopen_state->bs->backing_file[0])=
) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret =3D -EINVAL;
@@ -3857,7 +3879,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_sta=
te)
      * from bdrv_set_backing_hd()) has the new values.
      */
     if (reopen_state->replace_backing_bs) {
-        BlockDriverState *old_backing_bs =3D backing_bs(bs);
+        BlockDriverState *old_backing_bs =3D child_bs(bs->backing);
         assert(!old_backing_bs || !old_backing_bs->implicit);
         /* Abort the permission update on the backing bs we're detaching=
 */
         if (old_backing_bs) {
--=20
2.21.0


