Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D2C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC3A2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EXSIN0WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3A2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpdN-0005Q2-5t
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVV-0005FS-Ap
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36051 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVS-0001ml-6s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wX246Dz9sVm; Fri,  9 Oct 2020 21:19:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238796;
 bh=uU2bvuuBHfIOdHxr5n2B5NhwOn/ignzorbQgCHxn99c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EXSIN0WS2z2Z2/hjZqACV/eE3QN6vqERn83JoGU5taLB85knvFGXzJuRt+Qb+elwG
 cM/rUnd/0Jo1kWAauBzRuTpntWPCPWptMEeONSbT8Yo8pfM+ZXwqF5NonONHjlRm+D
 mToLTDZT73DQ9F55ETI2F+cqxgV+ssvIvoF0uKCA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/20] spapr: Get rid of cas_check_pvr() error reporting
Date: Fri,  9 Oct 2020 21:19:37 +1100
Message-Id: <20201009101951.1569252-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 dbarboza@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nonngu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The cas_check_pvr() function has two purposes:
- finding the "best" logical PVR, ie. the most recent one supported by
  the guest for this CPU type
- checking if the guest supports the real PVR of this CPU type, which
  is just an optional extra information to workaround the lack of
  support for "compat" mode in PR KVM

This logic doesn't need error reporting, really. If we don't find a
suitable logical PVR, we return the special value 0 which is definitely
not a valid PVR. Let the caller decide on whether it should error out
or not.

This doesn't change the behavior.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200914123505.612812-6-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c2776b6a7d..885ea60778 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1590,12 +1590,11 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
     }
 }
 
-static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
-                              target_ulong *addr, bool *raw_mode_supported,
-                              Error **errp)
+/* Returns either a logical PVR or zero if none was found */
+static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
+                              target_ulong *addr, bool *raw_mode_supported)
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
-    uint32_t max_compat = spapr->max_compat_pvr;
     uint32_t best_compat = 0;
     int i;
 
@@ -1624,14 +1623,6 @@ static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
         }
     }
 
-    if ((best_compat == 0) && (!explicit_match || max_compat)) {
-        /* We couldn't find a suitable compatibility mode, and either
-         * the guest doesn't support "raw" mode for this CPU, or raw
-         * mode is disabled because a maximum compat mode is set */
-        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS");
-        return 0;
-    }
-
     *raw_mode_supported = explicit_match;
 
     /* Parsing finished */
@@ -1680,6 +1671,7 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
     bool guest_xive;
     CPUState *cs;
     void *fdt;
+    uint32_t max_compat = spapr->max_compat_pvr;
 
     /* CAS is supposed to be called early when only the boot vCPU is active. */
     CPU_FOREACH(cs) {
@@ -1692,9 +1684,14 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
         }
     }
 
-    cas_pvr = cas_check_pvr(spapr, cpu, &vec, &raw_mode_supported, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
+    cas_pvr = cas_check_pvr(cpu, max_compat, &vec, &raw_mode_supported);
+    if (!cas_pvr && (!raw_mode_supported || max_compat)) {
+        /*
+         * We couldn't find a suitable compatibility mode, and either
+         * the guest doesn't support "raw" mode for this CPU, or "raw"
+         * mode is disabled because a maximum compat mode is set.
+         */
+        error_report("Couldn't negotiate a suitable PVR during CAS");
         return H_HARDWARE;
     }
 
-- 
2.26.2


