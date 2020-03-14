Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7DC1975A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F152073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F152073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2IA-00080O-QR
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HC-0006cw-IO
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HB-0004Zy-9V
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53344 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jD2HA-0004M1-Tw; Sat, 14 Mar 2020 04:36:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0D3BC9AEFBC28A105EB2;
 Sat, 14 Mar 2020 16:36:03 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Mar 2020 16:35:56 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 4/4] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
Date: Sat, 14 Mar 2020 16:47:30 +0800
Message-ID: <20200314084730.25876-5-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200314084730.25876-1-pannengyuan@huawei.com>
References: <20200314084730.25876-1-pannengyuan@huawei.com>
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent
 Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, euler.robot@huawei.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some memleaks when we call 'device_list_properties'.
This patch move timer_new from init into realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
---
v2->v1:
- no changes in this patch.
v3->v2:
- remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
v4->v3:
- split patch into two, this patch fix the memleaks.
v5->v4:
- No change in this patch. But add [patch 3/4] to fix SEGVs during make check-qtest-ppc64 if apply this patch.
  This patch also depend to another fix [patch 2/4].
---
 hw/misc/mos6522.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 19e154b870..c1cd154a84 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -485,6 +485,11 @@ static void mos6522_init(Object *obj)
     for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
         s->timers[i].index = i;
     }
+}
+
+static void mos6522_realize(DeviceState *dev, Error **errp)
+{
+    MOS6522State *s = MOS6522(dev);
 
     s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
     s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
@@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
 
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
+    dc->realize = mos6522_realize;
     device_class_set_props(dc, mos6522_properties);
     mdc->parent_reset = dc->reset;
     mdc->set_sr_int = mos6522_set_sr_int;
-- 
2.18.2


