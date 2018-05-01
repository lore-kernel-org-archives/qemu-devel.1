Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6Q-0005bK-5O
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6O-0003Sx-NG
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:50 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 14:08:37 +0200
Message-Id: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] arm: isolate and clean up dtb generation
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


Changelog v2->v3:
   * drop already merged patches
       'arm: always start from  first_cpu when registering loader cpu res=
et callback'
       'ppc: e500: switch E500 based  machines to full machine definition=
'
   * add small not related cleanup
       'arm: boot: set boot_info starting from first_cpu'
   * add extra suggested patch
       'make sure that we aren't overwriting mc->get_hotplug_handler by a=
ccident'
   * make sure that dtb_limit initialized to 0
   * drop stale comment
   * drop not needed line movement
   * drop not needed extra new line
Changelog v1->v2:
   * drop "arm: reuse  arm_boot_address_space() in armv7m_load_kernel()"
   * move "arm: always start from first_cpu  when registering loader cpu =
reset callback"
     at the begigning of series and rebase
   * add "ppc: e500: switch E500 based machines to full  machine definiti=
on"
     and rebase 4/5 on top of it
   * fixup typo in virt_machine_get_hotpug_handler() name
   * add doc comment to skip_dtb_autoload field
   * 1-2/5 are queued in respective arm/ppc trees and are included for se=
ries
     completness so it would be easier to test, I expect series to go thr=
ough
     arm tree
  =20

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
  pc: simplify MachineClass::get_hotplug_handler handling
  platform-bus-device: use device plug callback instead of machine_done
    notifier
  arm/boot: split load_dtb() from arm_load_kernel()
  arm: boot: set boot_info starting from first_cpu
  make sure that we aren't overwriting mc->get_hotplug_handler by
    accident

 hw/ppc/e500.h               |  5 +++
 include/hw/arm/arm.h        | 45 +++++++++++++++------
 include/hw/arm/sysbus-fdt.h | 37 ++++-------------
 include/hw/arm/virt.h       |  1 +
 include/hw/i386/pc.h        |  8 ----
 include/hw/platform-bus.h   |  4 +-
 hw/arm/boot.c               | 74 ++++++++++------------------------
 hw/arm/sysbus-fdt.c         | 64 ++----------------------------
 hw/arm/virt.c               | 96 +++++++++++++++++++++++++++++----------=
------
 hw/core/platform-bus.c      | 29 +++-----------
 hw/i386/pc.c                |  7 +---
 hw/ppc/e500.c               | 38 ++++++++----------
 hw/ppc/e500plat.c           | 32 +++++++++++++++
 hw/ppc/spapr.c              |  1 +
 hw/s390x/s390-virtio-ccw.c  |  1 +
 15 files changed, 193 insertions(+), 249 deletions(-)

--=20
2.7.4
