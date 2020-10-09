Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19463C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E0B22245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcuisGP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E0B22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQm82-0002nf-Ik
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzN-0002BD-He
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzK-0008Vj-BB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyc0nP3wSxqrGG1ZvIQufgDbDyfxbVgN+LU++ks7MPs=;
 b=BcuisGP1WgAE10PhC8OKoUv2IUb3icfXcmC2amV5ovJ8KMH7jR1rGwLZUjUcbt09qcc3Kt
 BtH/qEkTJuN6CnobTjA9T2gfMdQPhFkGyN7/CPvR0vLZ0IRf4k9Y/RI3FNHlL/dJiJlFcj
 h696d9E3JTSKQYIMkidJQ9qjB2hZkOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Lsvy-sakOuSYb3ervZDjzg-1; Fri, 09 Oct 2020 02:34:43 -0400
X-MC-Unique: Lsvy-sakOuSYb3ervZDjzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5796414A
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70EE77367C;
 Fri,  9 Oct 2020 06:34:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2DB3D1129942; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] block: Add bdrv_lock()/unlock()
Date: Fri,  9 Oct 2020 08:34:31 +0200
Message-Id: <20201009063432.303441-14-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Inside of coroutine context, we can't directly use aio_context_acquire()
for the AioContext of a block node because we already own the lock of
the current AioContext and we need to avoid double locking to prevent
deadlocks.

This provides helper functions to lock the AioContext of a node only if
it's not the same as the current AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20201005155855.256490-14-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/block.h | 14 ++++++++++++++
 block.c               | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 1027c58a41..d16c401cb4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -657,6 +657,20 @@ AioContext *coroutine_fn bdrv_co_enter(BlockDriverState *bs);
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
index 8d9b9017d3..430edf79bb 100644
--- a/block.c
+++ b/block.c
@@ -6326,6 +6326,33 @@ void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx)
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
2.26.2


