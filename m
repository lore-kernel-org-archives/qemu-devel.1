Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1073C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C90720791
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C90720791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdkH-0005b3-2h
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXh-0005w6-NP
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5241 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXe-0007Ge-MH
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8168DF0A678DFFE6DC66;
 Sat, 17 Oct 2020 12:09:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:41 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 03/18] migration/rdma: create multifd_setup_ops for Tx/Rx
 thread
Date: Sat, 17 Oct 2020 12:25:33 +0800
Message-ID: <1602908748-43335-4-git-send-email-zhengchuan@huawei.com>
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

Create multifd_setup_ops for TxRx thread, no logic change.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/multifd.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 migration/multifd.h |  7 +++++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 68b171f..1f82307 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -383,6 +383,8 @@ struct {
     int exiting;
     /* multifd ops */
     MultiFDMethods *ops;
+    /* multifd setup ops */
+    MultiFDSetup *setup_ops;
 } *multifd_send_state;
 
 /*
@@ -790,8 +792,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
         } else {
             /* update for tls qio channel */
             p->c = ioc;
-            qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                                   QEMU_THREAD_JOINABLE);
+            qemu_thread_create(&p->thread, p->name,
+                               multifd_send_state->setup_ops->send_thread_setup,
+                               p, QEMU_THREAD_JOINABLE);
        }
        return false;
     }
@@ -839,6 +842,11 @@ cleanup:
     multifd_new_send_channel_cleanup(p, sioc, local_err);
 }
 
+static void multifd_send_channel_setup(MultiFDSendParams *p)
+{
+    socket_send_channel_create(multifd_new_send_channel_async, p);
+}
+
 int multifd_save_setup(Error **errp)
 {
     int thread_count;
@@ -856,6 +864,7 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
+    multifd_send_state->setup_ops = multifd_setup_ops_init();
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
 
     for (i = 0; i < thread_count; i++) {
@@ -875,7 +884,7 @@ int multifd_save_setup(Error **errp)
         p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         p->name = g_strdup_printf("multifdsend_%d", i);
         p->tls_hostname = g_strdup(s->hostname);
-        socket_send_channel_create(multifd_new_send_channel_async, p);
+        multifd_send_state->setup_ops->send_channel_setup(p);
     }
 
     for (i = 0; i < thread_count; i++) {
@@ -902,6 +911,8 @@ struct {
     uint64_t packet_num;
     /* multifd ops */
     MultiFDMethods *ops;
+    /* multifd setup ops */
+    MultiFDSetup *setup_ops;
 } *multifd_recv_state;
 
 static void multifd_recv_terminate_threads(Error *err)
@@ -1095,6 +1106,7 @@ int multifd_load_setup(Error **errp)
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     qatomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
+    multifd_recv_state->setup_ops = multifd_setup_ops_init();
     multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
 
     for (i = 0; i < thread_count; i++) {
@@ -1173,9 +1185,31 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+    multifd_recv_state->setup_ops->recv_channel_setup(ioc, p);
+    qemu_thread_create(&p->thread, p->name,
+                       multifd_recv_state->setup_ops->recv_thread_setup,
+                       p, QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
     return qatomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
 }
+
+static void multifd_recv_channel_setup(QIOChannel *ioc, MultiFDRecvParams *p)
+{
+    return;
+}
+
+static MultiFDSetup multifd_socket_ops = {
+    .send_thread_setup = multifd_send_thread,
+    .recv_thread_setup = multifd_recv_thread,
+    .send_channel_setup = multifd_send_channel_setup,
+    .recv_channel_setup = multifd_recv_channel_setup
+};
+
+MultiFDSetup *multifd_setup_ops_init(void)
+{
+    MultiFDSetup *ops;
+
+    ops = &multifd_socket_ops;
+    return ops;
+}
diff --git a/migration/multifd.h b/migration/multifd.h
index 8d6751f..446315b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -166,6 +166,13 @@ typedef struct {
     int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp);
 } MultiFDMethods;
 
+typedef struct {
+    void *(*send_thread_setup)(void *opaque);
+    void *(*recv_thread_setup)(void *opaque);
+    void (*send_channel_setup)(MultiFDSendParams *p);
+    void (*recv_channel_setup)(QIOChannel *ioc, MultiFDRecvParams *p);
+} MultiFDSetup;
+
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
-- 
1.8.3.1


