Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBDEC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33F4206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33F4206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6vw-00042N-UC
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:07:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6o8-0006t9-CU
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6ZE-0004JK-R0
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:17 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:55390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6ZE-0004IK-LZ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:16 -0400
Received: from player778.ha.ovh.net (unknown [10.109.160.46])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id BCBB72102C9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:44:14 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 0625159C4190;
	Mon, 13 May 2019 08:44:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:43 +0200
Message-Id: <20190513084245.25755-13-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3341107977402747878
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.98
Subject: [Qemu-devel] [PATCH v4 12/14] spapr/irq: initialize the IRQ device
 only once
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a check to make sure that the routine initializing the emulated
IRQ device is called once. We don't have much to test on the XICS
side, so we introduce a 'init' boolean under ICSState.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v3:

 - introduced a 'init' boolean under ICSState
=20
 include/hw/ppc/xics.h | 1 +
 hw/intc/spapr_xive.c  | 9 +++++++++
 hw/intc/xics_spapr.c  | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index eb65ad7e43b7..d6f8e4c4c282 100644
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
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 246b21ae7f31..1e649d6cdbe1 100644
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
index 9d2b8adef7c5..5a1835e8b1ed 100644
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
--=20
2.20.1


