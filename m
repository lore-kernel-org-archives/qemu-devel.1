Received: from eggs.gnu.org ([2001:4830:134:3::10]:39000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5Bca-0006XO-Oo
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d5BcX-0002JR-JR
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:44:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 14:43:29 +0100
Message-Id: <1493646214-3342-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/5] Add qemu_vga.ndrv MacOS PPC VGA driver
 from QemuMacDrivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Last year Ben posted an initial set of patches for OpenBIOS which provided a
MacOS PPC VGA driver enabling MacOS guests to control the colour depth and
resolution of the QEMU stdvga device. The QemuMacDrivers repository was set up on
qemu-project.org [1] but due to personal circumstances in the second half of last
year, I was unable to spend much time on it.

Over the last few months I've reworked the OpenBIOS patches and applied all the
required dependencies upstream which makes it possible to enable the driver with
a fairly simple patch [2] to OpenBIOS's vga.fs (binary provided for testing, but not
to be included in the final merge).

The main change I've made is that instead of serving the driver binary directly
through the VGA PCI BAR (with the relevant binary inlined within OpenBIOS), the
driver is now hosted by QEMU and is installed via the fw_cfg interface by the
OpenBIOS vga.fs driver during startup. Not only does this make it possible to
further develop the driver without also having to rebuild OpenBIOS every time but
it also leaves us with the ability to serve a proper IEEE-1275 FCode ROM via the
VGA PCI BAR later if needed.

In addition to this I've added a new OpenBIOS NVRAM variable "vga-ndrv?" which
defaults to "true" but can be overidden via -prom-env to force disable the
driver if any incompatibilities are found. I've tested it locally against my
OS X 10.2 and MacOS 9.2.1 images and it seems to work there, but as I don't
have an exhaustive set of MacOS images available I'd be grateful for some more
testing.

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg06159.html
[2] https://mail.coreboot.org/pipermail/openbios/2017-May/009909.html

This patchset can also be found on my github repository at
https://github.com/mcayland/qemu/tree/ppc-vga-upstream.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (5):
  Add QemuMacDrivers as submodule
  Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a built as submodule
  ppc: add qemu_vga.ndrv ROM to fw_cfg interface for OldWorld Macs
  ppc: add qemu_vga.ndrv ROM to fw_cfg interface for NewWorld Macs
  [Testing] Provide NDRV-capable openbios-ppc binary for testing

 .gitmodules           |    3 +++
 Makefile              |    3 ++-
 hw/ppc/mac_newworld.c |   18 +++++++++++++++++-
 hw/ppc/mac_oldworld.c |   18 +++++++++++++++++-
 pc-bios/README        |    3 +++
 pc-bios/openbios-ppc  |  Bin 750840 -> 754936 bytes
 pc-bios/qemu_vga.ndrv |  Bin 0 -> 14752 bytes
 roms/QemuMacDrivers   |    1 +
 8 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 pc-bios/qemu_vga.ndrv
 create mode 160000 roms/QemuMacDrivers

-- 
1.7.10.4
