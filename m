Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81006C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B98206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQYa2M2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B98206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFCo-0006f4-2i
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2S-0002pB-Vw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2R-0007yE-3A
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnckcosW7GZH2xOLXj9yJG8fwnV90NqhQ18Ca83SjjY=;
 b=IQYa2M2gkdJLWRIRcadOdwlb0xGvxkMtDWSCQPKddy8//rdNOXqUZv9BoYxj8lXK45MpNG
 KfODRBPeLCjeS3SDYUyE0i96k1MptjUsMdbnPYns0cvWeFDBM5QPluasmWXAByjIzyQCZy
 d7onboJce8AkFrFlGaQuHubuec1NpgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-mYTQyUFSNt68FH2c77BaAw-1; Mon, 07 Sep 2020 07:10:16 -0400
X-MC-Unique: mYTQyUFSNt68FH2c77BaAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B9C18B9ED2;
 Mon,  7 Sep 2020 11:10:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 554389CBA;
 Mon,  7 Sep 2020 11:10:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/64] block: Add bdrv_supports_compressed_writes()
Date: Mon,  7 Sep 2020 13:08:55 +0200
Message-Id: <20200907110936.261684-24-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Filters cannot compress data themselves but they have to implement
.bdrv_co_pwritev_compressed() still (or they cannot forward compressed
writes).  Therefore, checking whether
bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
know whether the node can actually handle compressed writes.  This
function looks down the filter chain to see whether there is a
non-filter that can actually convert the compressed writes into
compressed data (and thus normal writes).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 2c09b93d07..981ab5b314 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -532,6 +532,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 void bdrv_next_cleanup(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
+bool bdrv_supports_compressed_writes(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/block.c b/block.c
index f5eabaa032..c09a766f54 100644
--- a/block.c
+++ b/block.c
@@ -5065,6 +5065,29 @@ bool bdrv_is_sg(BlockDriverState *bs)
     return bs->sg;
 }
 
+/**
+ * Return whether the given node supports compressed writes.
+ */
+bool bdrv_supports_compressed_writes(BlockDriverState *bs)
+{
+    BlockDriverState *filtered;
+
+    if (!bs->drv || !block_driver_can_compress(bs->drv)) {
+        return false;
+    }
+
+    filtered = bdrv_filter_bs(bs);
+    if (filtered) {
+        /*
+         * Filters can only forward compressed writes, so we have to
+         * check the child.
+         */
+        return bdrv_supports_compressed_writes(filtered);
+    }
+
+    return true;
+}
+
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
-- 
2.25.4


