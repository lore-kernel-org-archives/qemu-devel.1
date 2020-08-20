Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91772076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91772076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kuH-0001FN-5U
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8ktI-0007fw-UM; Thu, 20 Aug 2020 09:46:04 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:43703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8ktG-0003vg-Nz; Thu, 20 Aug 2020 09:46:04 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.189])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3B43C524A502;
 Thu, 20 Aug 2020 15:45:51 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 15:45:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051a7d6b59-9472-4906-a5db-efce8816abf1,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 4/4] spapr/xive: Allocate vCPU IPIs from the vCPU contexts
Date: Thu, 20 Aug 2020 15:45:47 +0200
Message-ID: <20200820134547.2355743-5-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200820134547.2355743-1-clg@kaod.org>
References: <20200820134547.2355743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3a1f280e-9775-4af8-8e0a-6fc3f71e7c4d
X-Ovh-Tracer-Id: 9119507774312778601
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddutddggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:45:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When QEMU switches to the XIVE interrupt mode, it creates all the
guest interrupts at the level of the KVM device. These interrupts are
backed by real HW interrupts from the IPI interrupt pool of the XIVE
controller.

Currently, this is done from the QEMU main thread, which results in
allocating all interrupts from the chip on which QEMU is running. IPIs
are not distributed across the system and the load is not well
balanced across the interrupt controllers.

Change the vCPU IPI allocation to run from the vCPU context. The
associated XIVE IPI interrupt will be allocated on the chip on which
the vCPU is running and improve distribution of the IPIs in the system.
When the vCPUs are pinned, this will make the IPI local to the chip of
the vCPU. It will reduce rerouting between interrupt controllers and
gives better performance.

Device interrupts are still treated the same. To improve placement, we
would need some information on the chip owning the virtual source or
the HW source in case of a passthrough device but this reuires
changes in PAPR.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index f838c208b559..7d7f6fdbe25a 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -146,13 +146,43 @@ int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
     return s.ret;
 }
 
-static int kvmppc_xive_reset_ipi(SpaprXive *xive, CPUState *cs, Error **errp)
+/*
+ * Allocate the vCPU IPIs from the vCPU context. This will allocate
+ * the XIVE IPI interrupt on the chip on which the vCPU is running.
+ * This gives a better distribution of IPIs when the guest has a lot
+ * of vCPUs. When the vCPUs are pinned, this will make the IPI local
+ * to the chip of the vCPU. It will reduce rerouting between interrupt
+ * controllers and gives better performance.
+ */
+typedef struct {
+    SpaprXive *xive;
+    Error *err;
+    int rc;
+} XiveInitIPI;
+
+static void kvmppc_xive_reset_ipi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     unsigned long ipi = kvm_arch_vcpu_id(cs);
+    XiveInitIPI *s = arg.host_ptr;
     uint64_t state = 0;
 
-    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, ipi,
-                              &state, true, errp);
+    s->rc = kvm_device_access(s->xive->fd, KVM_DEV_XIVE_GRP_SOURCE, ipi,
+                              &state, true, &s->err);
+}
+
+static int kvmppc_xive_reset_ipi(SpaprXive *xive, CPUState *cs, Error **errp)
+{
+    XiveInitIPI s = {
+        .xive = xive,
+        .err  = NULL,
+        .rc   = 0,
+    };
+
+    run_on_cpu(cs, kvmppc_xive_reset_ipi_on_cpu, RUN_ON_CPU_HOST_PTR(&s));
+    if (s.err) {
+        error_propagate(errp, s.err);
+    }
+    return s.rc;
 }
 
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
-- 
2.25.4


