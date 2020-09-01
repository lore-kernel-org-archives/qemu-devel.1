Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AACE2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1CX2ZBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AACE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7hh-0000E9-FD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NV-0000My-9s
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NT-0007Ab-AK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4AaaXw2/6EKJzKr5jX11uxo8nsweuTPMdbWEsNTDMg=;
 b=Z1CX2ZBvFsAW8K0SvVkuB1LwsQLjN7Uvu1WRcAw4mWdxnwd4YCyCTO56HFf7NPukSnBenB
 fDEOsWXaCkRwQ5XNJF8Jl4Ve5xldqnilCbQHxK+1b3Mf6mI6evS9+sWErvYtNbz5KGkHyR
 l5fZ0j91IDCJkC0cF2utt7h/CHbro/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-hJrIQei6PxuOx7KyPYKWmw-1; Tue, 01 Sep 2020 10:35:12 -0400
X-MC-Unique: hJrIQei6PxuOx7KyPYKWmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F7510ABDA8;
 Tue,  1 Sep 2020 14:35:11 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC0CF7EB98;
 Tue,  1 Sep 2020 14:35:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 19/43] block: Use CAFs in bdrv_refresh_filename()
Date: Tue,  1 Sep 2020 16:34:00 +0200
Message-Id: <20200901143424.884735-20-mreitz@redhat.com>
In-Reply-To: <20200901143424.884735-1-mreitz@redhat.com>
References: <20200901143424.884735-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bdrv_refresh_filename() and the kind of related bdrv_dirname() should
look to the primary child when they wish to copy the underlying file's
filename.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 660386795a..ed29d1edb4 100644
--- a/block.c
+++ b/block.c
@@ -6822,6 +6822,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
     BdrvChild *child;
+    BlockDriverState *primary_child_bs;
     QDict *opts;
     bool backing_overridden;
     bool generate_json_filename; /* Whether our default implementation should
@@ -6891,20 +6892,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
@@ -6913,11 +6924,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
 
@@ -6937,6 +6948,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *child_bs;
 
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
@@ -6947,8 +6959,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
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


