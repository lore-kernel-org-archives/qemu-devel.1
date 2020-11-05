Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519DC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6062080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6062080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZNc-0008Kb-Qn
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kaZMb-0007rt-7q; Thu, 05 Nov 2020 02:07:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kaZMY-00073W-H2; Thu, 05 Nov 2020 02:07:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CRZMG51p0zhfv6;
 Thu,  5 Nov 2020 15:06:50 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 5 Nov 2020
 15:06:41 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH] hw/intc: fix heap-buffer-overflow in rxicu_realize()
Date: Thu, 5 Nov 2020 15:06:26 +0800
Message-ID: <20201105070626.2277696-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:06:54
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When 'j = icu->nr_sense – 1', the 'j < icu->nr_sense' condition is true,
then 'j = icu->nr_sense', the'icu->init_sense[j]' has out-of-bounds access.
Maybe this could lead to some security problems.

The asan showed stack:
ERROR: AddressSanitizer: heap-buffer-overflow on address 0x604000004d7d at pc 0x55852cd26a76 bp 0x7ffe39f26200 sp 0x7ffe39f261f0
READ of size 1 at 0x604000004d7d thread T0
    #0 0x55852cd26a75 in rxicu_realize ../hw/intc/rx_icu.c:311
    #1 0x55852cf075f7 in device_set_realized ../hw/core/qdev.c:886
    #2 0x55852cd4a32f in property_set_bool ../qom/object.c:2251
    #3 0x55852cd4f9bb in object_property_set ../qom/object.c:1398
    #4 0x55852cd54f3f in object_property_set_qobject ../qom/qom-qobject.c:28
    #5 0x55852cd4fc3f in object_property_set_bool ../qom/object.c:1465
    #6 0x55852cbf0b27 in register_icu ../hw/rx/rx62n.c:156
    #7 0x55852cbf12a6 in rx62n_realize ../hw/rx/rx62n.c:261
    #8 0x55852cf075f7 in device_set_realized ../hw/core/qdev.c:886
    #9 0x55852cd4a32f in property_set_bool ../qom/object.c:2251
    #10 0x55852cd4f9bb in object_property_set ../qom/object.c:1398
    #11 0x55852cd54f3f in object_property_set_qobject ../qom/qom-qobject.c:28
    #12 0x55852cd4fc3f in object_property_set_bool ../qom/object.c:1465
    #13 0x55852cbf1a85 in rx_gdbsim_init ../hw/rx/rx-gdbsim.c:109
    #14 0x55852cd22de0 in qemu_init ../softmmu/vl.c:4380
    #15 0x55852ca57088 in main ../softmmu/main.c:49
    #16 0x7feefafa5d42 in __libc_start_main (/lib64/libc.so.6+0x26d42)

Change the 'j < icu->nr_sense' condition place to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/intc/rx_icu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 94e17a9dea..692a4c78e0 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -308,11 +308,9 @@ static void rxicu_realize(DeviceState *dev, Error **errp)
         return;
     }
     for (i = j = 0; i < NR_IRQS; i++) {
-        if (icu->init_sense[j] == i) {
+        if (j < icu->nr_sense && icu->init_sense[j] == i) {
             icu->src[i].sense = TRG_LEVEL;
-            if (j < icu->nr_sense) {
-                j++;
-            }
+            j++;
         } else {
             icu->src[i].sense = TRG_PEDGE;
         }
-- 
2.27.0


