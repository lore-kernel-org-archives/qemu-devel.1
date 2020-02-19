Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154AFC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0EA20658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0EA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Lid-0001zi-V0
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j4Lhu-0001Nb-R4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j4Lht-0007Mh-GK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:31:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38146 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j4Lht-0007Hj-5a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:31:49 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1F5BABD63FBF78B98F31;
 Wed, 19 Feb 2020 17:31:44 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 19 Feb 2020 17:31:36 +0800
From: <pannengyuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH] migration/savevm: release gslist after dump_vmstate_json
Date: Wed, 19 Feb 2020 17:47:05 +0800
Message-ID: <20200219094705.8960-1-pannengyuan@huawei.com>
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
Cc: zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'list' forgot to free at the end of dump_vmstate_json_to_file(), although it's called only once, but seems like a clean code.

Fix the leak as follow:
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
    #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
    #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
    #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1084
    #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1028
    #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b5f7)
    #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/object.c:1038
    #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/object.c:1092
    #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/migration/savevm.c:638
    #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
    #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
    #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x27f020d)

Indirect leak of 7472 byte(s) in 467 object(s) allocated from:
    #0 0x7fb946abd768 in __interceptor_malloc (/lib64/libasan.so.5+0xef768)
    #1 0x7fb945eca445 in g_malloc (/lib64/libglib-2.0.so.0+0x52445)
    #2 0x7fb945ee2066 in g_slice_alloc (/lib64/libglib-2.0.so.0+0x6a066)
    #3 0x7fb945ee3139 in g_slist_prepend (/lib64/libglib-2.0.so.0+0x6b139)
    #4 0x5585db591581 in object_class_get_list_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1084
    #5 0x5585db590f66 in object_class_foreach_tramp /mnt/sdb/qemu-new/qemu/qom/object.c:1028
    #6 0x7fb945eb35f7 in g_hash_table_foreach (/lib64/libglib-2.0.so.0+0x3b5f7)
    #7 0x5585db59110c in object_class_foreach /mnt/sdb/qemu-new/qemu/qom/object.c:1038
    #8 0x5585db5916b6 in object_class_get_list /mnt/sdb/qemu-new/qemu/qom/object.c:1092
    #9 0x5585db335ca0 in dump_vmstate_json_to_file /mnt/sdb/qemu-new/qemu/migration/savevm.c:638
    #10 0x5585daa5bcbf in main /mnt/sdb/qemu-new/qemu/vl.c:4420
    #11 0x7fb941204812 in __libc_start_main ../csu/libc-start.c:308
    #12 0x5585da29420d in _start (/mnt/sdb/qemu-new/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x27f020d)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index f19cb9ec7a..60e6ea8a8d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -665,6 +665,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
     }
     fprintf(out_file, "\n}\n");
     fclose(out_file);
+    g_slist_free(list);
 }
 
 static uint32_t calculate_new_instance_id(const char *idstr)
-- 
2.18.2


