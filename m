Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52112C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D58820725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D58820725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtyE-0001Wr-9C
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWtvl-00053S-Oo
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:44:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3755 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWtvk-0007RS-Pn
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:44:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 00EF447EA034DFFC1136;
 Fri,  8 May 2020 11:44:04 +0800 (CST)
Received: from opensource.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 11:43:54 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 2/2] migration/rdma: cleanup rdma context before g_free to
 avoid memleaks
Date: Fri, 8 May 2020 06:07:55 -0400
Message-ID: <20200508100755.7875-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200508100755.7875-1-pannengyuan@huawei.com>
References: <20200508100755.7875-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 22:13:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When error happen in initializing 'rdma_return_path', we should cleanup rdma context
before g_free(rdma) to avoid some memleaks. This patch fix that.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 migration/rdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 72e8b1c95b..ec45d33ba3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4094,20 +4094,20 @@ void rdma_start_outgoing_migration(void *opaque,
         rdma_return_path = qemu_rdma_data_init(host_port, errp);
 
         if (rdma_return_path == NULL) {
-            goto err;
+            goto return_path_err;
         }
 
         ret = qemu_rdma_source_init(rdma_return_path,
             s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp);
 
         if (ret) {
-            goto err;
+            goto return_path_err;
         }
 
         ret = qemu_rdma_connect(rdma_return_path, errp);
 
         if (ret) {
-            goto err;
+            goto return_path_err;
         }
 
         rdma->return_path = rdma_return_path;
@@ -4120,6 +4120,8 @@ void rdma_start_outgoing_migration(void *opaque,
     s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
     migrate_fd_connect(s, NULL);
     return;
+return_path_err:
+    qemu_rdma_cleanup(rdma);
 err:
     g_free(rdma);
     g_free(rdma_return_path);
-- 
2.18.2


