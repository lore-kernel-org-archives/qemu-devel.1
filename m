Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05717C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3779208C9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJSnR19m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3779208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTwy-0002Js-2K
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiW-0005sR-UR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiU-00010s-P9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GdG7y/uVIjtA/pzRCXGa+y8uc64e6boF3Zk7jcxT44=;
 b=EJSnR19mzGY+jGUoY0cj7IrBlfMWc21Z6D3P4G/J1lIyvdtWJCfNjxVk+MTuXpuM3KOYi6
 /LGm4oVpOaVoDZpz4YdIKcRNHxP5o8QcVsXpzxBTj38hHKdTb4un1S+o2WfExM/bXUmwvD
 0l7otA8938zoMrdqf7RZ1l08BcXi7bU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-dX8h4n6SMQ-qJoeN3JS1Wg-1; Thu, 25 Jun 2020 11:23:04 -0400
X-MC-Unique: dX8h4n6SMQ-qJoeN3JS1Wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44104804002;
 Thu, 25 Jun 2020 15:23:03 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DECC460BE1;
 Thu, 25 Jun 2020 15:23:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 20/47] block: Iterate over children in refresh_limits
Date: Thu, 25 Jun 2020 17:21:48 +0200
Message-Id: <20200625152215.941773-21-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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

Instead of looking at just bs->file and bs->backing, we should look at
all children that could end up receiving forwarded requests.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index c2af7711d6..37057f13e0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -135,6 +135,8 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BdrvChild *c;
+    bool have_limits;
     Error *local_err = NULL;
 
     memset(&bs->bl, 0, sizeof(bs->bl));
@@ -149,14 +151,21 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
                                 drv->bdrv_co_preadv_part) ? 1 : 512;
 
     /* Take some limits from the children as a default */
-    if (bs->file) {
-        bdrv_refresh_limits(bs->file->bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
+    have_limits = false;
+    QLIST_FOREACH(c, &bs->children, next) {
+        if (c->role & (BDRV_CHILD_DATA | BDRV_CHILD_FILTERED | BDRV_CHILD_COW))
+        {
+            bdrv_refresh_limits(c->bs, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            bdrv_merge_limits(&bs->bl, &c->bs->bl);
+            have_limits = true;
         }
-        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
-    } else {
+    }
+
+    if (!have_limits) {
         bs->bl.min_mem_alignment = 512;
         bs->bl.opt_mem_alignment = qemu_real_host_page_size;
 
@@ -164,15 +173,6 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.max_iov = IOV_MAX;
     }
 
-    if (bs->backing) {
-        bdrv_refresh_limits(bs->backing->bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
-    }
-
     /* Then let the driver override it */
     if (drv->bdrv_refresh_limits) {
         drv->bdrv_refresh_limits(bs, errp);
-- 
2.26.2


