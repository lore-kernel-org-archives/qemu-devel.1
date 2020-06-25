Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4A5207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB8HRouu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4A5207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTxj-0003Ws-Ec
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiO-0005gn-KE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiK-0000oM-3e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yEX1cwu7AhSnNJ+xZkL8DLXxlRL6pDn3Gj2dmxQeiE=;
 b=DB8HRouuBcvjLrPUmppzH3hDjtKrtXGZ13RDHzZvRf9RcRlx7YCCZkIDCCECmM/U7wlc9a
 bRK73rspUxioLbjxePz6WAX41noz6lXbvzH3pYLb61LbI8P2gDyn2bHTQ1O205ZT2P8UJY
 /bcmH8MCxf5QncXdYdoVxnFDXiYJ/xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-b62nW2fXOOuSiKDzXYfpiQ-1; Thu, 25 Jun 2020 11:22:53 -0400
X-MC-Unique: b62nW2fXOOuSiKDzXYfpiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53AA61009455;
 Thu, 25 Jun 2020 15:22:52 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA47C7C214;
 Thu, 25 Jun 2020 15:22:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 15/47] block: Use CAFs when working with backing chains
Date: Thu, 25 Jun 2020 17:21:43 +0200
Message-Id: <20200625152215.941773-16-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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

Use child access functions when iterating through backing chains so
filters do not break the chain.

In addition, bdrv_find_overlay() will now always return the actual
overlay; that is, it will never return a filter node but only one with a
COW backing file (there may be filter nodes between that node and @bs).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index a44af9c3c1..712230ef5c 100644
--- a/block.c
+++ b/block.c
@@ -4724,7 +4724,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
 }
 
 /*
- * Finds the image layer in the chain that has 'bs' as its backing file.
+ * Finds the image layer in the chain that has 'bs' (or a filter on
+ * top of it) as its backing file.
  *
  * active is the current topmost image.
  *
@@ -4736,11 +4737,18 @@ int bdrv_change_backing_file(BlockDriverState *bs,
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs)
 {
-    while (active && bs != backing_bs(active)) {
-        active = backing_bs(active);
+    bs = bdrv_skip_filters(bs);
+    active = bdrv_skip_filters(active);
+
+    while (active) {
+        BlockDriverState *next = bdrv_backing_chain_next(active);
+        if (bs == next) {
+            return active;
+        }
+        active = next;
     }
 
-    return active;
+    return NULL;
 }
 
 /* Given a BDS, searches for the base layer. */
@@ -4892,9 +4900,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
      * other intermediate nodes have been dropped.
      * If 'top' is an implicit node (e.g. "commit_top") we should skip
      * it because no one inherits from it. We use explicit_top for that. */
-    while (explicit_top && explicit_top->implicit) {
-        explicit_top = backing_bs(explicit_top);
-    }
+    explicit_top = bdrv_skip_implicit_filters(explicit_top);
     update_inherits_from = bdrv_inherits_from_recursive(base, explicit_top);
 
     /* success - we can delete the intermediate states, and link top->base */
@@ -5351,7 +5357,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
     while (top && top != base) {
-        top = backing_bs(top);
+        top = bdrv_filter_or_cow_bs(top);
     }
 
     return top != NULL;
@@ -5607,6 +5613,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     int is_protocol = 0;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
+    BlockDriverState *bs_below;
 
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
@@ -5617,7 +5624,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     is_protocol = path_has_protocol(backing_file);
 
-    for (curr_bs = bs; curr_bs->backing; curr_bs = curr_bs->backing->bs) {
+    /*
+     * Being largely a legacy function, skip any filters here
+     * (because filters do not have normal filenames, so they cannot
+     * match anyway; and allowing json:{} filenames is a bit out of
+     * scope).
+     */
+    for (curr_bs = bdrv_skip_filters(bs);
+         bdrv_cow_child(curr_bs) != NULL;
+         curr_bs = bs_below)
+    {
+        bs_below = bdrv_backing_chain_next(curr_bs);
 
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
@@ -5625,7 +5642,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
             char *backing_file_full_ret;
 
             if (strcmp(backing_file, curr_bs->backing_file) == 0) {
-                retval = curr_bs->backing->bs;
+                retval = bs_below;
                 break;
             }
             /* Also check against the full backing filename for the image */
@@ -5635,7 +5652,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
                 bool equal = strcmp(backing_file, backing_file_full_ret) == 0;
                 g_free(backing_file_full_ret);
                 if (equal) {
-                    retval = curr_bs->backing->bs;
+                    retval = bs_below;
                     break;
                 }
             }
@@ -5661,7 +5678,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
             g_free(filename_tmp);
 
             if (strcmp(backing_file_full, filename_full) == 0) {
-                retval = curr_bs->backing->bs;
+                retval = bs_below;
                 break;
             }
         }
-- 
2.26.2


