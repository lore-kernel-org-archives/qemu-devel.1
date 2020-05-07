Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54037C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAA920838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DMTpT1Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAA920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYkh-0004j0-6W
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYht-0007V6-Me; Thu, 07 May 2020 01:04:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44055 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhr-0006zf-Ej; Thu, 07 May 2020 01:04:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn3bQ5z9sSc; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=rv01STFoNzIdEUQWkxzNomnQspQsudGQNlgPG2JbmyM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DMTpT1FdqS2BSW3DjblH09ZoJKG4RsRdVlkOsE/aDexmol5KAfvQs0MYQ6xfAKZOY
 tw7c+w8fNeNjK66bz5DRcMYUUQYdELWmmyNzXtYzNsdpDH1P7bPnz3IVP9l1b+mdoF
 7qeHMZ5WH3vop+XoSL3Oz3tlGsh1/2JrJixNP0QA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/18] spapr: Don't check capabilities removed between CAS calls
Date: Thu,  7 May 2020 15:02:12 +1000
Message-Id: <20200507050228.802395-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
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

We currently check if some capability in OV5 was removed by the guest
since the previous CAS, and we trigger a CAS reboot in that case. This
was required because it could call for a device-tree property or node
removal, that we didn't support until recently (see commit 6787d27b04a7
"spapr: add option vector handling in CAS-generated resets" for details).

Now that we render a full FDT at CAS and that SLOF is able to handle
node removal, we don't need to do a CAS reset in this case anymore.
Also, this check can only return true if the guest has already called
CAS since the last full system reset (otherwise spapr->ov5_cas is
empty). Linux doesn't do that so this can be considered as dead code
for the vast majority of existing setups.

Drop the check. Since the only use of the ov5_cas_old variable is
precisely the check itself, drop the variable as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158514993021.478799.10928618293640651819.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d50fc9117..e8ee447537 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1676,7 +1676,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     target_ulong fdt_bufsize = args[2];
     target_ulong ov_table;
     uint32_t cas_pvr;
-    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
+    SpaprOptionVector *ov1_guest, *ov5_guest;
     bool guest_radix;
     Error *local_err = NULL;
     bool raw_mode_supported = false;
@@ -1782,22 +1782,10 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
      * by LoPAPR 1.1, 14.5.4.8, which QEMU doesn't implement, we don't need
      * to worry about this for now.
      */
-    ov5_cas_old = spapr_ovec_clone(spapr->ov5_cas);
-
-    /* also clear the radix/hash bit from the current ov5_cas bits to
-     * be in sync with the newly ov5 bits. Else the radix bit will be
-     * seen as being removed and this will generate a reset loop
-     */
-    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
 
     /* full range of negotiated ov5 capabilities */
     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
     spapr_ovec_cleanup(ov5_guest);
-    /* capabilities that have been added since CAS-generated guest reset.
-     * if capabilities have since been removed, generate another reset
-     */
-    spapr->cas_reboot = !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);
-    spapr_ovec_cleanup(ov5_cas_old);
     /* Now that processing is finished, set the radix/hash bit for the
      * guest if it requested a valid mode; otherwise terminate the boot. */
     if (guest_radix) {
-- 
2.26.2


