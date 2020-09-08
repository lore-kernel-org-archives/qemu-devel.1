Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBCAC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC23A21897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jEf0iqoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC23A21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW9h-0001Qp-Vz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3J-00060B-QF; Tue, 08 Sep 2020 01:20:21 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3H-0005uF-Mu; Tue, 08 Sep 2020 01:20:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkl1MqHz9sTK; Tue,  8 Sep 2020 15:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542399;
 bh=oNqINut4m7yPkBkTE4WEvkmXs8Ug4gFGqv9k3XWsOTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jEf0iqoCZmfuEs7XYs7lyDN/WUInOPYKlkSIJPiQlrtRoBArCLwf+g593yFsPqOqx
 obekzdzDyxKJMKqL84A3ucrHXn9Lpav2wEFxkh8BntCOPfiNloQbv17PVoZ9CXJcbJ
 n0f1NpZn8TvCrVwJFfvj/UCPb2IEW/u1hr4zN4Qk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/33] spapr/xive: Allocate vCPU IPIs from the vCPU contexts
Date: Tue,  8 Sep 2020 15:19:31 +1000
Message-Id: <20200908051953.1616885-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

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
Message-Id: <20200820134547.2355743-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 507637d51e..66bf4c06fe 100644
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
2.26.2


