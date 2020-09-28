Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C91C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC952206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FeDB7fn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC952206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMvxO-0005gp-RQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kMvwP-00058d-8i; Mon, 28 Sep 2020 12:23:53 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kMvwN-00075N-0S; Mon, 28 Sep 2020 12:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=IoaT5jp+b0vzUhfQ6esOGTbBoedlkbWQPeidq+Vn7/c=; 
 b=FeDB7fn22s2nO3etf6YzO1o6G/FF8NhOHvluREPEpXSV8I1F0XspvLaOz4n15nE2JiBE0ro5bBRxsvMYluyvfNtwSzoGk615is1kpXRJ4eG+jYRpU6WsZlpLULAyxbxo9zDsUKH2NqoHTVsrN37nbhfUWZ+g/cVcDNUebTTSe3VSKXixTyrj6BetQYm4YxaLmIVIe0K7fNJ5iVYI5oBW8zxFcJRQSVD4bqPcGkU84E4ogmAF1f3WeGreDZCN/8/qsczZYzgM22gztJFKukcV1jOhKxMg0JqWHGBUHrgPuO9n2Ft4o3y94p5vjO4eEA+8rKdyEHfAZovVV+h7nYhPQA==;
Received: from [81.0.34.134] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kMvwK-00035E-5t; Mon, 28 Sep 2020 18:23:48 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kMvw7-0003vL-46; Mon, 28 Sep 2020 18:23:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Use L1E_SIZE in qcow2_write_l1_entry()
Date: Mon, 28 Sep 2020 18:23:33 +0200
Message-Id: <20200928162333.14998-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 11:34:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We overlooked these in 02b1ecfa100e7ecc2306560cd27a4a2622bfeb04

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 9acc6ce4ae..aa87d3e99b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -240,14 +240,14 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
     }
 
     ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L1,
-            s->l1_table_offset + 8 * l1_start_index, bufsize, false);
+            s->l1_table_offset + L1E_SIZE * l1_start_index, bufsize, false);
     if (ret < 0) {
         return ret;
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_L1_UPDATE);
     ret = bdrv_pwrite_sync(bs->file,
-                           s->l1_table_offset + 8 * l1_start_index,
+                           s->l1_table_offset + L1E_SIZE * l1_start_index,
                            buf, bufsize);
     if (ret < 0) {
         return ret;
-- 
2.20.1


