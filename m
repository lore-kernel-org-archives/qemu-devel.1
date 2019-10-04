Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74F5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99BB2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KD0RiHEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99BB2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKGZ-00035i-8O
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2f-0005He-9b
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2d-0005Ph-Sg
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2d-00054Y-Fr; Fri, 04 Oct 2019 05:38:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YH2N6Vz9sRY; Fri,  4 Oct 2019 19:37:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181875;
 bh=89KyJjUcwP9bHAU1OyRkuXlWihVQWtOKSTECqsZvs2Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KD0RiHEZa7FpzbVHTXy7i9PA2FF0B+GTOMNnT2RloCukSGJw0/6+x6kKmOPFIJBBq
 /Kh/GVn0ZVBYGWe00sCzSyyuoppJkE9REJhnxql8128zG8zbZzyHzzYn8p8i1HXv8f
 rxQjoFs6npYscwU/etfzligHImwKxpq2O9qvpOPI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/53] spapr: Simplify handling of pre ISA 3.0 guest workaround
 handling
Date: Fri,  4 Oct 2019 19:37:09 +1000
Message-Id: <20191004093747.31350-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Certain old guest versions don't understand the radix MMU introduced with
POWER ISA 3.0, but incorrectly select it if presented with the option at
CAS time.  We workaround this in qemu by explicitly excluding the radix
(and other ISA 3.0 linked) options if the guest doesn't explicitly note
support for ISA 3.0.

This is handled by the 'cas_legacy_guest_workaround' flag, which is prett=
y
vague.  Rename it to 'cas_pre_isa3_guest' to be clearer about what it's f=
or.

In addition, we unnecessarily call spapr_populate_pa_features() with
different options when initially constructing the device tree and when
adjusting it at CAS time.  At the initial construct time cas_pre_isa3_gue=
st
is already false, so we can still use the flag, rather than explicitly
overriding it to be false at the callsite.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c         | 10 ++++------
 hw/ppc/spapr_hcall.c   |  3 +--
 include/hw/ppc/spapr.h |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2725b139a7..b906ac6547 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -220,8 +220,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int off=
set, PowerPCCPU *cpu)
 /* Populate the "ibm,pa-features" property */
 static void spapr_populate_pa_features(SpaprMachineState *spapr,
                                        PowerPCCPU *cpu,
-                                       void *fdt, int offset,
-                                       bool legacy_guest)
+                                       void *fdt, int offset)
 {
     uint8_t pa_features_206[] =3D { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
@@ -287,7 +286,7 @@ static void spapr_populate_pa_features(SpaprMachineSt=
ate *spapr,
     if ((spapr_get_cap(spapr, SPAPR_CAP_HTM) !=3D 0) && pa_size > 24) {
         pa_features[24] |=3D 0x80;    /* Transactional memory support */
     }
-    if (legacy_guest && pa_size > 40) {
+    if (spapr->cas_pre_isa3_guest && pa_size > 40) {
         /* Workaround for broken kernels that attempt (guest) radix
          * mode when they can't handle it, if they see the radix bit set
          * in pa-features. So hide it from them. */
@@ -350,8 +349,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachine=
State *spapr)
             return ret;
         }
=20
-        spapr_populate_pa_features(spapr, cpu, fdt, offset,
-                                   spapr->cas_legacy_guest_workaround);
+        spapr_populate_pa_features(spapr, cpu, fdt, offset);
     }
     return ret;
 }
@@ -553,7 +551,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
=20
-    spapr_populate_pa_features(spapr, cpu, fdt, offset, false);
+    spapr_populate_pa_features(spapr, cpu, fdt, offset);
=20
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23e4bdb829..3d3a67149a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1765,8 +1765,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
             exit(EXIT_FAILURE);
         }
     }
-    spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
-                                                          OV1_PPC_3_00);
+    spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_PPC_3_=
00);
     spapr_ovec_cleanup(ov1_guest);
     if (!spapr->cas_reboot) {
         /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 03111fd55b..dfec8e8e76 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -175,7 +175,7 @@ struct SpaprMachineState {
=20
     /* ibm,client-architecture-support option negotiation */
     bool cas_reboot;
-    bool cas_legacy_guest_workaround;
+    bool cas_pre_isa3_guest;
     SpaprOptionVector *ov5;         /* QEMU-supported option vectors */
     SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
     uint32_t max_compat_pvr;
--=20
2.21.0


