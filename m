Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79058C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE8D227BF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE8D227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii75Y-0005WM-E2
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 20:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ii74i-00055R-Bx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ii74f-0002sh-F0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:27:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55692 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ii74d-0002c7-FR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:27:23 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4A2291230EC708B85930;
 Fri, 20 Dec 2019 09:27:13 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 09:27:03 +0800
From: <pannengyuan@huawei.com>
To: <thuth@redhat.com>, <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: [PATCH V2] vhost-user-test: fix a memory leak
Date: Fri, 20 Dec 2019 09:26:54 +0800
Message-ID: <1576805214-2508-1-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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

Spotted by ASAN.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Changes V2 to V1:
- use a "goto cleanup", instead of duplicating the "free" functions.
- free "dest_cmdline" at the end.
---
 tests/vhost-user-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 91ea373..dcb8617 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -717,7 +717,7 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
     guint64 size;
 
     if (!wait_for_fds(s)) {
-        return;
+        goto cleanup;
     }
 
     size = get_log_size(s);
@@ -776,8 +776,11 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
     g_source_unref(source);
 
     qtest_quit(to);
+
+ cleanup:
     test_server_free(dest);
     g_free(uri);
+    g_string_free(dest_cmdline, true);
 }
 
 static void wait_for_rings_started(TestServer *s, size_t count)
-- 
2.7.2.windows.1



