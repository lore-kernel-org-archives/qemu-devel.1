Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5633F20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GDbfaGyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5633F20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdooO-0006XY-Cv
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolj-00015O-5W; Wed, 27 May 2020 01:38:23 -0400
Received: from ozlabs.org ([203.11.71.1]:57935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolh-0001bq-Kn; Wed, 27 May 2020 01:38:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03q1tpqz9sRW; Wed, 27 May 2020 15:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557895;
 bh=zC2AQ8bz3NPVon90j5g3Hah9yM8NZ5q/yFSIGF3Tb6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GDbfaGyk/abL4UwotvcPxgR/+fD4QaxAzGNfb9RTQ0Y6HzM9UMNoELJAchvuyzEK5
 TLHv914Ys1LbbWAbMkuCPH77Yd+q8C9QzO3S4SOo4jSDb7xaLrApjabVllgQDZJ8Na
 gIxhOD3DFu3OJ90wmvjcZ0K2ShqxTNVehn3Gwj50=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/15] ppc/pnv: Fix NMI system reset SRR1 value
Date: Wed, 27 May 2020 15:37:55 +1000
Message-Id: <20200527053809.356168-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:38:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
SRR1 setting wrong for sresets that hit outside of power-save states.

Fix this, better documenting the source for the bit definitions.

Fixes: 01b552b05b0f ("ppc/pnv: Add support for NMI interface")
Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200507114824.788942-1-npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[dwg: Fixed up some tab indentation]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index da637822f9..f48a61d6d1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1984,12 +1984,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
-    /*
-     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
-     * dependent. POWER processors use this for xscom triggered interrupts,
-     * which come from the BMC or NMI IPIs.
-     */
-    env->spr[SPR_SRR1] |= PPC_BIT(43);
+    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
+        /*
+         * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
+         * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
+         * (PPC_BIT(43)).
+         */
+        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
+            warn_report("ppc_cpu_do_system_reset does not set system reset wakeup reason");
+            env->spr[SPR_SRR1] |= PPC_BIT(43);
+        }
+    } else {
+        /*
+         * For non-powersave system resets, SRR1[42:45] are defined to be
+         * implementation-dependent. The POWER9 User Manual specifies that
+         * an external (SCOM driven, which may come from a BMC nmi command or
+         * another CPU requesting a NMI IPI) system reset exception should be
+         * 0b0010 (PPC_BIT(44)).
+         */
+        env->spr[SPR_SRR1] |= PPC_BIT(44);
+    }
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.26.2


