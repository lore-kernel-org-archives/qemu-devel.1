Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB246C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF6220691
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF6220691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMZs-00034e-QG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jwMYz-0002dn-Rz
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:21:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42508 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jwMYy-0002sb-09
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:21:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DC41B6A3423E00541CE2;
 Fri, 17 Jul 2020 17:21:38 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 17:21:29 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v1] migration: tls: unref creds after used
Date: Fri, 17 Jul 2020 17:19:43 +0800
Message-ID: <20200717091943.1942-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:21:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: quintela@redhat.com, dgilbert@redhat.com, xiexiangyou@huawei.com,
 yezhenyu2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add the reference of creds in migration_tls_get_creds(),
but there was no place to unref it.  So the OBJECT(creds) will
never be freed and result in memory leak.

Unref the creds after creating the tls-channel server/client.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 migration/tls.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/tls.c b/migration/tls.c
index 5171afc6c4..0740d02976 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -97,7 +97,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
         s->parameters.tls_authz,
         errp);
     if (!tioc) {
-        return;
+        goto cleanup;
     }
 
     trace_migration_tls_incoming_handshake_start();
@@ -107,6 +107,9 @@ void migration_tls_channel_process_incoming(MigrationState *s,
                               NULL,
                               NULL,
                               NULL);
+
+cleanup:
+    object_unref(OBJECT(creds));
 }
 
 
@@ -146,13 +149,13 @@ void migration_tls_channel_connect(MigrationState *s,
     }
     if (!hostname) {
         error_setg(errp, "No hostname available for TLS");
-        return;
+        goto cleanup;
     }
 
     tioc = qio_channel_tls_new_client(
         ioc, creds, hostname, errp);
     if (!tioc) {
-        return;
+        goto cleanup;
     }
 
     trace_migration_tls_outgoing_handshake_start(hostname);
@@ -162,4 +165,7 @@ void migration_tls_channel_connect(MigrationState *s,
                               s,
                               NULL,
                               NULL);
+
+cleanup:
+    object_unref(OBJECT(creds));
 }
-- 
2.19.1



