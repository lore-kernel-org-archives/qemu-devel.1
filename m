Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F77C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFB92070E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFB92070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtRkF-0007JH-7m
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jtRjQ-0006rT-Ig
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:16:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3717 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jtRiy-0006Os-8G
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:16:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 55EF5BA132FCBD106A22;
 Thu,  9 Jul 2020 16:16:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Jul 2020
 16:15:53 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH] migration: fix memory leak in qmp_migrate_set_parameters
Date: Thu, 9 Jul 2020 16:28:25 +0800
Message-ID: <1594283305-105724-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:16:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, fangying1@huawei.com, zhukeqian1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Chuan <zhengchuan@huawei.com>

"tmp.tls_hostname" and "tmp.tls_creds" allocated by migrate_params_test_apply()
is forgot to free at the end of qmp_migrate_set_parameters(). Fix that.

The leak stack:
Direct leak of 2 byte(s) in 2 object(s) allocated from:
   #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
   #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
   #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
   #3 0xaaaac52447fb in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1377)
   #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
   #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c:165)
   #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
   #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
   #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
   #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
   #10 0xaaaac55cae0f in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
   #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
   #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
   #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
   #14 0xaaaac47f45ef(/usr/bin/qemu-kvm-4.1.0+0x8455ef)
   #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
   #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)

Direct leak of 2 byte(s) in 2 object(s) allocated from:
   #0 0xffffb597c20b in __interceptor_malloc (/usr/lib64/libasan.so.4+0xd320b)
   #1 0xffffb52dcb1b in g_malloc (/usr/lib64/libglib-2.0.so.0+0x58b1b)
   #2 0xffffb52f8143 in g_strdup (/usr/lib64/libglib-2.0.so.0+0x74143)
   #3 0xaaaac5244893 in migrate_params_test_apply (/usr/src/debug/qemu-4.1.0/migration/migration.c:1382)
   #4 0xaaaac52fdca7 in qmp_migrate_set_parameters (/usr/src/debug/qemu-4.1.0/qapi/qapi-commands-migration.c:192)
   #5 0xaaaac551d543 in qmp_dispatch (/usr/src/debug/qemu-4.1.0/qapi/qmp-dispatch.c)
   #6 0xaaaac52a0a8f in qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:125)
   #7 0xaaaac52a1c7f in monitor_qmp_dispatch (/usr/src/debug/qemu-4.1.0/monitor/qmp.c:214)
   #8 0xaaaac55cb0cf in aio_bh_call (/usr/src/debug/qemu-4.1.0/util/async.c:117)
   #9 0xaaaac55d4543 in aio_bh_poll (/usr/src/debug/qemu-4.1.0/util/aio-posix.c:459)
   #10 0xaaaac55cae0f in in aio_dispatch (/usr/src/debug/qemu-4.1.0/util/async.c:268)
   #11 0xffffb52d6a7b in g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0+0x52a7b)
   #12 0xaaaac55d1e3b(/usr/bin/qemu-kvm-4.1.0+0x1622e3b)
   #13 0xaaaac4e314bb(/usr/bin/qemu-kvm-4.1.0+0xe824bb)
   #14 0xaaaac47f45ef (/usr/bin/qemu-kvm-4.1.0+0x8455ef)
   #15 0xffffb4bfef3f in __libc_start_main (/usr/lib64/libc.so.6+0x23f3f)
   #16 0xaaaac47ffacb(/usr/bin/qemu-kvm-4.1.0+0x850acb)

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: KeQian Zhu <zhukeqian1@huawei.com>
Reviewed-by: HaiLiang <zhang.zhanghailiang@huawei.com@huawei.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 92e44e0..045180c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1342,12 +1342,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
 
     if (params->has_tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = g_strdup(params->tls_creds->u.s);
+        dest->tls_creds = params->tls_creds->u.s;
     }
 
     if (params->has_tls_hostname) {
         assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
+        dest->tls_hostname = params->tls_hostname->u.s;
     }
 
     if (params->has_max_bandwidth) {
-- 
1.8.3.1


