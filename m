Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F593C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8DD20791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8DD20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTddz-0005qZ-Je
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXk-000618-BT
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36936 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXg-0007I3-Q8
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8252E61335AD4405501E;
 Sat, 17 Oct 2020 12:10:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:51 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 17/18] migration/rdma: send data for both rdma-pin-all and
 NOT rdma-pin-all mode
Date: Sat, 17 Oct 2020 12:25:47 +0800
Message-ID: <1602908748-43335-18-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:10:01
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

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/rdma.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 327f80f..519fa7a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2001,6 +2001,20 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
                                .repeat = 1,
                              };
 
+    /* use multifd to send data */
+    if (migrate_use_multifd()) {
+        int channel = get_multifd_RDMA_channel();
+        int ret = 0;
+        MultiFDSendParams *multifd_send_param = NULL;
+        ret = get_multifd_send_param(channel, &multifd_send_param);
+        if (ret) {
+            error_report("rdma: error getting multifd_send_param(%d)", channel);
+            return -EINVAL;
+        }
+        rdma = (RDMAContext *)multifd_send_param->rdma;
+        block = &(rdma->local_ram_blocks.block[current_index]);
+    }
+
 retry:
     sge.addr = (uintptr_t)(block->local_host_addr +
                             (current_addr - block->offset));
@@ -2196,6 +2210,27 @@ retry:
     return 0;
 }
 
+static int multifd_rdma_write_flush(void)
+{
+    /* The multifd RDMA threads send data */
+    MultiFDSendParams *multifd_send_param = NULL;
+    RDMAContext *rdma = NULL;
+    MigrationState *s = migrate_get_current();
+    int ret = 0;
+
+    ret = get_multifd_send_param(s->rdma_channel,
+                                 &multifd_send_param);
+    if (ret) {
+        error_report("rdma: error getting multifd_send_param(%d)",
+                     s->rdma_channel);
+        return ret;
+    }
+    rdma = (RDMAContext *)(multifd_send_param->rdma);
+    rdma->nb_sent++;
+
+    return ret;
+}
+
 /*
  * Push out any unwritten RDMA operations.
  *
@@ -2218,8 +2253,15 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
     }
 
     if (ret == 0) {
-        rdma->nb_sent++;
-        trace_qemu_rdma_write_flush(rdma->nb_sent);
+        if (migrate_use_multifd()) {
+            ret = multifd_rdma_write_flush();
+            if (ret) {
+                return ret;
+            }
+        } else {
+            rdma->nb_sent++;
+            trace_qemu_rdma_write_flush(rdma->nb_sent);
+        }
     }
 
     rdma->current_length = 0;
@@ -4061,6 +4103,7 @@ wait_reg_complete:
             }
 
             qemu_sem_post(&multifd_send_param->sem_sync);
+            qemu_sem_wait(&multifd_send_param->sem);
         }
     }
 
@@ -4443,6 +4486,7 @@ static void *multifd_rdma_send_thread(void *opaque)
     Error *local_err = NULL;
     int ret = 0;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
+    RDMAContext *rdma = p->rdma;
 
     trace_multifd_send_thread_start(p->id);
     if (multifd_send_initial_packet(p, &local_err) < 0) {
@@ -4451,7 +4495,7 @@ static void *multifd_rdma_send_thread(void *opaque)
 
     /* wait for semaphore notification to register memory */
     qemu_sem_wait(&p->sem_sync);
-    if (qemu_rdma_registration(p->rdma) < 0) {
+    if (qemu_rdma_registration(rdma) < 0) {
         goto out;
     }
     /*
@@ -4467,13 +4511,26 @@ static void *multifd_rdma_send_thread(void *opaque)
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-
+        /* To complete polling(CQE) */
+        while (rdma->nb_sent) {
+            ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
+            if (ret < 0) {
+                error_report("multifd RDMA migration: "
+                             "complete polling error!");
+                return NULL;
+            }
+        }
         /* Send FINISHED to the destination */
         head.type = RDMA_CONTROL_REGISTER_FINISHED;
-        ret = qemu_rdma_exchange_send(p->rdma, &head, NULL, NULL, NULL, NULL);
+        ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL);
         if (ret < 0) {
+            error_report("multifd RDMA migration: "
+                         "sending remote error!");
             return NULL;
         }
+
+        /* sync main thread */
+        qemu_sem_post(&p->sem);
     }
 
 out:
-- 
1.8.3.1


