Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAF722245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC016M4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAF722245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQm8j-0003w3-EM
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzI-0001yr-L3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzG-0008Up-Ts
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLyDWMeNHpHjWrzq3YeyNor0Ou8l1NL+W3Oo+IlQZ/k=;
 b=jC016M4bTXNpRhYIM+dfSrxTSpMz3HhRBTjGnXgC2fyMpL13BzPNVdA17ebTcFVBdQyOLq
 RnYq/iggl1brtThwlIxfuJ2p7izFpyznOzT/qiJTwRWi2bQSQokiu1ujeidt22YYM8VcGk
 AZF+u7F8zHdRBi7wJuTz0KhnMQAKw18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-yFBjsAQVN2CS4PLKWHyi_Q-1; Fri, 09 Oct 2020 02:34:40 -0400
X-MC-Unique: yFBjsAQVN2CS4PLKWHyi_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE9718BA2B0
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7062160BFA;
 Fri,  9 Oct 2020 06:34:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A5AE112993C; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] block: Add bdrv_co_enter()/leave()
Date: Fri,  9 Oct 2020 08:34:30 +0200
Message-Id: <20201009063432.303441-13-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Add a pair of functions to temporarily move the current coroutine to the
AioContext of a given BlockDriverState.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20201005155855.256490-13-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/block.h | 17 +++++++++++++++++
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index ce2ac39299..1027c58a41 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -640,6 +640,23 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
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
index 52b2e2709f..8d9b9017d3 100644
--- a/block.c
+++ b/block.c
@@ -6303,6 +6303,29 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
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
2.26.2


