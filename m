Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B62C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FEA20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K8zfbq8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FEA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCBM-0007dZ-KE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByi-0004tA-Jo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByg-0002sr-US
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50583 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByg-0002o7-6L; Tue, 02 Jul 2019 02:09:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg5W55z9sPJ; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=MiiiRQaRuLNiixyAghX2fjOpuUv+ioQymj9gtPvP+cE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K8zfbq8EV9t8Tc+uxKUISVC/mE2+7Lxq4oQNvktPj3ZuBRTUESMXXMgMdCvc6X56z
 2rS/0S33DcopuQSQnVoc1OAmlfjB3PRWBOKY9JwqsIGYbkVSkARsnTC3M9QdBOGOXA
 Z2xiImnNNQZvpS8fqbXsEYwa1+f3Xushj1Lqv4dY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:16 +1000
Message-Id: <20190702060857.3926-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 08/49] xics/spapr: Register RTAS/hypercalls once
 at machine init
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

QEMU may crash when running a spapr machine in 'dual' interrupt controlle=
r
mode on some older (but not that old, eg. ubuntu 18.04.2) KVMs with parti=
al
XIVE support:

qemu-system-ppc64: hw/ppc/spapr_rtas.c:411: spapr_rtas_register:
 Assertion `!name || !rtas_table[token].name' failed.

XICS is controlled by the guest thanks to a set of RTAS calls. Depending
on whether KVM XICS is used or not, the RTAS calls are handled by KVM or
QEMU. In both cases, QEMU needs to expose the RTAS calls to the guest
through the "rtas" node of the device tree.

The spapr_rtas_register() helper takes care of all of that: it adds the
RTAS call token to the "rtas" node and registers a QEMU callback to be
invoked when the guest issues the RTAS call. In the KVM XICS case, QEMU
registers a dummy callback that just prints an error since it isn't
supposed to be invoked, ever.

Historically, the XICS controller was setup during machine init and
released during final teardown. This changed when the 'dual' interrupt
controller mode was added to the spapr machine: in this case we need
to tear the XICS down and set it up again during machine reset. The
crash happens because we indeed have an incompatibility with older
KVMs that forces QEMU to fallback on emulated XICS, which tries to
re-registers the same RTAS calls.

This could be fixed by adding proper rollback that would unregister
RTAS calls on error. But since the emulated RTAS calls in QEMU can
now detect when they are mistakenly called while KVM XICS is in
use, it seems simpler to register them once and for all at machine
init. This fixes the crash and allows to remove some now useless
lines of code.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156044429963.125694.13710679451927268758.stgit@bahia.lab.tou=
louse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c          | 19 -------------------
 hw/intc/xics_spapr.c        |  8 --------
 hw/ppc/spapr_irq.c          |  3 ++-
 include/hw/ppc/spapr.h      |  4 ----
 include/hw/ppc/xics.h       |  1 -
 include/hw/ppc/xics_spapr.h |  1 +
 6 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 5ba5b77561..5c4208f430 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -331,15 +331,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int v=
al)
     }
 }
=20
-static void rtas_dummy(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                       uint32_t token,
-                       uint32_t nargs, target_ulong args,
-                       uint32_t nret, target_ulong rets)
-{
-    error_report("pseries: %s must never be called for in-kernel XICS",
-                 __func__);
-}
-
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
 {
     int rc;
@@ -360,11 +351,6 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **=
errp)
         goto fail;
     }
=20
-    spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_dummy);
-    spapr_rtas_register(RTAS_IBM_INT_ON, "ibm,int-on", rtas_dummy);
-
     rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
     if (rc < 0) {
         error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
@@ -454,11 +440,6 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, E=
rror **errp)
     close(kernel_xics_fd);
     kernel_xics_fd =3D -1;
=20
-    spapr_rtas_unregister(RTAS_IBM_SET_XIVE);
-    spapr_rtas_unregister(RTAS_IBM_GET_XIVE);
-    spapr_rtas_unregister(RTAS_IBM_INT_OFF);
-    spapr_rtas_unregister(RTAS_IBM_INT_ON);
-
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index d470ab5f7a..8d605b68a7 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -285,14 +285,6 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
=20
 void xics_spapr_init(SpaprMachineState *spapr)
 {
-    /* Emulated mode can only be initialized once. */
-    if (spapr->ics->init) {
-        return;
-    }
-
-    spapr->ics->init =3D true;
-
-    /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
     spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
     spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 3156daf093..dfb99f35ea 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -114,6 +114,8 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
     }
=20
     spapr->ics =3D ICS_BASE(obj);
+
+    xics_spapr_init(spapr);
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
@@ -236,7 +238,6 @@ static const char *spapr_irq_get_nodename_xics(SpaprM=
achineState *spapr)
=20
 static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
 {
-    xics_spapr_init(spapr);
 }
=20
 static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4f5becf1f3..60553d32c4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -676,10 +676,6 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, Spapr=
MachineState *sm,
                               uint32_t nargs, target_ulong args,
                               uint32_t nret, target_ulong rets);
 void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
-static inline void spapr_rtas_unregister(int token)
-{
-    spapr_rtas_register(token, NULL, NULL);
-}
 target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *sm,
                              uint32_t token, uint32_t nargs, target_ulon=
g args,
                              uint32_t nret, target_ulong rets);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d6f8e4c4c2..eb65ad7e43 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -119,7 +119,6 @@ struct ICSState {
     uint32_t offset;
     ICSIRQState *irqs;
     XICSFabric *xics;
-    bool init; /* sPAPR ICS device initialized */
 };
=20
 #define ICS_PROP_XICS "xics"
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 2476b540ed..6c1d9ee559 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -36,5 +36,6 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t n=
r_servers, void *fdt,
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 void xics_spapr_init(SpaprMachineState *spapr);
+void xics_spapr_connect(SpaprMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
--=20
2.21.0


