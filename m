Received: from eggs.gnu.org ([2001:4830:134:3::10]:38194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dx66z-0006gN-EZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dx66u-0003QI-Iy
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:46:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36003
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dx66u-0003P6-BB
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:46:20 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 27 Sep 2017 07:45:56 +0100
Message-Id: <1506494757-7352-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] sun4u: update PCI topology to include simba
 PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This patch implements what I've been working towards over the past few
months in order to get a more realistic Ultra 5 model for the sun4u
machine. The basic change is that devices are no longer plugged into the
PCI root bus, but behind PCI busA for in-built devices and PCI busB for all
other devices.

Note: this patch requires my previous fix for allowing 32-bit PCI IO
accesses through the PCI bridge posted at
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06371.html in
order for devices plugged into PCI busB to function correctly.

The benefits of this patch are that guest OSs can map PCI BARs correctly
without overlapping (Linux currently issues several warnings about this
on boot) and interrupt routing is updated to match the official
documentation.

For users the main visible change is that it is no longer possible to
plug PCI devices into the PCI root bus, but instead devices should be
added to PCI busB. For example with this patchset if you try and plug
a virtio-blk-pci device as before you now get this error:

$ ./qemu-system-sparc64 -device virtio-blk-pci,...
qemu-system-sparc64: -device virtio-blk-pci: PCI: no slot/function available
for virtio-blk-pci, all in use or reserved

Instead the correct command line should be:

$ ./qemu-system-sparc64 -device virtio-blk-pci,bus=pciB,...

Since the patch changes the PCI IO space, PCI topology and interrupt
routing I've included a custom-built openbios-sparc64 to maintain
bisectability. Once this patch has been applied I will immediately send
an updated MR to sync the OpenBIOS submodule and binaries once again.

As it stands the patch is reasonably straightforward: the hardest part
is related to the in-built sunhme network card since the combination
of QEMU's -netdev syntax not supporting in-built NICs and
pci_nic_init_nofail() asserting if not using the PCI root bus lead to
some interesting code. I hope that I've managed to come up with a solution
that implements reasonable behaviour in these cases.

On a final note I should add that this passes all my OpenBIOS SPARC64
image boot tests without introducing regressions, and whilst we introduce
PCI topology changes there is no effect on migration because the sun4u
machine is currently not migratable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (1):
  sun4u: update PCI topology to include simba PCI bridges

 hw/pci-host/apb.c        |   47 +++++++++++++++++++++++++++---------
 hw/sparc64/sun4u.c       |   60 +++++++++++++++++++++++++++++++++-------------
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 3 files changed, 79 insertions(+), 28 deletions(-)

-- 
1.7.10.4
