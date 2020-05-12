Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E3C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC1F206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVLR58fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC1F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWAT-00057f-LR
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8r-0003OJ-Oe
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:44:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYW8r-00043O-2z
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589294659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVhphe42YboNI73ipReJhHsUFh2j7kanYA6+hAjilN0=;
 b=iVLR58fRc5tcuhafTZb0yUrFFqIlHQntvZ0PQkOj1oNvluDle5zKqZ8NdnIvLvX3fLLwuQ
 iZVOhvSm0t0qXB7Z6avFQFKqR3lTzE4Im8AG2ytirNG2DzcR+vCvKot5rgb/QqsTEHYaxm
 G8utmX6EeN6TFwHsR4k5f/2fy5vqfI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Q_5XCfcnOte1G7TsRcnwwg-1; Tue, 12 May 2020 10:44:17 -0400
X-MC-Unique: Q_5XCfcnOte1G7TsRcnwwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F77F88CE47;
 Tue, 12 May 2020 14:44:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3995D9DD;
 Tue, 12 May 2020 14:44:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 3/3] block: Assert we're running in the right thread
Date: Tue, 12 May 2020 16:43:18 +0200
Message-Id: <20200512144318.181049-4-kwolf@redhat.com>
In-Reply-To: <20200512144318.181049-1-kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tracked_request_begin() is called for most I/O operations, so it's a
good place to assert that we're indeed running in the home thread of the
node's AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 7808e8bdc0..924bf5ba46 100644
--- a/block/io.c
+++ b/block/io.c
@@ -695,14 +695,17 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
                                   uint64_t bytes,
                                   enum BdrvTrackedRequestType type)
 {
+    Coroutine *self = qemu_coroutine_self();
+
     assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
+    assert(bs->aio_context == qemu_coroutine_get_aio_context(self));
 
     *req = (BdrvTrackedRequest){
         .bs = bs,
         .offset         = offset,
         .bytes          = bytes,
         .type           = type,
-        .co             = qemu_coroutine_self(),
+        .co             = self,
         .serialising    = false,
         .overlap_offset = offset,
         .overlap_bytes  = bytes,
-- 
2.25.3


