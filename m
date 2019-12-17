Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798ECC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4370C20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KSKF80Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4370C20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4uQ-0008KG-PJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i0-00088S-9m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hz-0005Q5-8y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:44 -0500
Received: from ozlabs.org ([203.11.71.1]:44197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hy-0005It-TO; Mon, 16 Dec 2019 23:43:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWQ3Mvlz9sSc; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557810;
 bh=XLlY5FBUcVMyrEFkz9vewlVb4cLY9FD8ynFlsFrhYL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KSKF80CaXWmW06rRmci+xEwVB+LYvGxtsvh3hzelY8T+Dd9SIZYtXbAbThavsbihv
 ZK4xd0fHbPdra+NZVCXDxMYZ4lu0cqExqMecN3HM4ALgydCbNgPZUjZ/hIryxwHDrz
 EQcy7JaDgk7sngoCe0DNHkEHCMo2/cGH3V1YzyDQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/88] ppc/pnv: Add a LPC "ranges" property
Date: Tue, 17 Dec 2019 15:42:10 +1100
Message-Id: <20191217044322.351838-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

And fix a typo in the MEM address space definition.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191118091908.15044-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index fb9f930320..c5a85c38c7 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -86,7 +86,7 @@ enum {
 #define ISA_FW_SIZE             0x10000000
 #define LPC_IO_OPB_ADDR         0xd0010000
 #define LPC_IO_OPB_SIZE         0x00010000
-#define LPC_MEM_OPB_ADDR        0xe0010000
+#define LPC_MEM_OPB_ADDR        0xe0000000
 #define LPC_MEM_OPB_SIZE        0x10000000
 #define LPC_FW_OPB_ADDR         0xf0000000
 #define LPC_FW_OPB_SIZE         0x10000000
@@ -143,6 +143,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_of=
fset)
                             cpu_to_be32(PNV9_LPCM_SIZE >> 32),
                             cpu_to_be32((uint32_t)PNV9_LPCM_SIZE),
     };
+    uint32_t lpc_ranges[12] =3D { 0, 0,
+                                cpu_to_be32(LPC_MEM_OPB_ADDR),
+                                cpu_to_be32(LPC_MEM_OPB_SIZE),
+                                cpu_to_be32(1), 0,
+                                cpu_to_be32(LPC_IO_OPB_ADDR),
+                                cpu_to_be32(LPC_IO_OPB_SIZE),
+                                cpu_to_be32(3), 0,
+                                cpu_to_be32(LPC_FW_OPB_ADDR),
+                                cpu_to_be32(LPC_FW_OPB_SIZE),
+    };
     uint32_t reg[2];
=20
     /*
@@ -211,6 +221,8 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_off=
set)
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, offset, "compatible", lpc_compat,
                       sizeof(lpc_compat))));
+    _FDT((fdt_setprop(fdt, offset, "ranges", lpc_ranges,
+                      sizeof(lpc_ranges))));
=20
     return 0;
 }
--=20
2.23.0


