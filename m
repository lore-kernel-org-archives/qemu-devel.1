Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17380C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21A82339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YwbM8ldt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21A82339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LK1-0003Ow-GP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0S-0004bg-9R
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-00085w-Cf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:08 -0400
Received: from ozlabs.org ([203.11.71.1]:58795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0O-0007zt-6t; Wed, 21 Aug 2019 03:26:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjB43Fvz9sQq; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372350;
 bh=SfKVXl6Z5YWnWJb4dab18JG/Iivu1pPKm0+aPJywsPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YwbM8ldtKNFkE9ebWTXUtjOuokb/mib1l/+4OJXgjfvpMx0v6HhIfox/1XEkatarE
 f/f0mQC19y5vr5QeI77HNvLzzJHb4OJe2U9JR5dhZ8+qOGlsb13c5kdMIL9sRfcBND
 bzN9y5E9zhxGDVB3k7m2K7mYHaQROupkLqAakG4A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:18 +1000
Message-Id: <20190821072542.23090-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 18/42] spapr: Implement H_JOIN
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190718034214.14948-5-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 74 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0890c2840f..15e27d9a10 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1070,6 +1070,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
     add_str(hypertas, "hcall-tce");
     add_str(hypertas, "hcall-vio");
     add_str(hypertas, "hcall-splpar");
+    add_str(hypertas, "hcall-join");
     add_str(hypertas, "hcall-bulk");
     add_str(hypertas, "hcall-set-mode");
     add_str(hypertas, "hcall-sprg0");
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index eb54b96097..10c0b53339 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1070,6 +1070,62 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
+/*
+ * Confer to self, aka join. Cede could use the same pattern as well, if
+ * EXCP_HLT can be changed to ECXP_HALTED.
+ */
+static target_ulong h_confer_self(PowerPCCPU *cpu)
+{
+    CPUState *cs =3D CPU(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod =3D false;
+        return H_SUCCESS;
+    }
+    cs->halted =3D 1;
+    cs->exception_index =3D EXCP_HALTED;
+    cs->exit_request =3D 1;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env =3D &cpu->env;
+    CPUState *cs;
+    bool last_unjoined =3D true;
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    /*
+     * Must not join the last CPU running. Interestingly, no such restri=
ction
+     * for H_CONFER-to-self, but that is probably not intended to be use=
d
+     * when H_JOIN is available.
+     */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c =3D POWERPC_CPU(cs);
+        CPUPPCState *e =3D &c->env;
+        if (c =3D=3D cpu) {
+            continue;
+        }
+
+        /* Don't have a way to indicate joined, so use halted && MSR[EE]=
=3D0 */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            last_unjoined =3D false;
+            break;
+        }
+    }
+    if (last_unjoined) {
+        return H_CONTINUE;
+    }
+
+    return h_confer_self(cpu);
+}
+
 static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1090,26 +1146,15 @@ static target_ulong h_confer(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
             return H_PARAMETER;
         }
=20
-        spapr_cpu =3D spapr_cpu_state(target_cpu);
-
         /*
          * target =3D=3D self is a special case, we wait until prodded, =
without
          * dispatch counter check.
          */
         if (cpu =3D=3D target_cpu) {
-            if (spapr_cpu->prod) {
-                spapr_cpu->prod =3D false;
-
-                return H_SUCCESS;
-            }
-
-            cs->halted =3D 1;
-            cs->exception_index =3D EXCP_HALTED;
-            cs->exit_request =3D 1;
-
-            return H_SUCCESS;
+            return h_confer_self(cpu);
         }
=20
+        spapr_cpu =3D spapr_cpu_state(target_cpu);
         if (!spapr_cpu->vpa_addr || ((dispatch & 1) =3D=3D 0)) {
             return H_SUCCESS;
         }
@@ -1984,6 +2029,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
=20
+    /* hcall-join */
+    spapr_register_hypercall(H_JOIN, h_join);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
--=20
2.21.0


