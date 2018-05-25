Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fMK3u-0001kL-KD
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fMK3q-0006Mm-KO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:15:46 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 25 May 2018 22:15:23 +0100
Message-Id: <20180525211523.14897-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] 40p: remove pci_allow_0_address = true from
 40p machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au

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
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index be4db6a687..5ed0bcd862 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -884,7 +884,6 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->desc = "IBM RS/6000 7020 (40p)",
     mc->init = ibm_40p_init;
     mc->max_cpus = 1;
-    mc->pci_allow_0_address = true;
     mc->default_ram_size = 128 * M_BYTE;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
-- 
2.11.0
