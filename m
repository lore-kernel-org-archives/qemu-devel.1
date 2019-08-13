Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C448BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E92120644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gBo+s5ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E92120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxQni-0006UZ-TX
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxQmH-0004yv-LS
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxQmG-0003Lk-Gf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:59:29 -0400
Received: from ozlabs.org ([203.11.71.1]:41121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxQmF-0003JA-79; Tue, 13 Aug 2019 02:59:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4673VN02RGz9sNy; Tue, 13 Aug 2019 16:59:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565679564;
 bh=emrIgzu+XTunHT9T/aAO9YQzehEDIDPRz+sDuCSkRv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gBo+s5apgl0rcWHCsC+SZWw6CnnolcfEcWweMB1VrIvP+KGXU4iGx+cd7lnMopWZu
 FcWxCvbJTB/coFyx2pZMHGyW3F3offAYHAUge6G2ONqa8Tl6vej82HL65UZLtpEfQa
 iD9M7W8Sru3z/RyJme0rRrTHa4+WURGAc3DNXiTU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 13 Aug 2019 16:59:20 +1000
Message-Id: <20190813065920.23203-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813065920.23203-1-david@gibson.dropbear.id.au>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 2/2] spapr/xive: Fix migration of hot-plugged
 CPUs
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
Cc: clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The migration sequence of a guest using the XIVE exploitation mode
relies on the fact that the states of all devices are restored before
the machine is. This is not true for hot-plug devices such as CPUs
which state come after the machine. This breaks migration because the
thread interrupt context registers are not correctly set.

Fix migration of hotplugged CPUs by restoring their context in the
'post_load' handler of the XiveTCTX model.

Fixes: 277dd3d7712a ("spapr/xive: add migration support for KVM")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190813064853.29310-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 19 +++++++++++++++++--
 hw/intc/xive.c           | 21 ++++++++++++++++++++-
 include/hw/ppc/xive.h    |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 3bf8e7a20e..8898615c69 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -72,11 +72,17 @@ static void kvm_cpu_disable_all(void)
  * XIVE Thread Interrupt Management context (KVM)
  */
=20
-static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
+void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
 {
+    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
     uint64_t state[2];
     int ret;
=20
+    /* The KVM XIVE device is not in use yet */
+    if (xive->fd =3D=3D -1) {
+        return;
+    }
+
     /* word0 and word1 of the OS ring. */
     state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
=20
@@ -655,7 +661,16 @@ int kvmppc_xive_post_load(SpaprXive *xive, int versi=
on_id)
         }
     }
=20
-    /* Restore the thread interrupt contexts */
+    /*
+     * Restore the thread interrupt contexts of initial CPUs.
+     *
+     * The context of hotplugged CPUs is restored later, by the
+     * 'post_load' handler of the XiveTCTX model because they are not
+     * available at the time the SpaprXive 'post_load' method is
+     * called. We can not restore the context of all CPUs in the
+     * 'post_load' handler of XiveTCTX because the machine is not
+     * necessarily connected to the KVM device at that time.
+     */
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index cf77bdb7d3..da148e9f6f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -615,12 +615,31 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
     return 0;
 }
=20
+static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
+{
+    Error *local_err =3D NULL;
+
+    if (kvm_irqchip_in_kernel()) {
+        /*
+         * Required for hotplugged CPU, for which the state comes
+         * after all states of the machine.
+         */
+        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_xive_tctx =3D {
     .name =3D TYPE_XIVE_TCTX,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .pre_save =3D vmstate_xive_tctx_pre_save,
-    .post_load =3D NULL, /* handled by the sPAPRxive model */
+    .post_load =3D vmstate_xive_tctx_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveTCTX),
         VMSTATE_END_OF_LIST()
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 55c53c7417..736335174a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -438,5 +438,6 @@ void kvmppc_xive_source_set_irq(void *opaque, int src=
no, int val);
 void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
+void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
=20
 #endif /* PPC_XIVE_H */
--=20
2.21.0


