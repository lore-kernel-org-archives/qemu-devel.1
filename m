Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FEE207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zid1OHS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FEE207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTuc-0005xz-JD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiV-0005pX-SA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTiU-00010O-5s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lsugp79RAMNcHG74w7ZGLRAAjt0YELvG0KbMAv1dqUk=;
 b=Zid1OHS+8I/f8UBdlYAhdcllNfzMgn7l+rRVhGJSl8XwMQABK8ELBgv7JCPYzuy/PU7DEa
 HDxtw1IXPEhgIX2bpa/fyaB9zH77ZrZuJYN0TFjn76Nnaa3hKnNWEW5GKxmXd4jIwFQePj
 GA2JOtkG0Jv9X25Ee98qap6KqiD5q/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-uKKlE8xoNJe1IIbDriV24A-1; Thu, 25 Jun 2020 11:23:00 -0400
X-MC-Unique: uKKlE8xoNJe1IIbDriV24A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8638107ACCD;
 Thu, 25 Jun 2020 15:22:58 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C91F2B4A8;
 Thu, 25 Jun 2020 15:22:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 18/47] block: Flush all children in generic code
Date: Thu, 25 Jun 2020 17:21:46 +0200
Message-Id: <20200625152215.941773-19-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
---
 block/io.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index 097a3861d8..c2af7711d6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2769,6 +2769,8 @@ static int coroutine_fn bdrv_flush_co_entry(void *opaque)
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BdrvChild *primary_child = bdrv_primary_child(bs);
+    BdrvChild *child;
     int current_gen;
     int ret = 0;
 
@@ -2798,7 +2800,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     /* Write back cached data to the OS even with cache=unsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret = bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2808,15 +2810,15 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
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
@@ -2860,8 +2862,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
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


