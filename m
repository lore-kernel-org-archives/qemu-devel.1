Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74849C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16972137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RmtPuAR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16972137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWKd-0006cc-Rb
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW4G-0007AV-6l; Tue, 08 Sep 2020 01:21:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW4E-00069c-FV; Tue, 08 Sep 2020 01:21:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkz2Nkcz9sWB; Tue,  8 Sep 2020 15:20:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542411;
 bh=qGDKszCu7L1a5W4LErh5xaKIlShUztA7IfBe8gYA/fo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RmtPuAR2NgKD+Y10K7GgIhmWGAi2NwX47Kn7awWU02zxbKkEk0/voXGVrtgT/cW6Z
 +Hzrs3zbPempiYnTa0GnxYQRZYCfNAuApWz+02zqLlDq99fZ3xiCZmGrW+Dvyg8itY
 qf79sPgkZ6+QxfFzdpnOo2gJxFZysdT2wezpioIU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 33/33] spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node
 hcall
Date: Tue,  8 Sep 2020 15:19:53 +1000
Message-Id: <20200908051953.1616885-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
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
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The current implementation of h_home_node_associativity hard codes
the values of associativity domains of the vcpus. Let's make
it consider the values already initialized in spapr->numa_assoc_array,
via the spapr_numa_get_vcpu_assoc() helper.

We want to set it and forget it, and for that we also need to
assert that we don't overflow the registers of the hypercall.
>From R4 to R9 we can squeeze in 12 associativity domains for
vcpus, so let's assert that VCPU_ASSOC_SIZE -1 isn't greater
than that.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200904172422.617460-4-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_numa.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 066ffc2a5f..64fe567f5d 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -176,10 +176,11 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
+    g_autofree uint32_t *vcpu_assoc = NULL;
     target_ulong flags = args[0];
     target_ulong procno = args[1];
     PowerPCCPU *tcpu;
-    int idx;
+    int idx, assoc_idx;
 
     /* only support procno from H_REGISTER_VPA */
     if (flags != 0x1) {
@@ -191,16 +192,40 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
         return H_P2;
     }
 
-    /* sequence is the same as in the "ibm,associativity" property */
+    /*
+     * Given that we want to be flexible with the sizes and indexes,
+     * we must consider that there is a hard limit of how many
+     * associativities domain we can fit in R4 up to R9, which would be
+     * 12 associativity domains for vcpus. Assert and bail if that's
+     * not the case.
+     */
+    G_STATIC_ASSERT((VCPU_ASSOC_SIZE - 1) <= 12);
+
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, tcpu);
+    /* assoc_idx starts at 1 to skip associativity size */
+    assoc_idx = 1;
 
-    idx = 0;
 #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
                              ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
-    args[idx++] = ASSOCIATIVITY(procno, -1);
-    for ( ; idx < 6; idx++) {
-        args[idx] = -1;
+
+    for (idx = 0; idx < 6; idx++) {
+        int32_t a, b;
+
+        /*
+         * vcpu_assoc[] will contain the associativity domains for tcpu,
+         * including tcpu->node_id and procno, meaning that we don't
+         * need to use these variables here.
+         *
+         * We'll read 2 values at a time to fill up the ASSOCIATIVITY()
+         * macro. The ternary will fill the remaining registers with -1
+         * after we went through vcpu_assoc[].
+         */
+        a = assoc_idx < VCPU_ASSOC_SIZE ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+        b = assoc_idx < VCPU_ASSOC_SIZE ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+
+        args[idx] = ASSOCIATIVITY(a, b);
     }
 #undef ASSOCIATIVITY
 
-- 
2.26.2


