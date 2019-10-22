Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E822084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E822084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxQM-0001ky-LI
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMxBe-00019v-Kw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMxBd-0006ls-5m
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:10 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:43458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMxBc-0006lV-W3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:09 -0400
Received: from player688.ha.ovh.net (unknown [10.108.42.167])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 55A4B765FD
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 18:39:07 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id A544CB32C363;
 Tue, 22 Oct 2019 16:39:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v5 2/7] spapr_cpu_core: Implement DeviceClass::reset
Date: Tue, 22 Oct 2019 18:38:07 +0200
Message-Id: <20191022163812.330-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022163812.330-1-clg@kaod.org>
References: <20191022163812.330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3506896735755406310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.227
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Since vCPUs aren't plugged into a bus, we manually register a reset
handler for each vCPU. We also call this handler at realize time
to ensure hot plugged vCPUs are reset before being exposed to the
guest. This results in vCPUs being reset twice at machine reset.
It doesn't break anything but it is slightly suboptimal and above
all confusing.

The hotplug path in device_set_realized() already knows how to reset
a hotplugged device if the device reset handler is present. Implement
one for sPAPR CPU cores that resets all vCPUs under a core.

While here rename spapr_cpu_reset() to spapr_reset_vcpu() for
consistency with spapr_realize_vcpu() and spapr_unrealize_vcpu().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[clg: add documentation on the reset helper usage ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2b21285d2009..2e34832d0ea2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -25,9 +25,8 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
=20
-static void spapr_cpu_reset(void *opaque)
+static void spapr_reset_vcpu(PowerPCCPU *cpu)
 {
-    PowerPCCPU *cpu =3D opaque;
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
@@ -193,7 +192,6 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Spa=
prCpuCore *sc)
     if (!sc->pre_3_0_migration) {
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
     }
-    qemu_unregister_reset(spapr_cpu_reset, cpu);
     if (spapr_cpu_state(cpu)->icp) {
         object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
     }
@@ -204,12 +202,36 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, S=
paprCpuCore *sc)
     object_unparent(OBJECT(cpu));
 }
=20
+/*
+ * Called when CPUs are hot-plugged.
+ */
+static void spapr_cpu_core_reset(DeviceState *dev)
+{
+    CPUCore *cc =3D CPU_CORE(dev);
+    SpaprCpuCore *sc =3D SPAPR_CPU_CORE(dev);
+    int i;
+
+    for (i =3D 0; i < cc->nr_threads; i++) {
+        spapr_reset_vcpu(sc->threads[i]);
+    }
+}
+
+/*
+ * Called by the machine reset.
+ */
+static void spapr_cpu_core_reset_handler(void *opaque)
+{
+    spapr_cpu_core_reset(opaque);
+}
+
 static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
 {
     SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
     int i;
=20
+    qemu_unregister_reset(spapr_cpu_core_reset_handler, sc);
+
     for (i =3D 0; i < cc->nr_threads; i++) {
         spapr_unrealize_vcpu(sc->threads[i], sc);
     }
@@ -238,12 +260,6 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
         goto error_intc_create;
     }
=20
-    /*
-     * FIXME: Hot-plugged CPUs are not reset. Do it at realize.
-     */
-    qemu_register_reset(spapr_cpu_reset, cpu);
-    spapr_cpu_reset(cpu);
-
     if (!sc->pre_3_0_migration) {
         vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
                          cpu->machine_data);
@@ -338,6 +354,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
             goto err_unrealize;
         }
     }
+
+    qemu_register_reset(spapr_cpu_core_reset_handler, sc);
     return;
=20
 err_unrealize:
@@ -366,6 +384,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc=
, void *data)
=20
     dc->realize =3D spapr_cpu_core_realize;
     dc->unrealize =3D spapr_cpu_core_unrealize;
+    dc->reset =3D spapr_cpu_core_reset;
     dc->props =3D spapr_cpu_core_properties;
     scc->cpu_type =3D data;
 }
--=20
2.21.0


