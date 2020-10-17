Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4DCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8398207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8398207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTde2-0005vX-1H
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXu-0006Gg-8P
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5248 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXs-0007Iy-4e
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 87BF5CC55B61983A2968;
 Sat, 17 Oct 2020 12:09:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:46 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 10/18] migration/rdma: Create the multifd recv channels for
 RDMA
Date: Sat, 17 Oct 2020 12:25:40 +0800
Message-ID: <1602908748-43335-11-git-send-email-zhengchuan@huawei.com>
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

We still don't transmit anything through them, and we only build
the RDMA connections.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/rdma.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2baa933..63559f1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3266,6 +3266,40 @@ static void rdma_cm_poll_handler(void *opaque)
     }
 }
 
+static bool qemu_rdma_accept_setup(RDMAContext *rdma)
+{
+    RDMAContext *multifd_rdma = NULL;
+    int thread_count;
+    int i;
+    MultiFDRecvParams *multifd_recv_param;
+    thread_count = migrate_multifd_channels();
+    /* create the multifd channels for RDMA */
+    for (i = 0; i < thread_count; i++) {
+        if (get_multifd_recv_param(i, &multifd_recv_param) < 0) {
+            error_report("rdma: error getting multifd_recv_param(%d)", i);
+            return false;
+        }
+
+        multifd_rdma = (RDMAContext *) multifd_recv_param->rdma;
+        if (multifd_rdma->cm_id == NULL) {
+            break;
+        } else {
+            multifd_rdma = NULL;
+        }
+    }
+
+    if (multifd_rdma) {
+        qemu_set_fd_handler(rdma->channel->fd,
+                            rdma_accept_incoming_migration,
+                            NULL, (void *)(intptr_t)multifd_rdma);
+    } else {
+        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
+                            NULL, rdma);
+    }
+
+    return true;
+}
+
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
     RDMACapabilities cap;
@@ -3365,6 +3399,10 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
+    } else if (migrate_use_multifd()) {
+        if (!qemu_rdma_accept_setup(rdma)) {
+            goto err_rdma_dest_wait;
+        }
     } else {
         qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
                             NULL, rdma);
@@ -3975,6 +4013,35 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
     return rioc->file;
 }
 
+static void migration_rdma_process_incoming(QEMUFile *f,
+                                            RDMAContext *rdma, Error **errp)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    QIOChannel *ioc = NULL;
+    bool start_migration = false;
+
+    /* FIXME: Need refactor */
+    if (!migrate_use_multifd()) {
+        rdma->migration_started_on_destination = 1;
+        migration_fd_process_incoming(f, errp);
+        return;
+    }
+
+    if (!mis->from_src_file) {
+        mis->from_src_file = f;
+        qemu_file_set_blocking(f, false);
+    } else {
+        ioc = QIO_CHANNEL(getQIOChannel(f));
+        /* Multiple connections */
+        assert(migrate_use_multifd());
+        start_migration = multifd_recv_new_channel(ioc, errp);
+    }
+
+    if (start_migration) {
+        migration_incoming_process();
+    }
+}
+
 static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma = opaque;
@@ -4003,8 +4070,7 @@ static void rdma_accept_incoming_migration(void *opaque)
         return;
     }
 
-    rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f, &local_err);
+    migration_rdma_process_incoming(f, rdma, &local_err);
     if (local_err) {
         error_reportf_err(local_err, "RDMA ERROR:");
     }
-- 
1.8.3.1


