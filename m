Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A3ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80192205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B02p8wvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80192205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYZD-0000NI-QN
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKW-0004rM-Fc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKU-0005EP-II
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36839 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKU-00057Y-4L; Thu, 24 Oct 2019 04:18:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrZ65kqz9sS6; Thu, 24 Oct 2019 19:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905118;
 bh=I+w0vyc2IGs0peaw/UV5O//pvuGcu05DaH5gofGUyMY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B02p8wvinxdeLiQMq9Kd7Vsm/W2hBJVeyME6fFK59ADNps9tca8Fsf2Ew8FxeN4vW
 L6ep32Yr4FGrlCSfRSYVREh5oBecCWAnZOx5xwgxupTTm6YQGfxjXgN2PmG5l4H6zZ
 w4CbicVU0kma9xo1K3AL+iL4leO2TpLN3eTJHQTs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 23/28] spapr_cpu_core: Implement DeviceClass::reset
Date: Thu, 24 Oct 2019 19:18:08 +1100
Message-Id: <20191024081813.2115-24-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Message-Id: <20191022163812.330-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2b21285d20..2e34832d0e 100644
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


