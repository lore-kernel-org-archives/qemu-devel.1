Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E977C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F0C206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnH7U/8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F0C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWA1-0004Fl-UV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8b-0002xS-9v
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:44:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8Z-00042N-RA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589294642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybxicmw62WPTarXz7cdaSgDqp3JUN9/hShkGjxRS1qg=;
 b=QnH7U/8jBpa9dAlltB/DkKgY8lz5jlUuW2cTtzn3QBM/gqwXH8SnYE8y1w1puMqUx5Acxj
 uiKUEWz5GYTBjYzhFUeojkz8GS5fRHi8E8cl/ubgg/etD4Nv5dY0xSApYBnqAEbsQ26xZC
 m7ozT784Ytwfr3dQyfseGwojbkW6IcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-SblDYKekP-WGsGPfSsEMcQ-1; Tue, 12 May 2020 10:44:00 -0400
X-MC-Unique: SblDYKekP-WGsGPfSsEMcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D79EC1A1;
 Tue, 12 May 2020 14:43:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38CB35D9DD;
 Tue, 12 May 2020 14:43:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 2/3] block: Allow bdrv_run_co() from different AioContext
Date: Tue, 12 May 2020 16:43:17 +0200
Message-Id: <20200512144318.181049-3-kwolf@redhat.com>
In-Reply-To: <20200512144318.181049-1-kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:05
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

Coroutine functions that are entered through bdrv_run_co() are already
safe to call from synchronous code in a different AioContext because
bdrv_coroutine_enter() will schedule them in the context of the node.

However, the coroutine fastpath still requires that we're already in the
right AioContext when called in coroutine context.

In order to make the behaviour more consistent and to make life a bit
easier for callers, let's check the AioContext and automatically move
the current coroutine around if we're not in the right context yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index c1badaadc9..7808e8bdc0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -895,8 +895,21 @@ static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
                        void *opaque, int *ret)
 {
     if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
+        Coroutine *self = qemu_coroutine_self();
+        AioContext *bs_ctx = bdrv_get_aio_context(bs);
+        AioContext *co_ctx = qemu_coroutine_get_aio_context(self);
+
+        if (bs_ctx != co_ctx) {
+            /* Move to the iothread of the node */
+            aio_co_schedule(bs_ctx, self);
+            qemu_coroutine_yield();
+        }
         entry(opaque);
+        if (bs_ctx != co_ctx) {
+            /* Move back to the original AioContext */
+            aio_co_schedule(bs_ctx, self);
+            qemu_coroutine_yield();
+        }
     } else {
         Coroutine *co = qemu_coroutine_create(entry, opaque);
         *ret = NOT_DONE;
-- 
2.25.3


