Received: from eggs.gnu.org ([2001:4830:134:3::10]:58296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1eBXsD-0000sd-KL
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 22:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1eBXsA-0006p9-Et
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 22:14:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1eBXsA-0006oi-6O
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 22:14:50 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA63DhRZ058793
	for <qemu-devel@nongnu.org>; Sun, 5 Nov 2017 22:14:44 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e220pjj38-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 22:14:44 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Mon, 6 Nov 2017 03:14:42 -0000
Date: Mon, 6 Nov 2017 14:14:35 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <4d05be59374384a32c09437f5d0308bfafaf0128.1509937620.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] target/ppc: correct htab shift for hash on
 radix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au

KVM HV will soon support running a guest in hash mode on a POWER9 host
running in radix mode (see [1]), however the guest currently fails to
boot.

This is because the "htab_shift" value (the size of the MMU's hash
table) is added to the device tree before KVM has had a chance to
change it. If the host is in hash mode, KVM does not need to change it
and so the problem is not seen, but when the host is in radix mode a
change is required and we see a problem.

To fix this, move the call spapr_setup_hpt_and_vrma() (where
htab_shift could be changed) up a little so that it's called before
spapr_h_cas_compose_response() (where htab_shift is added to the
device tree).

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

[1] See http://www.spinics.net/lists/kvm-ppc/msg13057.html
---
I tested this patch using a kernel based on Paul's kvm-ppc-next branch from his
powerpc tree:
https://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/

 hw/ppc/spapr_hcall.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d59d1534d..be22a6b289 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1636,6 +1636,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
                                                           OV1_PPC_3_00);
     if (!spapr->cas_reboot) {
+        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
+         * (because the guest isn't going to use radix) then set it up here. */
+        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
+            /* legacy hash or new hash: */
+            spapr_setup_hpt_and_vrma(spapr);
+        }
         spapr->cas_reboot =
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) != 0);
@@ -1644,13 +1650,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (spapr->cas_reboot) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    } else {
-        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
-         * (because the guest isn't going to use radix) then set it up here. */
-        if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt_and_vrma(spapr);
-        }
     }
 
     return H_SUCCESS;
-- 
2.14.1.4.g334a7be4f
