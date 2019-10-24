Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B1CA9EBD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00FB2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DxlR9TgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00FB2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYPB-0005md-Ez
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKT-0004k8-Ah
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKR-000558-J6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45981 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKR-0004zl-71; Thu, 24 Oct 2019 04:18:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrY36ctz9sRK; Thu, 24 Oct 2019 19:18:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905117;
 bh=UZTZ+rNi2S7nifzD4DHbqXRrfElzrdf4P+U68TJ+Ip4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DxlR9TgEwFtNCW49PwOaOBaEmppb7j4rlJDlFz8Rnctd4pAI55/cM1rkMacssxahP
 ypOOWPXn3n/oUwQ909xi92qJ+o/dfPLi3wsp240TCqJZObGhtpKHVvuNR/+Y+mobVZ
 6CIodkk9dqHTgMSyJ/ZDBRgU9fbBALDixFuU6ZII=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/28] spapr: Set VSMT to smp_threads by default
Date: Thu, 24 Oct 2019 19:17:51 +1100
Message-Id: <20191024081813.2115-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Support for setting VSMT is available in KVM since linux-4.13. Most distr=
os
that support KVM on POWER already have it. It thus seem reasonable enough
to have the default machine to set VSMT to smp_threads.

This brings contiguous VCPU ids and thus brings their upper bound down to
the machine's max_cpus. This is especially useful for XIVE KVM devices,
which may thus allocate only one VP descriptor per VCPU.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157010411885.246126.12610015369068227139.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 7 ++++++-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4eb97d3a9b..428b834f30 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2496,6 +2496,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState =
*ms, uint32_t id, int *idx)
 static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *ms =3D MACHINE(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     Error *local_err =3D NULL;
     bool vsmt_user =3D !!spapr->vsmt;
     int kvm_smt =3D kvmppc_smt_threads();
@@ -2522,7 +2523,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
             goto out;
         }
         /* In this case, spapr->vsmt has been set by the command line */
-    } else {
+    } else if (!smc->smp_threads_vsmt) {
         /*
          * Default VSMT value is tricky, because we need it to be as
          * consistent as possible (for migration), but this requires
@@ -2531,6 +2532,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
          * overwhelmingly common case in production systems.
          */
         spapr->vsmt =3D MAX(8, smp_threads);
+    } else {
+        spapr->vsmt =3D smp_threads;
     }
=20
     /* KVM: If necessary, set the SMT mode: */
@@ -4438,6 +4441,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
     smc->linux_pci_probe =3D true;
+    smc->smp_threads_vsmt =3D true;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4505,6 +4509,7 @@ static void spapr_machine_4_1_class_options(Machine=
Class *mc)
=20
     spapr_machine_4_2_class_options(mc);
     smc->linux_pci_probe =3D false;
+    smc->smp_threads_vsmt =3D false;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cbd1a4c9f3..2009eb64f9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -122,6 +122,7 @@ struct SpaprMachineClass {
     bool broken_host_serial_model; /* present real host info to the gues=
t */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
+    bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
=20
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
--=20
2.21.0


