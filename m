Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C7C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 07:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7005A20730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 07:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7005A20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izErR-0004Oc-LE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 02:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1izEnG-0001Fp-5o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 02:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1izEnE-0000ZW-4b
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 02:08:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58666 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1izEn6-0007jP-7w; Wed, 05 Feb 2020 02:08:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 375FF86DF44D2F0DC405;
 Wed,  5 Feb 2020 15:07:53 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Feb 2020 15:07:45 +0800
From: <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH 3/3] stellaris: delay timer_new to avoid memleaks
Date: Wed, 5 Feb 2020 15:06:59 +0800
Message-ID: <20200205070659.22488-4-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200205070659.22488-1-pannengyuan@huawei.com>
References: <20200205070659.22488-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

There is a memory leak when we call 'device_list_properties' with typenam=
e =3D stellaris-gptm. It's easy to reproduce as follow:

  virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-prope=
rties", "arguments": {"typename": "stellaris-gptm"}}'

This patch delay timer_new in realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: qemu-arm@nongnu.org
---
 hw/arm/stellaris.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index bb025e0bd0..221a78674e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -347,11 +347,15 @@ static void stellaris_gptm_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
=20
     s->opaque[0] =3D s->opaque[1] =3D s;
+}
+
+static void stellaris_gptm_realize(DeviceState *dev, Error **errp)
+{
+    gptm_state *s =3D STELLARIS_GPTM(dev);
     s->timer[0] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opaq=
ue[0]);
     s->timer[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opaq=
ue[1]);
 }
=20
-
 /* System controller.  */
=20
 typedef struct {
@@ -1536,6 +1540,7 @@ static void stellaris_gptm_class_init(ObjectClass *=
klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_stellaris_gptm;
+    dc->realize =3D stellaris_gptm_realize;
 }
=20
 static const TypeInfo stellaris_gptm_info =3D {
--=20
2.21.0.windows.1



