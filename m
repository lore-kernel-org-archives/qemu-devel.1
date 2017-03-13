Received: from eggs.gnu.org ([2001:4830:134:3::10]:42481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnUL3-0003K2-Ax
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnUKx-00012i-CV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:04:57 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:04:27 +0200
Message-Id: <20170313180432.7067-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] hw: arm: exynos: Bring up secondary CPU
 + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Hi,


The first patch fixes GIC and brings the secondary CPU. Unfortunately,
this brings up to light an annoying issue with CPUIDLE driver.


Changes since v1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Use one cast to obj in patch 1/5 (suggested by Peter).
2. Add Peter's review tags.
3. Re-order patches 3 and 4 to silence the checkpatch warning earlier.


Overview of the problem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
On Exynos4210, by default Linux kernel uses cpuidle driver which tries
to enter low power mode, called AFTR (Arm Off, Top Running).  On real
hardware this brings some power savings.  This AFTR mode requires second
CPU to be off, so the driver (coupled cpuidle driver) when system is idle=
:
1. Turns off second CPU,
2. Enters AFTR on CPU0.

However the QEMU system is then totally unresponsive (e.g. on serial cons=
ole)
and RCU stalls appear from time to time.  I spent some time on it and did=
 not
find the real cause behind the lag.  Maybe it is because the second CPU
does not really power down itself and system just burns the cycles under =
spin
locks?

Looking at recent stable kernels:
 - 3.10, 3.16 - works fine with two CPUs (no CPUIDLE driver),
 - 4.1 and newer - stalls and are unresponsive due to CPUIDLE being enabl=
ed.

The cpuidle driver is not relying on DTS. It is just enabled in exynos_de=
fconfig
and works.

Workarounds
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Boot with only 1 cpu
2. Build a kernel with disabled CONFIG_CPU_IDLE



Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  hw/intc/exynos4210_gic: Fix GIC memory mappings for secondary CPU
  hw/intc/exynos4210_gic: Use more meaningful name for local variable
  hw/timer/exynos4210_mct: Fix checkpatch style errors
  hw/timer/exynos4210_mct: Cleanup indentation and empty new lines
  hw/timer/exynos4210_mct: Remove unused defines

 hw/intc/exynos4210_gic.c  | 33 +++++++++++++++++++------------
 hw/timer/exynos4210_mct.c | 50 ++++++++++++++++++++---------------------=
------
 2 files changed, 41 insertions(+), 42 deletions(-)

--=20
2.9.3
