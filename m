Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1704C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785EB2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8FHh3ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785EB2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFCD-0005Rx-Ks
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2g-0003FM-Ex
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2b-00085r-Jh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHVXgyJlfQdIVjhroQp/QxRrihey4fSUaFWnlX6/jmI=;
 b=L8FHh3ZNd/HfEdwjXxPGVewstIamzpWhqbvMfz96mSJFkBFGp/LNMA0SmCPyP1/NbB9b7v
 A4wwxYsowwpprHns3FX1xEFWelfGemAtY34QRrj9+QpVtS2ugxeCZPZRtPtgcF7tVZIRWb
 vmxJgP2kJSHLy2qhLt5WCeLVyZbipJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-ApexKXieMteQ-RBEeeBTZA-1; Mon, 07 Sep 2020 07:10:26 -0400
X-MC-Unique: ApexKXieMteQ-RBEeeBTZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50FB51007465;
 Mon,  7 Sep 2020 11:10:25 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 591779CBA;
 Mon,  7 Sep 2020 11:10:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/64] block: Re-evaluate backing file handling in reopen
Date: Mon,  7 Sep 2020 13:09:03 +0200
Message-Id: <20200907110936.261684-32-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Reopening a node's backing child needs a bit of special handling because
the "backing" child has different defaults than all other children
(among other things).  Adding filter support here is a bit more
difficult than just using the child access functions.  In fact, we often
have to directly use bs->backing because these functions are about the
"backing" child (which may or may not be the COW backing file).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index 96bf8672f1..660386795a 100644
--- a/block.c
+++ b/block.c
@@ -4004,7 +4004,7 @@ static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
                                      Error **errp)
 {
     BlockDriverState *bs = reopen_state->bs;
-    BlockDriverState *overlay_bs, *new_backing_bs;
+    BlockDriverState *overlay_bs, *below_bs, *new_backing_bs;
     QObject *value;
     const char *str;
 
@@ -4043,26 +4043,57 @@ static int bdrv_reopen_parse_backing(BDRVReopenState *reopen_state,
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
+    for (below_bs = bdrv_filter_or_cow_bs(overlay_bs);
+         below_bs && below_bs->implicit;
+         below_bs = bdrv_filter_or_cow_bs(overlay_bs))
+    {
+        overlay_bs = below_bs;
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
@@ -4211,7 +4242,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
+        (reopen_state->bs->backing || reopen_state->bs->backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
@@ -4352,7 +4383,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
      * from bdrv_set_backing_hd()) has the new values.
      */
     if (reopen_state->replace_backing_bs) {
-        BlockDriverState *old_backing_bs = backing_bs(bs);
+        BlockDriverState *old_backing_bs = child_bs(bs->backing);
         assert(!old_backing_bs || !old_backing_bs->implicit);
         /* Abort the permission update on the backing bs we're detaching */
         if (old_backing_bs) {
-- 
2.25.4


