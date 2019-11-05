Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75906C49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B41D20717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B41D20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv1B-0006Vs-AR
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRusz-00055N-Qy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusy-0007ol-9S
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52082 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007j4-1U; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2C00798C75144E635ABB;
 Tue,  5 Nov 2019 17:12:18 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:08 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 10/14] arm/sdei: add support to register interrupt bind
 notifier
Date: Tue, 5 Nov 2019 17:10:52 +0800
Message-ID: <20191105091056.9541-11-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 James Morse <james.morse@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Other qemu modules related with the interrupt bind operation may want
to be notified when guest requests to bind interrupt to sdei event, so
we add register and unregister interfaces.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/sdei.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sdei.h | 17 +++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/arm/sdei.c b/target/arm/sdei.c
index 529a06c1f6..4cc68e4acf 100644
--- a/target/arm/sdei.c
+++ b/target/arm/sdei.c
@@ -48,6 +48,52 @@
=20
 static QemuSDEState *sde_state;
=20
+typedef struct QemuSDEIBindNotifyEntry {
+    QTAILQ_ENTRY(QemuSDEIBindNotifyEntry) entry;
+    QemuSDEIBindNotify *func;
+    void *opaque;
+    int irq;
+} QemuSDEIBindNotifyEntry;
+
+static QTAILQ_HEAD(, QemuSDEIBindNotifyEntry) bind_notifiers =3D
+    QTAILQ_HEAD_INITIALIZER(bind_notifiers);
+
+void qemu_register_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                      void *opaque, int irq)
+{
+    QemuSDEIBindNotifyEntry *be =3D g_new0(QemuSDEIBindNotifyEntry, 1);
+
+    be->func =3D func;
+    be->opaque =3D opaque;
+    be->irq =3D irq;
+    QTAILQ_INSERT_TAIL(&bind_notifiers, be, entry);
+}
+
+void qemu_unregister_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                        void *opaque, int irq)
+{
+    QemuSDEIBindNotifyEntry *be;
+
+    QTAILQ_FOREACH(be, &bind_notifiers, entry) {
+        if (be->func =3D=3D func && be->opaque =3D=3D opaque && be->irq =
=3D=3D irq) {
+            QTAILQ_REMOVE(&bind_notifiers, be, entry);
+            g_free(be);
+            return;
+        }
+    }
+}
+
+static void sdei_notify_bind(int irq, int32_t event, bool bind)
+{
+    QemuSDEIBindNotifyEntry *be, *nbe;
+
+    QTAILQ_FOREACH_SAFE(be, &bind_notifiers, entry, nbe) {
+        if (be->irq =3D=3D irq) {
+            be->func(be->opaque, irq, event, bind);
+        }
+    }
+}
+
 static void qemu_sde_prop_init(QemuSDEState *s)
 {
     QemuSDEProp *sde_props =3D s->sde_props_state;
@@ -529,6 +575,7 @@ static int32_t sdei_alloc_event_num(QemuSDEState *s, =
bool is_critical,
             sde_props[index].interrupt =3D intid;
             sde_props[index].is_shared =3D is_shared;
             sde_props[index].is_critical =3D is_critical;
+            sdei_notify_bind(intid, event, true);
             override_qemu_irq(s, event, intid);
             s->irq_map[intid] =3D event;
             qemu_mutex_unlock(&sde_props[index].lock);
@@ -547,6 +594,7 @@ static int32_t sdei_free_event_num_locked(QemuSDEStat=
e *s, QemuSDEProp *prop)
         return SDEI_DENIED;
     }
=20
+    sdei_notify_bind(prop->interrupt, prop->event_id, false);
     restore_qemu_irq(s, prop->event_id, prop->interrupt);
     s->irq_map[prop->interrupt] =3D SDEI_INVALID_EVENT_ID;
     prop->event_id =3D SDEI_INVALID_EVENT_ID;
diff --git a/target/arm/sdei.h b/target/arm/sdei.h
index 5ecc32d667..9c15cf3186 100644
--- a/target/arm/sdei.h
+++ b/target/arm/sdei.h
@@ -38,4 +38,21 @@ void sdei_handle_request(CPUState *cs, struct kvm_run =
*run);
  */
 bool trigger_sdei_by_irq(int cpu, int irq);
=20
+/*
+ * Notify callback prototype; the argument "bind" tells whether it is a =
bind
+ * operation or unbind one.
+ */
+typedef void QemuSDEIBindNotify(void *opaque, int irq,
+                                int32_t event, bool bind);
+/*
+ * Register a notify callback for a specific interrupt bind operation; t=
he
+ * client will be both notified by bind and unbind operation.
+ */
+void qemu_register_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                      void *opaque, int irq);
+/*
+ * Unregister a notify callback for a specific interrupt bind operation.
+ */
+void qemu_unregister_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                        void *opaque, int irq);
 #endif
--=20
2.19.1


