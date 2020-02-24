Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB7C35DEA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419F92084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m1BBjZgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419F92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NOE-0002Ld-EJ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NNI-0000xk-2I
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6NNG-0001j2-Sn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:42:56 -0500
Received: from ozlabs.org ([203.11.71.1]:57215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6NNG-0001im-Ha; Mon, 24 Feb 2020 18:42:54 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RJQ72m7Gz9sSb; Tue, 25 Feb 2020 10:37:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582587455;
 bh=GyzBZMDoAMPRnJCvIsnfxFsMHlBhNBqGfLr4nb9ELlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m1BBjZgfAz9evchJx+24BlgIm7hMhYLqsbeOYjl9TXtx6/Q8By5QvP9oH4pJFpoBQ
 lQRHCZTFZaOsoZx2IaQG1Bm+TWTioLzIcY5c7b9eubK6rgQuCHVPbmappWY4kt1Q20
 L4u53doG3Aeq0TSeRKyVOGQ/hRlBra6gDrQUnOII=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: [PATCH v6 18/18] spapr: Fold spapr_node0_size() into its only caller
Date: Tue, 25 Feb 2020 10:37:24 +1100
Message-Id: <20200224233724.46415-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224233724.46415-1-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
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

The Real Mode Area (RMA) needs to fit within the NUMA node owning memory
at address 0.  That's usually node 0, but can be a later one if there are
some nodes which have no memory (only CPUs).

This is currently handled by the spapr_node0_size() helper.  It has only
one caller, so there's not a lot of point splitting it out.  It's also
extremely easy to misread the code as clamping to the size of the smalles=
t
node rather than the first node with any memory.

So, fold it into the caller, and add some commentary to make it a bit
clearer exactly what it's doing.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f0354b699d..9ba645c9cb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -296,20 +296,6 @@ static void spapr_populate_pa_features(SpaprMachineS=
tate *spapr,
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
 }
=20
-static hwaddr spapr_node0_size(MachineState *machine)
-{
-    if (machine->numa_state->num_nodes) {
-        int i;
-        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
-            if (machine->numa_state->nodes[i].node_mem) {
-                return MIN(pow2floor(machine->numa_state->nodes[i].node_=
mem),
-                           machine->ram_size);
-            }
-        }
-    }
-    return machine->ram_size;
-}
-
 static void add_str(GString *s, const gchar *s1)
 {
     g_string_append_len(s, s1, strlen(s1) + 1);
@@ -2652,10 +2638,24 @@ static hwaddr spapr_rma_size(SpaprMachineState *s=
papr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
     hwaddr rma_size =3D machine->ram_size;
-    hwaddr node0_size =3D spapr_node0_size(machine);
=20
     /* RMA has to fit in the first NUMA node */
-    rma_size =3D MIN(rma_size, node0_size);
+    if (machine->numa_state->num_nodes) {
+        /*
+         * It's possible for there to be some zero-memory nodes first
+         * in the list.  We need the RMA to fit inside the memory of
+         * the first node which actually has some memory.
+         */
+        int i;
+
+        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
+            if (machine->numa_state->nodes[i].node_mem !=3D 0) {
+                rma_size =3D MIN(rma_size,
+                               machine->numa_state->nodes[i].node_mem);
+                break;
+            }
+        }
+    }
=20
     /*
      * VRMA access is via a special 1TiB SLB mapping, so the RMA can
@@ -2672,6 +2672,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *sp=
apr, Error **errp)
         spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
     }
=20
+    /*
+     * RMA size must be a power of 2
+     */
+    rma_size =3D pow2floor(rma_size);
+
     if (rma_size < (MIN_RMA_SLOF * MiB)) {
         error_setg(errp,
 "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)",
--=20
2.24.1


