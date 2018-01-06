Received: from eggs.gnu.org ([2001:4830:134:3::10]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvNt-0006Es-75
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvNo-0007fH-AU
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:48:05 -0500
Received: from smtp8.web4u.cz ([81.91.87.88]:58150 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1eXvNo-0007Xz-0V
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:48:00 -0500
From: pisa@cmp.felk.cvut.cz
Date: Sat,  6 Jan 2018 21:47:28 +0100
Message-Id: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 0/7] CAN bus support for QEMU (SJA1000 PCI so
 far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <frederic.konrad@adacore.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Basic emulation of CAN bus controller and interconnection for QEMU.

Patches version 3:
Support to connect to host SocketCAN interface has been
separated from the core bus implementation. Only simple
statically initialize pointer to the connection function
is used, no QOM concept for now.
SJA1000 message filters redone and code unified where
possible.
Basic documentation added.
QEMU_ALIGNED used in definition of CAN frame structure,
structure and defines still separated from Linux/SocketCAN
API defined ones to allow to keep QEMU message format
independed from host system one. Check for correspondence
to socketcan one added.

Patches version 2:
The bus emulation and the SJA1000 chip emulation introduced
by individual patches as suggested by Frederic Konrad.
Simple example board to test SJA1000 as single memory-mapped BAR
has been omitted in a new series because emulation of real
existing boards can provide same functions now.
Conditionalized debug printfs changed to be exposed to compiler
syntax check as suggested in review.

The work has been started by Jin Yang in the frame of GSoC 2013 slot
contributed by RTEMS project which has been looking for environment
to allow develop and test CAN drivers for multiple CPU architectures.

I have menthored the project and then done substantial code cleanup
and update to QOM. Deniz Eren then used emulation for SJA1000 base card
driver development for other operating system and contributed
PCM-3680I and MIOe-3680 support.

Some page about the project

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/wikis/home

FEE CTU GitLab repository with can-pci branch for 2.3, 2.4, 2.7, 2.8, 2.10 and 2.11
version if QEMU is available there

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci

mirror at GitHub

  https://github.com/CTU-IIG/qemu

There are many areas for improvement and extension of the code still
(for example freeze and migration is not implemented. CAN controllers
use proper QOM model but bus/interconnection emulation uses simple broadcast
connection which is required for CAN, but it is not based on QEMU bus model).
I have tried to look into QEMU VLANs implementation but it
does not map straightforward to CAN and I would need some help/opinion
from more advanced developers to decide what is their right
mapping to CAN.

CAN-FD support would be interesting requires other developers/
companies contributions or setup of some project to allow invite
some students and colleagues from my university into project.

But I believe that (even in its actual state) provided solution
is great help for embedded systems developers when they can connect
SocketCAN from one or more embedded systems running in virtual
environment together or with Linux host SocketCAN virtual
or real bus interfaces.

We have even tested our generic CANopen device configured
for CANopen 401 profile for generic I/O running in the virtual
system which can control GPIO inputs/outputs through virtual
industrial I/O card.

Generally QEMU can be interesting setup which allows
to test complete industrial and automotive applications
in virtual environment even before real hardware is availabe.

Deniz Eren (2):
  CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation added.
  CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.

Pavel Pisa (5):
  CAN bus simple messages transport implementation for QEMU
  CAN bus support to connect bust to Linux host SocketCAN interface.
  CAN bus SJA1000 chip register level emulation for QEMU
  CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.
  QEMU CAN bus emulation documentation

 default-configs/pci.mak   |   3 +
 docs/can.txt              |  78 ++++
 hw/Makefile.objs          |   1 +
 hw/can/Makefile.objs      |  14 +
 hw/can/can_core.c         | 129 ++++++
 hw/can/can_host_stub.c    |  36 ++
 hw/can/can_kvaser_pci.c   | 375 +++++++++++++++++
 hw/can/can_mioe3680_pci.c | 335 ++++++++++++++++
 hw/can/can_pcm3680_pci.c  | 335 ++++++++++++++++
 hw/can/can_sja1000.c      | 996 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/can/can_sja1000.h      | 176 ++++++++
 hw/can/can_socketcan.c    | 294 ++++++++++++++
 include/can/can_emu.h     | 143 +++++++
 13 files changed, 2915 insertions(+)
 create mode 100644 docs/can.txt
 create mode 100644 hw/can/Makefile.objs
 create mode 100644 hw/can/can_core.c
 create mode 100644 hw/can/can_host_stub.c
 create mode 100644 hw/can/can_kvaser_pci.c
 create mode 100644 hw/can/can_mioe3680_pci.c
 create mode 100644 hw/can/can_pcm3680_pci.c
 create mode 100644 hw/can/can_sja1000.c
 create mode 100644 hw/can/can_sja1000.h
 create mode 100644 hw/can/can_socketcan.c
 create mode 100644 include/can/can_emu.h

-- 
2.11.0
