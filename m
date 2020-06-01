Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1CA20738
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="cgv60H+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1CA20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfm7l-0000rG-1B
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6Z-0007xI-QX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:59 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:42152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6Z-0004eT-0m
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tMc0vnjbQXPQUNrgS179VaVHVjpu/SGBHlmCv2j3lZg=; b=cgv60H+sw/mqfEuOJFlhQoMHXR
 LsIwwHFwBZLhJ00pVCcFqLJ+znWrR0etSXo9Ka6uppoY2QKHAdo7LcBnmwWTERBpwt++jFpAKNbRH
 3djvk4NbLntXWycug6cCmTXT0ktcLytS8bDjpnMbVRRnlItmPDJZxdU+NREoaUc8w/xY=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] target/tricore: Implement tricore_cpu_get_phys_page_debug
Date: Mon,  1 Jun 2020 17:11:18 +0200
Message-Id: <20200601151119.33196-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
References: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6661700, da=78633381,
 mc=167, sc=3, hc=164, sp=1, fso=6661700, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.1.150616, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.1.5740001
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this also removes tricore_cpu_get_phys_page_attrs_debug() as it was a
temporary fix from b190f477e29c7cd03a8fee49c96d27f160e3f5b0.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20200529072148.284037-5-kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.c    | 10 +---------
 target/tricore/helper.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 743b404a95..c8c1e9e7d5 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -23,14 +23,6 @@
 #include "exec/exec-all.h"
 #include "qemu/error-report.h"
 
-static hwaddr tricore_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
-                                         MemTxAttrs *attrs)
-{
-    error_report("function cpu_get_phys_page_attrs_debug not "
-                    "implemented, aborting");
-    return -1;
-}
-
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
     env->features |= 1ULL << feature;
@@ -161,7 +153,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->dump_state = tricore_cpu_dump_state;
     cc->set_pc = tricore_cpu_set_pc;
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
-    cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
+    cc->get_phys_page_debug = tricore_cpu_get_phys_page_debug;
     cc->tcg_initialize = tricore_tcg_init;
     cc->tlb_fill = tricore_cpu_tlb_fill;
 }
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index d5db7b2c03..7715293263 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -42,6 +42,19 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
 
     return ret;
 }
+
+hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(cs);
+    hwaddr phys_addr;
+    int prot;
+    int mmu_idx = cpu_mmu_index(&cpu->env, false);
+
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+        return -1;
+    }
+    return phys_addr;
+}
 #endif
 
 /* TODO: Add exeption support*/
-- 
2.26.2


