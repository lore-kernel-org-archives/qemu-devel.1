Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9F52082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES9ST0bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9F52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTsf-00029T-BH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiR-0005jM-LN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiP-0000uW-Bd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Na6LFAxvfpAY3dT78yZFmDnKhomLwTA8w3U/O1UEuR4=;
 b=ES9ST0bia5A/JwgIz9Z9506JVWiM5R/Sjt+rL6NBNu/IgrSLJew0L55JI6W3Thv1D2ouZv
 VewcpolPaSCqbX+kCI+3Sqf85VeZftc/B8tNv9aY2k1E6URlU2qcc6yonFbdKr3s28k2W6
 UeVjNARbFWSP172e++ZUMto5Myi2Yss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-nLdUukXOOaC-dWG1HBoezg-1; Thu, 25 Jun 2020 11:22:57 -0400
X-MC-Unique: nLdUukXOOaC-dWG1HBoezg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47D31005512;
 Thu, 25 Jun 2020 15:22:56 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 653D8579A3;
 Thu, 25 Jun 2020 15:22:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 17/47] block: Re-evaluate backing file handling in reopen
Date: Thu, 25 Jun 2020 17:21:45 +0200
Message-Id: <20200625152215.941773-18-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 block.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 712230ef5c..8131d0b5eb 100644
--- a/block.c
+++ b/block.c
@@ -4026,26 +4026,56 @@ static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
         }
     }
 
+    /*
+     * Ensure that @bs can really handle backing files, because we are
+     * about to give it one (or swap the existing one)
+     */
+    if (bs->drv->is_filter) {
+        /* Filters always have a file or a backing child */
+        if (!bs->backing) {
+            error_setg(errp, "'%s' is a %s filter node that does not support a "
+                       "backing child", bs->node_name, bs->drv->format_name);
+            return -EINVAL;
+        }
+    } else if (!bs->drv->supports_backing) {
+        error_setg(errp, "Driver '%s' of node '%s' does not support backing "
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
     overlay_bs = bs;
-    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit) {
-        overlay_bs = backing_bs(overlay_bs);
+    while (bdrv_filter_or_cow_bs(overlay_bs) &&
+           bdrv_filter_or_cow_bs(overlay_bs)->implicit)
+    {
+        overlay_bs = bdrv_filter_or_cow_bs(overlay_bs);
     }
 
     /* If we want to replace the backing file we need some extra checks */
-    if (new_backing_bs != backing_bs(overlay_bs)) {
+    if (new_backing_bs != bdrv_filter_or_cow_bs(overlay_bs)) {
         /* Check for implicit nodes between bs and its backing file */
         if (bs != overlay_bs) {
             error_setg(errp, "Cannot change backing link if '%s' has "
                        "an implicit backing file", bs->node_name);
             return -EPERM;
         }
-        /* Check if the backing link that we want to replace is frozen */
-        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overlay_bs),
-                                         errp)) {
+        /*
+         * Check if the backing link that we want to replace is frozen.
+         * Note that
+         * bdrv_filter_or_cow_child(overlay_bs) == overlay_bs->backing,
+         * because we know that overlay_bs == bs, and that @bs
+         * either is a filter that uses ->backing or a COW format BDS
+         * with bs->drv->supports_backing == true.
+         */
+        if (bdrv_is_backing_chain_frozen(overlay_bs,
+                                         child_bs(overlay_bs->backing), errp))
+        {
             return -EPERM;
         }
         reopen_state->replace_backing_bs = true;
@@ -4196,7 +4226,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
+        (reopen_state->bs->backing || reopen_state->bs->backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
@@ -4337,7 +4367,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
      * from bdrv_set_backing_hd()) has the new values.
      */
     if (reopen_state->replace_backing_bs) {
-        BlockDriverState *old_backing_bs = backing_bs(bs);
+        BlockDriverState *old_backing_bs = child_bs(bs->backing);
         assert(!old_backing_bs || !old_backing_bs->implicit);
         /* Abort the permission update on the backing bs we're detaching */
         if (old_backing_bs) {
-- 
2.26.2


