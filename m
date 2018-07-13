Received: from eggs.gnu.org ([2001:4830:134:3::10]:40241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdtQg-00029A-BZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdtQf-0004CM-55
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:27:54 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 13 Jul 2018 10:27:28 +0200
Message-Id: <1531470464-21522-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/16] Fix crashes with introspection of ARM
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

As discovered recently, you can crash QEMU with a lot of devices
that do not get the reference counting of child objects right.
You just have to run 'device-list-properties' and call 'info qtree'
afterwards.
This patch series fixes a bunch of these problems in the ARM code.
I did not fix all problems yet, since it is quite time consuming,
and this series is big enough already. The remaining problems can
be fixed in an independent patch series later.

v2:
 - Updated the first patch according to the review feedback from v1
 - Added more patches with additional fixes

Thomas Huth (16):
  qom/object: Add a new function object_initialize_child()
  hw/core/sysbus: Add a function for creating and attaching an object
  hw/arm/bcm2836: Fix crash with device_add bcm2837 on unsupported
    machines
  hw/arm/armv7: Fix crash when introspecting the "iotkit" device
  hw/cpu/a15mpcore: Fix introspection problem with the a15mpcore_priv
    device
  hw/display/xlnx_dp: Move problematic code from instance_init to
    realize
  hw/arm/xlnx-zynqmp: Fix crash when introspecting the "xlnx,zynqmp"
    device
  hw/arm/msf2-soc: Fix introspection problem with the "msf2-soc" device
  hw/cpu/a9mpcore: Fix introspection problems with the "a9mpcore_priv"
    device
  hw/arm/fsl-imx6: Fix introspection problems with the "fsl,imx6" device
  hw/arm/fsl-imx7: Fix introspection problems with the "fsl,imx7" device
  hw/arm/fsl-imx25: Fix introspection problem with the "fsl,imx25"
    device
  hw/arm/fsl-imx31: Fix introspection problem with the "fsl,imx31"
    device
  hw/cpu/arm11mpcore: Fix introspection problem with 'arm11mpcore_priv'
  hw/*/realview: Fix introspection problem with 'realview_mpcore' &
    'realview_gic'
  hw/arm/allwinner-a10: Fix introspection problem with 'allwinner-a10'

 hw/arm/allwinner-a10.c   | 19 +++++-----
 hw/arm/armv7m.c          |  7 ++--
 hw/arm/bcm2836.c         | 18 +++------
 hw/arm/fsl-imx25.c       | 30 +++++++--------
 hw/arm/fsl-imx31.c       | 26 ++++++-------
 hw/arm/fsl-imx6.c        | 56 ++++++++++------------------
 hw/arm/fsl-imx7.c        | 96 ++++++++++++++++--------------------------------
 hw/arm/iotkit.c          | 74 ++++++++++++++++---------------------
 hw/arm/msf2-soc.c        | 15 ++++----
 hw/arm/xlnx-zynqmp.c     | 61 ++++++++++++++----------------
 hw/core/sysbus.c         |  8 ++++
 hw/cpu/a15mpcore.c       |  8 ++--
 hw/cpu/a9mpcore.c        | 18 ++++-----
 hw/cpu/arm11mpcore.c     | 14 +++----
 hw/cpu/realview_mpcore.c |  8 ++--
 hw/display/xlnx_dp.c     | 23 +++++-------
 hw/intc/armv7m_nvic.c    |  5 +--
 hw/intc/realview_gic.c   |  7 +---
 include/hw/sysbus.h      |  3 ++
 include/qom/object.h     | 23 +++++++++++-
 qom/object.c             | 15 ++++++++
 21 files changed, 244 insertions(+), 290 deletions(-)

-- 
1.8.3.1
