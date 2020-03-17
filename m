Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67351C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EF4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BdEcvAiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EF4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Ob-00042a-BS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96T-0002JQ-GG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96S-0008AZ-3q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39649 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96R-0005bs-OR; Tue, 17 Mar 2020 06:05:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL070bTz9sTW; Tue, 17 Mar 2020 21:04:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439480;
 bh=oiZ3JZYRTp5ngIchAz0dmXK42fd85g4mCvyBpTXbBeM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BdEcvAiLfudgqFFJJFolwfh7oKjpjtDE2/kA0wOMl09hz/FyVz4QGwfy5mC4WsbB1
 BlqfJjji1B4nKJWb/sNYf/hNH//N1SG4zChNnpBF3fK0VLRXFkCAx5cj+owyzehUSo
 +nRPRyw1IQdfMNm6Osphnx8MAy1kyArRSfvN7+6U=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 33/45] spapr/rtas: Reserve space for RTAS blob and log
Date: Tue, 17 Mar 2020 21:04:11 +1100
Message-Id: <20200317100423.622643-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment SLOF reserves space for RTAS and instantiates the RTAS blob
which is 20 bytes binary blob calling an hypercall. The rest of the RTAS
area is a log which SLOF has no idea about but QEMU does.

This moves RTAS sizing to QEMU and this overrides the size from SLOF.
The only remaining problem is that SLOF copies the number of bytes it
reserved (2KB for now) so QEMU needs to reserve at least this much;
SLOF will be fixed separately to check that rtas-size from QEMU is
enough for those 20 bytes for the H_RTAS hcall.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200316011841.99970-1-aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 1 +
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1038420c4a..2f9a65b414 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -967,6 +967,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, v=
oid *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
=20
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2015e37ac5..35b489a549 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -736,6 +736,7 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *=
fdt, hwaddr addr);
 #define SPAPR_IS_PCI_LIOBN(liobn)   (!!((liobn) & 0x80000000))
 #define SPAPR_PCI_DMA_WINDOW_NUM(liobn) ((liobn) & 0xff)
=20
+#define RTAS_SIZE               2048
 #define RTAS_ERROR_LOG_MAX      2048
=20
 /* Offset from rtas-base where error log is placed */
--=20
2.24.1


