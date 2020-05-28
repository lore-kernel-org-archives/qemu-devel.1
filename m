Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBADC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C952073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcNFiFps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C952073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKgr-0008Ba-9D
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbt-00048m-BE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbs-00040Q-Jf
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqYKidgh5G1o4ZTcC+zTmHKmnxR2i9Cweaej/MX4Lv8=;
 b=fcNFiFpsnscqBPs488c6LVl1Vaiv4oCTgHV/O0prVL0UNthRGaTPvyMjTJcCzF7LKQVv9p
 +b0bdBBIRuVCqb9vrShwhC/bVzyKpP1dIVsLZNpPZQgSoZCV2VClrydibq0gbn3sowvplA
 zOaGj4BZml5Oe02iToDdqqukLVrsdtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-BbchL4vgMEmehycdPAQ31A-1; Thu, 28 May 2020 11:38:18 -0400
X-MC-Unique: BbchL4vgMEmehycdPAQ31A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 539DD1855A01;
 Thu, 28 May 2020 15:38:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D18710013D0;
 Thu, 28 May 2020 15:38:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 11/12] block: Add bdrv_co_move_to_aio_context()
Date: Thu, 28 May 2020 17:37:41 +0200
Message-Id: <20200528153742.274164-12-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function to move the current coroutine to the AioContext of a
given BlockDriverState.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  6 ++++++
 block.c               | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..fb77062a1e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -631,6 +631,12 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
  */
 AioContext *bdrv_get_aio_context(BlockDriverState *bs);
 
+/**
+ * Move the current coroutine to the AioContext of @bs and return the old
+ * AioContext of the coroutine.
+ */
+AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverState *bs);
+
 /**
  * Transfer control to @co in the aio context of @bs
  */
diff --git a/block.c b/block.c
index 8416376c9b..cd576b991c 100644
--- a/block.c
+++ b/block.c
@@ -6215,6 +6215,16 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs ? bs->aio_context : qemu_get_aio_context();
 }
 
+AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverState *bs)
+{
+    Coroutine *self = qemu_coroutine_self();
+    AioContext *old_ctx = qemu_coroutine_get_aio_context(self);
+    AioContext *new_ctx = bdrv_get_aio_context(bs);
+
+    aio_co_reschedule_self(new_ctx);
+    return old_ctx;
+}
+
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
 {
     aio_co_enter(bdrv_get_aio_context(bs), co);
-- 
2.25.4


