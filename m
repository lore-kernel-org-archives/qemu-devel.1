Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9617C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7684A20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KI226gt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7684A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCO6-00023i-Mm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByi-0004rt-6J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByg-0002se-Qf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:20 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42717 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByg-0002oK-3k; Tue, 02 Jul 2019 02:09:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMh1Fssz9sPM; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047744;
 bh=vIFJ6a3uhpNiBYk44KaDMXM3ZdKaVq+9WdCp8TsZy5k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KI226gt/kbZZbj1BpmtvmV5ux6ekHlWEFzl0obYVq1EOmkjE8lWmFlGjs/XEwpsBh
 Rna9/CSJD2M7cW7hqzzA6qWye/FxlRwlwIwKYwtGtYEwNb0G94d2G6qfijtQV6rrSJ
 UiEuNvqtvdk7ikDjeC0LM4yLmmgKEiSmRfM/3B6Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:17 +1000
Message-Id: <20190702060857.3926-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 09/49] xics/spapr: Detect old KVM XICS on POWER9
 hosts
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

Older KVMs on POWER9 don't support destroying/recreating a KVM XICS
device, which is required by 'dual' interrupt controller mode. This
causes QEMU to emit a warning when the guest is rebooted and to fall
back on XICS emulation:

qemu-system-ppc64: warning: kernel_irqchip allowed but unavailable:
 Error on KVM_CREATE_DEVICE for XICS: File exists

If kernel irqchip is required, QEMU will thus exit when the guest is
first rebooted. Failing QEMU this late may be a painful experience
for the user.

Detect that and exit at machine init instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156044430517.125694.6207865998817342638.stgit@bahia.lab.toul=
ouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/ppc-spapr-xive.rst |  4 ++--
 hw/intc/xics_kvm.c            | 30 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_irq.c            | 13 +++++++++++++
 include/hw/ppc/xics_spapr.h   |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rs=
t
index 7a64c9d049..6159bc6eed 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -142,8 +142,8 @@ xics            XICS KVM       XICS emul.     XICS KV=
M
 (3) QEMU fails at CAS with ``Guest requested unavailable interrupt
     mode (XICS), either don't set the ic-mode machine property or try
     ic-mode=3Dxics or ic-mode=3Ddual``
-(4) QEMU/KVM incompatibility due to device destruction in reset. This
-    needs to be addressed more cleanly with an error.
+(4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fa=
ils
+    with ``KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don`=
`
=20
=20
 XIVE Device tree properties
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 5c4208f430..c7f8f5edd2 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -452,3 +452,33 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, E=
rror **errp)
     /* Clear the presenter from the VCPUs */
     kvm_disable_icps();
 }
+
+/*
+ * This is a heuristic to detect older KVMs on POWER9 hosts that don't
+ * support destruction of a KVM XICS device while the VM is running.
+ * Required to start a spapr machine with ic-mode=3Ddual,kernel-irqchip=3D=
on.
+ */
+bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr)
+{
+    int rc;
+
+    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
+    if (rc < 0) {
+        /*
+         * The error is ignored on purpose. The KVM XICS setup code
+         * will catch it again anyway. The goal here is to see if
+         * close() actually destroys the device or not.
+         */
+        return false;
+    }
+
+    close(rc);
+
+    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
+    if (rc >=3D 0) {
+        close(rc);
+        return false;
+    }
+
+    return errno =3D=3D EEXIST;
+}
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index dfb99f35ea..75654fc67a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -669,6 +669,19 @@ static void spapr_irq_check(SpaprMachineState *spapr=
, Error **errp)
             return;
         }
     }
+
+    /*
+     * On a POWER9 host, some older KVM XICS devices cannot be destroyed=
 and
+     * re-created. Detect that early to avoid QEMU to exit later when th=
e
+     * guest reboots.
+     */
+    if (kvm_enabled() &&
+        spapr->irq =3D=3D &spapr_irq_dual &&
+        machine_kernel_irqchip_required(machine) &&
+        xics_kvm_has_broken_disconnect(spapr)) {
+        error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kerne=
l-irqchip=3Don");
+        return;
+    }
 }
=20
 /*
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 6c1d9ee559..d968f2499c 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -35,6 +35,7 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t n=
r_servers, void *fdt,
                    uint32_t phandle);
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
+bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
 void xics_spapr_init(SpaprMachineState *spapr);
 void xics_spapr_connect(SpaprMachineState *spapr);
=20
--=20
2.21.0


