Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE24C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6122146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EnwRO3qQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6122146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5HW-0000mt-UV
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ia-0000LJ-8r
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iZ-0005vp-31
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:20 -0500
Received: from ozlabs.org ([203.11.71.1]:49689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iY-0005aN-NY; Mon, 16 Dec 2019 23:44:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWV4SJlz9sSs; Tue, 17 Dec 2019 15:43:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557814;
 bh=DSSa+2JspH3S+BZddb51VgY8bu9p/D1QJFBo+rul0po=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EnwRO3qQoy/YU3F+usm43cfCb9ZV920WTksOoJBDGErVlEEcYnjPUL4bRPCyy4QUo
 lwpYDw21utzN6K5FdrijBG8MY/NkwQjQjBFmQs8PDuh6ok74LhwIbCm6DkQK6piiqv
 Uy+P4q8GKXJaSPQ78+KXMUlmSKB6Hax0LnRwYtbk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 32/88] ppc/pnv: Introduce a pnv_xive_is_cpu_enabled() helper
Date: Tue, 17 Dec 2019 15:42:26 +1100
Message-Id: <20191217044322.351838-33-david@gibson.dropbear.id.au>
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

and use this helper to exclude CPUs which are not enabled in the XIVE
controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   | 19 +++++++++++++++++++
 include/hw/ppc/pnv.h |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9798bd9e72..ec8349ee4a 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -372,6 +372,21 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
+/*
+ * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
+ * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
+ * second register covers cores 16-23 (normal) or 8-11 (fused).
+ */
+static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir =3D ppc_cpu_pir(cpu);
+    uint32_t fc =3D PNV9_PIR2FUSEDCORE(pir);
+    uint64_t reg =3D fc < 8 ? PC_THREAD_EN_REG0 : PC_THREAD_EN_REG1;
+    uint32_t bit =3D pir & 0x3f;
+
+    return xive->regs[reg >> 3] & PPC_BIT(bit);
+}
+
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint8_t priority,
@@ -391,6 +406,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
             XiveTCTX *tctx;
             int ring;
=20
+            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+                continue;
+            }
+
             tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
=20
             /*
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 03cb429f21..12b0169a40 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -99,6 +99,11 @@ typedef struct Pnv9Chip {
     PnvQuad      *quads;
 } Pnv9Chip;
=20
+/*
+ * A SMT8 fused core is a pair of SMT4 cores.
+ */
+#define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
+
 typedef struct PnvChipClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
--=20
2.23.0


