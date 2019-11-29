Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD40C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C34F2176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ur83RSAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C34F2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaViD-0006tl-9Z
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 21:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVBo-0002Xk-54
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVBk-0003Ht-Gl
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:18 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46095 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaVBi-0002tc-Vc; Thu, 28 Nov 2019 20:35:16 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PHBN2j4tz9sRG; Fri, 29 Nov 2019 12:35:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574991308;
 bh=55/r0wZVyzKD4cnomur2Zr9HJjTyRz7z6AB2879fBAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ur83RSAQ5EklczAC5H6aE42pb0DQAV37Gxz1itbDp4TaIC6eUftpECzt3omUPjlRA
 q+ySj0BMmbpLDckaQs3NxSLYq2+ppoY1gYf9sQeTeSmZBmYs+TBOSGgfUVsRLbLzoY
 3ryOO4w2OFRQr2D2mwtvOZcdkXb40dCl878GKghQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 3/4] spapr: Clean up RMA size calculation
Date: Fri, 29 Nov 2019 12:35:03 +1100
Message-Id: <20191129013504.145455-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129013504.145455-1-david@gibson.dropbear.id.au>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the calculation of the Real Mode Area (RMA) size into a helper
function.  While we're there clean it up and correct it in a few ways:
  * Add comments making it clearer where the various constraints come fro=
m
  * Remove a pointless check that the RMA fits within Node 0 (we've just
    clamped it so that it does)
  * The 16GiB limit we apply is only correct for POWER8, but there is als=
o
    a 1TiB limit that applies on POWER9.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 52c39daa99..7efd4f2b85 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2664,6 +2664,40 @@ static PCIHostState *spapr_create_default_phb(void=
)
     return PCI_HOST_BRIDGE(dev);
 }
=20
+static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    hwaddr rma_size =3D machine->ram_size;
+    hwaddr node0_size =3D spapr_node0_size(machine);
+
+    /* RMA has to fit in the first NUMA node */
+    rma_size =3D MIN(rma_size, node0_size);
+
+    /*
+     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
+     * never exceed that
+     */
+    rma_size =3D MIN(rma_size, TiB);
+
+    /*
+     * RMA size is controlled in hardware by LPCR[RMLS].  On POWER8
+     * the largest RMA that can be specified there is 16GiB
+     */
+    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_=
00,
+                               0, spapr->max_compat_pvr)) {
+        rma_size =3D MIN(rma_size, 16 * GiB);
+    }
+
+    if (rma_size < (MIN_RMA_SLOF * MiB)) {
+        error_setg(errp,
+"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)",
+                   MIN_RMA_SLOF);
+        return -1;
+    }
+
+    return rma_size;
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
@@ -2675,7 +2709,6 @@ static void spapr_machine_init(MachineState *machin=
e)
     int i;
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
-    hwaddr node0_size =3D spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err =3D NULL;
@@ -2715,20 +2748,7 @@ static void spapr_machine_init(MachineState *machi=
ne)
         exit(1);
     }
=20
-    spapr->rma_size =3D node0_size;
-
-    /* Actually we don't support unbounded RMA anymore since we added
-     * proper emulation of HV mode. The max we can get is 16G which
-     * also happens to be what we configure for PAPR mode so make sure
-     * we don't do anything bigger than that
-     */
-    spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
-
-    if (spapr->rma_size > node0_size) {
-        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx"=
)",
-                     spapr->rma_size);
-        exit(1);
-    }
+    spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
=20
     /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
@@ -2956,13 +2976,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
         }
     }
=20
-    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
-        error_report(
-            "pSeries SLOF firmware requires >=3D %ldM guest RMA (Real Mo=
de Area memory)",
-            MIN_RMA_SLOF);
-        exit(1);
-    }
-
     if (kernel_filename) {
         uint64_t lowaddr =3D 0;
=20
--=20
2.23.0


