Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0937C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A711B20863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V6ThXOJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSykd-0007sz-Ug
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:59:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyIH-0006qQ-Eo
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyIG-0000GA-H1
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39107 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyIG-0008Li-4K; Tue, 21 May 2019 02:30:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qpl68Jtz9sPc; Tue, 21 May 2019 16:29:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420175;
	bh=GUZhhj9ktzjORPqE5ENQeBsjM9/HbMGBpQ2Ql0E1fAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6ThXOJSmb4kPMtO8taapUgRPS1uwk0c1OGvfylhWvJsa0sE6eb/PZLXte8fNcAaf
	rl9MGSa6X6nAwnIephktqhkt4B6c6lUF1FJQAVTxDi1LBB6MTTovsUI5cGbqumVzft
	59mv8eeWaplxcEu2Bk89fH026fYz9l/5QmzmSCHo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:29:22 +1000
Message-Id: <20190521062924.6930-37-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 36/38] spapr/irq: initialize the IRQ device only
 once
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Add a check to make sure that the routine initializing the emulated
IRQ device is called once. We don't have much to test on the XICS
side, so we introduce a 'init' boolean under ICSState.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190513084245.25755-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c  | 9 +++++++++
 hw/intc/xics_spapr.c  | 7 +++++++
 include/hw/ppc/xics.h | 1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a79574b23c..f6f6c29d6a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -338,6 +338,15 @@ void spapr_xive_init(SpaprXive *xive, Error **errp)
     XiveSource *xsrc =3D &xive->source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
=20
+    /*
+     * The emulated XIVE device can only be initialized once. If the
+     * ESB memory region has been already mapped, it means we have been
+     * through there.
+     */
+    if (memory_region_is_mapped(&xsrc->esb_mmio)) {
+        return;
+    }
+
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
                           "xive.tima", 4ull << TM_SHIFT);
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 9d2b8adef7..5a1835e8b1 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -239,6 +239,13 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
=20
 void xics_spapr_init(SpaprMachineState *spapr)
 {
+    /* Emulated mode can only be initialized once. */
+    if (spapr->ics->init) {
+        return;
+    }
+
+    spapr->ics->init =3D true;
+
     /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
     spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index eb65ad7e43..d6f8e4c4c2 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -119,6 +119,7 @@ struct ICSState {
     uint32_t offset;
     ICSIRQState *irqs;
     XICSFabric *xics;
+    bool init; /* sPAPR ICS device initialized */
 };
=20
 #define ICS_PROP_XICS "xics"
--=20
2.21.0


