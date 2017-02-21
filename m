Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAKx-0006YN-O2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAKw-0003YZ-FY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:35 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 21 Feb 2017 14:18:18 +0100
Message-Id: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Allow direct vfio-platform device
 instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, okaya@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Up to now, supporting a new VFIO-PLATFORM device has requested
to create a dummy derived device. The type of the derived
device was used to match the device tree node creation function.

Since the actual adaptation fits within this node creation function
and not anywhere else at the moment, let's allow to instantiate the
VFIO-PLATFORM device and pass the compatibility string with 2 separate
options, manufacturer and model. sysbus-fdt is adapted to associate
a node creation function with this combo.

The removal of the abstract characteristics was discussed on the ML
(https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03326.html)
in the context of HiDma integrayion.

This change should ease the integration of new devices and limit the
amount of adaptation code to the minimumy, ie. the node creation
function).

The AMD XGBE is the first device that can be instantiated that way:
-device vfio-platform,host=e0900000.xgmac,manufacturer=amd,model=xgbe-seattle-v1a
Note the legacy option still is available:
-device vfio-amd-xgbe,host=e0900000.xgmac

Eric Auger (2):
  vfio/platform: make the vfio-platform device non abstract
  hw/arm/sysbus-fdt: Allow device matching with compat string

 hw/arm/sysbus-fdt.c             | 59 ++++++++++++++++++++++++++++++++---------
 hw/vfio/platform.c              | 18 +++++++++++--
 include/hw/vfio/vfio-platform.h |  2 ++
 3 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.5.5
