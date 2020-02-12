Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F5C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C342073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C342073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1iqM-00054Y-C8
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 22:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j1ipk-0004W7-9y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j1ipj-0008B4-2M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:37:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2760 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j1ipi-00082Z-OP; Tue, 11 Feb 2020 22:37:03 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5118BAA397E7F4F92B6E;
 Wed, 12 Feb 2020 11:36:55 +0800 (CST)
Received: from HGHY4C002233111.china.huawei.com (10.133.205.93) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Feb 2020 11:36:45 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <i.mitsyanko@gmail.com>,
 <peter.maydell@linaro.org>
Subject: [PATCH] hw/char/exynos4210_uart: Fix memleaks in exynos4210_uart_init
Date: Wed, 12 Feb 2020 11:36:41 +0800
Message-ID: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

It's easy to reproduce as follow:
virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties",
"arguments":{"typename":"exynos4210.uart"}}'

ASAN shows memory leak stack:
  #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
  #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:530
  #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
  #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:569
  #5 0xaaad270beee3 in exynos4210_uart_init /qemu/hw/char/exynos4210_uart.c:677
  #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/object.c:516
  #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:684
  #8 0xaaad2755df2f in qmp_device_list_properties /qemu/qom/qom-qmp-cmds.c:152

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
 hw/char/exynos4210_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 25d6588e41..5048db5410 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
-    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                         exynos4210_uart_timeout_int, s);
-    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
-
     /* memory mapping */
     memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
                           "exynos4210.uart", EXYNOS4210_UART_REGS_MEM_SIZE);
@@ -691,6 +687,10 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
 {
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
+    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                         exynos4210_uart_timeout_int, s);
+    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
+
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
                              NULL, s, NULL, true);
-- 
2.23.0



