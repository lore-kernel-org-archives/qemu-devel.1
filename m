Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF0C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B366F2189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f94vLA4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B366F2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Dwu-0006nt-Uc
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3DcN-0004ld-Sk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3DcL-0003uR-4E
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:09:10 -0400
Received: from ozlabs.org ([203.11.71.1]:54457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3DcK-0003hB-Dw; Thu, 29 Aug 2019 02:09:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscP0WMQz9sPg; Thu, 29 Aug 2019 16:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058917;
 bh=+4/VGiM8L4S4+fxqsRINSodZQNe1QrZxc1fcAPmzxUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f94vLA4id2c1ZuFEfUGQ9cE5lvJ2qJtUITOC0VXc5aEvIKl3Ovjco5dlwTVKSkJMU
 HQJ1aXPohxvDWkvf5WmhrBzGtfWoCZz5ixrlgkP/N1NnKiYwQlAca5ZQXQTLzjwu8v
 SmImZcGN0XJYHammPPO25V8kyHBnTwyim2xShcr8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:25 +1000
Message-Id: <20190829060827.25731-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 17/19] spapr_pci: Advertise BAR reallocation
 capability
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The pseries guests do not normally allocate PCI resources and rely on
the system firmware doing so. Furthermore at least at some point in
the past the pseries guests won't even allowed to change BARs, probably
it is still the case for phyp. So since the initial commit we have [1]
which prevents resource reallocation.

This is not a problem until we want specific BAR alignments, for example,
PAGE_SIZE=3D=3D64k to make sure we can still map MMIO BARs directly. For
the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
does not allocate BARs, the guest does this instead and does not align
BARs even if Linux is given pci=3Dresource_alignment=3D16@pci:0:0 as
PCI_PROBE_ONLY makes Linux ignore alignment requests.

ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3].
This makes use of the dial to advertise to the guest that we can handle
BAR reassignments. This limits the change to the latest pseries machine
to avoid old guests explosion.

We do not remove the flag from [1] as pseries guests are still supported
under phyp so having that removed may cause problems.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/platforms/pseries/setup.c?h=3Dv5.1#n773
[2] https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-qemu/slof/pci-p=
hb.fs;h=3D06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=3DHEAD#l338
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Df81c11af
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190719043734.108462-1-aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 9 +++++++++
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d063312a3b..447fb5c4ea 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1168,6 +1168,7 @@ static void spapr_dt_ov5_platform_support(SpaprMach=
ineState *spapr, void *fdt,
 static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     int chosen;
     const char *boot_device =3D machine->boot_order;
     char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
@@ -1225,6 +1226,11 @@ static void spapr_dt_chosen(SpaprMachineState *spa=
pr, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
     }
=20
+    /* We can deal with BAR reallocation just fine, advertise it to the =
guest */
+    if (smc->linux_pci_probe) {
+        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
+    }
+
     spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
@@ -4476,6 +4482,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
+    smc->linux_pci_probe =3D true;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4535,12 +4542,14 @@ DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
  */
 static void spapr_machine_4_1_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         /* Only allow 4kiB and 64kiB IOMMU pagesizes */
         { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
     };
=20
     spapr_machine_4_2_class_options(mc);
+    smc->linux_pci_probe =3D false;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fa7c380edb..03111fd55b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -121,6 +121,7 @@ struct SpaprMachineClass {
     bool legacy_irq_allocation;
     bool broken_host_serial_model; /* present real host info to the gues=
t */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
+    bool linux_pci_probe;
=20
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
--=20
2.21.0


