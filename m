Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B0C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2082054F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="CQ4659hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2082054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvC0-0007oA-5d
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv54-0002OT-Tz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv53-00029O-RW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:10 -0400
Received: from shirlock.uni-paderborn.de ([131.234.189.15]:41602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iEv4w-00023m-U8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yNqUo6OL71pSo39VzqYet34WA5a4ptfKBtNP+PL5BPQ=; b=CQ4659hxdWmjYlq32Vx1TwHMyF
 zEghLw9TUEdlnOzqW4emZ37yoUcDKIqlbLhy1sJNJ8t7fW+0kEcISBGvKfkjf9yV47rFBoqBInz8Z
 9bc9k8MSytBKYnIUVTfz91pIP8uwDF92vhC6OtYr+jjUE8rI8GNUSqBETUodadOQA97g=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/tricore: Implement tricore_cpu_get_phys_page_debug
Date: Mon, 30 Sep 2019 14:46:42 +0200
Message-Id: <20190930124643.179695-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
References: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.30.123917, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.27.5650000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.234.189.15
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
Cc: david.brenken@efs-auto.de
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
index df807c1d74..7159d9cf8f 100644
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
2.23.0


