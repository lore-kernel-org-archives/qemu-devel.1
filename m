Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F59AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C1B223BF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C1B223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZsgx-0007U9-Up
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZsfw-0006yS-66
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:32:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZsfs-0006xH-Vn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:32:23 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQPgq1s1fz722w;
 Tue,  3 Nov 2020 17:32:07 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 17:32:01 +0800
Message-ID: <5FA12391.8090400@huawei.com>
Date: Tue, 3 Nov 2020 17:32:01 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <chenhc@lemote.com>, <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/intc: Fix incorrect calculation of core in liointc_read()
 and liointc_write()
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=alex.chen@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:32:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the loongson spec
(http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
that the ISR size of per CORE is 8, so here we need to divide
(addr - R_PERCORE_ISR(0)) by 8, not 4.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
---
 hw/intc/loongson_liointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index 30fb375b72..fbbfb57ee9 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -130,7 +130,7 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)

     if (addr >= R_PERCORE_ISR(0) &&
         addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        int core = (addr - R_PERCORE_ISR(0)) / 8;
         r = p->per_core_isr[core];
         goto out;
     }
@@ -173,7 +173,7 @@ liointc_write(void *opaque, hwaddr addr,

     if (addr >= R_PERCORE_ISR(0) &&
         addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        int core = (addr - R_PERCORE_ISR(0)) / 8;
         p->per_core_isr[core] = value;
         goto out;
     }
-- 
2.19.1

