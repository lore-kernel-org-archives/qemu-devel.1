Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F19C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F45920881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NcC01rF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F45920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCDV-0001qS-8r
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByl-000514-GK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByj-0002w3-TO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49323 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByj-0002sv-5x; Tue, 02 Jul 2019 02:09:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMj59B1z9sPc; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047745;
 bh=XL9rUUuoMrbbedAD0CK7JXtj492z57BZhCOuHxR3UNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NcC01rF03GK0dgXZjHJXcu6hlvEVss7YMsPpzNPSd2Tc8Vz4GFSGy1vG+EvN7UOaj
 NslDPrSvcu8VI3DsF1HmututNZ8C3KLRmAR1Nk8OuGPwDZX+TkpCNoM4DKsmAl04qB
 z8mQrE8K3kJGUw7Ex8NBtj4KJkgxcw4RN6IFgt/M=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:23 +1000
Message-Id: <20190702060857.3926-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 15/49] xics/spapr: Only emulated XICS should use
 RTAS/hypercalls emulation
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

Checking that we're not using the in-kernel XICS is ok with the "xics"
interrupt controller mode, but it is definitely not enough with the
other modes since the guest could be using XIVE.

Ensure XIVE is not in use when emulated XICS RTAS/hypercalls are
called.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c | 53 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 8d605b68a7..7cd3c93d71 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -41,22 +41,23 @@
  * Guest interfaces
  */
=20
-static bool check_in_kernel_xics(const char *func)
+static bool check_emulated_xics(SpaprMachineState *spapr, const char *fu=
nc)
 {
-    if (kvm_irqchip_in_kernel()) {
-        error_report("pseries: %s must never be called for in-kernel XIC=
S",
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ||
+        kvm_irqchip_in_kernel()) {
+        error_report("pseries: %s must only be called for emulated XICS"=
,
                      func);
-        return true;
+        return false;
     }
=20
-    return false;
+    return true;
 }
=20
-#define CHECK_IN_KERNEL_XICS_HCALL              \
-    do {                                        \
-        if (check_in_kernel_xics(__func__)) {   \
-            return H_HARDWARE;                  \
-        }                                       \
+#define CHECK_EMULATED_XICS_HCALL(spapr)               \
+    do {                                               \
+        if (!check_emulated_xics((spapr), __func__)) { \
+            return H_HARDWARE;                         \
+        }                                              \
     } while (0)
=20
 static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -64,7 +65,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
 {
     target_ulong cppr =3D args[0];
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
     return H_SUCCESS;
@@ -76,7 +77,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
     target_ulong mfrr =3D args[1];
     ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     if (!icp) {
         return H_PARAMETER;
@@ -91,7 +92,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     args[0] =3D xirr;
     return H_SUCCESS;
@@ -102,7 +103,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     args[0] =3D xirr;
     args[1] =3D cpu_get_host_ticks();
@@ -114,7 +115,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
 {
     target_ulong xirr =3D args[0];
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
     return H_SUCCESS;
@@ -127,7 +128,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
     uint32_t mfrr;
     uint32_t xirr;
=20
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
=20
     if (!icp) {
         return H_PARAMETER;
@@ -141,12 +142,12 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
-#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
-    do {                                                \
-        if (check_in_kernel_xics(__func__)) {           \
-            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
-            return;                                     \
-        }                                               \
+#define CHECK_EMULATED_XICS_RTAS(spapr, rets)          \
+    do {                                               \
+        if (!check_emulated_xics((spapr), __func__)) { \
+            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);     \
+            return;                                    \
+        }                                              \
     } while (0)
=20
 static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -157,7 +158,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno, server, priority;
=20
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
=20
     if ((nargs !=3D 3) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -192,7 +193,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
=20
     if ((nargs !=3D 1) || (nret !=3D 3)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -224,7 +225,7 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
=20
     if ((nargs !=3D 1) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -257,7 +258,7 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachine=
State *spapr,
     ICSState *ics =3D spapr->ics;
     uint32_t nr, srcno;
=20
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
=20
     if ((nargs !=3D 1) || (nret !=3D 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
--=20
2.21.0


