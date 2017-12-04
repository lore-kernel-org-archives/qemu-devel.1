Received: from eggs.gnu.org ([2001:4830:134:3::10]:48393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjq-0005Zp-2G
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjl-0004LM-Sb
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Dec 2017 14:48:02 +1100
Message-Id: <20171204034802.7336-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171204034802.7336-1-david@gibson.dropbear.id.au>
References: <20171204034802.7336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/3] spapr: Include "pre-plugged" DIMMS in ram
 size calculation at reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

At guest reset time, we allocate a hash page table (HPT) for the guest
based on the guest's RAM size.  If dynamic HPT resizing is not available we
use the maximum RAM size, if it is we use the current RAM size.

But the "current RAM size" calculation is incorrect - we just use the
"base" ram_size from the machine structure.  This doesn't include any
pluggable DIMMs that are already plugged at reset time.

This means that if you try to start a 'pseries' machine with a DIMM
specified on the command line that's much larger than the "base" RAM size,
then the guest will get a woefully inadequate HPT.  This can lead to a
guest freeze during boot as it runs out of HPT space during initial MMU
setup.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a471de6cab..1ac7eb0f8c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1386,7 +1386,10 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
             && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
         hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
     } else {
-        hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->ram_size);
+        uint64_t current_ram_size;
+
+        current_ram_size = MACHINE(spapr)->ram_size + get_plugged_memory_size();
+        hpt_shift = spapr_hpt_shift_for_ramsize(current_ram_size);
     }
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
 
-- 
2.14.3
