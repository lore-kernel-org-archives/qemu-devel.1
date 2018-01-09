Received: from eggs.gnu.org ([2001:4830:134:3::10]:36721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjE9-0001nW-SU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjE5-0001zs-Tj
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:45 -0300
Message-Id: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 0/9] resolv device by Flattened Device
 Tree alias name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi,

This RFC series is intended to simplify Flattened Device Tree support,
in particular the 'compatible' FDT entry, when Linux names mismatches
QEMU ones, but this is the same device modelled.

So far this is only a 'proof of concept'.

To see how the qtests perform, I only modified the Xilinx ZynqMP machine.

This is only the 6th generic alias compatibility API in QEMU   ¯\_(ツ)_/¯

Since v2:

- Follow Eduardo advice:
"If aliases exist only for compatibility, they should be restricted to
the places where compatibility is really needed."

- Do not modify QOM/qobject, use a specific GHashTable for FDT alias resolv.

- The aliases aren't display in HMP / -device help

If a machine is expected to use FDT, it needs to explicitely resolv any
device name with the type_resolve_fdt_alias() function.

Regards,

Phil.

Philippe Mathieu-Daudé (9):
  hw/sysbus: add helpers to register FDT aliases
  hw/char/cadence_uart: add FDT aliases
  hw/net/cadence_gem: add FDT aliases
  hw/timer/cadence_ttc: add FDT aliases
  hw/dma/axidma: add 'xlnx,eth-dma' FDT alias
  hw/usb/hcd-ehci: add 'xlnx,ps7-usb' FDT aliases
  hw/ssi/xlnx-spips: add 'xlnx.zynq-qspi' FDT alias
  hw/dma/xlnx_dpdma: add 'xlnx,axi-dpdma-1.0' FDT alias
  hw/arm/xlnx-zynqmp: use Linux FDT names

 include/hw/sysbus-fdt.h  | 18 ++++++++++++++++++
 hw/arm/xlnx-zynqmp.c     | 14 ++++++++++----
 hw/char/cadence_uart.c   | 12 ++++++++++++
 hw/core/sysbus-fdt.c     | 30 ++++++++++++++++++++++++++++++
 hw/dma/xilinx_axidma.c   |  2 ++
 hw/dma/xlnx_dpdma.c      |  2 ++
 hw/net/cadence_gem.c     | 10 ++++++++++
 hw/ssi/xilinx_spips.c    |  2 ++
 hw/timer/cadence_ttc.c   |  8 ++++++++
 hw/usb/hcd-ehci-sysbus.c |  8 ++++++++
 hw/core/Makefile.objs    |  1 +
 11 files changed, 103 insertions(+), 4 deletions(-)
 create mode 100644 include/hw/sysbus-fdt.h
 create mode 100644 hw/core/sysbus-fdt.c

-- 
2.15.1
