Received: from eggs.gnu.org ([2001:4830:134:3::10]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o58-0006kG-JS
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o57-0003v8-M5
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Apr 2018 16:28:00 +0200
Message-Id: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v2 0/5] arm: isolate and clean up dtb
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


Changelog v1->v2:
   * drop "arm: reuse  arm_boot_address_space() in armv7m_load_kernel()"
   * move "arm: always start from first_cpu  when registering loader cpu reset callback"
     at the begigning of series and rebase
   * add "ppc: e500: switch E500 based machines to full  machine definition"
     and rebase 4/5 on top of it
   * fixup typo in virt_machine_get_hotpug_handler() name
   * add doc comment to skip_dtb_autoload field
   * 1-2/5 are queued in respective arm/ppc trees and are included for series
     completness so it would be easier to test, I expect series to go through
     arm tree
   

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


Igor Mammedov (5):
  arm: always start from first_cpu when registering loader cpu reset
    callback
  ppc: e500: switch E500 based machines to full machine definition
  pc: simplify MachineClass::get_hotplug_handler handling
  platform-bus-device: use device plug callback instead of machine_done
    notifier
  arm/boot: split load_dtb() from arm_load_kernel()

 hw/ppc/e500.h               |  34 ++++++++--
 include/hw/arm/arm.h        |  44 ++++++++++---
 include/hw/arm/sysbus-fdt.h |  37 ++---------
 include/hw/arm/virt.h       |   1 +
 include/hw/i386/pc.h        |   8 ---
 include/hw/platform-bus.h   |   4 +-
 hw/arm/boot.c               |  73 ++++++---------------
 hw/arm/sysbus-fdt.c         |  67 ++------------------
 hw/arm/virt.c               |  95 ++++++++++++++++++----------
 hw/core/platform-bus.c      |  29 ++-------
 hw/i386/pc.c                |   6 +-
 hw/ppc/e500.c               | 151 +++++++++++++++++++++++---------------------
 hw/ppc/e500plat.c           |  95 ++++++++++++++++++++--------
 hw/ppc/mpc8544ds.c          |  47 +++++++++-----
 14 files changed, 342 insertions(+), 349 deletions(-)

-- 
2.7.4
