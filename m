Received: from eggs.gnu.org ([2001:4830:134:3::10]:34368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003FC-Ny
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008Iq-OK
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:19 +0200
Message-Id: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 0/6] Clock and power gating support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, mark.burton@greensocs.com, saipava@xilinx.com, luc.michel@greensocs.com, alistair@alistair23.me, Damien Hedde <damien.hedde@greensocs.com>

This set of patches add support for power and clock gating in device objects.
It adds two booleans to the state, one for power state and one of clock state.

The state is controlled trough 2 functions, one for power and one for clock.
Two new methods *power_update* and *clock_update* is added to the device class
which are called on state change and can be overriden.

Default behavior is the following:
+ Device are initialized in powered and clocked state.
+ reset method is called when powering-up.

This set also implements this support in the cadence_uart device in the
xilinx_zynq platform as an example.

The 1st patch add the gating support to the base device object. The 2nd patch
add functions to act on a whole bus tree. The 3rd patch overrides the 
*power/clock_update* methods for sysbus devices to enable/disable the memory
regions according to the state.

The 4th patch updates the cadence_uart device and the 5th patch adds
uart clock gating support to the zynq clock controller *slcr*. The 6th patch
finally adds the support to *xilinx-zynq* machine.

This is an RFC as it remains open questions about the strategy to implement
this kind of support. Here's some remarks:

+ This set adds power and clock, some reset state could be added too. Although
  default behavior is tricky to implement because there is many kind of reset
  (eg syncronous/asynchronous).
+ I used methods which require to store links of controlled devices in
  clock/power controller. Using gpios or specifics child objects to
  achieve the same functionnaly is possible.
+ Power and clock state could be merged to a single 3-state (powered-off,
  unclocked, on) since clock does not really matters when powered-off.
+ Regarding migration, it's problematic to add the VMStateDescription in qdev
  so we let it to the specialization (eg in cadence_uart) to handle it. Is
  this a problem ? Anyway support of clock gating requires modification in
  specialization. It may not be necessary to store the gating states in each
  device, since it is stored already in the controller registers. But we would
  then have to set the gating state of devices in the controller's post_load
  which may occurs before or after devices VMState load: It seems tricky to
  ensure device state is correct at the end if gating update do side-effects.
+ theses patches add a simple vision (1 power, 1 clock). Devices can be more
  complex. For example, the zynq's uart has 2 independant clock domains:
  1 for the bus interface, 1 for uart operations. I'm not sure if we should
  keep 1, add the bus/device separation or do something more configurable on
  a per-specialization basis.

Feel free to comment,

Damien Hedde (6):
  qdev: add a power and clock gating support
  qdev: add power/clock gating control on bus tree
  sysbus: Specialize gating_update to enable/disable memory regions
  cadence_uart: add clock/power gating support
  zynq_slcr: add uart clock gating and soft reset support
  xilinx_zynq: add uart clock gating support

 include/hw/qdev-core.h |  50 ++++++++++++++++++++
 include/hw/sysbus.h    |   3 ++
 hw/arm/xilinx_zynq.c   |  20 +++++---
 hw/char/cadence_uart.c |  25 +++++++++-
 hw/core/qdev.c         | 103 +++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus.c       |  39 ++++++++++++++++
 hw/misc/zynq_slcr.c    |  63 +++++++++++++++++++++++++
 7 files changed, 296 insertions(+), 7 deletions(-)

-- 
2.18.0
