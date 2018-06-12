Received: from eggs.gnu.org ([2001:4830:134:3::10]:59831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPb-00027v-L8
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fSmPY-0005y1-GA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:44:51 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 12 Jun 2018 17:43:55 +0100
Message-Id: <20180612164402.28680-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/7] mac99: add via-pmu support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This patchset is based upon Ben H's experimental branch which adds PMU
support to the QEMU mac99 machine. Currently mac99 uses the via-cuda
device which works in a lot of cases, but many OSs such as MacOS 10.5
only support via-pmu.

A lot of the work I've been doing on the Mac machines over the past
year or so has been to enable me to remove all the hacks from the PMU
work to enable it to be submitted upstream, and here we are.

The choice of via is controlled with a new "via" machine option which
has 3 values:

  via=cuda
  - Use via-cuda as per the current mac99 machine but largely unsupported

  via=pmu-adb
  - Use via-pmu but attach the mouse and keyboard to the PMU ADB bus
    rather than USB (useful for esoteric OS X images)
    
  via=pmu
  - Use via-pmu with USB mouse and keyboards, as per a real PowerMac3,1
    machine
  
Eventually the aim is to switch the mac99 default option to via=pmu but
there are some minor issues with older OS X related to timer calibration
and USB that means I'm not ready to do that just yet.

Note that the via-pmu device also requires an updated OpenBIOS containing
a suitable PMU driver which have been posted over to the OpenBIOS mailing
list at https://mail.coreboot.org/pipermail/openbios/2018-June/010384.html.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (7):
  ppc: introduce Core99MachinesState for the mac99 machine
  mac_newworld: add via machine option to control mac99 VIA/ADB
    configuration
  mac_newworld: add gpios to macio devices with PMU enabled
  mac_newworld: wire up programmer switch to NMI handler
  adb: fix read reg 3 byte ordering
  adb: add property to disable direct reg 3 writes
  mac_newworld: add PMU device

 default-configs/ppc-softmmu.mak |   2 +
 hw/input/adb-kbd.c              |  29 +-
 hw/input/adb-mouse.c            |  41 +-
 hw/input/adb.c                  |   7 +
 hw/misc/macio/Makefile.objs     |   2 +
 hw/misc/macio/gpio.c            | 231 +++++++++++
 hw/misc/macio/macio.c           |  89 +++-
 hw/misc/macio/pmu.c             | 871 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/macio/trace-events      |  28 ++
 hw/ppc/mac.h                    |  20 +
 hw/ppc/mac_newworld.c           |  84 +++-
 include/hw/input/adb.h          |   1 +
 include/hw/misc/macio/gpio.h    |  47 +++
 include/hw/misc/macio/macio.h   |   7 +
 include/hw/misc/macio/pmu.h     | 237 +++++++++++
 include/hw/ppc/ppc.h            |   1 +
 16 files changed, 1639 insertions(+), 58 deletions(-)
 create mode 100644 hw/misc/macio/gpio.c
 create mode 100644 hw/misc/macio/pmu.c
 create mode 100644 include/hw/misc/macio/gpio.h
 create mode 100644 include/hw/misc/macio/pmu.h

-- 
2.11.0
