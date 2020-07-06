Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB29C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1F820739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Znf+B9u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1F820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOIb-0005B3-6p
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0V-0004pe-MT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0T-0004Mu-SP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrKoebiL2UfqTB2RJFDxEt9GUE2N/cuYD81ybQUoEMc=;
 b=Znf+B9u8iwC4FTmuMKnKCiZBMIRzv0nHNSpVdj59s4BX+XNwl2isMjskXy6JXxfY2l8xs5
 G+i3y5Uf8fK5df0JVy6SwF0jhZ/VgavFz6hfsRkX+qCJuTFWLkSJP6VaYGnxgZLiVluKPU
 VPVVggmElXD+D4U6iiX9Yqxa5ACohAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Z8mfu8oMO0SayqObcMufeA-1; Mon, 06 Jul 2020 06:05:47 -0400
X-MC-Unique: Z8mfu8oMO0SayqObcMufeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C6FB80183C;
 Mon,  6 Jul 2020 10:05:46 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DB48275E3B;
 Mon,  6 Jul 2020 10:05:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/31] block: drop unallocated_blocks_are_zero
Date: Mon,  6 Jul 2020 12:04:31 +0200
Message-Id: <20200706100432.2301919-31-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Currently this field only set by qed and qcow2. But in fact, all
backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
these semantics: on unallocated blocks, if there is no backing file they
just memset the buffer with zeroes.

So, document this behavior for .supports_backing and drop
.unallocated_blocks_are_zero

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528094405.145708-10-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     |  5 -----
 include/block/block_int.h | 12 +++++++++++-
 block/io.c                |  9 ++-------
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e7934e07f2..bca3bb831c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
     /* offset at which the VM state can be saved (0 if not possible) */
     int64_t vm_state_offset;
     bool is_dirty;
-    /*
-     * True if unallocated blocks read back as zeroes. This is equivalent
-     * to the LBPRZ flag in the SCSI logical block provisioning page.
-     */
-    bool unallocated_blocks_are_zero;
     /*
      * True if this block driver only supports compressed writes
      */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1b86b59af1..3d6cf88592 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -123,7 +123,17 @@ struct BlockDriver {
      */
     bool bdrv_needs_filename;
 
-    /* Set if a driver can support backing files */
+    /*
+     * Set if a driver can support backing files. This also implies the
+     * following semantics:
+     *
+     *  - Return status 0 of .bdrv_co_block_status means that corresponding
+     *    blocks are not allocated in this layer of backing-chain
+     *  - For such (unallocated) blocks, read will:
+     *    - fill buffer with zeros if there is no backing file
+     *    - read from the backing file otherwise, where the block layer
+     *      takes care of reading zeros beyond EOF if backing file is short
+     */
     bool supports_backing;
 
     /* For handling image reopen for split or non-split files */
diff --git a/block/io.c b/block/io.c
index 36d4d562a6..b6564e34c5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2406,7 +2406,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero) {
+    } else if (want_zero && bs->drv->supports_backing) {
         if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
@@ -2415,12 +2415,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
                 ret |= BDRV_BLOCK_ZERO;
             }
         } else {
-            BlockDriverInfo bdi;
-            int ret2 = bdrv_get_info(bs, &bdi);
-
-            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
-                ret |= BDRV_BLOCK_ZERO;
-            }
+            ret |= BDRV_BLOCK_ZERO;
         }
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 30f073cf2a..38198b4e75 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4987,7 +4987,6 @@ err:
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
-    bdi->unallocated_blocks_are_zero = true;
     bdi->cluster_size = s->cluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     return 0;
diff --git a/block/qed.c b/block/qed.c
index c0c65015c7..a2dd952699 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1514,7 +1514,6 @@ static int bdrv_qed_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     memset(bdi, 0, sizeof(*bdi));
     bdi->cluster_size = s->header.cluster_size;
     bdi->is_dirty = s->header.features & QED_F_NEED_CHECK;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
-- 
2.26.2


