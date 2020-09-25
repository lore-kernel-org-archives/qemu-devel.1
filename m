Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42162086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7BK30se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42162086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmiT-0001Yb-Gj
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWT-0003oi-GC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWN-0004J7-Ml
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJcE2eKX4MSRYIivfXLil9oVYKvuM5PqU9DzpHd1rCw=;
 b=L7BK30seZc45QSS/OKR9xPVoCKm15DKBalk4M0E9i1RBJFUURa7hPShxx4Oy/SzYYtBOPF
 xvk7nJevZBj5ZrhhfUwxsgV4ymFD8wKX2+ZRpKaqTDmgdk/ZRbvuTadmG4ggNLd67E3suE
 M+wBvPxrthqTasoWabGJk+1d2rgyW4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-mWJxMNN1O9qRroVteRP5DQ-1; Fri, 25 Sep 2020 08:08:11 -0400
X-MC-Unique: mWJxMNN1O9qRroVteRP5DQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3301805EE4;
 Fri, 25 Sep 2020 12:08:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7912773693;
 Fri, 25 Sep 2020 12:08:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 18/26] migration/tls: extract migration_tls_client_create for
 common-use
Date: Fri, 25 Sep 2020 13:06:47 +0100
Message-Id: <20200925120655.295142-19-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

migration_tls_client_create will be used in multifd-tls, let's
extract it.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <1600139042-104593-3-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/tls.c | 26 ++++++++++++++++++--------
 migration/tls.h |  6 ++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/migration/tls.c b/migration/tls.c
index 8fbf9ac796..66c6f43221 100644
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
index cdd70001ed..0cfbe368ba 100644
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
2.26.2


