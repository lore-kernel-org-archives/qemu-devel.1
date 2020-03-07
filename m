Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C37C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23C82067C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23C82067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAPak-0000KG-Up
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 21:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jAPa3-0008MZ-13
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jAPa1-0006jq-Oo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:52:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3187 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jAPa1-0006W4-EK; Fri, 06 Mar 2020 21:52:45 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C605DD1FDEB630085179;
 Sat,  7 Mar 2020 10:52:38 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sat, 7 Mar 2020 10:52:32 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] core/qdev: fix memleak in qdev_get_gpio_out_connector()
Date: Sat, 7 Mar 2020 11:07:56 +0800
Message-ID: <20200307030756.5913-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, euler.robot@huawei.com,
 pbonzini@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a memory leak in qdev_get_gpio_out_connector().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3937d1eb1a..85f062def7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -557,7 +557,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
 
 qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
 {
-    char *propname = g_strdup_printf("%s[%d]",
+    g_autofree char *propname = g_strdup_printf("%s[%d]",
                                      name ? name : "unnamed-gpio-out", n);
 
     qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
-- 
2.18.2


