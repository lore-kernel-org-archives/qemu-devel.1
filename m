Received: from eggs.gnu.org ([2001:4830:134:3::10]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fa4Gt-00009C-NB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fa4Gq-0005uw-FI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:13:59 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Mon,  2 Jul 2018 21:13:45 +0200
Message-Id: <20180702191345.19120-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH v2] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org

Drivers for this card exists on PPC-based AmigaOS guests so it is useful to
allow users to emulate the graphics card for PPC machines.

As cirrus vga is currently preferred over std(vga) in absence of any user
choice, this change also sets the default display of spapr machines to
std as otherwise qemu refuses to start these machines. Not specifying an
explicit graphics mode is for instance done by 'make check'.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

---

v2
Adds std as default display for spapr machines

Notes
This change will make all other ppc machines to use cirrusgd as default
display because QEMU internally prefers that card. If this is considered
as being too risky, setting the default mode for the other machines as it
has been done for spapr would bring them back to the previous level.
However, this is rarely used in the exiting code base.

Alternatively, using the cirrusgd is possibly considered more an exception
than the rule these days, so altering the code to prefer stdvga over
cirrusgd may be the better solution (this should also render the changes
of v2 obsolete).

Feedback on how to proceed is welcome.

The patch applies to current ppc-for-3.0 minus v1 of the patch.
---
 default-configs/ppc-softmmu.mak | 1 +
 hw/ppc/spapr.c                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 7e1a3d8135..6f12bf84f0 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -29,6 +29,7 @@ CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
+CONFIG_VGA_CIRRUS=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2baec026f..0c12c404d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3962,6 +3962,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
+    mc->default_display = "std";
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
-- 
2.18.0
