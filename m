Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0542CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C95D2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RX1FLq17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C95D2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpft-00080o-26
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVa-0005OG-PJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34035 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVX-0001oO-VR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wd31h7z9sWV; Fri,  9 Oct 2020 21:20:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238801;
 bh=uCDy2eT032X0jjKEb/Bj7R46DtU4RECqXdUasI0Wcpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RX1FLq17ecaRylhVulE6gkOyDBnJVeo3XD0CsemeEJUC9nae6b407FEx2819rfe+w
 LVkvTBbKqX/bNZwE4/2aHeoMeln1LVa3jLVlEUtjDW5Qr9vWBO6LDZLbNLAiq/wNpz
 R06/8dr5IdCygs01uJBcfJilhHHGO9yC53svugOk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/20] spapr_numa: change reference-points and maxdomain
 settings
Date: Fri,  9 Oct 2020 21:19:49 +1100
Message-Id: <20201009101951.1569252-19-david@gibson.dropbear.id.au>
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
Cc: dbarboza@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

This is the first guest visible change introduced in
spapr_numa.c. The previous settings of both reference-points
and maxdomains were too restrictive, but enough for the
existing associativity we're setting in the resources.

We'll change that in the following patches, populating the
associativity arrays based on user input. For those changes
to be effective, reference-points and maxdomains must be
more flexible. After this patch, we'll have 4 distinct
levels of NUMA (0x4, 0x3, 0x2, 0x1) and maxdomains will
allow for any type of configuration the user intends to
do - under the scope and limitations of PAPR itself, of
course.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20201007172849.302240-4-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_numa.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index fe395e80a3..16badb1f4b 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -178,24 +178,51 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
  */
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
 {
+    MachineState *ms = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t refpoints[] = {
         cpu_to_be32(0x4),
-        cpu_to_be32(0x4),
+        cpu_to_be32(0x3),
         cpu_to_be32(0x2),
+        cpu_to_be32(0x1),
     };
     uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
-    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+    uint32_t maxdomain = ms->numa_state->num_nodes + spapr->gpu_numa_id;
     uint32_t maxdomains[] = {
         cpu_to_be32(4),
-        maxdomain,
-        maxdomain,
-        maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain)
     };
 
-    if (smc->pre_5_1_assoc_refpoints) {
-        nr_refpoints = 2;
+    if (spapr_machine_using_legacy_numa(spapr)) {
+        uint32_t legacy_refpoints[] = {
+            cpu_to_be32(0x4),
+            cpu_to_be32(0x4),
+            cpu_to_be32(0x2),
+        };
+        uint32_t legacy_maxdomain = spapr->gpu_numa_id > 1 ? 1 : 0;
+        uint32_t legacy_maxdomains[] = {
+            cpu_to_be32(4),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(spapr->gpu_numa_id),
+        };
+
+        G_STATIC_ASSERT(sizeof(legacy_refpoints) <= sizeof(refpoints));
+        G_STATIC_ASSERT(sizeof(legacy_maxdomains) <= sizeof(maxdomains));
+
+        nr_refpoints = 3;
+
+        memcpy(refpoints, legacy_refpoints, sizeof(legacy_refpoints));
+        memcpy(maxdomains, legacy_maxdomains, sizeof(legacy_maxdomains));
+
+        /* pseries-5.0 and older reference-points array is {0x4, 0x4} */
+        if (smc->pre_5_1_assoc_refpoints) {
+            nr_refpoints = 2;
+        }
     }
 
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-- 
2.26.2


