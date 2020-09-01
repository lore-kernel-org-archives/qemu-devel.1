Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581322158C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXUBcegz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581322158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7ci-0005Tk-GP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NM-0008MJ-5E
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NK-00078w-5M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6UZu6oy2R1ryVrhn3VfOXR3Jy05hV5fWO7qGTQSxwU=;
 b=UXUBcegzUKkTgFgutj+KxHHbcpbJ2j2TyFRJYUhZxjKiR84vyDs7IZaPaqAAnsvW9d1jsz
 dPsk+Lqy5BTV/ybqqna5L8kTcTIaGoXizc3dNxsibFfwA/SrLwAdx+NAiS8rEQv+pTBeZq
 boq7/WUSDDW++YfUaMeSR+9eNa3vWeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-Ro9jbR3mNpOf9FLMJSvI4A-1; Tue, 01 Sep 2020 10:35:03 -0400
X-MC-Unique: Ro9jbR3mNpOf9FLMJSvI4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 381E710051D3;
 Tue,  1 Sep 2020 14:35:02 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE13578B5D;
 Tue,  1 Sep 2020 14:35:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 15/43] block: Re-evaluate backing file handling in reopen
Date: Tue,  1 Sep 2020 16:33:56 +0200
Message-Id: <20200901143424.884735-16-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
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
2.26.2


