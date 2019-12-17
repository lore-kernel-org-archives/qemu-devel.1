Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F285C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4562072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FX0w8UiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4562072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5LG-0006Nu-Ik
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kt-0003UM-1j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kr-0001JK-Uz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:42 -0500
Received: from ozlabs.org ([203.11.71.1]:41657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kr-0000EE-Jn; Mon, 16 Dec 2019 23:46:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWl66Mjz9sTj; Tue, 17 Dec 2019 15:43:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557827;
 bh=97r7TzXK+1Ou/D6VolXeUHodoCbDq+0CZLkcFo2DuDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FX0w8UiFnAj4wBixpRcCpXcetm2ollHht0h7be5O+fmJUssmSfhVIJUyoPvjOWo09
 igMouJevZp/f4jwZWXuw0p7Uy3yU4OD5hYmhoFQ7jl9RLD8HPDvLVZAkJgGK5KkS1L
 30pg9WehN3tOydgj8jpl+6OqrxYUQMA0Mghex82g=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 79/88] ppc/pnv: Introduce PnvMachineClass::dt_power_mgt()
Date: Tue, 17 Dec 2019 15:43:13 +1100
Message-Id: <20191217044322.351838-80-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

We add an extra node to advertise power management on some machines,
namely powernv9 and powernv10. This is achieved by using the
pnv_is_power9() and pnv_is_power10() helpers.

This can be achieved with QOM. Add a method to the base class for
powernv machines and have it implemented by machine types that
support power management instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623839642.360005.9243510140436689941.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 10 ++++++----
 include/hw/ppc/pnv.h |  8 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 97845e7bde..a2ad7258f8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -472,7 +472,7 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *fd=
t)
                        &args);
 }
=20
-static void pnv_dt_power_mgt(void *fdt)
+static void pnv_dt_power_mgt(PnvMachineState *pnv, void *fdt)
 {
     int off;
=20
@@ -539,9 +539,9 @@ static void *pnv_dt_create(MachineState *machine)
         pnv_dt_bmc_sensors(pnv->bmc, fdt);
     }
=20
-    /* Create an extra node for power management on Power9 and Power10 *=
/
-    if (pnv_is_power9(pnv) || pnv_is_power10(pnv)) {
-        pnv_dt_power_mgt(fdt);
+    /* Create an extra node for power management on machines that suppor=
t it */
+    if (pmc->dt_power_mgt) {
+        pmc->dt_power_mgt(pnv, fdt);
     }
=20
     return fdt;
@@ -1709,6 +1709,7 @@ static void pnv_machine_power9_class_init(ObjectCla=
ss *oc, void *data)
=20
     pmc->compat =3D compat;
     pmc->compat_size =3D sizeof(compat);
+    pmc->dt_power_mgt =3D pnv_dt_power_mgt;
 }
=20
 static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
@@ -1722,6 +1723,7 @@ static void pnv_machine_power10_class_init(ObjectCl=
ass *oc, void *data)
=20
     pmc->compat =3D compat;
     pmc->compat_size =3D sizeof(compat);
+    pmc->dt_power_mgt =3D pnv_dt_power_mgt;
 }
=20
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index d534746bd4..8a42c199b6 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -190,6 +190,8 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t=
 pir);
 #define PNV_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(PnvMachineClass, klass, TYPE_PNV_MACHINE)
=20
+typedef struct PnvMachineState PnvMachineState;
+
 typedef struct PnvMachineClass {
     /*< private >*/
     MachineClass parent_class;
@@ -197,9 +199,11 @@ typedef struct PnvMachineClass {
     /*< public >*/
     const char *compat;
     int compat_size;
+
+    void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
 } PnvMachineClass;
=20
-typedef struct PnvMachineState {
+struct PnvMachineState {
     /*< private >*/
     MachineState parent_obj;
=20
@@ -216,7 +220,7 @@ typedef struct PnvMachineState {
     Notifier     powerdown_notifier;
=20
     PnvPnor      *pnor;
-} PnvMachineState;
+};
=20
 static inline bool pnv_chip_is_power9(const PnvChip *chip)
 {
--=20
2.23.0


