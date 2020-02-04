Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A949C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE722084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE722084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyncG-0003Kf-Te
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iynbe-0002nQ-SE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iynbd-0007UO-PU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:06:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2754 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iynbb-0006gX-1i; Mon, 03 Feb 2020 21:06:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 01129323CB897F3B19F3;
 Tue,  4 Feb 2020 10:06:17 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 10:06:11 +0800
From: <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH v2] pl031: add finalize function to avoid memleaks
Date: Tue, 4 Feb 2020 10:05:54 +0800
Message-ID: <20200204020554.9380-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-arm@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org
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
Changes V2 to V1:
- Delay the timer_new until realize instead of putting it into instance_i=
nit, since the pl031 can't be hotplugged(suggested by Peter Maydell).
---
 hw/rtc/pl031.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index ae47f09635..0b9253eb30 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -190,7 +190,11 @@ static void pl031_init(Object *obj)
     qemu_get_timedate(&tm, 0);
     s->tick_offset =3D mktimegm(&tm) -
         qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+}
=20
+static void pl031_realize(DeviceState *dev, Error **errp)
+{
+    PL031State *s =3D PL031(dev);
     s->timer =3D timer_new_ns(rtc_clock, pl031_interrupt, s);
 }
=20
@@ -321,6 +325,7 @@ static void pl031_class_init(ObjectClass *klass, void=
 *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_pl031;
+    dc->realize =3D pl031_realize;
     device_class_set_props(dc, pl031_properties);
 }
=20
--=20
2.21.0.windows.1



