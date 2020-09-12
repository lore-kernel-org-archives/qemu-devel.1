Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85453C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2278721548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2278721548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH2kL-00071M-5w
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 06:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kH2jK-0005Gw-GT
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:26:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4738 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kH2jG-00083g-Hy
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:26:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id ACDCB9359B7E162DBA38;
 Sat, 12 Sep 2020 18:25:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 18:25:40 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v2 2/6] migration/tls: extract migration_tls_client_create for
 common-use
Date: Sat, 12 Sep 2020 18:36:15 +0800
Message-ID: <1599906979-17240-3-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599906979-17240-1-git-send-email-zhengchuan@huawei.com>
References: <1599906979-17240-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 06:25:47
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

migration_tls_client_create will be used in multifd-tls, let's
extract it.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/tls.c | 26 ++++++++++++++++++--------
 migration/tls.h |  6 ++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/migration/tls.c b/migration/tls.c
index 7a02ec8..186be8a 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -22,7 +22,6 @@
 #include "channel.h"
 #include "migration.h"
 #include "tls.h"
-#include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -125,11 +124,10 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
     object_unref(OBJECT(ioc));
 }
 
-
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
-                                   const char *hostname,
-                                   Error **errp)
+QIOChannelTLS *migration_tls_client_create(MigrationState *s,
+                                           QIOChannel *ioc,
+                                           const char *hostname,
+                                           Error **errp)
 {
     QCryptoTLSCreds *creds;
     QIOChannelTLS *tioc;
@@ -137,7 +135,7 @@ void migration_tls_channel_connect(MigrationState *s,
     creds = migration_tls_get_creds(
         s, QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, errp);
     if (!creds) {
-        return;
+        return NULL;
     }
 
     if (s->parameters.tls_hostname && *s->parameters.tls_hostname) {
@@ -145,11 +143,23 @@ void migration_tls_channel_connect(MigrationState *s,
     }
     if (!hostname) {
         error_setg(errp, "No hostname available for TLS");
-        return;
+        return NULL;
     }
 
     tioc = qio_channel_tls_new_client(
         ioc, creds, hostname, errp);
+
+    return tioc;
+}
+
+void migration_tls_channel_connect(MigrationState *s,
+                                   QIOChannel *ioc,
+                                   const char *hostname,
+                                   Error **errp)
+{
+    QIOChannelTLS *tioc;
+
+    tioc = migration_tls_client_create(s, ioc, hostname, errp);
     if (!tioc) {
         return;
     }
diff --git a/migration/tls.h b/migration/tls.h
index cdd7000..0cfbe36 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -22,11 +22,17 @@
 #define QEMU_MIGRATION_TLS_H
 
 #include "io/channel.h"
+#include "io/channel-tls.h"
 
 void migration_tls_channel_process_incoming(MigrationState *s,
                                             QIOChannel *ioc,
                                             Error **errp);
 
+QIOChannelTLS *migration_tls_client_create(MigrationState *s,
+                                           QIOChannel *ioc,
+                                           const char *hostname,
+                                           Error **errp);
+
 void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
                                    const char *hostname,
-- 
1.8.3.1


