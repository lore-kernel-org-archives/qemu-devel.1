Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845BC35DEC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A74B2084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pfh6D2b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NOM-0002eY-Ms
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIR-0006cw-UL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NIQ-0008B0-Fj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:37:55 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:58809)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6NIQ-00087b-46; Mon, 24 Feb 2020 18:37:54 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RJQ6596pz9sSX; Tue, 25 Feb 2020 10:37:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582587454;
 bh=2HMMcHS71SZcl1mdEZbUO8BqzSboB4TqxyWpdz2JwgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pfh6D2b/hCpTqdbe2xOgLDE1NoGtFr4CAZgf0QxMb3Q7KW65rTdeTtxxcbTxob/UK
 G8g9SIEomasRU+4kCF661JpmUjnHKv+qlUeBLLWzYGaAjto9xKbqOwHj6OXP69UMHL
 pFNofn+Ijb9IE0SM+go0J902hUzDr7wBb/B90SNI=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: [PATCH v6 17/18] spapr: Clean up RMA size calculation
Date: Tue, 25 Feb 2020 10:37:23 +1100
Message-Id: <20200224233724.46415-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224233724.46415-1-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the calculation of the Real Mode Area (RMA) size into a helper
function.  While we're there clean it up and correct it in a few ways:
  * Add comments making it clearer where the various constraints come fro=
m
  * Remove a pointless check that the RMA fits within Node 0 (we've just
    clamped it so that it does)

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 59 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6e9f15f64d..f0354b699d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2648,6 +2648,40 @@ static PCIHostState *spapr_create_default_phb(void=
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
+     * Clamp the RMA size based on machine type.  This is for
+     * migration compatibility with older qemu versions, which limited
+     * the RMA size for complicated and mostly bad reasons.
+     */
+    if (smc->rma_limit) {
+        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
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
@@ -2660,7 +2694,6 @@ static void spapr_machine_init(MachineState *machin=
e)
     int i;
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
-    hwaddr node0_size =3D spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err =3D NULL;
@@ -2700,22 +2733,7 @@ static void spapr_machine_init(MachineState *machi=
ne)
         exit(1);
     }
=20
-    spapr->rma_size =3D node0_size;
-
-    /*
-     * Clamp the RMA size based on machine type.  This is for
-     * migration compatibility with older qemu versions, which limited
-     * the RMA size for complicated and mostly bad reasons.
-     */
-    if (smc->rma_limit) {
-        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
-    }
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
@@ -2954,13 +2972,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
         }
     }
=20
-    if (spapr->rma_size < MIN_RMA_SLOF) {
-        error_report(
-            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real =
Mode Area memory)",
-            MIN_RMA_SLOF / MiB);
-        exit(1);
-    }
-
     if (kernel_filename) {
         uint64_t lowaddr =3D 0;
=20
--=20
2.24.1


