Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735DC2BAEE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6771D206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 04:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Nz5WkQo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6771D206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbb6-0004mI-Dp
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 00:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba7-0003Ph-6y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jCba6-000768-3q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 00:05:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59867 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jCba5-0006rE-AX; Fri, 13 Mar 2020 00:05:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48dsYj34s9z9sSW; Fri, 13 Mar 2020 15:05:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584072345;
 bh=4+vqW/+RBRo5X6Te37ypI3apVYu8PMdyc07IjtIT7Ng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nz5WkQo2a7+N0qCHLKIu/aj1PsHVjdm5xcVcTbFYrlUUoWP2N1am8sM0yvxFALPGs
 bcE6Z/31+a8yd8EVzDcZ+ycD6RzXo6OZops2iwvGZNQZ3fUmukCq0RVtr0Qk0ES0pS
 5vIsYgtRsI0/Y0tpCym1YiBrdJ+tDhUjgRA9Bwx4=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com
Subject: [PATCH 4/4] spapr: Fold spapr_node0_size() into its only caller
Date: Fri, 13 Mar 2020 15:05:39 +1100
Message-Id: <20200313040539.819138-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313040539.819138-1-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
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
index 6c32ec3c0a..6a42c0f1c9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -295,20 +295,6 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
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
@@ -2631,10 +2617,24 @@ static hwaddr spapr_rma_size(SpaprMachineState *s=
papr, Error **errp)
     MachineState *machine =3D MACHINE(spapr);
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
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
+                hwaddr node_size =3D machine->numa_state->nodes[i].node_=
mem;
+                rma_size =3D MIN(rma_size, pow2floor(node_size));
+                break;
+            }
+        }
+    }
=20
     /*
      * VRMA access is via a special 1TiB SLB mapping, so the RMA can
@@ -2651,6 +2651,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *sp=
apr, Error **errp)
         rma_size =3D MIN(rma_size, smc->rma_limit);
     }
=20
+    /*
+     * RMA size must be a power of 2
+     */
+    rma_size =3D pow2floor(rma_size);
+
     if (rma_size < MIN_RMA_SLOF) {
         error_setg(errp,
 "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area me=
mory)",
--=20
2.24.1


