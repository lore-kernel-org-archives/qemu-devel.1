Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D784FC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A392C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A392C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWSp-0002iP-SA
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iyWSG-0001xW-A1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iyWSF-0007ZS-8y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:47:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2693 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iyWSC-0007Ss-Qe; Mon, 03 Feb 2020 02:47:33 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0003527C3EF67B893E43;
 Mon,  3 Feb 2020 15:47:27 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Feb 2020 15:47:21 +0800
From: <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH] pl031: add finalize function to avoid memleaks
Date: Mon, 3 Feb 2020 15:47:18 +0800
Message-ID: <20200203074718.37252-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, xuding42@huawei.com, qemu-arm@nongnu.org,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

There is a memory leak when we call 'device_list_properties' with
typename =3D pl031. It's easy to reproduce as follow:

  virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-prope=
rties", "arguments": {"typename": "pl031"}}'

The memory leak stack:
  Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f6e0925a970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7f6e06f4d49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x564a0f7654ea in timer_new_full /mnt/sdb/qemu/include/qemu/timer.=
h:530
    #3 0x564a0f76555d in timer_new /mnt/sdb/qemu/include/qemu/timer.h:551
    #4 0x564a0f765589 in timer_new_ns /mnt/sdb/qemu/include/qemu/timer.h:=
569
    #5 0x564a0f76747d in pl031_init /mnt/sdb/qemu/hw/rtc/pl031.c:198
    #6 0x564a0fd4a19d in object_init_with_type /mnt/sdb/qemu/qom/object.c=
:360
    #7 0x564a0fd4b166 in object_initialize_with_type /mnt/sdb/qemu/qom/ob=
ject.c:467
    #8 0x564a0fd4c8e6 in object_new_with_type /mnt/sdb/qemu/qom/object.c:=
636
    #9 0x564a0fd4c98e in object_new /mnt/sdb/qemu/qom/object.c:646
    #10 0x564a0fc69d43 in qmp_device_list_properties /mnt/sdb/qemu/qom/qo=
m-qmp-cmds.c:204
    #11 0x564a0ef18e64 in qdev_device_help /mnt/sdb/qemu/qdev-monitor.c:2=
78

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/rtc/pl031.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index ae47f09635..50664ca000 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -194,6 +194,15 @@ static void pl031_init(Object *obj)
     s->timer =3D timer_new_ns(rtc_clock, pl031_interrupt, s);
 }
=20
+static void pl031_finalize(Object *obj)
+{
+    PL031State *s =3D PL031(obj);
+    if (s->timer) {
+        timer_del(s->timer);
+        timer_free(s->timer);
+    }
+}
+
 static int pl031_pre_save(void *opaque)
 {
     PL031State *s =3D opaque;
@@ -329,6 +338,7 @@ static const TypeInfo pl031_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(PL031State),
     .instance_init =3D pl031_init,
+    .instance_finalize =3D pl031_finalize,
     .class_init    =3D pl031_class_init,
 };
=20
--=20
2.21.0.windows.1



