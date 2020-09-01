Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC56C28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6228F20FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6fI4j1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6228F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7fr-0003xv-Ar
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NR-00009d-9d
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7NO-00079U-Db
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FkKw+2u0pVIhoGiV+5RN7L0YEQ2P4sgGJ0cjzoBelg=;
 b=Y6fI4j1IbaOtKZCXmoCKADrJTXVmt1s5IQAzXIP7zYbhVTbcxDuq6ISRI66FKnxLGegwLC
 qqDsCLyGbAL5reVTZWpgTEKj0PjuiQfIG6FlUiIbMkSsZzHLldfoCqykBsZxjJX5QgAYAg
 HrQaJXNhqjt6+gxOtDyps9af3f/ptVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-6gx6tWFcOxS7gzTdyX-6pg-1; Tue, 01 Sep 2020 10:35:05 -0400
X-MC-Unique: 6gx6tWFcOxS7gzTdyX-6pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A3A64082;
 Tue,  1 Sep 2020 14:35:04 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 138207EB94;
 Tue,  1 Sep 2020 14:35:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 16/43] block: Flush all children in generic code
Date: Tue,  1 Sep 2020 16:33:57 +0200
Message-Id: <20200901143424.884735-17-mreitz@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If the driver does not support .bdrv_co_flush() so bdrv_co_flush()
itself has to flush the children of the given node, it should not flush
just bs->file->bs, but in fact all children that might have been written
to (judging from the permissions taken on them).

This is a bug fix for qcow2 images with an external data file, as they
so far did not flush that data_file node.

In any case, the BLKDBG_EVENT() should be emitted on the primary child,
because that is where a blkdebug node would be if there is any.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6f9402117e..8d777cd0ec 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2771,6 +2771,8 @@ static int coroutine_fn bdrv_flush_co_entry(void *opaque)
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BdrvChild *primary_child = bdrv_primary_child(bs);
+    BdrvChild *child;
     int current_gen;
     int ret = 0;
 
@@ -2800,7 +2802,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     /* Write back cached data to the OS even with cache=unsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret = bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2810,15 +2812,15 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
     /* But don't actually force it to the disk with cache=unsafe */
     if (bs->open_flags & BDRV_O_NO_FLUSH) {
-        goto flush_parent;
+        goto flush_children;
     }
 
     /* Check if we really need to flush anything */
     if (bs->flushed_gen == current_gen) {
-        goto flush_parent;
+        goto flush_children;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
@@ -2862,8 +2864,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     /* Now flush the underlying protocol.  It will also have BDRV_O_NO_FLUSH
      * in the case of cache=unsafe, so there are no useless flushes.
      */
-flush_parent:
-    ret = bs->file ? bdrv_co_flush(bs->file->bs) : 0;
+flush_children:
+    ret = 0;
+    QLIST_FOREACH(child, &bs->children, next) {
+        if (child->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)) {
+            int this_child_ret = bdrv_co_flush(child->bs);
+            if (!ret) {
+                ret = this_child_ret;
+            }
+        }
+    }
+
 out:
     /* Notify any pending flushes that we have completed */
     if (ret == 0) {
-- 
2.26.2


