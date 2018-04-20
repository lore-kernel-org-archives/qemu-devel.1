Received: from eggs.gnu.org ([2001:4830:134:3::10]:48715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZf-0002GJ-Ew
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9VZe-0008W8-Hz
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:55:35 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:48:32 +0100
Message-Id: <20180420124835.7268-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] aspeed,
 highbank: fix RAM migration oddities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Rob Herring <robh@kernel.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In a couple of places in the highbank and aspeed boards,
we create RAM regions with memory_region_init_ram_nomigrate()
and then either:
 * don't call vmstate_register_ram()
 * from a device, register it with
   vmstate_register_ram_global()

The first case is a bug. Currently it means that the underlying
RAM block will have a name which is the empty string; it will
migrate, but if there is more than one such RAM block in the
system migration will fail. Future changes to the migration
code are likely to mean that the RAM block isn't migrated at all.

The second case is also a bug: since the name used for the RAM
block is global to all of QEMU, it means that you can't have
more than one instance of the device without QEMU abort()ing
because of the name clash.

Fix both of these by using memory_region_init_ram(), which
automatically registers the RAM block for migration with
a sensible name.

This patchset is a cross-version migration compatibility
break for the boards "palmetto-bmc", "ast2500-evb", "romulus-bmc",
"highbank" and "midway". We don't promise migration compat
for those boards, so this is OK.

NB: I haven't tested this code beyond "does make check pass",
because I don't have a test image for any of these boards.
Testing welcomed :-)

thanks
-- PMM

Peter Maydell (3):
  hw/arm/highbank: don't make sysram 'nomigrate'
  hw/arm/aspeed: don't make 'boot_rom' region 'nomigrate'
  hw/arm/aspeed_soc: don't use vmstate_register_ram_global for SRAM

 hw/arm/aspeed.c     | 2 +-
 hw/arm/aspeed_soc.c | 3 +--
 hw/arm/highbank.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.17.0
