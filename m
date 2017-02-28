Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied7-0006pE-HL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-00047c-QA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:37 -0500
Received: from greensocs.com ([193.104.36.180]:38329)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-00046c-B1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:32 -0500
From: fred.konrad@greensocs.com
Date: Tue, 28 Feb 2017 11:02:55 +0100
Message-Id: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

Hi,

This is the third version of the clock framework API it contains:

  * The first 6 patches which introduce the framework.
  * The 7th patch which introduces a fixed-clock model.
  * The rest which gives an example how to model a PLL from the existing
    zynqmp-crf extracted from the qemu xilinx tree.

No specific behavior is expected yet when the CRF register set is accesse=
d but
the user can see for example the dp_video_ref and vpll_to_lpd rate changi=
ng in
the monitor with the "info qtree" command when the vpll_ctrl register is
modified.

bus: main-system-bus
  type System
  dev: xlnx.zynqmp_crf, id ""
    gpio-out "sysbus-irq" 1
    qemu-clk "dbg_trace" 0
    qemu-clk "dp_stc_ref" 0
    qemu-clk "dpll_to_lpd" 12500000
    qemu-clk "acpu_clk" 0
    qemu-clk "pcie_ref" 0
    qemu-clk "topsw_main" 0
    qemu-clk "topsw_lsbus" 0
    qemu-clk "dp_audio_ref" 0
    qemu-clk "sata_ref" 0
    qemu-clk "dp_video_ref" 1428571
    qemu-clk "vpll_clk" 50000000
    qemu-clk "apll_to_lpd" 12500000
    qemu-clk "dpll_clk" 50000000
    qemu-clk "gpu_ref" 0
    qemu-clk "aux_refclk" 0
    qemu-clk "video_clk" 27000000
    qemu-clk "gdma_ref" 0
    qemu-clk "gt_crx_ref_clk" 0
    qemu-clk "dbg_fdp" 0
    qemu-clk "apll_clk" 50000000
    qemu-clk "pss_alt_ref_clk" 0
    qemu-clk "ddr" 0
    qemu-clk "dbg_tstmp" 0
    qemu-clk "pss_ref_clk" 50000000
    qemu-clk "dpdma_ref" 0
    qemu-clk "vpll_to_lpd" 12500000
    mmio 00000000fd1a0000/000000000000010c
   =20
This series is based on the current master
(d992f2f1368ceb92e6bfd8efece174110f4236ff).

Thanks,
Fred

V2 -> V3:
  * Rebased on current master.
  * Renamed qemu_clk / QEMUClock as suggested by C=C3=A9dric.
  * Renamed in_rate to ref_rate and out_rate to rate.
  * Renamed qemu_clk_bind_clock to qemu_clk_bind.
  * Example added to the documentation as suggested by Peter.

V1 -> V2:
  * Rebased on current master.
  * Some function renamed and documentation fixed.

RFC -> V1:
  * Rebased on current master.
  * The docs has been fixed.
  * qemu_clk_init_device helper has been provided to ease the initializat=
ion
    of the devices.

KONRAD Frederic (10):
  qemu-clk: introduce qemu-clk qom object
  qemu-clk: allow to add a clock to a device
  qemu-clk: allow to bind two clocks together
  qemu-clk: introduce an init array to help the device construction
  qdev-monitor: print the device's clock with info qtree
  docs: add qemu-clock documentation
  introduce fixed-clock
  introduce zynqmp_crf
  zynqmp: add the zynqmp_crf to the platform
  zynqmp: add reference clock

 Makefile.objs                 |   1 +
 docs/clock.txt                | 278 ++++++++++++
 hw/arm/xlnx-zynqmp.c          |  56 +++
 hw/misc/Makefile.objs         |   2 +
 hw/misc/fixed-clock.c         |  88 ++++
 hw/misc/xilinx_zynqmp_crf.c   | 968 ++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/xlnx-zynqmp.h  |   8 +
 include/hw/misc/fixed-clock.h |  30 ++
 include/qemu/qemu-clock.h     | 161 +++++++
 qdev-monitor.c                |   2 +
 qemu-clock.c                  | 176 ++++++++
 11 files changed, 1770 insertions(+)
 create mode 100644 docs/clock.txt
 create mode 100644 hw/misc/fixed-clock.c
 create mode 100644 hw/misc/xilinx_zynqmp_crf.c
 create mode 100644 include/hw/misc/fixed-clock.h
 create mode 100644 include/qemu/qemu-clock.h
 create mode 100644 qemu-clock.c

--=20
1.8.3.1
