Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08840C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A1520791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A1520791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTde1-0005tu-DF
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXg-0005t0-4T
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5238 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXe-0007CU-9D
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7393A80C7702E1FEBCA2;
 Sat, 17 Oct 2020 12:09:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:45 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 09/18] migration/rdma: add multifd_rdma_load_setup() to
 setup multifd rdma
Date: Sat, 17 Oct 2020 12:25:39 +0800
Message-ID: <1602908748-43335-10-git-send-email-zhengchuan@huawei.com>
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

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/rdma.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index ad4e4ba..2baa933 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4010,6 +4010,48 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 }
 
+static bool multifd_rdma_load_setup(const char *host_port,
+                                    RDMAContext *rdma, Error **errp)
+{
+    int thread_count;
+    int i;
+    int idx;
+    MultiFDRecvParams *multifd_recv_param;
+    RDMAContext *multifd_rdma;
+
+    if (!migrate_use_multifd()) {
+        return true;
+    }
+
+    if (multifd_load_setup(errp) != 0) {
+        /*
+         * We haven't been able to create multifd threads
+         * nothing better to do
+         */
+        return false;
+    }
+
+    thread_count = migrate_multifd_channels();
+    for (i = 0; i < thread_count; i++) {
+        if (get_multifd_recv_param(i, &multifd_recv_param) < 0) {
+            ERROR(errp, "rdma: error getting multifd_recv_param(%d)", i);
+            return false;
+        }
+
+        multifd_rdma = qemu_rdma_data_init(host_port, errp);
+        for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
+            multifd_rdma->wr_data[idx].control_len = 0;
+            multifd_rdma->wr_data[idx].control_curr = NULL;
+        }
+        /* the CM channel and CM id is shared */
+        multifd_rdma->channel = rdma->channel;
+        multifd_rdma->listen_id = rdma->listen_id;
+        multifd_recv_param->rdma = (void *)multifd_rdma;
+    }
+
+    return true;
+}
+
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
@@ -4057,6 +4099,16 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
         qemu_rdma_return_path_dest_init(rdma_return_path, rdma);
     }
 
+    /* multifd rdma setup */
+    if (!multifd_rdma_load_setup(host_port, rdma, &local_err)) {
+        /*
+         * We haven't been able to create multifd threads
+         * nothing better to do
+         */
+        error_report_err(local_err);
+        goto err;
+    }
+
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
     return;
-- 
1.8.3.1


