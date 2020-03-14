Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B3C5ACBF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B456120751
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B456120751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2IA-000819-Sd
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HC-0006cv-7v
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HA-0004Xp-Si
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3722 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jD2HA-0003wo-GT; Sat, 14 Mar 2020 04:36:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EBE393BC5AB3469B3A53;
 Sat, 14 Mar 2020 16:35:57 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Mar 2020 16:35:51 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 1/4] s390x: fix memleaks in cpu_finalize
Date: Sat, 14 Mar 2020 16:47:27 +0800
Message-ID: <20200314084730.25876-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200314084730.25876-1-pannengyuan@huawei.com>
References: <20200314084730.25876-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-s390x@nongnu.org,
 euler.robot@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org
---
v2->v1:
- Similarly to other cleanups, move timer_new into realize(Suggested by P=
hilippe Mathieu-Daud=C3=A9)
v3->v2:
- Also do the timer_free in unrealize, it seems balanced.
v4->v3:
- Also do timer_free on the error path in realize() and fix some coding s=
tyle.
- Use device_class_set_parent_unrealize to declare unrealize.
v5->v4:
- remove timer_del on the error path of realize(), it's redundant. (Sugge=
sted by David Hildenbrand)
- Simply use errp instead a temporary variable. (Suggested by David Hilde=
nbrand)
---
 target/s390x/cpu-qom.h |  1 +
 target/s390x/cpu.c     | 30 ++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index dbe5346ec9..af9ffed0d8 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -61,6 +61,7 @@ typedef struct S390CPUClass {
     const char *desc;
=20
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
     void (*reset)(CPUState *cpu, cpu_reset_type type);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index cf84d307c6..8ce38bf399 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -182,6 +182,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Err=
or **errp)
 #if !defined(CONFIG_USER_ONLY)
     MachineState *ms =3D MACHINE(qdev_get_machine());
     unsigned int max_cpus =3D ms->smp.max_cpus;
+
+    cpu->env.tod_timer =3D
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
+    cpu->env.cpu_timer =3D
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
+
     if (cpu->env.core_id >=3D max_cpus) {
         error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
                    ", maximum core-id: %d", cpu->env.core_id,
@@ -224,9 +230,27 @@ static void s390_cpu_realizefn(DeviceState *dev, Err=
or **errp)
=20
     scc->parent_realize(dev, &err);
 out:
+    timer_free(cpu->env.tod_timer);
+    timer_free(cpu->env.cpu_timer);
     error_propagate(errp, err);
 }
=20
+static void s390_cpu_unrealizefn(DeviceState *dev, Error **errp)
+{
+    S390CPUClass *scc =3D S390_CPU_GET_CLASS(dev);
+
+#if !defined(CONFIG_USER_ONLY)
+    S390CPU *cpu =3D S390_CPU(dev);
+
+    timer_del(cpu->env.tod_timer);
+    timer_del(cpu->env.cpu_timer);
+    timer_free(cpu->env.tod_timer);
+    timer_free(cpu->env.cpu_timer);
+#endif
+
+    scc->parent_unrealize(dev, errp);
+}
+
 static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
 {
     GuestPanicInformation *panic_info;
@@ -279,10 +303,6 @@ static void s390_cpu_initfn(Object *obj)
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
@@ -453,6 +473,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
=20
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
+    device_class_set_parent_unrealize(dc, s390_cpu_unrealizefn,
+                                      &scc->parent_unrealize);
     device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable =3D true;
=20
--=20
2.18.2


