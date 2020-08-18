Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC049C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE6920706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mEtxObkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE6920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tAI-0005oo-KB
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t68-0007MV-CI; Tue, 18 Aug 2020 00:19:44 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t66-0006LN-2y; Tue, 18 Aug 2020 00:19:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNZ3nT3z9sV1; Tue, 18 Aug 2020 14:19:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724366;
 bh=DDx05xw1OIDE5M5zfqz3Kclc5VMes58zkL4yq+6/qGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mEtxObkOXS7US8DR1ge+lWMSFOKqonHduSLejpPLOA4DlK1iIhhZP6NwUwbW+LPUS
 DUp6a5yUkcAahQLcknv6MlToN/z00tkwQZGiom9KT8akkVl/PlmJLYbQcSFp7XZYbw
 7o6vsdVb0PynDlrOMX8ewlYQNcyWVQefPLKox2iw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 09/40] spapr: Forbid nested KVM-HV in pre-power9 compat mode
Date: Tue, 18 Aug 2020 14:18:51 +1000
Message-Id: <20200818041922.251708-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Nested KVM HV only works if the kernel is using the radix MMU mode, ie.
the CPU is POWER9 and it is not running in some pre-power9 compat mode.
Otherwise, the KVM HV module fails to load in the guest with -ENODEV.
It might be painful for a user to discover this late that nested cannot
work with their setup. Erroring out at machine init instead seems to be
the best we can do.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <159491948127.188975.9621435875869177751.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 275f5bd034..10a80a8159 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -382,6 +382,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                                     uint8_t val, Error **errp)
 {
     ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+
     if (!val) {
         /* capability disabled by default */
         return;
@@ -391,6 +393,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
         error_setg(errp, "No Nested KVM-HV support in TCG");
         error_append_hint(errp, "Try appending -machine cap-nested-hv=off\n");
     } else if (kvm_enabled()) {
+        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                              spapr->max_compat_pvr)) {
+            error_setg(errp, "Nested KVM-HV only supported on POWER9");
+            error_append_hint(errp,
+                              "Try appending -machine max-cpu-compat=power9\n");
+            return;
+        }
+
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
                        "KVM implementation does not support Nested KVM-HV");
-- 
2.26.2


