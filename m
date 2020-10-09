Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D401C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1360221FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D/CRotbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1360221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpk6-0004kx-Gt
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVb-0005Q7-DP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:19 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45971 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVY-0001nr-3K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wc1k38z9sWP; Fri,  9 Oct 2020 21:19:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238800;
 bh=OAaG0EfHUCTPTYELPg04P7dVR70GRYrY3vEIgbH0kBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D/CRotbMhdfvLinWZPrKW/QVqMGcUOK8myuGDpdXgj7GMjl6oHPB0ZHnUxKF9zEnK
 TPNv2/nlBeJuKZXUDC6rKWXnaDEdEHC8U46p1M50dFYUknocHvq18kGyXGaWgGZEh3
 QK5FdpLvHVppx9ouj4F8SgNsXy/kHYr3lmqFoVEk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/20] spapr: Add a return value to spapr_check_pagesize()
Date: Fri,  9 Oct 2020 21:19:45 +1100
Message-Id: <20201009101951.1569252-15-david@gibson.dropbear.id.au>
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

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200914123505.612812-14-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 4 +---
 hw/ppc/spapr_caps.c    | 7 +++++--
 include/hw/ppc/spapr.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7f3a620d41..4256794f3b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3490,9 +3490,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
                                       &error_abort);
     pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(memdev));
-    spapr_check_pagesize(spapr, pagesize, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_check_pagesize(spapr, pagesize, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 10a80a8159..9341e9782a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -310,13 +310,13 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
 
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
-void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
+bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp)
 {
     hwaddr maxpagesize = (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXPAGESIZE]);
 
     if (!kvmppc_hpt_needs_host_contiguous_pages()) {
-        return;
+        return true;
     }
 
     if (maxpagesize > pagesize) {
@@ -324,7 +324,10 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                    "Can't support %"HWADDR_PRIu" kiB guest pages with %"
                    HWADDR_PRIu" kiB host pages with this KVM implementation",
                    maxpagesize >> 10, pagesize >> 10);
+        return false;
     }
+
+    return true;
 }
 
 static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 02f3c29838..bba8736269 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -934,7 +934,7 @@ void spapr_caps_cpu_apply(SpaprMachineState *spapr, PowerPCCPU *cpu);
 void spapr_caps_add_properties(SpaprMachineClass *smc);
 int spapr_caps_post_migration(SpaprMachineState *spapr);
 
-void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
+bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp);
 /*
  * XIVE definitions
-- 
2.26.2


