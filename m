Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C884C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835C9206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ9aeIIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835C9206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSwi-00036v-JV
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSty-00015a-EQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStq-0002DG-9c
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNF7vQhyvLveIcH0LkUirOla3WHTA58VFXcyLY7+IQw=;
 b=PQ9aeIIH5mW182uI2DqdsRkrwQWD8RiVakBLsJFzjcfGALJMEemoEQ7VTmV30ki2Ndonws
 OWGnBquc9rRL9pTI3CIXOy6BtMmEWl1sWXBIw88prGbVCMoez15lZZUVwL8n9caOVXedlc
 s0CoJry9ah+JwioHSBAM79b7iZYlKcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-9_KCP4w9OQWra_i7_fRDvg-1; Mon, 05 Oct 2020 11:59:37 -0400
X-MC-Unique: 9_KCP4w9OQWra_i7_fRDvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1322218C5218;
 Mon,  5 Oct 2020 15:59:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C59BC60C11;
 Mon,  5 Oct 2020 15:59:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 12/14] block: Add bdrv_co_enter()/leave()
Date: Mon,  5 Oct 2020 17:58:53 +0200
Message-Id: <20201005155855.256490-13-kwolf@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a pair of functions to temporarily move the current coroutine to the
AioContext of a given BlockDriverState.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 17 +++++++++++++++++
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 981ab5b314..b5fa7b2229 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -626,6 +626,23 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
  */
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
+/**
+ * Move the current coroutine to the AioContext of @bs and return the old
+ * AioContext of the coroutine. Increase bs->in_flight so that draining @bs
+ * will wait for the operation to proceed until the corresponding
+ * bdrv_co_leave().
+ *
+ * Consequently, you can't call drain inside a bdrv_co_enter/leave() section as
+ * this will deadlock.
+ */
+AioContext *coroutine_fn bdrv_co_enter(BlockDriverState *bs);
+
+/**
+ * Ends a section started by bdrv_co_enter(). Move the current coroutine back
+ * to old_ctx and decrease bs->in_flight again.
+ */
+void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx);
+
 /**
  * Transfer control to @co in the aio context of @bs
  */
diff --git a/block.c b/block.c
index f4b6dd5d3d..5eac2683b2 100644
--- a/block.c
+++ b/block.c
@@ -6372,6 +6372,29 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs ? bs->aio_context : qemu_get_aio_context();
 }
 
+AioContext *coroutine_fn bdrv_co_enter(BlockDriverState *bs)
+{
+    Coroutine *self = qemu_coroutine_self();
+    AioContext *old_ctx = qemu_coroutine_get_aio_context(self);
+    AioContext *new_ctx;
+
+    /*
+     * Increase bs->in_flight to ensure that this operation is completed before
+     * moving the node to a different AioContext. Read new_ctx only afterwards.
+     */
+    bdrv_inc_in_flight(bs);
+
+    new_ctx = bdrv_get_aio_context(bs);
+    aio_co_reschedule_self(new_ctx);
+    return old_ctx;
+}
+
+void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx)
+{
+    aio_co_reschedule_self(old_ctx);
+    bdrv_dec_in_flight(bs);
+}
+
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
 {
     aio_co_enter(bdrv_get_aio_context(bs), co);
-- 
2.25.4


