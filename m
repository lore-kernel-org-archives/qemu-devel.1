Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D35C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BE420838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPVciojI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BE420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17I9-0008OD-FP
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Gq-00074B-O3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Gn-0002Da-7F
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596110562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XayNoVv3dgHV0iD1XYOMbKFaFqk1jbDF/grCCtuv5QY=;
 b=aPVciojIriDNhxmh0GswMtBVPMfkUqD6kQ9RaCEVThwhDb2KNdBkBo4gRzUKlUImTLgpNl
 7iV1/W8UszLCTmfD0FORS8pXpu4xftXED2NFpV/CLa6LsUaPVk09gJAtRkOwjSxpSn3y9o
 TE9YSKc92EgTXX/ABWFxW6OJq/uc7BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-aNe8LedSO1iiJ1UBqDXUhg-1; Thu, 30 Jul 2020 08:02:39 -0400
X-MC-Unique: aNe8LedSO1iiJ1UBqDXUhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3992107BA69;
 Thu, 30 Jul 2020 12:02:38 +0000 (UTC)
Received: from localhost (ovpn-113-153.ams2.redhat.com [10.36.113.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E0378A191;
 Thu, 30 Jul 2020 12:02:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] qcow2: Release read-only bitmaps when inactivated
Date: Thu, 30 Jul 2020 14:02:33 +0200
Message-Id: <20200730120234.49288-2-mreitz@redhat.com>
In-Reply-To: <20200730120234.49288-1-mreitz@redhat.com>
References: <20200730120234.49288-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During migration, we release all bitmaps after storing them on disk, as
long as they are (1) stored on disk, (2) not read-only, and (3)
consistent.

(2) seems arbitrary, though.  The reason we do not release them is
because we do not write them, as there is no need to; and then we just
forget about all bitmaps that we have not written to the file.  However,
read-only persistent bitmaps are still in the file and in sync with
their in-memory representation, so we may as well release them just like
any R/W bitmap that we have updated.

It leads to actual problems, too: After migration, letting the source
continue may result in an error if there were any bitmaps on read-only
nodes (such as backing images), because those have not been released by
bdrv_inactive_all(), but bdrv_invalidate_cache_all() attempts to reload
them (which fails, because they are still present in memory).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 1f38806ca6..8c34b2aef7 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1562,11 +1562,22 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         Qcow2Bitmap *bm;
 
         if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
-            bdrv_dirty_bitmap_readonly(bitmap) ||
             bdrv_dirty_bitmap_inconsistent(bitmap)) {
             continue;
         }
 
+        if (bdrv_dirty_bitmap_readonly(bitmap)) {
+            /*
+             * Store the bitmap in the associated Qcow2Bitmap so it
+             * can be released later
+             */
+            bm = find_bitmap_by_name(bm_list, name);
+            if (bm) {
+                bm->dirty_bitmap = bitmap;
+            }
+            continue;
+        }
+
         need_write = true;
 
         if (check_constraints_on_bitmap(bs, name, granularity, errp) < 0) {
@@ -1618,7 +1629,9 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
 
     /* allocate clusters and store bitmaps */
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (bm->dirty_bitmap == NULL) {
+        BdrvDirtyBitmap *bitmap = bm->dirty_bitmap;
+
+        if (bitmap == NULL || bdrv_dirty_bitmap_readonly(bitmap)) {
             continue;
         }
 
@@ -1641,6 +1654,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         g_free(tb);
     }
 
+success:
     if (release_stored) {
         QSIMPLEQ_FOREACH(bm, bm_list, entry) {
             if (bm->dirty_bitmap == NULL) {
@@ -1651,13 +1665,14 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         }
     }
 
-success:
     bitmap_list_free(bm_list);
     return;
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (bm->dirty_bitmap == NULL || bm->table.offset == 0) {
+        if (bm->dirty_bitmap == NULL || bm->table.offset == 0 ||
+            bdrv_dirty_bitmap_readonly(bm->dirty_bitmap))
+        {
             continue;
         }
 
-- 
2.26.2


