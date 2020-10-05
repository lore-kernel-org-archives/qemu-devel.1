Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EDC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B9120663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BChUZ78Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B9120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPT5R-0008TT-IL
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSu2-00017s-4G
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSty-0002EB-47
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4s01xsYXxscT/6wpjsQxGM0R1AAU853iDGCwbSdMxI=;
 b=BChUZ78Yqn0IT/kksIdWPwe4LpbRQBCAom83i6nvoLeCEBEgVfT4/rceKgpIDVWSXJu8F0
 NyfCmHZERKsT3ZMqSngYNJFMftCsLanXtFYLAl14epAD971KNrS2CgKHVnvA0vh84QG9rE
 Ao9VLE6Q5nC7/s1wbo+vHStRyzyEKlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-52vmmK25N3qiqLrNFr6uIQ-1; Mon, 05 Oct 2020 11:59:38 -0400
X-MC-Unique: 52vmmK25N3qiqLrNFr6uIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A591C106B2A8;
 Mon,  5 Oct 2020 15:59:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C558610AF;
 Mon,  5 Oct 2020 15:59:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 13/14] block: Add bdrv_lock()/unlock()
Date: Mon,  5 Oct 2020 17:58:54 +0200
Message-Id: <20201005155855.256490-14-kwolf@redhat.com>
In-Reply-To: <20201005155855.256490-1-kwolf@redhat.com>
References: <20201005155855.256490-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Inside of coroutine context, we can't directly use aio_context_acquire()
for the AioContext of a block node because we already own the lock of
the current AioContext and we need to avoid double locking to prevent
deadlocks.

This provides helper functions to lock the AioContext of a node only if
it's not the same as the current AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 14 ++++++++++++++
 block.c               | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index b5fa7b2229..65d79270e6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -643,6 +643,20 @@ AioContext *coroutine_fn bdrv_co_enter(BlockDriverState *bs);
  */
 void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx);
 
+/**
+ * Locks the AioContext of @bs if it's not the current AioContext. This avoids
+ * double locking which could lead to deadlocks: This is a coroutine_fn, so we
+ * know we already own the lock of the current AioContext.
+ *
+ * May only be called in the main thread.
+ */
+void coroutine_fn bdrv_co_lock(BlockDriverState *bs);
+
+/**
+ * Unlocks the AioContext of @bs if it's not the current AioContext.
+ */
+void coroutine_fn bdrv_co_unlock(BlockDriverState *bs);
+
 /**
  * Transfer control to @co in the aio context of @bs
  */
diff --git a/block.c b/block.c
index 5eac2683b2..e39d5fa3db 100644
--- a/block.c
+++ b/block.c
@@ -6395,6 +6395,33 @@ void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx)
     bdrv_dec_in_flight(bs);
 }
 
+void coroutine_fn bdrv_co_lock(BlockDriverState *bs)
+{
+    AioContext *ctx = bdrv_get_aio_context(bs);
+
+    /* In the main thread, bs->aio_context won't change concurrently */
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+
+    /*
+     * We're in coroutine context, so we already hold the lock of the main
+     * loop AioContext. Don't lock it twice to avoid deadlocks.
+     */
+    assert(qemu_in_coroutine());
+    if (ctx != qemu_get_aio_context()) {
+        aio_context_acquire(ctx);
+    }
+}
+
+void coroutine_fn bdrv_co_unlock(BlockDriverState *bs)
+{
+    AioContext *ctx = bdrv_get_aio_context(bs);
+
+    assert(qemu_in_coroutine());
+    if (ctx != qemu_get_aio_context()) {
+        aio_context_release(ctx);
+    }
+}
+
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
 {
     aio_co_enter(bdrv_get_aio_context(bs), co);
-- 
2.25.4


