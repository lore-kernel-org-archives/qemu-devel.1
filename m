Received: from eggs.gnu.org ([2001:4830:134:3::10]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dQIwO-0007R2-1U
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dQIwJ-0003jH-42
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:47:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35848
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dQIwI-0003ir-TV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:47:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5SJj0UG018238
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 15:47:48 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcj0cadhm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 15:47:48 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 16:47:46 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 16:47:31 -0300
Message-Id: <20170628194731.15742-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr.c: do not adjust rma_size with
 KVM RADIX in ppc_spapr_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

In ppc_spapr_init when setting rma_size we have the following verification:

    if (rma_alloc_size && (rma_alloc_size < node0_size)) {
        spapr->rma_size = rma_alloc_size;
    } else {
        spapr->rma_size = node0_size;

        /* With KVM, we don't actually know whether KVM supports an
         * unbounded RMA (PR KVM) or is limited by the hash table size
         * (HV KVM using VRMA), so we always assume the latter
         *
         * In that case, we also limit the initial allocations for RTAS
         * etc... to 256M since we have no way to know what the VRMA size
         * is going to be as it depends on the size of the hash table
         * isn't determined yet.
         */
        if (kvm_enabled()) {
            spapr->vrma_adjust = 1;
            spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
        }

This code (and the comment that precedes it) is taking constraints and conditions
related to KVM HPT guests and filtering them with "if (kvm_enabled())". Note that
this also means that, for KVM RADIX guests, we'll change rma_size and set the
vrma_adjust flag as well.

The flag vrma_adjust is used inside 'spapr_setup_hpt_and_vrma', which in turn is
called from ppc_spapr_reset as follows:

    if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
        /* If using KVM with radix mode available, VCPUs can be started
         * without a HPT because KVM will start them in radix mode.
         * Set the GR bit in PATB so that we know there is no HPT. */
        spapr->patb_entry = PATBE1_GR;
    } else {
        spapr_setup_hpt_and_vrma(spapr);
    }

In short, when running a KVM HPT guest, rma_size is shrinked, the flag vrma_adjust
is set and later on spapr_setup_hpt_and_vrma() is called to make the proper
adjustments. When running a KVM RADIX guest no post adjustment is made, leaving
rma_size with the value MIN(spapr->rma_size, 0x10000000).

This changed rma_size value is causing the code to populate more memory nodes
in 'spapr_populate_memory', which in turn results in differences in the memory
layout at SLOF init (alloc_top and rmo_top). At first this isn't causing bugs or
guest misbehavior in case of KVM RADIX - the problem is that this is happening
due to KVM HPT code.

This patch changes the if conditional inside ppc_spapr_init to:

        if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
            spapr->vrma_adjust = 1;
            spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
        }

To restrict the rma changes only to KVM HPT guests. If we need to do
adjustments for RADIX we should either do it explicitly in its own code
or make it clearer that a common code applies to both HPT and RADIX.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7d9af75..117ea9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2164,7 +2164,7 @@ static void ppc_spapr_init(MachineState *machine)
          * is going to be as it depends on the size of the hash table
          * isn't determined yet.
          */
-        if (kvm_enabled()) {
+        if (kvm_enabled() && !kvmppc_has_cap_mmu_radix()) {
             spapr->vrma_adjust = 1;
             spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
         }
-- 
2.9.4
