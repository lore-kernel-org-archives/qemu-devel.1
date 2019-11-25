Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A890C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E88A20748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E88A20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8PC-0005F5-PV
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8L6-0002Ue-KA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8L5-0001VV-EO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:16 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:49033)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8L5-0001UN-8z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:59:15 -0500
Received: from player697.ha.ovh.net (unknown [10.109.160.153])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BAC9B14DE65
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 07:59:13 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id DDBD5C8094C1;
 Mon, 25 Nov 2019 06:59:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 07/20] ppc/pnv: Fix TIMA indirect access
Date: Mon, 25 Nov 2019 07:58:07 +0100
Message-Id: <20191125065820.927-8-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8917408738711538662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.203
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the TIMA of a CPU needs to be accessed from the indirect page,
the thread id of the target CPU is first stored in the PC_TCTXT_INDIR0
register. This thread id is relative to the chip and not to the system.

Introduce a helper routine to look for a CPU of a given PIR and fix
pnv_xive_get_indirect_tctx() to scan only the threads of the local
chip and not the whole machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/intc/pnv_xive.c   | 13 +++++++------
 hw/ppc/pnv.c         | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 12b0169a4010..a58cfea3f2fd 100644
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
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ec8349ee4a1f..b2ab2ccc91e7 100644
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
index d899c83e5255..8f688f4efc5a 100644
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
--=20
2.21.0


