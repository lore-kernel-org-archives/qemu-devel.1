Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A1DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE73D20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZEDBd/qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE73D20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih53c-0004IC-IS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ie-0000Sz-GB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4id-00060a-72
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:24 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36595 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ic-0005cl-TD; Mon, 16 Dec 2019 23:44:23 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWW1C85z9sSy; Tue, 17 Dec 2019 15:43:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557815;
 bh=MNkuUrwEEOI6QJkCE3jk3dhRDtxbCW6eBnBkT4Cz3Ok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZEDBd/qP++CLQlsPY7kBwe4JVsb24pl8VRlhnnNQyPZCjQ3pFUL6sk09jtRiSH0RB
 53TXnpNiidqkvNEzo6EHlVQAl4YYuYNLKAA4FPDl4Ur+wTRsS54pyyKdkYT7xjDvIb
 5qcts6GIwvvxZplmezHaj9lbviITZ3mWCxT+nZh8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 33/88] ppc/pnv: Fix TIMA indirect access
Date: Tue, 17 Dec 2019 15:42:27 +1100
Message-Id: <20191217044322.351838-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the TIMA of a CPU needs to be accessed from the indirect page,
the thread id of the target CPU is first stored in the PC_TCTXT_INDIR0
register. This thread id is relative to the chip and not to the system.

Introduce a helper routine to look for a CPU of a given PIR and fix
pnv_xive_get_indirect_tctx() to scan only the threads of the local
chip and not the whole machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   | 13 +++++++------
 hw/ppc/pnv.c         | 17 +++++++++++++++++
 include/hw/ppc/pnv.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ec8349ee4a..b2ab2ccc91 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1400,12 +1400,13 @@ static const MemoryRegionOps pnv_xive_ic_lsi_ops =
=3D {
  */
=20
 /*
- * When the TIMA is accessed from the indirect page, the thread id
- * (PIR) has to be configured in the IC registers before. This is used
- * for resets and for debug purpose also.
+ * When the TIMA is accessed from the indirect page, the thread id of
+ * the target CPU is configured in the PC_TCTXT_INDIR0 register before
+ * use. This is used for resets and for debug purpose also.
  */
 static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXive *xive)
 {
+    PnvChip *chip =3D xive->chip;
     uint64_t tctxt_indir =3D xive->regs[PC_TCTXT_INDIR0 >> 3];
     PowerPCCPU *cpu =3D NULL;
     int pir;
@@ -1415,15 +1416,15 @@ static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXi=
ve *xive)
         return NULL;
     }
=20
-    pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt_indir) & 0xff;
-    cpu =3D ppc_get_vcpu_by_pir(pir);
+    pir =3D (chip->chip_id << 8) | GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt=
_indir);
+    cpu =3D pnv_chip_find_cpu(chip, pir);
     if (!cpu) {
         xive_error(xive, "IC: invalid PIR %x for indirect access", pir);
         return NULL;
     }
=20
     /* Check that HW thread is XIVE enabled */
-    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
+    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
         xive_error(xive, "IC: CPU %x is not enabled", pir);
     }
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d899c83e52..8f688f4efc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1371,6 +1371,23 @@ static void pnv_chip_class_init(ObjectClass *klass=
, void *data)
     dc->desc =3D "PowerNV Chip";
 }
=20
+PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
+{
+    int i, j;
+
+    for (i =3D 0; i < chip->nr_cores; i++) {
+        PnvCore *pc =3D chip->cores[i];
+        CPUCore *cc =3D CPU_CORE(pc);
+
+        for (j =3D 0; j < cc->nr_threads; j++) {
+            if (ppc_cpu_pir(pc->threads[j]) =3D=3D pir) {
+                return pc->threads[j];
+            }
+        }
+    }
+    return NULL;
+}
+
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(xi);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 12b0169a40..a58cfea3f2 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -162,6 +162,8 @@ typedef struct PnvChipClass {
 #define PNV_CHIP_INDEX(chip)                                    \
     (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
=20
+PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
+
 #define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
 #define PNV_MACHINE(obj) \
     OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
--=20
2.23.0


