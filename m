Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6C4C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CF1206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hB5AsN4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CF1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWBO-0007gR-Mc
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8M-0002fN-Cu
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:43:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8L-00041X-D5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589294628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGBQWwSx8J3Up4Q8x4/YZuvKiJkHxgyFQvzGyXc9bPE=;
 b=hB5AsN4XITV59mK6+d9S8MZl8V6mlm4tigfEE/7ErMgNLhTZpUd374s7dUFqSnyFxcUayL
 5RuRywzvXYAHK5vCoUdrKjdwPQRuYBY9Ym3jee1K6hNgN5dzRocMxHGU3qWs7x/mLqDtW4
 tUpJgtq/nbfJDb9REm3yGz43ZxryWog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-UsF_gpGPND6BALCsdxgSew-1; Tue, 12 May 2020 10:43:46 -0400
X-MC-Unique: UsF_gpGPND6BALCsdxgSew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B04718A0750;
 Tue, 12 May 2020 14:43:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661325D9DD;
 Tue, 12 May 2020 14:43:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 1/3] block: Factor out bdrv_run_co()
Date: Tue, 12 May 2020 16:43:16 +0200
Message-Id: <20200512144318.181049-2-kwolf@redhat.com>
In-Reply-To: <20200512144318.181049-1-kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a few bdrv_*() functions that can either spawn a new coroutine
and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
alreeady running in a coroutine. All of them duplicate basically the
same code.

Factor the common code into a new function bdrv_run_co().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 104 +++++++++++++++--------------------------------------
 1 file changed, 28 insertions(+), 76 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7d30e61edc..c1badaadc9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -891,6 +891,22 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
+static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
+                       void *opaque, int *ret)
+{
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        entry(opaque);
+    } else {
+        Coroutine *co = qemu_coroutine_create(entry, opaque);
+        *ret = NOT_DONE;
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, *ret == NOT_DONE);
+    }
+
+    return *ret;
+}
+
 typedef struct RwCo {
     BdrvChild *child;
     int64_t offset;
@@ -923,25 +939,15 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
                         QEMUIOVector *qiov, bool is_write,
                         BdrvRequestFlags flags)
 {
-    Coroutine *co;
     RwCo rwco = {
         .child = child,
         .offset = offset,
         .qiov = qiov,
         .is_write = is_write,
-        .ret = NOT_DONE,
         .flags = flags,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_rw_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-    return rwco.ret;
+    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco, &rwco.ret);
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
@@ -2230,7 +2236,6 @@ typedef struct BdrvCoBlockStatusData {
     int64_t *map;
     BlockDriverState **file;
     int ret;
-    bool done;
 } BdrvCoBlockStatusData;
 
 int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
@@ -2492,7 +2497,6 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
                                            data->want_zero,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->file);
-    data->done = true;
     aio_wait_kick();
 }
 
@@ -2508,7 +2512,6 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           int64_t *map,
                                           BlockDriverState **file)
 {
-    Coroutine *co;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
@@ -2518,18 +2521,9 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
         .pnum = pnum,
         .map = map,
         .file = file,
-        .done = false,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_block_status_above_co_entry(&data);
-    } else {
-        co = qemu_coroutine_create(bdrv_block_status_above_co_entry, &data);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !data.done);
-    }
-    return data.ret;
+    return bdrv_run_co(bs, bdrv_block_status_above_co_entry, &data, &data.ret);
 }
 
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
@@ -2669,22 +2663,13 @@ static inline int
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read)
 {
-    if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
-    } else {
-        BdrvVmstateCo data = {
-            .bs         = bs,
-            .qiov       = qiov,
-            .pos        = pos,
-            .is_read    = is_read,
-            .ret        = -EINPROGRESS,
-        };
-        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
-
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
-        return data.ret;
-    }
+    BdrvVmstateCo data = {
+        .bs         = bs,
+        .qiov       = qiov,
+        .pos        = pos,
+        .is_read    = is_read,
+    };
+    return bdrv_run_co(bs, bdrv_co_rw_vmstate_entry, &data, &data.ret);
 }
 
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
@@ -2890,22 +2875,11 @@ early_exit:
 
 int bdrv_flush(BlockDriverState *bs)
 {
-    Coroutine *co;
     FlushCo flush_co = {
         .bs = bs,
-        .ret = NOT_DONE,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_flush_co_entry(&flush_co);
-    } else {
-        co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
-    }
-
-    return flush_co.ret;
+    return bdrv_run_co(bs, bdrv_flush_co_entry, &flush_co, &flush_co.ret);
 }
 
 typedef struct DiscardCo {
@@ -3038,24 +3012,13 @@ out:
 
 int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
-    Coroutine *co;
     DiscardCo rwco = {
         .child = child,
         .offset = offset,
         .bytes = bytes,
-        .ret = NOT_DONE,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_pdiscard_co_entry(&rwco);
-    } else {
-        co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
-    }
-
-    return rwco.ret;
+    return bdrv_run_co(child->bs, bdrv_pdiscard_co_entry, &rwco, &rwco.ret);
 }
 
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
@@ -3477,7 +3440,6 @@ static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
 int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
                   PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
 {
-    Coroutine *co;
     TruncateCo tco = {
         .child      = child,
         .offset     = offset,
@@ -3485,17 +3447,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
         .prealloc   = prealloc,
         .flags      = flags,
         .errp       = errp,
-        .ret        = NOT_DONE,
     };
 
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_truncate_co_entry(&tco);
-    } else {
-        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
-        bdrv_coroutine_enter(child->bs, co);
-        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
-    }
-
-    return tco.ret;
+    return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco, &tco.ret);
 }
-- 
2.25.3


