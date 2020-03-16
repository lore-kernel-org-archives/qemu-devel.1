Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217AC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DD62051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DD62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDexT-0003RQ-RR
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jDeP6-0001C0-RG
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 21:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jDeP0-00085Z-2o
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 21:18:49 -0400
Received: from [107.174.27.60] (port=33320 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1jDeOz-0007rj-SK; Sun, 15 Mar 2020 21:18:46 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 3F003AE80048;
 Sun, 15 Mar 2020 21:17:00 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr/rtas: Reserve space for RTAS blob and log
Date: Mon, 16 Mar 2020 12:18:41 +1100
Message-Id: <20200316011841.99970-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment SLOF reserves space for RTAS and instantiates the RTAS blob
which is 20 bytes binary blob calling an hypercall. The rest of the RTAS
area is a log which SLOF has no idea about but QEMU does.

This moves RTAS sizing to QEMU and this overrides the size from SLOF.
The only remaining problem is that SLOF copies the number of bytes it
reserved (2KB for now) so QEMU needs to reserve at least this much;
SLOF will be fixed separately to check that rtas-size from QEMU is
enough for those 20 bytes the H_RTAS hcall.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h | 1 +
 hw/ppc/spapr.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2015e37ac5c8..35b489a54929 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -736,6 +736,7 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
 #define SPAPR_IS_PCI_LIOBN(liobn)   (!!((liobn) & 0x80000000))
 #define SPAPR_PCI_DMA_WINDOW_NUM(liobn) ((liobn) & 0xff)
 
+#define RTAS_SIZE               2048
 #define RTAS_ERROR_LOG_MAX      2048
 
 /* Offset from rtas-base where error log is placed */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 64bc8b83e91e..d3db3ec56e9c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -967,6 +967,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
 
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
-- 
2.17.1


