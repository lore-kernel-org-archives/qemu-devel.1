Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB5C47247
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6CE20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UNtgMpps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6CE20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYki-0004kI-1p
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhx-0007dN-Fx; Thu, 07 May 2020 01:04:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51327 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhv-0007Yo-PG; Thu, 07 May 2020 01:04:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn5Srsz9sSr; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=xlc5mtv/3xKknETuQ4MDMoZwVMk16BLB0W7Wmq965XI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UNtgMppsC/BBPsbWgxkSHkuLLpO5jgwtCxYFB5ODOk4WBhjIXBtejIJWwDZ0Hxkhu
 hLnnnWiAWGj7d5XkXmJ2T6qHeki/RgyB63nCc//aZkT3ltkKIcjFN+7jZbgRF/tNjj
 OwZtAuBlS75tGPQAoI/4Ln/APJRjcKtEV5ySl9ys=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/18] spapr: Simplify selection of radix/hash during CAS
Date: Thu,  7 May 2020 15:02:15 +1000
Message-Id: <20200507050228.802395-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The guest can select the MMU mode by setting bits 0-1 of byte 24
in OV5 to to 0b00 for hash or 0b01 for radix. As required by the
architecture, we terminate the boot process if any other value
is found there.

The usual way to negotiate features in OV5 is basically ANDing
the bitfield provided by the guest and the bitfield of features
supported by QEMU, previously populated at machine init.

For some not documented reason, MMU is treated differently : bit 1
of byte 24 (the radix/hash bit) is cleared from the guest OV5 and
explicitely set in the final negotiated OV5 if radix was requested.

Since the only expected input from the guest is the radix/hash bit
being set or not, it seems more appropriate to handle this like we
do for XIVE.

Set the radix bit in spapr->ov5 at machine init if it has a chance
to work (ie. power9, either TCG or a radix capable KVM) and rely
exclusively on spapr_ovec_intersect() to set the radix bit in
spapr->ov5_cas.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158514993621.478799.4204740354545734293.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 1 +
 hw/ppc/spapr_hcall.c | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 785c41d205..167b1216ba 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2837,6 +2837,7 @@ static void spapr_machine_init(MachineState *machine)
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_300);
         /* KVM and TCG always allow GTSE with radix... */
         spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
     }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index e8ee447537..fb4fdd4a0c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1739,9 +1739,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         exit(EXIT_FAILURE);
     }
 
-    /* The radix/hash bit in byte 24 requires special handling: */
     guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
-    spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
 
     guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
 
@@ -1786,14 +1784,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     /* full range of negotiated ov5 capabilities */
     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
     spapr_ovec_cleanup(ov5_guest);
-    /* Now that processing is finished, set the radix/hash bit for the
-     * guest if it requested a valid mode; otherwise terminate the boot. */
+
     if (guest_radix) {
         if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
             error_report("Guest requested unavailable MMU mode (radix).");
             exit(EXIT_FAILURE);
         }
-        spapr_ovec_set(spapr->ov5_cas, OV5_MMU_RADIX_300);
     } else {
         if (kvm_enabled() && kvmppc_has_cap_mmu_radix()
             && !kvmppc_has_cap_mmu_hash_v3()) {
-- 
2.26.2


