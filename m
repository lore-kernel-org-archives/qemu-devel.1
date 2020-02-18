Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C135C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DA820659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DA820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yyG-00030f-Hb
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j3yxN-0001RO-HV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j3yxM-0000u5-IF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:14:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43358 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j3yxM-0000s1-7D; Tue, 18 Feb 2020 04:14:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0727F7A2547525B3808B;
 Tue, 18 Feb 2020 17:14:08 +0800 (CST)
Received: from HGHY4C002233111.china.huawei.com (10.133.205.93) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Feb 2020 17:14:00 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <jcmvbkbc@gmail.com>,
 <crwulff@gmail.com>, <marex@denx.de>, <edgar.iglesias@gmail.com>,
 <david@gibson.dropbear.id.au>
Subject: [PATCH 2/3] hw/ppc/virtex_ml507:fix leak of fdevice tree blob
Date: Tue, 18 Feb 2020 17:11:53 +0800
Message-ID: <20200218091154.21696-3-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
References: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, pannengyuan@huawei.com,
 zhang.zhanghailiang@huawei.com, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

The device tree blob returned by load_device_tree is malloced.
We should free it after cpu_physical_memory_write().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
 hw/ppc/virtex_ml507.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 91dd00ee91..4eef70069f 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -188,6 +188,7 @@ static int xilinx_load_device_tree(hwaddr addr,
     if (r < 0)
         fprintf(stderr, "couldn't set /chosen/bootargs\n");
     cpu_physical_memory_write(addr, fdt, fdt_size);
+    g_free(fdt);
     return fdt_size;
 }
 
-- 
2.23.0



