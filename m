Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CDC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7277A205CA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/Girx8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7277A205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBA3-000069-Cg
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB88-0006bD-5g
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB7z-0000Nc-E8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOo0HnLkFMclT8v7V/nyO+TaQKMQNXfQwz6FtWWoY/M=;
 b=C/Girx8rYsG7VgdN1TCWvIZCUCekysQmT6P0kMEHbLfPiwfseR1mLTXKNjDqFIK73LQ6wM
 6lAX3izPP3MbkO+hit8lgcUGSgljYkxqMxr5VHqNh7t6PNvpZM7EZynYMLwD5c4pI7sLBI
 rhDPJYGZ1LkeTq1km38mOUE5hktVMpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-j1NACz3UN_idNBo4GxrMlQ-1; Mon, 09 Nov 2020 12:38:47 -0500
X-MC-Unique: j1NACz3UN_idNBo4GxrMlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3231074657;
 Mon,  9 Nov 2020 17:38:46 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F27455C1D0;
 Mon,  9 Nov 2020 17:38:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/15] block: Move bdrv_drain_all_end_quiesce() to block_int.h
Date: Mon,  9 Nov 2020 18:38:26 +0100
Message-Id: <20201109173839.2135984-3-mreitz@redhat.com>
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
References: <20201109173839.2135984-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

This function is really an internal helper for bdrv_close(). Update its
doc comment to make this clear and make the function private.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160387245480.131299.13430357162209598411.stgit@bahia>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     | 6 ------
 include/block/block_int.h | 9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4bfe3b546b..c9d7c58765 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -781,12 +781,6 @@ void bdrv_drained_end(BlockDriverState *bs);
  */
 void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_counter);
 
-/**
- * End all quiescent sections started by bdrv_drain_all_begin(). This is
- * only needed when deleting a BDS before bdrv_drain_all_end() is called.
- */
-void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
-
 /**
  * End a quiescent section started by bdrv_subtree_drained_begin().
  */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c..95d9333be1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1407,4 +1407,13 @@ static inline BlockDriverState *bdrv_primary_bs(BlockDriverState *bs)
     return child_bs(bdrv_primary_child(bs));
 }
 
+/**
+ * End all quiescent sections started by bdrv_drain_all_begin(). This is
+ * needed when deleting a BDS before bdrv_drain_all_end() is called.
+ *
+ * NOTE: this is an internal helper for bdrv_close() *only*. No one else
+ * should call it.
+ */
+void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
+
 #endif /* BLOCK_INT_H */
-- 
2.28.0


