Received: from eggs.gnu.org ([2001:4830:134:3::10]:58319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI8-0004AE-Ei
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI7-00019z-Hs
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:44 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Apr 2018 18:40:17 +0200
Message-Id: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 0/4] arm: isolate and clean up dtb
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com


While working on cpu hotplug for mach-virt, I've noticed that DTB
is generated incrementally across whole machvirt_init(). While it's
fine for machines with static DTB, it won't really work in case of
cpu hotplug and followed up reset since machine will load old DTB
that doesn't account for hotplugged CPUs.
So I've set on a quest to consolidate DTB generation and make it
reentrant so that on reset guest would see update DTB.

It's preliminary series which makes possible to call load_dtb()
later outside of arm_load_kernel() and in process of it drops
several machine_done notifiers, that were introduced to make
plaform-bus-devices work. Hopefully it makes code easier to follow.
It replaces machine_done notifiers with device hotplug framework
to allow for dynamic sysbus devices mapping at the moment they
are created instead of waiting for machine_done time and trying to
juggle with notifiers order to do initialization in propper order.

Mostly 'make check' tested +
manually with "ppce500" machine type and eTSEC device
(eTSEC is still initialized with the same IRQs as before series)


CC: qemu-arm@nongnu.org
CC: peter.maydell@linaro.org
CC: eric.auger@redhat.com

Igor Mammedov (4):
  arm: reuse arm_boot_address_space() in armv7m_load_kernel()
  platform-bus-device: use device plug callback instead of machine_done
    notifier
  arm: always start from first_cpu when registering loader cpu reset
    callback
  arm/boot: split load_dtb() from arm_load_kernel()

 hw/ppc/e500.h               |   3 ++
 include/hw/arm/arm.h        |  39 ++++++++++++-----
 include/hw/arm/sysbus-fdt.h |  37 ++++------------
 include/hw/arm/virt.h       |   3 ++
 include/hw/platform-bus.h   |   4 +-
 hw/arm/armv7m.c             |  10 +----
 hw/arm/boot.c               |  85 +++++++++++--------------------------
 hw/arm/sysbus-fdt.c         |  67 +++--------------------------
 hw/arm/virt.c               | 100 +++++++++++++++++++++++++++++---------------
 hw/core/platform-bus.c      |  29 +++----------
 hw/ppc/e500.c               |  37 +++++++++-------
 hw/ppc/e500plat.c           |  60 +++++++++++++++++++++++++-
 12 files changed, 227 insertions(+), 247 deletions(-)

-- 
2.7.4
