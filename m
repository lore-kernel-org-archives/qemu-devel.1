Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF7DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E232226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eOatJqYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E232226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpdJ-0005KZ-IC
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVT-0005Ct-HH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52195 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVQ-0001me-IJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wX10Ldz9sVS; Fri,  9 Oct 2020 21:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238796;
 bh=P6GDoue4Fmo2XAOiOyb4TA3e4zSKC+OE9HjRXqaEWYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eOatJqYHzpb98WGMZtpl9eswgjsHGlCs5zYHZ6rjXVhvFt8pSOdplehSXbhyU3aPi
 0uTIHCps0QKT2NYJDKo65raeN/brehW1MYbo/LpawrC3i4s6qIa9UCBI1uO7dSCrWZ
 uxq11gfurauwuoAfVDNgyZCpRQvzLSg474iVJ2tY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/20] spapr: Simplify error handling in
 do_client_architecture_support()
Date: Fri,  9 Oct 2020 21:19:38 +1100
Message-Id: <20201009101951.1569252-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
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
 qemu-ppc@nonngu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Use the return value of ppc_set_compat_all() to check failures,
which is preferred over hijacking local_err.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200914123505.612812-7-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 885ea60778..607740150f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1666,7 +1666,6 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
     uint32_t cas_pvr;
     SpaprOptionVector *ov1_guest, *ov5_guest;
     bool guest_radix;
-    Error *local_err = NULL;
     bool raw_mode_supported = false;
     bool guest_xive;
     CPUState *cs;
@@ -1697,8 +1696,9 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
 
     /* Update CPUs */
     if (cpu->compat_pvr != cas_pvr) {
-        ppc_set_compat_all(cas_pvr, &local_err);
-        if (local_err) {
+        Error *local_err = NULL;
+
+        if (ppc_set_compat_all(cas_pvr, &local_err) < 0) {
             /* We fail to set compat mode (likely because running with KVM PR),
              * but maybe we can fallback to raw mode if the guest supports it.
              */
@@ -1707,7 +1707,6 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
                 return H_HARDWARE;
             }
             error_free(local_err);
-            local_err = NULL;
         }
     }
 
-- 
2.26.2


