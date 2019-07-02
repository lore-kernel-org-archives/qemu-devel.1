Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469BC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103FE20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EndmzP4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103FE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCIo-0006TC-Vo
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByh-0004rC-Ra
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByg-0002s0-EZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39073 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByf-0002oI-Qs; Tue, 02 Jul 2019 02:09:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg6Gy1z9sPQ; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=0x9gvmdJs1taeeNzrwjE9y5EGXHaN56YdnVtMhExpLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EndmzP4wfocGjQuV/VU5NA/1aBk9mnrRGRTdIR8ydrwHBgr2hGXpg6w0SGLIOx87B
 RbbEs6FkDWpLjGRnn5c7SDWlXWf/nuOcWgUGv+w43RfeKazWNWPoVM5wS3+RLYQB/z
 f4NPczl/TJZpuvuQ+4kAAOWELlSnFxvcqWt/ZO/w=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:15 +1000
Message-Id: <20190702060857.3926-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 07/49] xics/spapr: Prevent RTAS/hypercalls
 emulation to be used by in-kernel XICS
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The XICS-related RTAS calls and hypercalls in QEMU are not supposed to
be called when the KVM in-kernel XICS is in use.

Add some explicit checks to detect that, print an error message and repor=
t
an hardware error to the guest.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156044429419.125694.507569071972451514.stgit@bahia.lab.toulo=
use-stg.fr.ibm.com>
[dwg: Correction to commit message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 5a1835e8b1..d470ab5f7a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -41,11 +41,31 @@
  * Guest interfaces
  */
=20
+static bool check_in_kernel_xics(const char *func)
+{
+    if (kvm_irqchip_in_kernel()) {
+        error_report("pseries: %s must never be called for in-kernel XIC=
S",
+                     func);
+        return true;
+    }
+
+    return false;
+}
+
+#define CHECK_IN_KERNEL_XICS_HCALL              \
+    do {                                        \
+        if (check_in_kernel_xics(__func__)) {   \
+            return H_HARDWARE;                  \
+        }                                       \
+    } while (0)
+
 static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong cppr =3D args[0];
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
     return H_SUCCESS;
 }
@@ -56,6 +76,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
     target_ulong mfrr =3D args[1];
     ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     if (!icp) {
         return H_PARAMETER;
     }
@@ -69,6 +91,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     args[0] =3D xirr;
     return H_SUCCESS;
 }
@@ -78,6 +102,8 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     args[0] =3D xirr;
     args[1] =3D cpu_get_host_ticks();
     return H_SUCCESS;
@@ -88,6 +114,8 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
 {
     target_ulong xirr =3D args[0];
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
     return H_SUCCESS;
 }
@@ -99,6 +127,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
     uint32_t mfrr;
     uint32_t xirr;
=20
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     if (!icp) {
         return H_PARAMETER;
     }
@@ -111,6 +141,14 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
     return H_SUCCESS;
 }
=20
+#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
+    do {                                                \
+        if (check_in_kernel_xics(__func__)) {           \
+            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
+            return;                                     \
+        }                                               \
+    } while (0)
+
 static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           uint32_t token,
                           uint32_t nargs, target_ulong args,
@@ -119,6 +157,8 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno, server, priority;
=20
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs !=3D 3) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -152,6 +192,8 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs !=3D 1) || (nret !=3D 3)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -182,6 +224,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs !=3D 1) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -213,6 +257,8 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs !=3D 1) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
--=20
2.21.0


