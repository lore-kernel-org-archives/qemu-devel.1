Received: from eggs.gnu.org ([2001:4830:134:3::10]:42654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1g0To3-00079I-90
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1g0To2-0002w4-3a
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:45:23 -0400
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19]:41002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1g0To1-0002ji-Au
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:45:21 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Sep 2018 17:44:55 +0200
Message-Id: <20180913154458.23939-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH v4 0/3] vfio/sysbus-fdt: Prepare for Generic DT
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

This patch series prepares for exporting generic devices in DT using
vfio-platform, providing direct access from a QEMU+KVM guest to the
exported devices.

  - Patches 1-2 (submitted before by Eric Auger) make the vfio-platform
    device non-abstract, incl. matching using a compatible string.
  - Patch 3 allows dynamic vfio-platform devices again, without needing to
    create device-specific vfio types for each and every new device.

This will avoid having to write device-specific instantation methods for
each and every "simple" device using only a set of generic properties.
Devices that need more specialized handling will still be able provide
their own instantation methods.

Note that this series no longer contains "[PATCH 4/4] hw/arm/sysbus-fdt:
Add support for instantiating generic devices", following advice from Eric
Auger, as that patch needs more safeguards.  Hence this series now contains
only preparative work.

Changes compared to v4 ("hw/arm/sysbus-fdt: Generic DT Pass-Through"),
http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg05006.html):
  - Propagate g_file_get_contents() errors through errp,
  - Add Tested-by (with amd-xgbe),
  - s/From now on/Soon/ in patch description,
  - s/sysbus/vfio-platform/ in patch description,
  - Postpone "[PATCH 4/4] hw/arm/sysbus-fdt: Add support for instantiating
    generic devices".

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

Thanks!

For testing, this patch series, and the postponed "hw/arm/sysbus-fdt: Add
support for instantiating generic devices" are available in the
topic/rcar3-virt-gpio-passthrough-v4 branch of my git repository at
https://github.com/geertu/qemu.git.

This has been tested on a Renesas Salvator-XS board with R-Car H3 ES2.0
with SATA:

    -device vfio-platform,host=ee300000.sata

and GPIO (needs VFIO No-IOMMU support):

    -device vfio-platform,host=e6055400.gpio

Thanks for applying!

Auger Eric (2):
  vfio/platform: Make the vfio-platform device non-abstract
  hw/arm/sysbus-fdt: Allow device matching with DT compatible value

Geert Uytterhoeven (1):
  hw/arm/virt: Allow dynamic vfio-platform devices again

 hw/arm/sysbus-fdt.c             | 61 +++++++++++++++++++++++++--------
 hw/arm/virt.c                   |  1 +
 hw/vfio/amd-xgbe.c              |  1 +
 hw/vfio/calxeda-xgmac.c         |  1 +
 hw/vfio/platform.c              | 24 ++++++++++++-
 include/hw/vfio/vfio-platform.h |  3 +-
 6 files changed, 75 insertions(+), 16 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
