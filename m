Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25300C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C7320734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHTYmViX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C7320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jityH-0008MM-2b
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMc-0005ci-Bh
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMI-0003wL-5J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+wiQMvEgwUWDH06/STJQUIBGPu2Tgfa4O82C44aUW0=;
 b=bHTYmViX4Pj44Wv161r7A7KGWZuz+gAf6UOuON1pZtYm8FpBF844GIfPyUeXWz/JxhG8Hq
 OD64jXG08rdU+S9AEFrCsnqKR/SJl12HeHhyIPKrP/TBGDcUPIS1hSUuwIro8u5SBjbMfp
 u5AAclvopuRShII1j0VximeqiVTBjKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-oFEYnQW3PfCPsoPFsDXJnA-1; Wed, 10 Jun 2020 01:32:59 -0400
X-MC-Unique: oFEYnQW3PfCPsoPFsDXJnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF84B107ACCD;
 Wed, 10 Jun 2020 05:32:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D56B619D61;
 Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D54A113848E; Wed, 10 Jun 2020 07:32:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 56/58] qdev: Convert bus-less devices to
 qdev_realize() with Coccinelle
Date: Wed, 10 Jun 2020 07:32:45 +0200
Message-Id: <20200610053247.1583243-57-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All remaining conversions to qdev_realize() are for bus-less devices.
Coccinelle script:

    // only correct for bus-less @dev!

    @@
    expression errp;
    expression dev;
    @@
    -    qdev_init_nofail(dev);
    +    qdev_realize(dev, NULL, &error_fatal);

    @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
    expression errp;
    expression dev;
    symbol true;
    @@
    -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
    +    qdev_realize(DEVICE(dev), NULL, errp);

    @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
    expression errp;
    expression dev;
    symbol true;
    @@
    -    object_property_set_bool(dev, true, "realized", errp);
    +    qdev_realize(DEVICE(dev), NULL, errp);

Note that Coccinelle chokes on ARMSSE typedef vs. macro in
hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
the spatch run.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/allwinner-a10.c                   |  2 +-
 hw/arm/allwinner-h3.c                    |  2 +-
 hw/arm/armsse.c                          | 20 ++++++---------
 hw/arm/armv7m.c                          |  2 +-
 hw/arm/aspeed.c                          |  3 +--
 hw/arm/aspeed_ast2600.c                  |  2 +-
 hw/arm/aspeed_soc.c                      |  2 +-
 hw/arm/bcm2836.c                         |  3 +--
 hw/arm/cubieboard.c                      |  2 +-
 hw/arm/digic.c                           |  2 +-
 hw/arm/digic_boards.c                    |  2 +-
 hw/arm/exynos4210.c                      |  4 +--
 hw/arm/fsl-imx25.c                       |  2 +-
 hw/arm/fsl-imx31.c                       |  2 +-
 hw/arm/fsl-imx6.c                        |  2 +-
 hw/arm/fsl-imx6ul.c                      |  3 +--
 hw/arm/fsl-imx7.c                        |  2 +-
 hw/arm/highbank.c                        |  2 +-
 hw/arm/imx25_pdk.c                       |  2 +-
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/kzm.c                             |  2 +-
 hw/arm/mcimx6ul-evk.c                    |  2 +-
 hw/arm/mcimx7d-sabre.c                   |  2 +-
 hw/arm/mps2-tz.c                         |  9 +++----
 hw/arm/mps2.c                            |  7 +++---
 hw/arm/musca.c                           |  6 ++---
 hw/arm/orangepi.c                        |  2 +-
 hw/arm/raspi.c                           |  2 +-
 hw/arm/realview.c                        |  2 +-
 hw/arm/sabrelite.c                       |  2 +-
 hw/arm/sbsa-ref.c                        |  2 +-
 hw/arm/stm32f205_soc.c                   |  2 +-
 hw/arm/stm32f405_soc.c                   |  2 +-
 hw/arm/versatilepb.c                     |  2 +-
 hw/arm/vexpress.c                        |  2 +-
 hw/arm/virt.c                            |  2 +-
 hw/arm/xilinx_zynq.c                     |  2 +-
 hw/arm/xlnx-versal.c                     |  2 +-
 hw/arm/xlnx-zcu102.c                     |  2 +-
 hw/arm/xlnx-zynqmp.c                     | 10 +++-----
 hw/block/nand.c                          |  2 +-
 hw/char/serial-isa.c                     |  2 +-
 hw/char/serial-pci-multi.c               |  2 +-
 hw/char/serial-pci.c                     |  2 +-
 hw/char/serial.c                         |  4 +--
 hw/core/cpu.c                            |  2 +-
 hw/hyperv/hyperv.c                       |  2 +-
 hw/i386/x86.c                            |  2 +-
 hw/ide/microdrive.c                      |  3 ++-
 hw/intc/pnv_xive.c                       |  4 +--
 hw/intc/spapr_xive.c                     |  4 +--
 hw/intc/xics.c                           |  2 +-
 hw/intc/xive.c                           |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  4 +--
 hw/pci-host/pnv_phb3.c                   |  6 ++---
 hw/pci-host/pnv_phb4.c                   |  2 +-
 hw/pci-host/pnv_phb4_pec.c               |  2 +-
 hw/pci-host/prep.c                       |  3 +--
 hw/ppc/pnv.c                             | 32 ++++++++++--------------
 hw/ppc/pnv_bmc.c                         |  2 +-
 hw/ppc/pnv_core.c                        |  2 +-
 hw/ppc/pnv_psi.c                         |  4 +--
 hw/ppc/spapr.c                           |  5 ++--
 hw/ppc/spapr_cpu_core.c                  |  2 +-
 hw/ppc/spapr_drc.c                       |  2 +-
 hw/ppc/spapr_iommu.c                     |  2 +-
 hw/ppc/spapr_irq.c                       |  2 +-
 hw/riscv/opentitan.c                     |  3 +--
 hw/riscv/riscv_hart.c                    |  3 +--
 hw/riscv/sifive_e.c                      |  3 +--
 hw/riscv/sifive_u.c                      |  9 +++----
 hw/s390x/s390-skeys.c                    |  2 +-
 hw/s390x/s390-stattrib.c                 |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  4 +--
 hw/s390x/sclp.c                          |  2 +-
 hw/s390x/tod.c                           |  2 +-
 target/i386/cpu.c                        |  3 +--
 tests/test-qdev-global-props.c           |  9 ++++---
 80 files changed, 124 insertions(+), 152 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index e05099c757..52e0d83760 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -74,7 +74,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sysbusdev;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 91d22640e4..8e09468e86 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -250,7 +250,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el2", true);
 
         /* Mark realized */
-        qdev_init_nofail(DEVICE(&s->cpus[i]));
+        qdev_realize(DEVICE(&s->cpus[i]), NULL, &error_fatal);
     }
 
     /* Generic Interrupt Controller */
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 8abe1307a9..9ddde339ec 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -584,8 +584,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * CPU must exist and have been parented into the cluster before
          * the cluster is realized.
          */
-        object_property_set_bool(OBJECT(&s->cluster[i]),
-                                 true, "realized", &err);
+        qdev_realize(DEVICE(&s->cluster[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -621,7 +620,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                     error_propagate(errp, err);
                     return;
                 }
-                object_property_set_bool(splitter, true, "realized", &err);
+                qdev_realize(DEVICE(splitter), NULL, &err);
                 if (err) {
                     error_propagate(errp, err);
                     return;
@@ -677,8 +676,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->sec_resp_splitter), true,
-                             "realized", &err);
+    qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -729,8 +727,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->mpc_irq_orgate), true,
-                             "realized", &err);
+    qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -889,8 +886,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->ppc_irq_orgate), true,
-                             "realized", &err);
+    qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1065,7 +1061,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(&s->nmi_orgate), true, "realized", &err);
+    qdev_realize(DEVICE(&s->nmi_orgate), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1113,7 +1109,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(splitter, true, "realized", &err);
+        qdev_realize(DEVICE(splitter), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -1160,7 +1156,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_bool(OBJECT(splitter), true, "realized", &err);
+        qdev_realize(DEVICE(splitter), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 5cdd0b9b51..ce83586e03 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -216,7 +216,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(s->cpu), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c548d24621..ee346b27c8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -302,8 +302,7 @@ static void aspeed_machine_init(MachineState *machine)
         object_property_set_int(OBJECT(&bmc->soc), ASPEED_SCU_PROT_KEY,
                                 "hw-prot-key", &error_abort);
     }
-    object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
-                             &error_abort);
+    qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
 
     memory_region_add_subregion(get_system_memory(),
                                 sc->memmap[ASPEED_SDRAM],
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index d465743247..6da687299f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -259,7 +259,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
          * is needed when using -kernel
          */
 
-        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
+        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index d1e48b7a5d..810cf9b6cc 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -230,7 +230,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
-        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
+        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 39a63f2565..ed1793f7b7 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -133,8 +133,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        object_property_set_bool(OBJECT(&s->cpu[n].core), true,
-                                 "realized", &err);
+        qdev_realize(DEVICE(&s->cpu[n].core), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 4bc4f08caf..a96c860575 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -80,7 +80,7 @@ static void cubieboard_init(MachineState *machine)
         exit(1);
     }
 
-    object_property_set_bool(OBJECT(a10), true, "realized", &err);
+    qdev_realize(DEVICE(a10), NULL, &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't realize Allwinner A10: ");
         exit(1);
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 13acd2cf6e..13a83f7430 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -62,7 +62,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 518a63e61d..b6452d918c 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -62,7 +62,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
         exit(EXIT_FAILURE);
     }
 
-    object_property_set_bool(OBJECT(s), true, "realized", &err);
+    qdev_realize(DEVICE(s), NULL, &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't realize DIGIC SoC: ");
         exit(1);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 2afeb73776..b888a5c9ab 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -190,7 +190,7 @@ static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
 
     object_property_set_int(OBJECT(orgate), nevents + 1, "num-lines",
                             &error_abort);
-    object_property_set_bool(OBJECT(orgate), true, "realized", &error_abort);
+    qdev_realize(DEVICE(orgate), NULL, &error_abort);
 
     for (i = 0; i < nevents + 1; i++) {
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(DEVICE(orgate), i));
@@ -223,7 +223,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                                 "mp-affinity", &error_abort);
         object_property_set_int(cpuobj, EXYNOS4210_SMP_PRIVATE_BASE_ADDR,
                                 "reset-cbar", &error_abort);
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
     }
 
     /*** IRQs ***/
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index d2c4970074..fb516bdbac 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -85,7 +85,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 08236c3230..42cca529c3 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -66,7 +66,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 33b1be4000..17593485b7 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -130,7 +130,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
+        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 72142cc2b6..f8c564033e 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -168,8 +168,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->cpu), QEMU_PSCI_CONDUIT_SMC,
                             "psci-conduit", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true,
-                             "realized", &error_abort);
+    qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
 
     /*
      * A7MPCORE
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index aa7051307d..ca8b5cc358 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -174,7 +174,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        object_property_set_bool(o, true, "realized", &error_abort);
+        qdev_realize(DEVICE(o), NULL, &error_abort);
     }
 
     /*
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 7f279d7f93..c7ef48ecde 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -280,7 +280,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
             object_property_set_int(cpuobj, MPCORE_PERIPHBASE,
                                     "reset-cbar", &error_abort);
         }
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
         cpu_fiq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ);
         cpu_virq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VIRQ);
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 69b95711e4..af8f7f969c 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -75,7 +75,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index a55d2c31e3..b11a846355 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -607,7 +607,7 @@ static void integratorcp_init(MachineState *machine)
         object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
     }
 
-    object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+    qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
 
     cpu = ARM_CPU(cpuobj);
 
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 0275d63079..e3f7d4ead2 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -73,7 +73,7 @@ static void kzm_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX31);
 
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)) {
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 769fe6d802..3d1d2e3c04 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -40,7 +40,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
 
     s = FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
                                 machine->ram);
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 645ad5470f..365f8183bc 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -42,7 +42,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
 
     s = FSL_IMX7(object_new(TYPE_FSL_IMX7));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
                                 machine->ram);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a2b20fff37..8155c35418 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -414,8 +414,7 @@ static void mps2tz_common_init(MachineState *machine)
 
             object_property_set_int(OBJECT(splitter), 2, "num-lines",
                                     &error_fatal);
-            object_property_set_bool(OBJECT(splitter), true, "realized",
-                                     &error_fatal);
+            qdev_realize(DEVICE(splitter), NULL, &error_fatal);
             qdev_connect_gpio_out(DEVICE(splitter), 0,
                                   qdev_get_gpio_in_named(DEVICE(&mms->iotkit),
                                                          "EXP_IRQ", i));
@@ -433,8 +432,7 @@ static void mps2tz_common_init(MachineState *machine)
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc) + ARRAY_SIZE(mms->msc),
                             "num-lines", &error_fatal);
-    object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
-                             "realized", &error_fatal);
+    qdev_realize(DEVICE(&mms->sec_resp_splitter), NULL, &error_fatal);
     dev_splitter = DEVICE(&mms->sec_resp_splitter);
     qdev_connect_gpio_out_named(iotkitdev, "sec_resp_cfg", 0,
                                 qdev_get_gpio_in(dev_splitter, 0));
@@ -466,8 +464,7 @@ static void mps2tz_common_init(MachineState *machine)
                             &mms->uart_irq_orgate, TYPE_OR_IRQ);
     object_property_set_int(OBJECT(&mms->uart_irq_orgate), 10, "num-lines",
                             &error_fatal);
-    object_property_set_bool(OBJECT(&mms->uart_irq_orgate), true,
-                             "realized", &error_fatal);
+    qdev_realize(DEVICE(&mms->uart_irq_orgate), NULL, &error_fatal);
     qdev_connect_gpio_out(DEVICE(&mms->uart_irq_orgate), 0,
                           get_sse_irq_in(mms, 15));
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 735f44c7a3..daa55f730b 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -229,7 +229,7 @@ static void mps2_common_init(MachineState *machine)
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, 6, "num-lines", &error_fatal);
-        object_property_set_bool(orgate, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
 
@@ -266,7 +266,7 @@ static void mps2_common_init(MachineState *machine)
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, 10, "num-lines", &error_fatal);
-        object_property_set_bool(orgate, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
 
@@ -281,8 +281,7 @@ static void mps2_common_init(MachineState *machine)
 
             txrx_orgate = object_new(TYPE_OR_IRQ);
             object_property_set_int(txrx_orgate, 2, "num-lines", &error_fatal);
-            object_property_set_bool(txrx_orgate, true, "realized",
-                                     &error_fatal);
+            qdev_realize(DEVICE(txrx_orgate), NULL, &error_fatal);
             txrx_orgate_dev = DEVICE(txrx_orgate);
             qdev_connect_gpio_out(txrx_orgate_dev, 0,
                                   qdev_get_gpio_in(armv7m, uart_txrx_irqno[i]));
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index d74042356d..34376328fc 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -405,8 +405,7 @@ static void musca_init(MachineState *machine)
 
         object_property_set_int(OBJECT(splitter), 2, "num-lines",
                                 &error_fatal);
-        object_property_set_bool(OBJECT(splitter), true, "realized",
-                                 &error_fatal);
+        qdev_realize(DEVICE(splitter), NULL, &error_fatal);
         qdev_connect_gpio_out(DEVICE(splitter), 0,
                               qdev_get_gpio_in_named(ssedev, "EXP_IRQ", i));
         qdev_connect_gpio_out(DEVICE(splitter), 1,
@@ -425,8 +424,7 @@ static void musca_init(MachineState *machine)
 
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc), "num-lines", &error_fatal);
-    object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
-                             "realized", &error_fatal);
+    qdev_realize(DEVICE(&mms->sec_resp_splitter), NULL, &error_fatal);
     dev_splitter = DEVICE(&mms->sec_resp_splitter);
     qdev_connect_gpio_out_named(ssedev, "sec_resp_cfg", 0,
                                 qdev_get_gpio_in(dev_splitter, 0));
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 44a333a6eb..678c93033e 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -86,7 +86,7 @@ static void orangepi_init(MachineState *machine)
                             &error_abort);
 
     /* Mark H3 object realized */
-    object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
+    qdev_realize(DEVICE(h3), NULL, &error_abort);
 
     /* Retrieve SD bus */
     di = drive_get_next(IF_SD);
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 78cb995251..380978fc27 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -287,7 +287,7 @@ static void raspi_machine_init(MachineState *machine)
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine->ram));
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* Create and plug in the SD cards */
     di = drive_get_next(IF_SD);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index aee7989037..f3c00fe00c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -114,7 +114,7 @@ static void realview_init(MachineState *machine,
                                     &error_fatal);
         }
 
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
 
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
     }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 33d731549d..a27e5baf60 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -51,7 +51,7 @@ static void sabrelite_init(MachineState *machine)
 
     s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 3fd3536796..e40c868a82 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -680,7 +680,7 @@ static void sbsa_ref_init(MachineState *machine)
         object_property_set_link(cpuobj, OBJECT(secure_sysmem),
                                  "secure-memory", &error_abort);
 
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index e2c3479702..19487544f0 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -155,7 +155,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
-    object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", &err);
+    qdev_realize(DEVICE(s->adc_irqs), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9f7838a4a3..c12d9f999d 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -173,7 +173,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
-    object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
+    qdev_realize(DEVICE(&s->adc_irqs), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 29e3bc6bd0..2ebdcbd8ac 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -215,7 +215,7 @@ static void versatile_init(MachineState *machine, int board_id)
         object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
     }
 
-    object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+    qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
 
     cpu = ARM_CPU(cpuobj);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index bebb0ed5a4..7ca5d523a4 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -229,7 +229,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
             object_property_set_int(cpuobj, periphbase,
                                     "reset-cbar", &error_abort);
         }
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
     }
 
     /* Create the private peripheral devices (including the GIC);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c3e80bcbce..caceb1e4a0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1819,7 +1819,7 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
     fdt_add_timer_nodes(vms);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 69d62ee24b..4247c4dbd8 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -202,7 +202,7 @@ static void zynq_init(MachineState *machine)
                             &error_fatal);
     object_property_set_int(OBJECT(cpu), MPCORE_PERIPHBASE, "reset-cbar",
                             &error_fatal);
-    object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
 
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 20f0121ab0..fed9d07ca2 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -47,7 +47,7 @@ static void versal_create_apu_cpus(Versal *s)
                                 "core-count", &error_abort);
         object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
                                  &error_abort);
-        object_property_set_bool(obj, true, "realized", &error_fatal);
+        qdev_realize(DEVICE(obj), NULL, &error_fatal);
     }
 }
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 822e24af65..b920bcee94 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -125,7 +125,7 @@ static void xlnx_zcu102_init(MachineState *machine)
     object_property_set_bool(OBJECT(&s->soc), s->virt, "virtualization",
                              &error_fatal);
 
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     /* Create and plug in the SD cards */
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 446b75a7aa..1de9d4a89d 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -209,15 +209,14 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "realized",
-                                 &err);
+        qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
     }
 
-    qdev_init_nofail(DEVICE(&s->rpu_cluster));
+    qdev_realize(DEVICE(&s->rpu_cluster), NULL, &error_fatal);
 }
 
 static void xlnx_zynqmp_init(Object *obj)
@@ -341,7 +340,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
-    qdev_init_nofail(DEVICE(&s->apu_cluster));
+    qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
     for (i = 0; i < num_apus; i++) {
@@ -368,8 +367,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 "reset-cbar", &error_abort);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
                                 "core-count", &error_abort);
-        object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
-                                 &err);
+        qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/block/nand.c b/hw/block/nand.c
index cdf3429ce6..7e25681d59 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -651,7 +651,7 @@ DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id)
         qdev_prop_set_drive(dev, "drive", blk, &error_fatal);
     }
 
-    qdev_init_nofail(dev);
+    qdev_realize(dev, NULL, &error_fatal);
     return dev;
 }
 
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 7630a874a8..01f9245b9b 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -74,7 +74,7 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     index++;
 
     isa_init_irq(isadev, &s->irq, isa->isairq);
-    object_property_set_bool(OBJECT(s), true, "realized", errp);
+    qdev_realize(DEVICE(s), NULL, errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
     memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 1d65d64c4e..56f915e7c9 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -106,7 +106,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
-        object_property_set_bool(OBJECT(s), true, "realized", &err);
+        qdev_realize(DEVICE(s), NULL, &err);
         if (err != NULL) {
             error_propagate(errp, err);
             multi_serial_pci_exit(dev);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 5f5ff10a75..298f3adba7 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -49,7 +49,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     SerialState *s = &pci->state;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(s), true, "realized", &err);
+    qdev_realize(DEVICE(s), NULL, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4582d488d0..9eebcb27e7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -991,7 +991,7 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
     SerialState *s = &sio->serial;
     Error *local_err = NULL;
 
-    object_property_set_bool(OBJECT(s), true, "realized", &local_err);
+    qdev_realize(DEVICE(s), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1098,7 +1098,7 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
     SerialState *s = &smm->serial;
     Error *local_err = NULL;
 
-    object_property_set_bool(OBJECT(s), true, "realized", &local_err);
+    qdev_realize(DEVICE(s), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index f31ec48ee6..4d5438b70e 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -59,7 +59,7 @@ CPUState *cpu_create(const char *typename)
 {
     Error *err = NULL;
     CPUState *cpu = CPU(object_new(typename));
-    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
+    qdev_realize(DEVICE(cpu), NULL, &err);
     if (err != NULL) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 4b11f7a76b..d527aa823f 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -133,7 +133,7 @@ void hyperv_synic_add(CPUState *cs)
     synic->cs = cs;
     object_property_add_child(OBJECT(cs), "synic", obj);
     object_unref(obj);
-    object_property_set_bool(obj, true, "realized", &error_abort);
+    qdev_realize(DEVICE(obj), NULL, &error_abort);
 }
 
 void hyperv_synic_reset(CPUState *cs)
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 9b6ebd92b5..bb31935f70 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -124,7 +124,7 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
-    object_property_set_bool(cpu, true, "realized", &local_err);
+    qdev_realize(DEVICE(cpu), NULL, &local_err);
 
     object_unref(cpu);
     error_propagate(errp, local_err);
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 6b30e36ed8..c4cc0a84eb 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/pcmcia.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 
@@ -560,7 +561,7 @@ PCMCIACardState *dscm1xxxx_init(DriveInfo *dinfo)
     MicroDriveState *md;
 
     md = MICRODRIVE(object_new(TYPE_DSCM1XXXX));
-    qdev_init_nofail(DEVICE(md));
+    qdev_realize(DEVICE(md), NULL, &error_fatal);
 
     if (dinfo != NULL) {
         ide_create_drive(&md->bus, 0, dinfo);
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 892c78069d..85ba0b4655 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1833,7 +1833,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1843,7 +1843,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 263cd1253c..b7fc8dde7a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -312,7 +312,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -326,7 +326,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
                              &error_abort);
-    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(end_xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d5032c8f8a..d365eeca66 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -384,7 +384,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
     object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    qdev_realize(DEVICE(obj), NULL, &local_err);
     if (local_err) {
         object_unparent(obj);
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8f2b4050cb..2c30dc53d8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -765,7 +765,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
     object_unref(obj);
     object_property_set_link(obj, cpu, "cpu", &error_abort);
     object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    qdev_realize(DEVICE(obj), NULL, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 4d80a691bc..23420028f5 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -91,7 +91,7 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "dcache-writeback",
                              &error_abort);
     object_property_set_bool(OBJECT(cpu), true, "endianness", &error_abort);
-    object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
     memory_region_init_ram(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 793006a822..a43c980fc9 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -71,7 +71,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "7.10.d", "version", &error_abort);
-    object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
     memory_region_init_ram(phys_lmb_bram, NULL,
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index e74b047380..abebc7e2ef 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -96,7 +96,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    qdev_realize(DEVICE(&s->cpu), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -172,7 +172,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     /* Create the PMU device */
     object_initialize_child(OBJECT(machine), "pmu", pmu,
                             TYPE_XLNX_ZYNQMP_PMU_SOC);
-    object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
+    qdev_realize(DEVICE(pmu), NULL, &error_fatal);
 
     /* Load the kernel */
     microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 6e2b0174f6..3ec904a55f 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1003,7 +1003,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
                             &error_abort);
-    object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &local_err);
+    qdev_realize(DEVICE(&phb->lsis), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1022,7 +1022,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                                    &error_abort);
     object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
                             &error_abort);
-    object_property_set_bool(OBJECT(&phb->msis), true, "realized", &local_err);
+    qdev_realize(DEVICE(&phb->msis), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1031,7 +1031,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     /* Power Bus Common Queue */
     object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
                                    &error_abort);
-    object_property_set_bool(OBJECT(&phb->pbcq), true, "realized", &local_err);
+    qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 368ae9eacd..10716d759d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1218,7 +1218,7 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(xsrc), nr_irqs, "nr-irqs", &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(phb), "xive", &error_fatal);
-    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index f9b41c5042..2d634c838e 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -390,7 +390,7 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(stk_obj, i, "stack-no", &error_abort);
         object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abort);
-        object_property_set_bool(stk_obj, true, "realized", &local_err);
+        qdev_realize(DEVICE(stk_obj), NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 42c7e63a60..1af0ebee45 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -238,8 +238,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
         s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
         object_property_set_int(OBJECT(s->or_irq), PCI_NUM_PINS, "num-lines",
                                 &error_fatal);
-        object_property_set_bool(OBJECT(s->or_irq), true, "realized",
-                                 &error_fatal);
+        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
         sysbus_init_irq(dev, &s->or_irq->out_irq);
 
         for (i = 0; i < PCI_NUM_PINS; i++) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b64baf71ca..80b4afd211 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1138,7 +1138,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             "bar", &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
                              ICS_PROP_XICS, &error_abort);
-    object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &local_err);
+    qdev_realize(DEVICE(&chip8->psi), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1149,8 +1149,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* Create LPC controller */
     object_property_set_link(OBJECT(&chip8->lpc), OBJECT(&chip8->psi), "psi",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
-                             &error_fatal);
+    qdev_realize(DEVICE(&chip8->lpc), NULL, &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_regs);
 
     chip->dt_isa_nodename = g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
@@ -1170,7 +1169,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip8->occ), OBJECT(&chip8->psi), "psi",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip8->occ), true, "realized", &local_err);
+    qdev_realize(DEVICE(&chip8->occ), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1184,8 +1183,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip8->homer), true, "realized",
-                             &local_err);
+    qdev_realize(DEVICE(&chip8->homer), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1352,7 +1350,7 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
                                            &error_fatal, NULL);
 
         object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
-        object_property_set_bool(OBJECT(eq), true, "realized", &error_fatal);
+        qdev_realize(DEVICE(eq), NULL, &error_fatal);
 
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->id),
                                 &eq->xscom_regs);
@@ -1384,7 +1382,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
                                  &error_fatal);
         object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()),
                                  "system-memory", &error_abort);
-        object_property_set_bool(OBJECT(pec), true, "realized", &local_err);
+        qdev_realize(DEVICE(pec), NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -1480,7 +1478,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    object_property_set_bool(OBJECT(&chip9->psi), true, "realized", &local_err);
+    qdev_realize(DEVICE(&chip9->psi), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1491,7 +1489,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip9->lpc), true, "realized", &local_err);
+    qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1505,7 +1503,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip9->occ), OBJECT(&chip9->psi), "psi",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip9->occ), true, "realized", &local_err);
+    qdev_realize(DEVICE(&chip9->occ), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1519,8 +1517,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip9->homer), true, "realized",
-                             &local_err);
+    qdev_realize(DEVICE(&chip9->homer), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1602,8 +1599,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    object_property_set_bool(OBJECT(&chip10->psi), true, "realized",
-                             &local_err);
+    qdev_realize(DEVICE(&chip10->psi), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1614,8 +1610,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip10->lpc), OBJECT(&chip10->psi), "psi",
                              &error_abort);
-    object_property_set_bool(OBJECT(&chip10->lpc), true, "realized",
-                             &local_err);
+    qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1734,8 +1729,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 "hrmor", &error_fatal);
         object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
                                  &error_abort);
-        object_property_set_bool(OBJECT(pnv_core), true, "realized",
-                                 &error_fatal);
+        qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
         /* Each core has an XSCOM MMIO region */
         xscom_core_base = pcc->xscom_core_base(chip, core_hwid);
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 5f86453b6a..2e1a03daa4 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -235,7 +235,7 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
     obj = object_new(TYPE_IPMI_BMC_SIMULATOR);
     object_ref(OBJECT(pnor));
     object_property_add_const_link(obj, "pnor", OBJECT(pnor));
-    object_property_set_bool(obj, true, "realized", &error_fatal);
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
 
     /* Install the HIOMAP protocol handlers to access the PNOR */
     ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(obj), IPMI_NETFN_OEM,
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 96a446f001..c986c16db1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -173,7 +173,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
-    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
+    qdev_realize(DEVICE(cpu), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 20e54ad5ac..75b8ae9703 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -510,7 +510,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_bool(OBJECT(ics), true, "realized",  &err);
+    qdev_realize(DEVICE(ics), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -851,7 +851,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
-    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
+    qdev_realize(DEVICE(xsrc), NULL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c381bb6fb5..8d630baa5d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1730,8 +1730,7 @@ static void spapr_rtc_create(SpaprMachineState *spapr)
     object_initialize_child_with_props(OBJECT(spapr), "rtc", &spapr->rtc,
                                        sizeof(spapr->rtc), TYPE_SPAPR_RTC,
                                        &error_fatal, NULL);
-    object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
-                              &error_fatal);
+    qdev_realize(DEVICE(&spapr->rtc), NULL, &error_fatal);
     object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->rtc),
                               "date");
 }
@@ -2629,7 +2628,7 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
                                     &error_fatal);
             object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
                                     &error_fatal);
-            object_property_set_bool(core, true, "realized", &error_fatal);
+            qdev_realize(DEVICE(core), NULL, &error_fatal);
 
             object_unref(core);
         }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9c8c1b14cf..26ad566f42 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -239,7 +239,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
     CPUState *cs = CPU(cpu);
     Error *local_err = NULL;
 
-    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
+    qdev_realize(DEVICE(cpu), NULL, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index b958f8acb5..2689104295 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -567,7 +567,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
                                 spapr_drc_index(drc));
     object_property_add_child(owner, prop_name, OBJECT(drc));
     object_unref(OBJECT(drc));
-    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
+    qdev_realize(DEVICE(drc), NULL, NULL);
     g_free(prop_name);
 
     return drc;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 7e1d6d59ac..0fecabc135 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -369,7 +369,7 @@ SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
     g_free(tmp);
     object_unref(OBJECT(tcet));
 
-    object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
+    qdev_realize(DEVICE(tcet), NULL, NULL);
 
     return tcet;
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 79b0e40b66..897bf98587 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -311,7 +311,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abort);
-        object_property_set_bool(obj, true, "realized", &local_err);
+        qdev_realize(DEVICE(obj), NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index bebd3213e1..f6776da8e9 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -61,8 +61,7 @@ static void riscv_opentitan_init(MachineState *machine)
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_RISCV_IBEX_SOC);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     memory_region_init_ram(main_mem, NULL, "riscv.lowrisc.ibex.ram",
         memmap[IBEX_RAM].size, &error_fatal);
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 56c2be5312..e26c382259 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -48,8 +48,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
-    object_property_set_bool(OBJECT(&s->harts[idx]), true,
-                             "realized", &err);
+    qdev_realize(DEVICE(&s->harts[idx]), NULL, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a9e4482270..1c17d02cf0 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -86,8 +86,7 @@ static void riscv_sifive_e_init(MachineState *machine)
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_E_SOC);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* Data Tightly Integrated Memory */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.e.ram",
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5b86520b24..ea197ab64f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -331,8 +331,7 @@ static void sifive_u_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
     object_property_set_uint(OBJECT(&s->soc), s->serial, "serial",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* register RAM */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
@@ -530,10 +529,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * CPU must exist and have been parented into the cluster before the
      * cluster is realized.
      */
-    object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
-                             &error_abort);
-    object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
-                             &error_abort);
+    qdev_realize(DEVICE(&s->e_cluster), NULL, &error_abort);
+    qdev_realize(DEVICE(&s->u_cluster), NULL, &error_abort);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d304b85640..1e036cc602 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -48,7 +48,7 @@ void s390_skeys_init(void)
                               obj);
     object_unref(obj);
 
-    qdev_init_nofail(DEVICE(obj));
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
 }
 
 static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 6d1e587527..0144b9021c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -50,7 +50,7 @@ void s390_stattrib_init(void)
                               obj);
     object_unref(obj);
 
-    qdev_init_nofail(DEVICE(obj));
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
 }
 
 /* Console commands: */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 201f9604fe..b111406d56 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -75,7 +75,7 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
     if (err != NULL) {
         goto out;
     }
-    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
+    qdev_realize(DEVICE(cpu), NULL, &err);
 
 out:
     object_unref(OBJECT(cpu));
@@ -210,7 +210,7 @@ static void s390_init_ipl_dev(const char *kernel_filename,
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
                               new);
     object_unref(new);
-    qdev_init_nofail(dev);
+    qdev_realize(dev, NULL, &error_fatal);
 }
 
 static void s390_create_virtio_net(BusState *bus, const char *name)
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index b66afb35c8..d39f6d7785 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -322,7 +322,7 @@ void s390_sclp_init(void)
 
     object_property_add_child(qdev_get_machine(), TYPE_SCLP, new);
     object_unref(new);
-    qdev_init_nofail(DEVICE(new));
+    qdev_realize(DEVICE(new), NULL, &error_fatal);
 }
 
 static void sclp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 7324e37b5e..3c2979175e 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -29,7 +29,7 @@ void s390_init_tod(void)
     object_property_add_child(qdev_get_machine(), TYPE_S390_TOD, obj);
     object_unref(obj);
 
-    qdev_init_nofail(DEVICE(obj));
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
 }
 
 S390TODState *s390_get_todstate(void)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba05da3f2e..da42ce6615 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6135,8 +6135,7 @@ static void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
     if (cpu->apic_state == NULL) {
         return;
     }
-    object_property_set_bool(OBJECT(cpu->apic_state), true, "realized",
-                             errp);
+    qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
 
     /* Map APIC MMIO area */
     apic = APIC_COMMON(cpu->apic_state);
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 42d3dd7030..1e6b0f33ff 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -26,6 +26,7 @@
 
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 
 
@@ -76,7 +77,7 @@ static void test_static_prop_subprocess(void)
     MyType *mt;
 
     mt = STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
-    qdev_init_nofail(DEVICE(mt));
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, PROP_DEFAULT);
 }
@@ -111,7 +112,7 @@ static void test_static_globalprop_subprocess(void)
     register_global_properties(props);
 
     mt = STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
-    qdev_init_nofail(DEVICE(mt));
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 200);
     g_assert_cmpuint(mt->prop2, ==, PROP_DEFAULT);
@@ -229,7 +230,7 @@ static void test_dynamic_globalprop_subprocess(void)
     register_global_properties(props);
 
     mt = DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
-    qdev_init_nofail(DEVICE(mt));
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 101);
     g_assert_cmpuint(mt->prop2, ==, 102);
@@ -272,7 +273,7 @@ static void test_subclass_global_props(void)
     register_global_properties(props);
 
     mt = STATIC_TYPE(object_new(TYPE_SUBCLASS));
-    qdev_init_nofail(DEVICE(mt));
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 102);
     g_assert_cmpuint(mt->prop2, ==, 104);
-- 
2.26.2


