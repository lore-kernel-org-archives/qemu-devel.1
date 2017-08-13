Received: from eggs.gnu.org ([2001:4830:134:3::10]:51816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh271-0007Ph-Nm
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh26y-0005uK-PW
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:03 -0400
Message-Id: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Aug 2017 19:04:38 +0200
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 00/12] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Hello,

Here's a series to add emulation of the Sam460ex to QEMU. (This board
is interesting because besides Linux, it is supported by several Amiga
like OSes.) This code is based on previous work by Fran=C3=A7ois Revol,
cleaning it up and adding some missing parts to get it to start
working at least for the Linux kernel and the original U-Boot firmware
of the board (which is needed to boot the Amiga like OSes easily).

This is not complete and cannot run most of the interesting OSes yet
as there are still missing parts and likely some bugs I could not fix
but since I have limited time and knowledge to work on this, I'd like
to submit it now to get it reviewed and maybe some advice or even some
help to finish it from other interested parties (especially if you
have better knowledge of this hardware). Hence this RFC series, but it
is probably in a shape now like some of the similar boards already in
QEMU so if after review it is deemed fit I'd like to submit it for
inclusion when development opens again.

Some resources and status for those who want to help:

The board is described on the manufacturer's site:
http://www.acube-systems.biz/index.php?page=3Dhardware&pid=3D5
where links can also be found to the official firmware and Linux
images. Only the original 2010.06.05 firmware is tested from the
20110414 updater (there is a newer version but that's only relevant
for real hardware and may not work with this emulation so that's not
recommended). This firmware works and starts booting but that's when
problems start and you'll most likely hit some problem with most
images before they boot.

AROS and Linux iso-s use the Parthenope (ub2lb) bootloader which
currently fails when it calls the start_unit_scan with NULL first
argument in cdrom.c:get_dev() which causes a null pointer dereference
in U-Boot/board/ACube/common/sys_dep.c:start_unit_scan() which causes
an exception in QEMU (vector 1300, I think it's Data TLB Error) and
this leads to breakage. This may be a bug in the firmware but
apparently on real hardware this works somehow so this suggests a
difference in emulation that should be fixed. If I fix this in U-Boot
then it hits another bug in board/ACube/common/cmd_boota.c where it
references stack variable beyond its scope and gets garbled text (I
wonder how this was working, maybe they used different compiler and
were lucky). This causes Parthenope not find its menu.lst config. Also
fixing this (here's a binary with both fixes:
http://zero.eik.bme.hu/~balaton/qemu/ ) finally it gets further
booting but then AROS fails while setting up the MMU so maybe this
means there are some bugs or differences between the MMU/TLB/exception
emulation and real hardware (assuming it works on real hardware at
all). But I don't know how real hardware works so I could not find it
out. Does anyone have an idea?

Linux can also be booted via -kernel -dtb -initrd instead of booting
the iso via the firmware and this gets to executing the initrd but
then it seems to hang and I could not identify where and why. There
are different Linux images so maybe some work better or worse but I
could not fully boot a Linux system yet only to the initrd (although
I've only tried a few not all of them). Also most of these images are
network installers and the on board ppc4xx ethernet port is not yet
emulated so this may cause the hang. Anyone wants to contribute?

MorphOS starts booting but does not find PCI devices so it fails.
Unfortunately I don't know how to set kernel parameters to enable
debug logging (passing them via the bootloader like on Mac does not
work and MorphOS people haven't reply my query about it) so I don't
care for now until other OSes easier to debug can't boot. (Besides,
MorphOS could also run on the Mac emulation and may get a new version
soon which might change a few things so it's low priority now; maybe
I look at it again when new version is available.) I could not test
AmigaOS because I don't have that but I would not be surprised if it
would also fail during boot for some reason but if someone has a copy
and can try it let me know how it fails (try -serial stdio to hopefully
get some logs).

How can you help? (Besides fixing bugs and implementing missing parts
if you can do that, but in that case you probably know what to do.)
No monetary donations are solicited or accepted (I'm saying this
because I got some anonymous donations in the past which I did not
claim so they went to the QEMU project and did not help this work in
any way, so this is not a good way to support this activity.) What
would be more useful is to test on real hardware to get logs for
comparison so if you have a Sam460ex (or its simpler Sam460cr version)
and could gather debug logs over the serial port try getting some with
an AROS iso then contact me with the log and for an AROS iso with more
logging enabled to get more details.

In any case, I do this in my free time and for personal interest so
don't expect any support or roadmap for this. If the info here is not
enough for you to get it working for testing then it's not ready for
you yet. I don't have time to help people with this so if you can't
find it out you should wait until it's more developed (which may take
years or could be never). Sorry for this disclaimer here but I've
learned that the situation with Amiga like OSes can sometimes be
interesting and I would like to avoid misunderstandings. This is very
much work in progress not useful for the general users at the moment,
only for interested developers.


BALATON Zoltan (12):
  ppc4xx: Move MAL from ppc405_uc to ppc4xx_devs
  ppc4xx: Make MAL emulation more generic
  ohci: Allow sysbus version to be used as a companion
  ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC SoCs
  ppc4xx: Split off 4xx I2C emulation from ppc405_uc to its own file
  ppc4xx_i2c: QOMify
  ppc4xx_i2c: Implement basic I2C functions
  hw/ide: Emulate SiI3112 SATA controller
  ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
  ppc: Add 460EX embedded CPU
  ppc4xx: Export ECB and PLB emulation
  ppc: Add aCube Sam460ex board

 default-configs/ppcemb-softmmu.mak |    3 +
 hw/ide/Makefile.objs               |    1 +
 hw/ide/sii3112.c                   |  365 +++++++
 hw/ppc/Makefile.objs               |    4 +-
 hw/ppc/ppc405.h                    |    3 +
 hw/ppc/ppc405_uc.c                 |  527 +---------
 hw/ppc/ppc440_pcix.c               |  506 ++++++++++
 hw/ppc/ppc4xx_devs.c               |  227 +++++
 hw/ppc/ppc4xx_i2c.c                |  391 ++++++++
 hw/ppc/sam460ex.c                  | 1895 ++++++++++++++++++++++++++++++=
++++++
 hw/usb/hcd-ehci-sysbus.c           |   25 +
 hw/usb/hcd-ehci.h                  |    1 +
 hw/usb/hcd-ohci.c                  |   15 +-
 include/hw/i2c/ppc4xx_i2c.h        |   64 ++
 include/hw/pci/pcie_host.h         |    2 +-
 include/hw/ppc/ppc4xx.h            |    3 +
 target/ppc/cpu-models.c            |    3 +
 target/ppc/cpu-models.h            |    1 +
 target/ppc/translate_init.c        |   38 +
 19 files changed, 3557 insertions(+), 517 deletions(-)
 create mode 100644 hw/ide/sii3112.c
 create mode 100644 hw/ppc/ppc440_pcix.c
 create mode 100644 hw/ppc/ppc4xx_i2c.c
 create mode 100644 hw/ppc/sam460ex.c
 create mode 100644 include/hw/i2c/ppc4xx_i2c.h

--=20
2.7.4
