Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540C4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6EB2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6EB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdZf-0007YX-NB
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXc-0005r7-KO
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5235 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXa-0007CO-74
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 673E8B90808B864C7865;
 Sat, 17 Oct 2020 12:09:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:42 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 04/18] migration/rdma: add multifd_setup_ops for rdma
Date: Sat, 17 Oct 2020 12:25:34 +0800
Message-ID: <1602908748-43335-5-git-send-email-zhengchuan@huawei.com>
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
 migration/multifd.c |  6 ++++
 migration/multifd.h |  4 +++
 migration/rdma.c    | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 1f82307..0d494df 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1210,6 +1210,12 @@ MultiFDSetup *multifd_setup_ops_init(void)
 {
     MultiFDSetup *ops;
 
+#ifdef CONFIG_RDMA
+    if (migrate_use_rdma()) {
+        ops = multifd_rdma_setup();
+        return ops;
+    }
+#endif
     ops = &multifd_socket_ops;
     return ops;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 446315b..62a0b2a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -173,6 +173,10 @@ typedef struct {
     void (*recv_channel_setup)(QIOChannel *ioc, MultiFDRecvParams *p);
 } MultiFDSetup;
 
+#ifdef CONFIG_RDMA
+MultiFDSetup *multifd_rdma_setup(void);
+#endif
+MultiFDSetup *multifd_setup_ops_init(void);
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
diff --git a/migration/rdma.c b/migration/rdma.c
index 0340841..ad4e4ba 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,6 +19,7 @@
 #include "qemu/cutils.h"
 #include "rdma.h"
 #include "migration.h"
+#include "multifd.h"
 #include "qemu-file.h"
 #include "ram.h"
 #include "qemu-file-channel.h"
@@ -4138,3 +4139,84 @@ err:
     g_free(rdma);
     g_free(rdma_return_path);
 }
+
+static void *multifd_rdma_send_thread(void *opaque)
+{
+    MultiFDSendParams *p = opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running = false;
+    qemu_mutex_unlock(&p->mutex);
+
+    return NULL;
+}
+
+static void multifd_rdma_send_channel_setup(MultiFDSendParams *p)
+{
+    Error *local_err = NULL;
+
+    if (p->quit) {
+        error_setg(&local_err, "multifd: send id %d already quit", p->id);
+        return ;
+    }
+    p->running = true;
+
+    qemu_thread_create(&p->thread, p->name, multifd_rdma_send_thread, p,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void *multifd_rdma_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *p = opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem_sync);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running = false;
+    qemu_mutex_unlock(&p->mutex);
+
+    return NULL;
+}
+
+static void multifd_rdma_recv_channel_setup(QIOChannel *ioc,
+                                            MultiFDRecvParams *p)
+{
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+
+    p->file = rioc->file;
+    return;
+}
+
+static MultiFDSetup multifd_rdma_ops = {
+    .send_thread_setup = multifd_rdma_send_thread,
+    .recv_thread_setup = multifd_rdma_recv_thread,
+    .send_channel_setup = multifd_rdma_send_channel_setup,
+    .recv_channel_setup = multifd_rdma_recv_channel_setup
+};
+
+MultiFDSetup *multifd_rdma_setup(void)
+{
+    MultiFDSetup *rdma_ops;
+
+    rdma_ops = &multifd_rdma_ops;
+
+    return rdma_ops;
+}
-- 
1.8.3.1


