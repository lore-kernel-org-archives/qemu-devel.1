Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D03C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41412072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41412072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZNz-0006b5-1j
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLJ-0002dL-CT
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:13 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16]:58556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLH-0000ep-8v
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:12 -0400
Received: from diego.uni-paderborn.de ([131.234.189.25]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.93 doohan)
 id 1jeZLE-000ReP-J2
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:22:08 +0200
Received: from mail.uni-paderborn.de by diego with queue id 675715-1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:22:07 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] target/tricore: Implement
 tricore_cpu_get_phys_page_debug
Date: Fri, 29 May 2020 09:21:47 +0200
Message-Id: <20200529072148.284037-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
References: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.5.29.71818, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.5.28.5740003
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6374311, da=78345992,
 mc=154, sc=3, hc=151, sp=1, fso=6374311, re=0, sd=0, hd=0
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: 
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
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
Cc: kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this also removes tricore_cpu_get_phys_page_attrs_debug() as it was a
temporary fix from b190f477e29c7cd03a8fee49c96d27f160e3f5b0.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
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


