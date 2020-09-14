Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116B720771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116B720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnne-0000bT-2u
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHni5-00078o-UT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHni2-0000pT-G0
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:52 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-RztJe6czPCCMT3mXO8w4Xw-1; Mon, 14 Sep 2020 08:35:36 -0400
X-MC-Unique: RztJe6czPCCMT3mXO8w4Xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE7E1021D22;
 Mon, 14 Sep 2020 12:35:34 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF8B1002393;
 Mon, 14 Sep 2020 12:35:33 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] spapr: Simplify error handling in
 spapr_cpu_core_realize()
Date: Mon, 14 Sep 2020 14:35:01 +0200
Message-Id: <20200914123505.612812-12-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", add a bool return value to
spapr_realize_vcpu() and use it in spapr_cpu_core_realize()
in order to get rid of the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0c879d4da262..b03620823adb 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -227,14 +227,14 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
)
     g_free(sc->threads);
 }
=20
-static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
+static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                SpaprCpuCore *sc, Error **errp)
 {
     CPUPPCState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
=20
     if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
-        return;
+        return false;
     }
=20
     /* Set time-base frequency to 512 MHz */
@@ -245,13 +245,14 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
=20
     if (spapr_irq_cpu_intc_create(spapr, cpu, errp) < 0) {
         cpu_remove_sync(CPU(cpu));
-        return;
+        return false;
     }
=20
     if (!sc->pre_3_0_migration) {
         vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
                          cpu->machine_data);
     }
+    return true;
 }
=20
 static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp=
)
@@ -312,7 +313,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Er=
ror **errp)
                                                   TYPE_SPAPR_MACHINE);
     SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
-    Error *local_err =3D NULL;
     int i, j;
=20
     if (!spapr) {
@@ -322,15 +322,14 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
=20
     sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
-        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
-        if (local_err) {
+        sc->threads[i] =3D spapr_create_vcpu(sc, i, errp);
+        if (!sc->threads[i]) {
             goto err;
         }
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        spapr_realize_vcpu(sc->threads[j], spapr, sc, &local_err);
-        if (local_err) {
+        if (!spapr_realize_vcpu(sc->threads[j], spapr, sc, errp)) {
             goto err_unrealize;
         }
     }
@@ -347,7 +346,6 @@ err:
         spapr_delete_vcpu(sc->threads[i], sc);
     }
     g_free(sc->threads);
-    error_propagate(errp, local_err);
 }
=20
 static Property spapr_cpu_core_properties[] =3D {
--=20
2.26.2


