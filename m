Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AA92087E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AA92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzfG-0006Xe-GV
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRzcP-0003TE-KR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:20:10 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:27523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kRzcO-0005RY-5S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:20:09 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-DCzTBWaDMiqRoqgyrY5Gpg-1; Mon, 12 Oct 2020 11:20:03 -0400
X-MC-Unique: DCzTBWaDMiqRoqgyrY5Gpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B5451074658;
 Mon, 12 Oct 2020 15:20:02 +0000 (UTC)
Received: from bahia.lan (ovpn-112-78.ams2.redhat.com [10.36.112.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2FE55760;
 Mon, 12 Oct 2020 15:20:01 +0000 (UTC)
Subject: [PATCH 3/4] spapr: Introduce an .instance_finalize hook for
 TYPE_SPAPR_CPU_CORE
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Oct 2020 17:20:00 +0200
Message-ID: <160251600084.796881.16652598027548391459.stgit@bahia.lan>
In-Reply-To: <160251562222.796881.8197386060416409319.stgit@bahia.lan>
References: <160251562222.796881.8197386060416409319.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 11:19:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The array of vCPUs and each individual vCPU under the core can be freed
in several locations. This is suboptimal and increases the odds of memory
leaks in future changes.

Actually they can be freed altogether when the core itself is ultimately
freed in a finalize hook. Initialize the array with zeroes so that the
finalize hook can be made idempotent.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 64ce6a0cb781..cffd74f542ba 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -197,7 +197,6 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Spapr=
CpuCore *sc)
     }
     spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
     cpu_remove_sync(CPU(cpu));
-    spapr_delete_vcpu(cpu);
 }
=20
 /*
@@ -233,7 +232,6 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
     for (i =3D 0; i < cc->nr_threads; i++) {
         spapr_unrealize_vcpu(sc->threads[i], sc);
     }
-    g_free(sc->threads);
 }
=20
 static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -320,11 +318,11 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
         return;
     }
=20
-    sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
+    sc->threads =3D g_new0(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
         sc->threads[i] =3D spapr_create_vcpu(sc, i, errp);
         if (!sc->threads[i]) {
-            goto err;
+            return;
         }
     }
=20
@@ -341,11 +339,6 @@ err_unrealize:
     while (--j >=3D 0) {
         spapr_unrealize_vcpu(sc->threads[j], sc);
     }
-err:
-    while (--i >=3D 0) {
-        spapr_delete_vcpu(sc->threads[i]);
-    }
-    g_free(sc->threads);
 }
=20
 static Property spapr_cpu_core_properties[] =3D {
@@ -367,6 +360,20 @@ static void spapr_cpu_core_class_init(ObjectClass *oc,=
 void *data)
     scc->cpu_type =3D data;
 }
=20
+static void spapr_cpu_core_instance_finalize(Object *obj)
+{
+    SpaprCpuCore *sc =3D SPAPR_CPU_CORE(obj);
+    CPUCore *cc =3D CPU_CORE(sc);
+    int i;
+
+    for (i =3D 0; i < cc->nr_threads; i++) {
+        if (sc->threads[i]) {
+            spapr_delete_vcpu(sc->threads[i]);
+        }
+    }
+    g_free(sc->threads);
+}
+
 #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
     {                                                   \
         .parent =3D TYPE_SPAPR_CPU_CORE,                  \
@@ -382,6 +389,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D {
         .abstract =3D true,
         .instance_size =3D sizeof(SpaprCpuCore),
         .class_size =3D sizeof(SpaprCpuCoreClass),
+        .instance_finalize =3D spapr_cpu_core_instance_finalize,
     },
     DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),



