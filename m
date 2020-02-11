Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE72C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F8320714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F8320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Qwz-0000eD-AQ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j1Qw7-0000CG-2k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j1Qw5-0002SH-GT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:30:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57882 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j1Qw5-00021f-2S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:30:25 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D04F2B3062E6468881E9;
 Tue, 11 Feb 2020 16:30:15 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Feb 2020 16:30:09 +0800
From: <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: [PATCH] migration-test: fix some memleaks in migration-test
Date: Tue, 11 Feb 2020 16:45:57 +0800
Message-ID: <20200211084557.32109-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

spotted by asan, 'check-qtest-aarch64' runs fail if sanitizers is enabled.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 tests/qtest/migration-test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cf27ebbc9d..2bb214c87f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -498,11 +498,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *arch = qtest_get_arch();
     const char *machine_opts = NULL;
     const char *memory_size;
+    int ret = 0;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
             g_test_skip("/dev/shm is not supported");
-            return -1;
+            ret = -1;
+            goto out;
         }
     }
 
@@ -611,8 +613,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         g_free(shmem_path);
     }
 
+out:
     migrate_start_destroy(args);
-    return 0;
+    return ret;
 }
 
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
@@ -1134,6 +1137,8 @@ static void test_validate_uuid(void)
 {
     MigrateStart *args = migrate_start_new();
 
+    g_free(args->opts_source);
+    g_free(args->opts_target);
     args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
     args->opts_target = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
     do_test_validate_uuid(args, false);
@@ -1143,6 +1148,8 @@ static void test_validate_uuid_error(void)
 {
     MigrateStart *args = migrate_start_new();
 
+    g_free(args->opts_source);
+    g_free(args->opts_target);
     args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
     args->opts_target = g_strdup("-uuid 22222222-2222-2222-2222-222222222222");
     args->hide_stderr = true;
@@ -1153,6 +1160,7 @@ static void test_validate_uuid_src_not_set(void)
 {
     MigrateStart *args = migrate_start_new();
 
+    g_free(args->opts_target);
     args->opts_target = g_strdup("-uuid 22222222-2222-2222-2222-222222222222");
     args->hide_stderr = true;
     do_test_validate_uuid(args, false);
@@ -1162,6 +1170,7 @@ static void test_validate_uuid_dst_not_set(void)
 {
     MigrateStart *args = migrate_start_new();
 
+    g_free(args->opts_source);
     args->opts_source = g_strdup("-uuid 11111111-1111-1111-1111-111111111111");
     args->hide_stderr = true;
     do_test_validate_uuid(args, false);
@@ -1379,6 +1388,7 @@ static void test_multifd_tcp_cancel(void)
                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
     qobject_unref(rsp);
 
+    g_free(uri);
     uri = migrate_get_socket_address(to2, "socket-address");
 
     wait_for_migration_status(from, "cancelled", NULL);
-- 
2.18.1


