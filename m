Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00453206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JajhEASy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00453206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFHJ-0000nL-29
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2l-0003K7-Ut
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2e-00086D-A4
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCfPuMzPikOUocPpoI2jnb1CB5Wz16WJaggYaK6/fAk=;
 b=JajhEASykYboi0Tt+EM6I34msgq3jokOK3N9ag5u1gPHG87ZwoNgCt3ULrhZsYr84wKwzE
 yFW6UDnkGgGXgSUEhq8KWQFDS8WJj+ooB86buYBVdk7K/tEeG9EN9QQm2xQHeWe2AuqQ6+
 W4OKypquCd/M3Gw2AS73Gd1Z7brZrb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-phmwGCcXNgG7ebjGiDpkKg-1; Mon, 07 Sep 2020 07:10:27 -0400
X-MC-Unique: phmwGCcXNgG7ebjGiDpkKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB4B1084C88;
 Mon,  7 Sep 2020 11:10:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B1AB7E42B;
 Mon,  7 Sep 2020 11:10:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/64] block: Flush all children in generic code
Date: Mon,  7 Sep 2020 13:09:04 +0200
Message-Id: <20200907110936.261684-33-kwolf@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

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
2.25.4


