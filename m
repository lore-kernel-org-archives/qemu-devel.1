Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8E20791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8E20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdgF-0008QR-5i
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXr-0006Db-LD
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5243 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXp-0007Hx-JL
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7B2445C3648B4EC72B5E;
 Sat, 17 Oct 2020 12:09:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:48 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 13/18] migration/rdma: Add the function for dynamic page
 registration
Date: Sat, 17 Oct 2020 12:25:43 +0800
Message-ID: <1602908748-43335-14-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:09:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, fengzhimin1@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 'qemu_rdma_registration' function, multifd send threads
call it to register memory.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/rdma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 1af81f5..a366849 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3738,6 +3738,57 @@ out:
     return ret;
 }
 
+/*
+ * Dynamic page registrations for multifd RDMA threads.
+ */
+static int qemu_rdma_registration(void *opaque)
+{
+    RDMAContext *rdma = opaque;
+    RDMAControlHeader resp = {.type = RDMA_CONTROL_RAM_BLOCKS_RESULT };
+    RDMALocalBlocks *local = &rdma->local_ram_blocks;
+    int reg_result_idx, i, nb_dest_blocks;
+    RDMAControlHeader head = { .len = 0, .repeat = 1 };
+    int ret = 0;
+
+    head.type = RDMA_CONTROL_RAM_BLOCKS_REQUEST;
+
+    ret = qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
+            &reg_result_idx, rdma->pin_all ?
+            qemu_rdma_reg_whole_ram_blocks : NULL);
+    if (ret < 0) {
+        goto out;
+    }
+
+    nb_dest_blocks = resp.len / sizeof(RDMADestBlock);
+
+    if (local->nb_blocks != nb_dest_blocks) {
+        rdma->error_state = -EINVAL;
+        ret = -1;
+        goto out;
+    }
+
+    qemu_rdma_move_header(rdma, reg_result_idx, &resp);
+    memcpy(rdma->dest_blocks,
+           rdma->wr_data[reg_result_idx].control_curr, resp.len);
+
+    for (i = 0; i < nb_dest_blocks; i++) {
+        network_to_dest_block(&rdma->dest_blocks[i]);
+
+        /* We require that the blocks are in the same order */
+        if (rdma->dest_blocks[i].length != local->block[i].length) {
+            rdma->error_state = -EINVAL;
+            ret = -1;
+            goto out;
+        }
+        local->block[i].remote_host_addr =
+            rdma->dest_blocks[i].remote_host_addr;
+        local->block[i].remote_rkey = rdma->dest_blocks[i].remote_rkey;
+    }
+
+out:
+    return ret;
+}
+
 /* Destination:
  * Called via a ram_control_load_hook during the initial RAM load section which
  * lists the RAMBlocks by name.  This lets us know the order of the RAMBlocks
-- 
1.8.3.1


