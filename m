Received: from eggs.gnu.org ([2001:4830:134:3::10]:58721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3j-0002fI-83
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3i-0001o9-6L
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:36 +1000
Message-Id: <20180612064503.14282-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/33] 40p: remove pci_allow_0_address = true
 from 40p machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The Linux sandalfoot zImage has an initialisation process which resets the
VGA controller by setting all the BAR addresses to zero to access the VGA
ioports at their legacy addresses.

Unfortunately setting the framebuffer BAR to address 0 makes the framebuffer
memory overlap the internal VGA memory causing accesses to fail, and so
prevents the kernel from switching successfully to text mode.

Since OpenHackWare configures the framebuffer BAR address outside of the legacy
VGA internal memory space, remove pci_allow_0_address from the 40p machine class
which causes the BAR reprogramming to zero to fail and so the VGA internal
memory can be accessed correctly again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index a1e7219db6..dbbe749bde 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -885,7 +885,6 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->desc = "IBM RS/6000 7020 (40p)",
     mc->init = ibm_40p_init;
     mc->max_cpus = 1;
-    mc->pci_allow_0_address = true;
     mc->default_ram_size = 128 * M_BYTE;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
-- 
2.17.1
