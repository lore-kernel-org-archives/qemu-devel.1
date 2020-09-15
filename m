Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EBCC2BBD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E246720897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E246720897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI18n-00048K-2d
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI15l-0007tF-W9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:53:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55548 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kI15k-0003Xz-7N
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:53:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 340456D7D04F4E59C54F;
 Tue, 15 Sep 2020 10:53:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 10:52:59 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v4 5/6] migration/tls: add support for multifd tls-handshake
Date: Tue, 15 Sep 2020 11:04:01 +0800
Message-ID: <1600139042-104593-6-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
References: <1600139042-104593-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 21:28:41
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, yuxiating@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar like migration main thread, we need to do handshake
for each multifd thread.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/multifd.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 24c468a..3325c66 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -20,6 +20,7 @@
 #include "ram.h"
 #include "migration.h"
 #include "socket.h"
+#include "tls.h"
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
@@ -719,6 +720,77 @@ out:
     return NULL;
 }
 
+static bool multifd_channel_connect(MultiFDSendParams *p,
+                                    QIOChannel *ioc,
+                                    Error *error);
+
+static void multifd_tls_outgoing_handshake(QIOTask *task,
+                                           gpointer opaque)
+{
+    MultiFDSendParams *p = opaque;
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *err = NULL;
+
+    qio_task_propagate_error(task, &err);
+    multifd_channel_connect(p, ioc, err);
+}
+
+static void multifd_tls_channel_connect(MultiFDSendParams *p,
+                                        QIOChannel *ioc,
+                                        Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    const char *hostname = p->tls_hostname;
+    QIOChannelTLS *tioc;
+
+    tioc = migration_tls_client_create(s, ioc, hostname, errp);
+    if (!tioc) {
+        return;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
+    qio_channel_tls_handshake(tioc,
+                              multifd_tls_outgoing_handshake,
+                              p,
+                              NULL,
+                              NULL);
+
+}
+
+static bool multifd_channel_connect(MultiFDSendParams *p,
+                                    QIOChannel *ioc,
+                                    Error *error)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (!error) {
+        if (s->parameters.tls_creds &&
+            *s->parameters.tls_creds &&
+            !object_dynamic_cast(OBJECT(ioc),
+                                 TYPE_QIO_CHANNEL_TLS)) {
+            multifd_tls_channel_connect(p, ioc, &error);
+            if (!error) {
+                /*
+                 * tls_channel_connect will call back to this
+                 * function after the TLS handshake,
+                 * so we mustn't call multifd_send_thread until then
+                 */
+                return false;
+            } else {
+                return true;
+            }
+        } else {
+            /* update for tls qio channel */
+            p->c = ioc;
+            qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                                   QEMU_THREAD_JOINABLE);
+       }
+       return false;
+    }
+
+    return true;
+}
+
 static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
@@ -749,8 +821,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+        if (multifd_channel_connect(p, sioc, local_err)) {
+            goto cleanup;
+        }
         return;
     }
 
-- 
1.8.3.1


