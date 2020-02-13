Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C66C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5F921739
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5F921739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24gX-00013T-TH
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j24fs-0000Ww-C3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j24fq-0003U6-Mg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:56:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55366 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j24fq-0003Nq-Bj; Wed, 12 Feb 2020 21:56:18 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AFAF19510F785A03DCE3;
 Thu, 13 Feb 2020 10:56:12 +0800 (CST)
Received: from HGHY4C002233111.china.huawei.com (10.133.205.93) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 10:56:06 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <i.mitsyanko@gmail.com>,
 <peter.maydell@linaro.org>
Subject: [PATCH v2] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Date: Thu, 13 Feb 2020 10:56:03 +0800
Message-ID: <20200213025603.149432-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com,
 Chen Qun <kuhn.chenqun@huawei.com>, philmd@redhat.com,
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
Changes V2 to V1:
-Keep s->wordtime in exynos4210_uart_init (Base on Eduardo and Philippe's comments).
---
 hw/char/exynos4210_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 25d6588e41..96d5180e3e 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -674,8 +674,6 @@ static void exynos4210_uart_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
-    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                         exynos4210_uart_timeout_int, s);
     s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
 
     /* memory mapping */
@@ -691,6 +689,9 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
 {
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
+    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                         exynos4210_uart_timeout_int, s);
+
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
                              NULL, s, NULL, true);
-- 
2.23.0



