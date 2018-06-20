Received: from eggs.gnu.org ([2001:4830:134:3::10]:55001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2N-0007yH-Fd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2M-0002lQ-9i
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:20:24 +0100
Message-Id: <20180620132032.28865-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/8] arm: implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eric Auger <eric.auger@redhat.com>

Hi; this is v3 of my iommu patchset. All the IOMMU stuff is now
in master, so the remaining part is just implementing and using
the Trustzone Memory Protection Controller in the mps2-an505.

Changes from v2 to v3 (all fairly minor):
 * add new variable to clarify sense of LUT bits
 * only autoinc the IDX register if CTRL.AUTOINC is set
 * NS accesses should see IDregs only
   (The datasheet is unclear on the exact behaviour on an
   NS access to a non-ID register, so I've made a best guess
   and had them RAZ/WI. This behaviour is not reachable for
   the mps2-an505 anyway, so it doesn't really matter.)

Patches still needing review: 2, 4, 5

thanks
-- PMM

Peter Maydell (8):
  hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection
    Controller
  hw/misc/tz-mpc.c: Implement registers
  hw/misc/tz-mpc.c: Implement correct blocked-access behaviour
  hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate
  hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS
  hw/arm/iotkit: Instantiate MPC
  hw/arm/iotkit: Wire up MPC interrupt lines
  hw/arm/mps2-tz.c: Instantiate MPCs

 hw/misc/Makefile.objs           |   1 +
 include/hw/arm/iotkit.h         |   8 +
 include/hw/misc/iotkit-secctl.h |   8 +
 include/hw/misc/tz-mpc.h        |  80 ++++
 hw/arm/iotkit.c                 | 112 +++++-
 hw/arm/mps2-tz.c                |  71 ++--
 hw/misc/iotkit-secctl.c         |  38 +-
 hw/misc/tz-mpc.c                | 628 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   8 +
 11 files changed, 917 insertions(+), 40 deletions(-)
 create mode 100644 include/hw/misc/tz-mpc.h
 create mode 100644 hw/misc/tz-mpc.c

-- 
2.17.1
