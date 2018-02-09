Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDa-0007M6-7X
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBDW-0001EO-RD
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:06 -0500
Received: from leibniz.telenet-ops.be ([2a02:1800:110:4::f00:d]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekBDW-0001DG-JW
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:08:02 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
	[IPv6:2a02:1800:120:4::f00:14])
	by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3zdJwj240GzMqftG
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:53 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:17:31 +0100
Message-Id: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 0/5] R-Car Gen3 GPIO Pass-Through Prototype
 (QEMU)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This RFC patch series is the QEMU side of a GPIO Pass-Through prototype
for Renesas R-Car platforms using vfio-platform.  Together with its
counterpart for Linux, it provides direct access from a QEMU+KVM guest
to a GPIO controller in an R-Car Gen3 SoC.  This allows the guest to
control the LEDs on a Renesas Salvator-X(S) board.

This patch series is not meant to be upstreamed as-is.  Indeed, for
various reasons (e.g. security, as the different GPIOs on the same GPIO
controller may control different parts of the system) access to GPIOs is
better not implemented using Device Pass-Through, but by
paravirtualization.  Yet, this is still a simple and valuable
proof-of-concept, which can serve as a basis for the future development
of Pass-Through support for more complex platform devices on R-Car Gen3
SoCs.

  - Patches 1-2 (submitted before by Eric Auger) make the vfio-platform
    device non-abstract, incl. matching using a compatible string.
  - Patch 3 allows dynamic sysbus devices again, without needing to
    create device-specific vfio types for each and every new device.
  - Patch 4 (submitted before by Xiao Feng Ren) adds support for the
    VFIO No-IOMMU mode, which was added to Linux two years ago (in
    v4.4).
  - Patch 5 adds code to instantiate device nodes for Renesas R-Car Gen3
    GPIO controllers.

Several questions and TODOs are appended to the individual patches.

Please see https://elinux.org/R-Car/Virtualization/VFIO for full usage
instructions of this prototype.

Thanks for your comments!

Auger Eric (2):
  vfio/platform: make the vfio-platform device non abstract
  hw/arm/sysbus-fdt: Allow device matching with compat string

Geert Uytterhoeven (2):
  hw/arm/virt: Allow dynamic sysbus devices again
  hw/arm/sysbus-fdt: Enable rcar-gen3-gpio dynamic instatiation

Xiao Feng Ren (1):
  vfio: No-IOMMU mode support

 hw/arm/sysbus-fdt.c             | 108 +++++++++++++++++++++++++++++++++++-----
 hw/arm/virt.c                   |   1 +
 hw/vfio/common.c                |  61 ++++++++++++++++++-----
 hw/vfio/platform.c              |  20 +++++++-
 include/hw/vfio/vfio-common.h   |   2 +
 include/hw/vfio/vfio-platform.h |   2 +
 6 files changed, 166 insertions(+), 28 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
