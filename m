Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE70C54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DE521473
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DE521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQTX-0005bQ-2N
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 03:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jQQSV-0005Bi-Ld
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:03:12 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jQQSU-0007me-M8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:03:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36580 helo=huawei.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jQQSU-0007cw-22
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:03:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5202F6D268063ED380CD;
 Mon, 20 Apr 2020 15:03:02 +0800 (CST)
Received: from opensource.huawei.com (10.175.104.212) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Apr 2020 15:02:45 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH] migration/rdma: fix a memleak on error path in
 rdma_start_incoming_migration
Date: Mon, 20 Apr 2020 06:27:27 -0400
Message-ID: <20200420102727.17339-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:03:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'rdma->host' is malloced in qemu_rdma_data_init, but forgot to free on the error
path in rdma_start_incoming_migration(), this patch fix that.

The leak stack:
Direct leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7fb7add18ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7fb7ad0df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x7fb7ad0f8b32 in g_strdup (/lib64/libglib-2.0.so.0+0x6cb32)
    #3 0x55a0464a0f6f in qemu_rdma_data_init /mnt/sdb/qemu/migration/rdma.c:2647
    #4 0x55a0464b0e76 in rdma_start_incoming_migration /mnt/sdb/qemu/migration/rdma.c:4020
    #5 0x55a0463f898a in qemu_start_incoming_migration /mnt/sdb/qemu/migration/migration.c:365
    #6 0x55a0458c75d3 in qemu_init /mnt/sdb/qemu/softmmu/vl.c:4438
    #7 0x55a046a3d811 in main /mnt/sdb/qemu/softmmu/main.c:48
    #8 0x7fb7a8417872 in __libc_start_main (/lib64/libc.so.6+0x23872)
    #9 0x55a04536b26d in _start (/mnt/sdb/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x286926d)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 migration/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index f61587891b..967fda5b0c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4056,6 +4056,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     return;
 err:
     error_propagate(errp, local_err);
+    g_free(rdma->host);
     g_free(rdma);
     g_free(rdma_return_path);
 }
-- 
2.18.2


