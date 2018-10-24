Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFOV4-00060W-QU
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFOOp-0005ll-SK
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:01:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:47964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFOOp-0005XQ-5X
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 15:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFOOi-0002N6-0M
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 19:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 015A72E8052
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 19:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Oct 2018 18:53:23 -0000
From: =?utf-8?b?SGlib3U1N8KgKFlhbm5pY2vCoER1Y2jDqm5lKQ==?=
	<yannick_duchene@yahoo.fr>
Reply-To: Bug 1799766 <1799766@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154040720342.20108.15765705817940864119.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1799766] [NEW] -device does not work as -drive do
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Copy/paste of https://stackoverflow.com/questions/52929723/qemu-eject-
complains-device-is-not-found-while-it-is-there , since I found this bug
trying to find an answer to an own question on Stack Overflow.

Below, what was my question the answer I wrote, all exposes the bug.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


I need to eject a floppy from QEmu=E2=80=AF3.0 monitor, but the command sur=
prisingly fails complaining the device is not found, while it is really the=
re.

Listing of devices:

    (qemu) info block
    fda: dos-6-22/Dos622-1.img (raw)
        Attached to:      /machine/unattached/device[11]
        Removable device: not locked, tray closed
        Cache mode:       writeback

    hda: hda.img (raw)
        Attached to:      /machine/peripheral-anon/device[1]
        Cache mode:       writeback

Eject command result:

    (qemu) eject fda
    Device 'fda' not found

This is so although this documentation says this is how I have to do:
https://www.linux-kvm.org/page/Change_cdrom (just that I want to eject
the floppy instead of the CD=E2=80=91ROM).

The `change` command complains the same:

    (qemu) change fda dos-6-22/Dos622-2.img raw
    Device 'fda' not found

Is this a bug or me doing something wrong?

I tried using different node names, with always the same result.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I=E2=80=99m posting as an answer, but I=E2=80=99m not strictly sure. I can =
just say, if
I understand correctly, this is a bug.

The answer comes in two parts.

First part, is a stripped down failing invocation:

    qemu-system-i386 \
       -monitor stdio \
       -machine type=3Disapc,vmport=3Doff \
       -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
       -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img \
       -global isa-fdc.driveA=3Dfda

    (qemu) info block
    ide1-cd0: [not inserted]
        Attached to:      /machine/unattached/device[19]
        Removable device: not locked, tray closed

    sd0: [not inserted]
        Removable device: not locked, tray closed

    fda: fda.img (raw)
        Attached to:      /machine/unattached/device[13]
        Removable device: not locked, tray closed
        Cache mode:       writeback
    (qemu) eject fda
    Device 'fda' not found

Second part, is the same without the last argument `-global isa-
fdc.driveA=3Dfda`:

    qemu-system-i386 \
       -monitor stdio \
       -machine type=3Disapc,vmport=3Doff \
       -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
       -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img

    (qemu) info block
    ide1-cd0: [not inserted]
        Attached to:      /machine/unattached/device[19]
        Removable device: not locked, tray closed

    floppy0: [not inserted]
        Attached to:      /machine/unattached/device[13]
        Removable device: not locked, tray closed

    sd0: [not inserted]
        Removable device: not locked, tray closed
    (qemu) eject floppy0

There is more error when `-global isa-fdc.driveA=3Dfda` is removed.
However, the documentation says:

> -global driver=3Ddriver,property=3Dproperty,value=3Dvalue
> Set default value of driver=E2=80=99s property prop to value, e.g.:

> qemu-system-i386 -global ide-hd.physical_block_size=3D4096 disk-image.img
> In particular, you can **use this to set driver properties for devices wh=
ich are created automatically by the machine model**. To create a device wh=
ich is not created automatically and set properties on it, use -device.

> -global driver.prop=3Dvalue is shorthand for -global
driver=3Ddriver,property=3Dprop,value=3Dvalue. The longhand syntax works ev=
en
when driver contains a dot.

What I put a stress on in the quote, suggest I=E2=80=99m not misusing `-glo=
bal`
and that=E2=80=99s most probably a bug.

**Update for more details:**

It seems using `-drive` instead of `-device` and `driveA` assignment,
the result is not the same, although RedHat documentation recommands
using `-device` instead of `-drive` and QEmu=E2=80=AF3.0 documentation says
`-drive` is essentially a shortcut for `-device` (=E2=80=9Cessentially=E2=
=80=9D, not
telling about the difference).

Below, two cases, with an except of `info block` and an excerpt of `info
qtree`.

With this one, `eject floppy0` works:

    qemu-system-i386 \
       -monitor stdio \
       -machine type=3Disapc,vmport=3Doff \
       -drive format=3Draw,if=3Dfloppy,media=3Ddisk,file=3Dfda.img \
       -device isa-vga,vgamem_mb=3D1 \
       -serial msmouse

    [=E2=80=A6]

    floppy0 (#block156): fda.img (raw)
        Attached to:      /machine/unattached/device[12]
        Removable device: not locked, tray closed
        Cache mode:       writeback

    [=E2=80=A6]

      dev: isa-fdc, id ""
        iobase =3D 1008 (0x3f0)
        irq =3D 6 (0x6)
        dma =3D 2 (0x2)
        driveA =3D ""
        driveB =3D ""
        check_media_rate =3D true
        fdtypeA =3D "auto"
        fdtypeB =3D "auto"
        fallback =3D "288"
        isa irq 6
        bus: floppy-bus.0
          type floppy-bus
          dev: floppy, id ""
            unit =3D 0 (0x0)
            drive =3D "floppy0"
            logical_block_size =3D 512 (0x200)
            physical_block_size =3D 512 (0x200)
            min_io_size =3D 0 (0x0)
            opt_io_size =3D 0 (0x0)
            discard_granularity =3D 4294967295 (0xffffffff)
            write-cache =3D "auto"
            share-rw =3D false
            drive-type =3D "144"

With this one, `eject fda` does not work:

    qemu-system-i386 \
       -monitor stdio \
       -machine type=3Disapc,vmport=3Doff \
       -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
       -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img \
       -global isa-fdc.driveA=3Dfda \
       -device isa-vga,vgamem_mb=3D1 \
       -serial msmouse

    [=E2=80=A6]

    fda: fda.img (raw)
        Attached to:      /machine/unattached/device[12]
        Removable device: not locked, tray closed
        Cache mode:       writeback

    [=E2=80=A6]

      dev: isa-fdc, id ""
        iobase =3D 1008 (0x3f0)
        irq =3D 6 (0x6)
        dma =3D 2 (0x2)
        driveA =3D ""
        driveB =3D ""
        check_media_rate =3D true
        fdtypeA =3D "auto"
        fdtypeB =3D "auto"
        fallback =3D "288"
        isa irq 6
        bus: floppy-bus.0
          type floppy-bus
          dev: floppy, id ""
            unit =3D 0 (0x0)
            drive =3D "fda"
            logical_block_size =3D 512 (0x200)
            physical_block_size =3D 512 (0x200)
            min_io_size =3D 0 (0x0)
            opt_io_size =3D 0 (0x0)
            discard_granularity =3D 4294967295 (0xffffffff)
            write-cache =3D "auto"
            share-rw =3D false
            drive-type =3D "144"

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799766

Title:
  -device does not work as -drive do

Status in QEMU:
  New

Bug description:
  Copy/paste of https://stackoverflow.com/questions/52929723/qemu-eject-
  complains-device-is-not-found-while-it-is-there , since I found this
  bug trying to find an answer to an own question on Stack Overflow.

  Below, what was my question the answer I wrote, all exposes the bug.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  =

  I need to eject a floppy from QEmu=E2=80=AF3.0 monitor, but the command s=
urprisingly fails complaining the device is not found, while it is really t=
here.

  Listing of devices:

      (qemu) info block
      fda: dos-6-22/Dos622-1.img (raw)
          Attached to:      /machine/unattached/device[11]
          Removable device: not locked, tray closed
          Cache mode:       writeback

      hda: hda.img (raw)
          Attached to:      /machine/peripheral-anon/device[1]
          Cache mode:       writeback

  Eject command result:

      (qemu) eject fda
      Device 'fda' not found

  This is so although this documentation says this is how I have to do:
  https://www.linux-kvm.org/page/Change_cdrom (just that I want to eject
  the floppy instead of the CD=E2=80=91ROM).

  The `change` command complains the same:

      (qemu) change fda dos-6-22/Dos622-2.img raw
      Device 'fda' not found

  Is this a bug or me doing something wrong?

  I tried using different node names, with always the same result.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I=E2=80=99m posting as an answer, but I=E2=80=99m not strictly sure. I ca=
n just say,
  if I understand correctly, this is a bug.

  The answer comes in two parts.

  First part, is a stripped down failing invocation:

      qemu-system-i386 \
         -monitor stdio \
         -machine type=3Disapc,vmport=3Doff \
         -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
         -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img \
         -global isa-fdc.driveA=3Dfda

      (qemu) info block
      ide1-cd0: [not inserted]
          Attached to:      /machine/unattached/device[19]
          Removable device: not locked, tray closed

      sd0: [not inserted]
          Removable device: not locked, tray closed

      fda: fda.img (raw)
          Attached to:      /machine/unattached/device[13]
          Removable device: not locked, tray closed
          Cache mode:       writeback
      (qemu) eject fda
      Device 'fda' not found

  Second part, is the same without the last argument `-global isa-
  fdc.driveA=3Dfda`:

      qemu-system-i386 \
         -monitor stdio \
         -machine type=3Disapc,vmport=3Doff \
         -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
         -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img

      (qemu) info block
      ide1-cd0: [not inserted]
          Attached to:      /machine/unattached/device[19]
          Removable device: not locked, tray closed

      floppy0: [not inserted]
          Attached to:      /machine/unattached/device[13]
          Removable device: not locked, tray closed

      sd0: [not inserted]
          Removable device: not locked, tray closed
      (qemu) eject floppy0

  There is more error when `-global isa-fdc.driveA=3Dfda` is removed.
  However, the documentation says:

  > -global driver=3Ddriver,property=3Dproperty,value=3Dvalue
  > Set default value of driver=E2=80=99s property prop to value, e.g.:

  > qemu-system-i386 -global ide-hd.physical_block_size=3D4096 disk-image.i=
mg
  > In particular, you can **use this to set driver properties for devices =
which are created automatically by the machine model**. To create a device =
which is not created automatically and set properties on it, use -device.

  > -global driver.prop=3Dvalue is shorthand for -global
  driver=3Ddriver,property=3Dprop,value=3Dvalue. The longhand syntax works
  even when driver contains a dot.

  What I put a stress on in the quote, suggest I=E2=80=99m not misusing
  `-global` and that=E2=80=99s most probably a bug.

  **Update for more details:**

  It seems using `-drive` instead of `-device` and `driveA` assignment,
  the result is not the same, although RedHat documentation recommands
  using `-device` instead of `-drive` and QEmu=E2=80=AF3.0 documentation sa=
ys
  `-drive` is essentially a shortcut for `-device` (=E2=80=9Cessentially=E2=
=80=9D, not
  telling about the difference).

  Below, two cases, with an except of `info block` and an excerpt of
  `info qtree`.

  With this one, `eject floppy0` works:

      qemu-system-i386 \
         -monitor stdio \
         -machine type=3Disapc,vmport=3Doff \
         -drive format=3Draw,if=3Dfloppy,media=3Ddisk,file=3Dfda.img \
         -device isa-vga,vgamem_mb=3D1 \
         -serial msmouse

      [=E2=80=A6]

      floppy0 (#block156): fda.img (raw)
          Attached to:      /machine/unattached/device[12]
          Removable device: not locked, tray closed
          Cache mode:       writeback

      [=E2=80=A6]

        dev: isa-fdc, id ""
          iobase =3D 1008 (0x3f0)
          irq =3D 6 (0x6)
          dma =3D 2 (0x2)
          driveA =3D ""
          driveB =3D ""
          check_media_rate =3D true
          fdtypeA =3D "auto"
          fdtypeB =3D "auto"
          fallback =3D "288"
          isa irq 6
          bus: floppy-bus.0
            type floppy-bus
            dev: floppy, id ""
              unit =3D 0 (0x0)
              drive =3D "floppy0"
              logical_block_size =3D 512 (0x200)
              physical_block_size =3D 512 (0x200)
              min_io_size =3D 0 (0x0)
              opt_io_size =3D 0 (0x0)
              discard_granularity =3D 4294967295 (0xffffffff)
              write-cache =3D "auto"
              share-rw =3D false
              drive-type =3D "144"

  With this one, `eject fda` does not work:

      qemu-system-i386 \
         -monitor stdio \
         -machine type=3Disapc,vmport=3Doff \
         -blockdev driver=3Dfile,node-name=3Dfda-img,filename=3Dfda.img \
         -blockdev driver=3Draw,node-name=3Dfda,file=3Dfda-img \
         -global isa-fdc.driveA=3Dfda \
         -device isa-vga,vgamem_mb=3D1 \
         -serial msmouse

      [=E2=80=A6]

      fda: fda.img (raw)
          Attached to:      /machine/unattached/device[12]
          Removable device: not locked, tray closed
          Cache mode:       writeback

      [=E2=80=A6]

        dev: isa-fdc, id ""
          iobase =3D 1008 (0x3f0)
          irq =3D 6 (0x6)
          dma =3D 2 (0x2)
          driveA =3D ""
          driveB =3D ""
          check_media_rate =3D true
          fdtypeA =3D "auto"
          fdtypeB =3D "auto"
          fallback =3D "288"
          isa irq 6
          bus: floppy-bus.0
            type floppy-bus
            dev: floppy, id ""
              unit =3D 0 (0x0)
              drive =3D "fda"
              logical_block_size =3D 512 (0x200)
              physical_block_size =3D 512 (0x200)
              min_io_size =3D 0 (0x0)
              opt_io_size =3D 0 (0x0)
              discard_granularity =3D 4294967295 (0xffffffff)
              write-cache =3D "auto"
              share-rw =3D false
              drive-type =3D "144"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799766/+subscriptions
