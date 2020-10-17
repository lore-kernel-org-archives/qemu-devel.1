Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29999C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACEB2076C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACEB2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdbZ-0002lY-M7
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXh-0005wQ-Sr
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5244 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXf-0007Hy-I0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7619A73645F7C5433B5A;
 Sat, 17 Oct 2020 12:09:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:49 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 14/18] migration/rdma: register memory for multifd RDMA
 channels
Date: Sat, 17 Oct 2020 12:25:44 +0800
Message-ID: <1602908748-43335-15-git-send-email-zhengchuan@huawei.com>
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

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/multifd.c |  3 ++
 migration/rdma.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9439b3c..c4d90ef 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -534,6 +534,9 @@ void multifd_send_terminate_threads(Error *err)
         qemu_mutex_lock(&p->mutex);
         p->quit = true;
         qemu_sem_post(&p->sem);
+        if (migrate_use_rdma()) {
+            qemu_sem_post(&p->sem_sync);
+        }
         qemu_mutex_unlock(&p->mutex);
     }
 }
diff --git a/migration/rdma.c b/migration/rdma.c
index a366849..3210e6e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3837,6 +3837,19 @@ static int rdma_load_hook(QEMUFile *f, void *opaque, uint64_t flags, void *data)
         return rdma_block_notification_handle(opaque, data);
 
     case RAM_CONTROL_HOOK:
+        if (migrate_use_multifd()) {
+            int i;
+            MultiFDRecvParams *multifd_recv_param = NULL;
+            int thread_count = migrate_multifd_channels();
+            /* Inform dest recv_thread to poll */
+            for (i = 0; i < thread_count; i++) {
+                if (get_multifd_recv_param(i, &multifd_recv_param)) {
+                    return -1;
+                }
+                qemu_sem_post(&multifd_recv_param->sem_sync);
+            }
+        }
+
         return qemu_rdma_registration_handle(f, opaque);
 
     default:
@@ -3909,6 +3922,24 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
         head.type = RDMA_CONTROL_RAM_BLOCKS_REQUEST;
         trace_qemu_rdma_registration_stop_ram();
 
+        if (migrate_use_multifd()) {
+            /*
+             * Inform the multifd channels to register memory
+             */
+            int i;
+            int thread_count = migrate_multifd_channels();
+            MultiFDSendParams *multifd_send_param = NULL;
+            for (i = 0; i < thread_count; i++) {
+                ret = get_multifd_send_param(i, &multifd_send_param);
+                if (ret) {
+                    error_report("rdma: error getting multifd(%d)", i);
+                    return ret;
+                }
+
+                qemu_sem_post(&multifd_send_param->sem_sync);
+            }
+        }
+
         /*
          * Make sure that we parallelize the pinning on both sides.
          * For very large guests, doing this serially takes a really
@@ -3967,6 +3998,21 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                     rdma->dest_blocks[i].remote_host_addr;
             local->block[i].remote_rkey = rdma->dest_blocks[i].remote_rkey;
         }
+        /* Wait for all multifd channels to complete registration */
+        if (migrate_use_multifd()) {
+            int i;
+            int thread_count = migrate_multifd_channels();
+            MultiFDSendParams *multifd_send_param = NULL;
+            for (i = 0; i < thread_count; i++) {
+                ret = get_multifd_send_param(i, &multifd_send_param);
+                if (ret) {
+                    error_report("rdma: error getting multifd(%d)", i);
+                    return ret;
+                }
+
+                qemu_sem_wait(&multifd_send_param->sem);
+            }
+        }
     }
 
     trace_qemu_rdma_registration_stop(flags);
@@ -3978,6 +4024,24 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
         goto err;
     }
 
+    if (migrate_use_multifd()) {
+        /*
+         * Inform src send_thread to send FINISHED signal.
+         * Wait for multifd RDMA send threads to poll the CQE.
+         */
+        int i;
+        int thread_count = migrate_multifd_channels();
+        MultiFDSendParams *multifd_send_param = NULL;
+        for (i = 0; i < thread_count; i++) {
+            ret = get_multifd_send_param(i, &multifd_send_param);
+            if (ret < 0) {
+                goto err;
+            }
+
+            qemu_sem_post(&multifd_send_param->sem_sync);
+        }
+    }
+
     return 0;
 err:
     rdma->error_state = ret;
@@ -4355,20 +4419,39 @@ static void *multifd_rdma_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     Error *local_err = NULL;
+    int ret = 0;
+    RDMAControlHeader head = { .len = 0, .repeat = 1 };
 
     trace_multifd_send_thread_start(p->id);
     if (multifd_send_initial_packet(p, &local_err) < 0) {
         goto out;
     }
 
+    /* wait for semaphore notification to register memory */
+    qemu_sem_wait(&p->sem_sync);
+    if (qemu_rdma_registration(p->rdma) < 0) {
+        goto out;
+    }
+    /*
+     * Inform the main RDMA thread to run when multifd
+     * RDMA thread have completed registration.
+     */
+    qemu_sem_post(&p->sem);
     while (true) {
+        qemu_sem_wait(&p->sem_sync);
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+
+        /* Send FINISHED to the destination */
+        head.type = RDMA_CONTROL_REGISTER_FINISHED;
+        ret = qemu_rdma_exchange_send(p->rdma, &head, NULL, NULL, NULL, NULL);
+        if (ret < 0) {
+            return NULL;
+        }
     }
 
 out:
@@ -4406,15 +4489,22 @@ static void multifd_rdma_send_channel_setup(MultiFDSendParams *p)
 static void *multifd_rdma_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
+    int ret = 0;
 
     while (true) {
+        qemu_sem_wait(&p->sem_sync);
+
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem_sync);
+        ret = qemu_rdma_registration_handle(p->file, p->c);
+        if (ret < 0) {
+            qemu_file_set_error(p->file, ret);
+            break;
+        }
     }
 
     qemu_mutex_lock(&p->mutex);
-- 
1.8.3.1


