Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBED221FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BpWkkxLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBED221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpiQ-0002KO-Cj
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVZ-0005Kv-Fn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:17 -0400
Received: from ozlabs.org ([203.11.71.1]:43853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVX-0001oH-L1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wc3RyBz9sWM; Fri,  9 Oct 2020 21:20:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238800;
 bh=hVdk1Rc1LNH6dfuCNTe5xpHy20p7C9+DbjHQVTJFXOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BpWkkxLDjrENjbVE4AmFKma0aTvfBHdKmMek4EwKSyFtwDg8fciqT/rEd8ZdTVB4p
 fas2WaisBkmvJRsQfNoFIUCkjTNjYHBRJ0IV3HpcWn+zXeg6u2807F8qEx3UhB4TNc
 Zs/xmxD3WMazostgpKsOkEN2F+LMiw9+n4VrSEEc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/20] spapr: add spapr_machine_using_legacy_numa() helper
Date: Fri,  9 Oct 2020 21:19:47 +1100
Message-Id: <20201009101951.1569252-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:19:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: dbarboza@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The changes to come to NUMA support are all guest visible. In
theory we could just create a new 5_1 class option flag to
avoid the changes to cascade to 5.1 and under. The reality is that
these changes are only relevant if the machine has more than one
NUMA node. There is no need to change guest behavior that has
been around for years needlesly.

This new helper will be used by the next patches to determine
whether we should retain the (soon to be) legacy NUMA behavior
in the pSeries machine. The new behavior will only be exposed
if:

- machine is pseries-5.2 and newer;
- more than one NUMA node is declared in NUMA state.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20201007172849.302240-2-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 12 ++++++++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4256794f3b..63315f2d0f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -294,6 +294,15 @@ static hwaddr spapr_node0_size(MachineState *machine)
     return machine->ram_size;
 }
 
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+
+    return smc->pre_5_2_numa_associativity ||
+           machine->numa_state->num_nodes <= 1;
+}
+
 static void add_str(GString *s, const gchar *s1)
 {
     g_string_append_len(s, s1, strlen(s1) + 1);
@@ -4519,8 +4528,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
  */
 static void spapr_machine_5_1_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_5_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    smc->pre_5_2_numa_associativity = true;
 }
 
 DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bba8736269..bb47896f17 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -138,6 +138,7 @@ struct SpaprMachineClass {
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
+    bool pre_5_2_numa_associativity;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
@@ -853,6 +854,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.26.2


