Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED07C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA0A206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PISQw3RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA0A206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Io-0000P6-R7
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95l-000170-G1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95h-0002mL-Qz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:57 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41261 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95h-0001vO-Aw; Tue, 17 Mar 2020 06:04:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKx0hl1z9sT3; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439477;
 bh=czLuj0l/HYBaWKsNYfYuhLXXjydZHWUzwaXT+FX4eR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PISQw3RUdijZVmThNvhG5TzTfgJjRkG3x5PzLWOR4EaFGhLoE4Tm7QcFkjRN7MYWH
 zz+ttIQQOh/1QjVne7kPqDIsYC3g4kY3MAVdF1P053/WnFI7m63QptY08IV3R5PoXQ
 /FyIqoJXhC4wDCQ8XxiMB+za6Uqpl06QthlwIVRU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 19/45] spapr: Don't attempt to clamp RMA to VRMA constraint
Date: Tue, 17 Mar 2020 21:03:57 +1100
Message-Id: <20200317100423.622643-20-david@gibson.dropbear.id.au>
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

The Real Mode Area (RMA) is the part of memory which a guest can access
when in real (MMU off) mode.  Of course, for a guest under KVM, the MMU
isn't really turned off, it's just in a special translation mode - Virtua=
l
Real Mode Area (VRMA) - which looks like real mode in guest mode.

The mechanics of how this works when using the hash MMU (HPT) put a
constraint on the size of the RMA, which depends on the size of the
HPT.  So, the latter part of spapr_setup_hpt_and_vrma() clamps the RMA
we advertise to the guest based on this VRMA limit.

There are several things wrong with this:
 1) spapr_setup_hpt_and_vrma() doesn't actually clamp, it takes the minim=
um
    of Node 0 memory size and the VRMA limit.  That will *often* work the
    same as clamping, but there can be other constraints on RMA size whic=
h
    supersede Node 0 memory size.  We have real bugs caused by this
    (currently worked around in the guest kernel)
 2) Some callers of spapr_setup_hpt_and_vrma() are in a situation where
    we're past the point that we can actually advertise an RMA limit to t=
he
    guest
 3) But most fundamentally, the VRMA limit depends on host configuration
    (page size) which shouldn't be visible to the guest, but this partial=
ly
    exposes it.  This can cause problems with migration in certain edge
    cases, although we will mostly get away with it.

In practice, this clamping is almost never applied anyway.  With 64kiB
pages and the normal rules for sizing of the HPT, the theoretical VRMA
limit will be 4x(guest memory size) and so never hit.  It will hit with
4kiB pages, where it will be (guest memory size)/4.  However all mainstre=
am
distro kernels for POWER have used a 64kiB page size for at least 10 year=
s.

So, simply replace this logic with a check that the RMA we've calculated
based only on guest visible configuration will fit within the host implie=
d
VRMA limit.  This can break if running HPT guests on a host kernel with
4kiB page size.  As noted that's very rare.  There also exist several
possible workarounds:
  * Change the host kernel to use 64kiB pages
  * Use radix MMU (RPT) guests instead of HPT
  * Use 64kiB hugepages on the host to back guest memory
  * Increase the guest memory size so that the RMA hits one of the fixed
    limits before the RMA limit.  This is relatively easy on POWER8 which
    has a 16GiB limit, harder on POWER9 which has a 1TiB limit.
  * Use a guest NUMA configuration which artificially constrains the RMA
    within the VRMA limit (the RMA must always fit within Node 0).

Previously, on KVM, we also temporarily reduced the rma_size to 256M so
that the we'd load the kernel and initrd safely, regardless of the VRMA
limit.  This was a) confusing, b) could significantly limit the size of
images we could load and c) introduced a behavioural difference between
KVM and TCG.  So we remove that as well.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         | 28 ++++++++++------------------
 hw/ppc/spapr_hcall.c   |  4 ++--
 include/hw/ppc/spapr.h |  3 +--
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 18bf4bc3de..ef7667455c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1569,7 +1569,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift,
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
=20
-void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
+void spapr_setup_hpt(SpaprMachineState *spapr)
 {
     int hpt_shift;
=20
@@ -1585,10 +1585,16 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *=
spapr)
     }
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
=20
-    if (spapr->vrma_adjust) {
+    if (kvm_enabled()) {
         hwaddr vrma_limit =3D kvmppc_vrma_limit(spapr->htab_shift);
=20
-        spapr->rma_size =3D MIN(spapr_node0_size(MACHINE(spapr)), vrma_l=
imit);
+        /* Check our RMA fits in the possible VRMA */
+        if (vrma_limit < spapr->rma_size) {
+            error_report("Unable to create %" HWADDR_PRIu
+                         "MiB RMA (VRMA only allows %" HWADDR_PRIu "MiB"=
,
+                         spapr->rma_size / MiB, vrma_limit / MiB);
+            exit(EXIT_FAILURE);
+        }
     }
 }
=20
@@ -1628,7 +1634,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
         spapr->patb_entry =3D PATE1_GR;
         spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
     } else {
-        spapr_setup_hpt_and_vrma(spapr);
+        spapr_setup_hpt(spapr);
     }
=20
     qemu_devices_reset();
@@ -2695,20 +2701,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
=20
     spapr->rma_size =3D node0_size;
=20
-    /* With KVM, we don't actually know whether KVM supports an
-     * unbounded RMA (PR KVM) or is limited by the hash table size
-     * (HV KVM using VRMA), so we always assume the latter
-     *
-     * In that case, we also limit the initial allocations for RTAS
-     * etc... to 256M since we have no way to know what the VRMA size
-     * is going to be as it depends on the size of the hash table
-     * which isn't determined yet.
-     */
-    if (kvm_enabled()) {
-        spapr->vrma_adjust =3D 1;
-        spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
-    }
-
     /* Actually we don't support unbounded RMA anymore since we added
      * proper emulation of HV mode. The max we can get is 16G which
      * also happens to be what we configure for PAPR mode so make sure
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c2b3286625..40c86e91eb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1458,7 +1458,7 @@ static void spapr_check_setup_free_hpt(SpaprMachine=
State *spapr,
         spapr_free_hpt(spapr);
     } else if (!(patbe_new & PATE1_GR)) {
         /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
-        spapr_setup_hpt_and_vrma(spapr);
+        spapr_setup_hpt(spapr);
     }
     return;
 }
@@ -1845,7 +1845,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
          * (because the guest isn't going to use radix) then set it up h=
ere. */
         if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
             /* legacy hash or new hash: */
-            spapr_setup_hpt_and_vrma(spapr);
+            spapr_setup_hpt(spapr);
         }
=20
         if (fdt_bufsize < sizeof(hdr)) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a4216935a1..90dbc55931 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -156,7 +156,6 @@ struct SpaprMachineState {
     SpaprPendingHpt *pending_hpt; /* in-progress resize */
=20
     hwaddr rma_size;
-    int vrma_adjust;
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
@@ -795,7 +794,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool =
reset, size_t space);
 void spapr_events_init(SpaprMachineState *sm);
 void spapr_dt_events(SpaprMachineState *sm, void *fdt);
 void close_htab_fd(SpaprMachineState *spapr);
-void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
+void spapr_setup_hpt(SpaprMachineState *spapr);
 void spapr_free_hpt(SpaprMachineState *spapr);
 SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
 void spapr_tce_table_enable(SpaprTceTable *tcet,
--=20
2.24.1


