Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BAC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3228A2072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3228A2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3X0O-00071h-Bl
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j3Wz9-0005KG-Qf
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j3Wz8-0003jz-Kl
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:22:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42702 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j3Wz5-0003WL-Ui; Sun, 16 Feb 2020 22:22:12 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 312C0782262440C76FEF;
 Mon, 17 Feb 2020 11:22:03 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Feb 2020 11:21:56 +0800
From: <pannengyuan@huawei.com>
To: <balrogg@gmail.com>, <peter.maydell@linaro.org>,
 <mav2-rk.cave-ayland@ilande.co.uk>, <david@gibson.dropbear.id.au>,
 <edgar.iglesias@gmail.com>, <alistair@alistair23.me>
Subject: [PATCH v2 1/2] s390x: fix memleaks in cpu_finalize
Date: Mon, 17 Feb 2020 11:21:26 +0800
Message-ID: <20200217032127.46508-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200217032127.46508-1-pannengyuan@huawei.com>
References: <20200217032127.46508-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: zhang.zhanghailiang@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, euler.robot@huawei.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x. =
The leak stack is as follow:

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/qe=
mu/timer.h:530
    #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/ti=
mer.h:551
    #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qemu=
/timer.h:569
    #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/s3=
90x/cpu.c:285
    #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/qom=
/object.c:372
    #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/qe=
mu/qom/object.c:516
    #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qom/=
object.c:684
    #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/s3=
90-virtio-ccw.c:64
    #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/mach=
ine-hmp-cmds.c:57
    #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/monit=
or/hmp.c:1082
    #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/qem=
u/monitor/misc.c:142

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Cornelia Huck <cohuck@redhat.com>
---
Changes v2 to v1:
- Similarly to other cleanups, move timer_new into realize, then do
timer_del in unrealize.
---
 target/s390x/cpu.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index cf84d307c6..f18dbc6fe4 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -170,7 +170,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Err=
or **errp)
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(dev);
 #if !defined(CONFIG_USER_ONLY)
     S390CPU *cpu =3D S390_CPU(dev);
+    cpu->env.tod_timer =3D
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
+    cpu->env.cpu_timer =3D
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
 #endif
+
     Error *err =3D NULL;
=20
     /* the model has to be realized before qemu_init_vcpu() due to kvm *=
/
@@ -227,6 +232,16 @@ out:
     error_propagate(errp, err);
 }
=20
+static void s390_cpu_unrealizefn(DeviceState *dev, Error **errp)
+{
+#if !defined(CONFIG_USER_ONLY)
+    S390CPU *cpu =3D S390_CPU(dev);
+
+    timer_del(cpu->env.tod_timer);
+    timer_del(cpu->env.cpu_timer);
+#endif
+}
+
 static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
 {
     GuestPanicInformation *panic_info;
@@ -279,10 +294,6 @@ static void s390_cpu_initfn(Object *obj)
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, N=
ULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
-    cpu->env.tod_timer =3D
-        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
-    cpu->env.cpu_timer =3D
-        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
 }
@@ -294,6 +305,8 @@ static void s390_cpu_finalize(Object *obj)
=20
     qemu_unregister_reset(s390_cpu_machine_reset_cb, cpu);
     g_free(cpu->irqstate);
+    timer_free(cpu->env.tod_timer);
+    timer_free(cpu->env.cpu_timer);
 #endif
 }
=20
@@ -453,6 +466,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
=20
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
+    dc->unrealize =3D s390_cpu_unrealizefn;
     device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable =3D true;
=20
--=20
2.21.0.windows.1



