Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0191720706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTOCY0iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0191720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU3l-0004Ox-8T
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTia-00061s-SI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiZ-00017M-7Y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/8zhymTzIASkGBdt7o/w7A64dbu+ST4wSjovqOs2p0=;
 b=eTOCY0iLwueBPqGuXCHcXuwyD5z2PpHTChQ+xPrVvqqB0kgrjElOBbzJQoHh7mGFpuOsz5
 brcsd5DPfGZr44ulXBX7018hH82o9kJ29s2Qacv6krQoPtP0u6YHPfJPcSUo30vpectJ5g
 g+sWAZePkLxD4mKuaMQ58WlLwbjkKHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-iM2jqbcWMeykjgOw5lKfYQ-1; Thu, 25 Jun 2020 11:23:06 -0400
X-MC-Unique: iM2jqbcWMeykjgOw5lKfYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6121D800C60;
 Thu, 25 Jun 2020 15:23:05 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 044325C296;
 Thu, 25 Jun 2020 15:23:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 21/47] block: Use CAFs in bdrv_refresh_filename()
Date: Thu, 25 Jun 2020 17:21:49 +0200
Message-Id: <20200625152215.941773-22-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

bdrv_refresh_filename() and the kind of related bdrv_dirname() should
look to the primary child when they wish to copy the underlying file's
filename.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 8131d0b5eb..7c827fefa0 100644
--- a/block.c
+++ b/block.c
@@ -6797,6 +6797,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
     BdrvChild *child;
+    BlockDriverState *primary_child_bs;
     QDict *opts;
     bool backing_overridden;
     bool generate_json_filename; /* Whether our default implementation should
@@ -6866,20 +6867,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     qobject_unref(bs->full_open_options);
     bs->full_open_options = opts;
 
+    primary_child_bs = bdrv_primary_bs(bs);
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file name
          * information before refreshing it */
         bs->exact_filename[0] = '\0';
 
         drv->bdrv_refresh_filename(bs);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file */
+    } else if (primary_child_bs) {
+        /*
+         * Try to reconstruct valid information from the underlying
+         * file -- this only works for format nodes (filter nodes
+         * cannot be probed and as such must be selected by the user
+         * either through an options dict, or through a special
+         * filename which the filter driver must construct in its
+         * .bdrv_refresh_filename() implementation).
+         */
 
         bs->exact_filename[0] = '\0';
 
         /*
          * We can use the underlying file's filename if:
          * - it has a filename,
+         * - the current BDS is not a filter,
          * - the file is a protocol BDS, and
          * - opening that file (as this BDS's format) will automatically create
          *   the BDS tree we have right now, that is:
@@ -6888,11 +6899,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   - no non-file child of this BDS has been overridden by the user
          *   Both of these conditions are represented by generate_json_filename.
          */
-        if (bs->file->bs->exact_filename[0] &&
-            bs->file->bs->drv->bdrv_file_open &&
-            !generate_json_filename)
+        if (primary_child_bs->exact_filename[0] &&
+            primary_child_bs->drv->bdrv_file_open &&
+            !drv->is_filter && !generate_json_filename)
         {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
+            strcpy(bs->exact_filename, primary_child_bs->exact_filename);
         }
     }
 
@@ -6912,6 +6923,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *child_bs;
 
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
@@ -6922,8 +6934,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
         return drv->bdrv_dirname(bs, errp);
     }
 
-    if (bs->file) {
-        return bdrv_dirname(bs->file->bs, errp);
+    child_bs = bdrv_primary_bs(bs);
+    if (child_bs) {
+        return bdrv_dirname(child_bs, errp);
     }
 
     bdrv_refresh_filename(bs);
-- 
2.26.2


