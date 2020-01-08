Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ABDC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3E3206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3E3206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBeA-00081S-GX
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1ip9ji-0002VB-JW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1ip9jh-0001wL-9q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:42:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2672 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1ip9jW-0001qv-Gd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:42:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D86D518C5FA667C78DE2;
 Wed,  8 Jan 2020 19:42:33 +0800 (CST)
Received: from HGHY4C002233111.china.huawei.com (10.133.205.93) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 19:42:27 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
Subject: [PATCH] vl: fix memory leak in configure_accelerators
Date: Wed, 8 Jan 2020 19:42:07 +0800
Message-ID: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-Mailman-Approved-At: Wed, 08 Jan 2020 08:43:53 -0500
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
Cc: liyiting@huawei.com, Chen Qun <kuhn.chenqun@huawei.com>,
 pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

The accel_list forgot to free, the asan output:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
    #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xffff91413d9b in g_strsplit (/lib64/libglib-2.0.so.0+0x73d9b)
    #3 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
    #4 0xaaab42fb58e7 in main /qemu/vl.c:4121
    #5 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #6 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)

Indirect leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
    #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xffff9141243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
    #3 0xffff91413e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
    #4 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
    #5 0xaaab42fb58e7 in main /qemu/vl.c:4121
    #6 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #7 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b1dab)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 86474a55c9..035a24e52b 100644
--- a/vl.c
+++ b/vl.c
@@ -2788,6 +2788,7 @@ static void configure_accelerators(const char *progname)
                 error_report("invalid accelerator %s", *tmp);
             }
         }
+        g_strfreev(accel_list);
     } else {
         if (accel != NULL) {
             error_report("The -accel and \"-machine accel=\" options are incompatible");
-- 
2.23.0



