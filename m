Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD4C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DDE2465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DDE2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii7Dm-00018q-2N
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 20:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ii7D4-0000kI-SM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ii7D2-0006Qc-IT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:36:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33234 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ii7D1-00065a-TX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:36:04 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 47918FF41C57773CA430;
 Fri, 20 Dec 2019 09:35:58 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 09:35:47 +0800
From: <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <marcandre.lureau@redhat.com>, <armbru@redhat.com>
Subject: [PATCH] util/module: fix a memory leak
Date: Fri, 20 Dec 2019 09:34:10 +0800
Message-ID: <1576805650-16380-1-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

spotted by ASAN

Fixes: 81d8ccb1bea4fb9eaaf4c8e30bd4021180a9a39f
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 util/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/module.c b/util/module.c
index e9fe3e5..8c5315a 100644
--- a/util/module.c
+++ b/util/module.c
@@ -214,6 +214,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
 
     if (!success) {
         g_hash_table_remove(loaded_modules, module_name);
+        g_free(module_name);
     }
 
     for (i = 0; i < n_dirs; i++) {
-- 
2.7.2.windows.1



