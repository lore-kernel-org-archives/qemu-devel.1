Received: from eggs.gnu.org ([2001:4830:134:3::10]:35317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyZEV-0002nD-Kb
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyZES-0003Of-H4
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:08:47 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  8 Sep 2018 10:08:17 +0100
Message-Id: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 0/3] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

According to the PReP specification section 6.1.6 "System Interrupt
Assignments", all PCI interrupts are routed via IRQ 15.

In the case of the 40p machine this isn't quite true in that it has a routing
quirk: the LSI SCSI device is always routed to IRQ 13. At least Linux and
NetBSD compare the model name presented by the firmware to "IBM PPS Model
6015", and if it matches will active this quirk.

There is also a slight issue in that whilst the legacy PReP machine is still
present in the codebase, the old IRQ routing must still be preserved. This is
done by introducing a new "is-legacy-prep" qdev property to the raven PCI host
bridge which preserves the old routing for -M prep until that code is finally
removed.

In order for guest OSs to make use of the fixed IRQ routing, the model name
in the residual data must be changed in OpenBIOS using the diff below:

diff --git a/arch/ppc/qemu/context.c b/arch/ppc/qemu/context.c
index 06e0122..5815895 100644
--- a/arch/ppc/qemu/context.c
+++ b/arch/ppc/qemu/context.c
@@ -111,7 +111,7 @@ static void *
 residual_build(uint32_t memsize, uint32_t load_base, uint32_t load_size)
 {
     residual_t *res;
-    const unsigned char model[] = "Qemu\0PPC\0";
+    const unsigned char model[] = "IBM PPS Model 6015\0";
     int i;
 
     res = malloc(sizeof(residual_t));

With the above OpenBIOS patch applied as well as this patchset, it is now
possible to boot the sandalfoot zImage all the way through to a working
userspace when using OpenBIOS.

(Note: this patchset requires the changes in my previous patchset "scsi:
replace lsi53c895a_create() and lsi53c810_create() functions)

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (3):
  raven: some minor IRQ-related tidy-ups
  40p: use OR gate to wire up raven PCI interrupts
  40p: add fixed IRQ routing for LSI SCSI device

 hw/pci-host/prep.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-------
 hw/ppc/prep.c      | 12 ++++++----
 2 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.11.0
