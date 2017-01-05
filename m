Received: from eggs.gnu.org ([2001:4830:134:3::10]:42904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHCO-000874-FW
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHCL-0006cR-AY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:11:56 -0500
Received: from smtp7.web4u.cz ([81.91.87.87]:57007 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1cPHCL-0006c2-3N
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:11:53 -0500
From: pisa@cmp.felk.cvut.cz
Date: Fri,  6 Jan 2017 00:11:22 +0100
Message-Id: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 0/6] CAN bus support for QEMU (SJA1000 PCI so
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <fred.konrad@greensocs.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Hello Stefan and others,

I have found some time over holidays. I have rebased patches
and checked that the CAN bus emulation works with QEMU-2.8 release.

The work has been started by Jin Yang in the frame of GSoC 2013 slot
contributed by RTEMS project which has been looking for environment
to allow develope and test CAN drivers for multiple CPU rachitectures.

I have menthored the project and then done substantial code cleanup
and update to QOM. Deniz Eren then used emulation for SJA1000 base card
driver development for other operating system and contributed
PCM-3680I support.

Some page about the project

  https://rtime.felk.cvut.cz/can/can-qemu/

RTLWS 2015 article

  http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can.pdf

and slides

  http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can-slides.pdf

GitHub repository with can-pci branch for 2.3, 2.4, 2.7 and 2.8
version if QEMU is available there

  https://github.com/CTU-IIG/qemu

There are more unsolved things in the code still (for example freeze
and migration would not work. CAN controllers use proper QOM model
but bus/interconnection emulation uses simple broadcast connection
which is required for CAN, but it is not based on QEMU bus model).

CAN-FD support would be interesting but it is missing and there
is almost zero chance that I find spare time to start such
work without more people contribute and or funded project
at university which would allow to seek between my colleagues
for cooperation.

But I believe that (even in its actual state) provided solution
is great help for embedded systems developers when they can connect
SocketCAN from one or more embedded systems running in virtual
environment together or with Linux host SocketCAN virtual
or real bus interfaces.

We have even tested our generic CANopen device configured
for CANopen 401 profile for generic I/O running in the virtual
system which can control GPIO inputs/outputs through virtual
industrial I/O card. This industrial I/O card support
would worth to be included in QEMU mainline as well but
it would require even more effort to get it into mainline
acceptable state then this CAN support even that we have
mainlined UIO and Comedi drivers for that this card hardware
to Linux mainline long time ago.

Generally QEMU can be interesting setup which allows
to test complete industrial applications in virtual
environment even before real hardware is availabe.

Best wishes and sucesfull year 2017,

Pavel

Deniz Eren (4):
  CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation added.
  Fixed IRQ problem for CAN device can_pcm3680_pci.
  Minor clean-up of can_pcm3680_pci.
  CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.

Pavel Pisa (2):
  CAN bus simple SJA1000 PCI card emulation for QEMU
  CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.

 default-configs/pci.mak   |   2 +
 hw/Makefile.objs          |   1 +
 hw/can/Makefile.objs      |   8 +
 hw/can/can_core.c         | 349 +++++++++++++++++
 hw/can/can_kvaser_pci.c   | 364 ++++++++++++++++++
 hw/can/can_mioe3680_pci.c | 325 ++++++++++++++++
 hw/can/can_pci.c          | 239 ++++++++++++
 hw/can/can_pcm3680_pci.c  | 325 ++++++++++++++++
 hw/can/can_sja1000.c      | 943 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/can/can_sja1000.h      | 163 ++++++++
 include/can/can_emu.h     | 123 ++++++
 11 files changed, 2842 insertions(+)
 create mode 100644 hw/can/Makefile.objs
 create mode 100644 hw/can/can_core.c
 create mode 100644 hw/can/can_kvaser_pci.c
 create mode 100644 hw/can/can_mioe3680_pci.c
 create mode 100644 hw/can/can_pci.c
 create mode 100644 hw/can/can_pcm3680_pci.c
 create mode 100644 hw/can/can_sja1000.c
 create mode 100644 hw/can/can_sja1000.h
 create mode 100644 include/can/can_emu.h

-- 
1.9.1
