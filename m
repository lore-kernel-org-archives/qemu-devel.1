Received: from eggs.gnu.org ([2001:4830:134:3::10]:48548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKrz-00018I-Ug
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKrw-00068z-VQ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:27 -0400
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:34208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1fiKrw-00067E-NX
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:24 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Jul 2018 16:34:09 +0200
Message-Id: <20180725143413.9728-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH v3 0/4] hw/arm/sysbus-fdt: Generic DT
 Pass-Through
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series allows to export generic devices in DT using
vfio-platform, providing direct access from a QEMU+KVM guest to the
exported devices.

  - Patches 1-2 (submitted before by Eric Auger) make the vfio-platform
    device non-abstract, incl. matching using a compatible string.
  - Patch 3 allows dynamic sysbus devices again, without needing to
    create device-specific vfio types for each and every new device.
  - Patch 4 adds code to instantiate device nodes for generic DT
    devices, copying a set of generic properties from the host.

This avoids having to write device-specific instantation methods for
each and every "simple" device using only a set of generic properties.
Devices that need more specialized handling can still provide their own
instantation method.

Changes compared to v2 (not submitted to the mailing list):
  - Use the compatible values from sysfs instead of user-supplied
    manufacturer and model options,
  - Replace "hw/arm/sysbus-fdt: Enable rcar-gen3-gpio dynamic
    instatiation" by generic "hw/arm/sysbus-fdt: Add support for
    instantiating generic devices",
  - Reword patch descriptions,
  - Drop RFC state,
  - Drop "vfio: No-IOMMU mode support".

Changes compared to v1 ("R-Car Gen3 GPIO Pass-Through Prototype (QEMU)",
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02716.html):
  - Restrict dynamic sysbus devices to TYPE_VFIO_PLATFORM, as suggested
    by Eric Auger.

For proper operation, this depends on "hw/arm/sysbus-fdt: Fix assertion
in copy_properties_from_host()"
(https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg04922.html).
Thanks!

For testing, this patch series and all prerequisites are available in
the topic/rcar3-virt-gpio-passthrough-v3 branch of my git repository at
https://github.com/geertu/qemu.git.

This has been tested on a Renesas Salvator-XS board with R-Car H3 ES2.0
with SATA:

    -device vfio-platform,host=ee300000.sata

and GPIO (needs VFIO No-IOMMU support):

    -device vfio-platform,host=e6055400.gpio

Thanks!

Auger Eric (2):
  vfio/platform: Make the vfio-platform device non-abstract
  hw/arm/sysbus-fdt: Allow device matching with DT compatible value

Geert Uytterhoeven (2):
  hw/arm/virt: Allow dynamic sysbus devices again
  hw/arm/sysbus-fdt: Add support for instantiating generic devices

 hw/arm/sysbus-fdt.c             | 163 +++++++++++++++++++++++++++++---
 hw/arm/virt.c                   |   1 +
 hw/vfio/amd-xgbe.c              |   1 +
 hw/vfio/calxeda-xgmac.c         |   1 +
 hw/vfio/platform.c              |  22 ++++-
 include/hw/vfio/vfio-platform.h |   3 +-
 6 files changed, 175 insertions(+), 16 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
