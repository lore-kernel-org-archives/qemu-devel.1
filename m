Received: from eggs.gnu.org ([209.51.188.92]:59287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giTHf-0005Vk-Kx
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 19:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giTCs-0005II-21
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 19:00:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:57618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1giTCr-0005HR-Sx
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 19:00:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1giTCq-00011z-77
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 00:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 327672E80C7
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 00:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Jan 2019 23:53:40 -0000
From: James Harvey <jamespharvey20@gmail.com>
Reply-To: Bug 1811543 <1811543@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154733722037.9104.8291788054708984327.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811543] [NEW] virtio-scsi gives improper discard
 sysfs entries
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

Apologies if this is just an inherent part of paravirtualization that
should be expected.

In my host, I have an LVM thin pool with chunk_size 128MB.  Within it, I
have a thin volume "tmp".  In the host:

# fdisk -l /dev/lvm/tmp
Disk /dev/lvm/tmp: 256 MiB, 268435456 bytes, 524288 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 262144 bytes / 134217728 bytes
Disklabel type: gpt
Disk identifier: BAE3154E-6E85-F642-8129-BAD7B58B2775

Device        Start    End Sectors  Size Type
/dev/lvm/tmp1  2048 524254  522207  255M Linux filesystem

$ lsblk
...
      =E2=94=94=E2=94=80lvm-tmp                      254:13   0   256M  0 l=
vm
        =E2=94=94=E2=94=80lvm-tmp1                   254:14   0   255M  0 p=
art

$ cat /sys/dev/block/254:13/discard_alignment
0
$ cat /sys/dev/block/254:13/queue/discard_granularity
134217728
$ cat /sys/dev/block/254:13/queue/discard_max_bytes
17179869184
$ cat /sys/dev/block/254:13/queue/discard_max_hw_bytes
0
$ cat /sys/dev/block/254:13/queue/discard_zeroes_data
0

$ cat /sys/dev/block/254:14/discard_alignment
133169152
$ cat /sys/dev/block/254:14/queue/discard_granularity
134217728
$ cat /sys/dev/block/254:14/queue/discard_max_bytes
17179869184
$ cat /sys/dev/block/254:14/queue/discard_max_hw_bytes
0
$ cat /sys/dev/block/254:14/queue/discard_zeroes_data
0

If this is given to QEMU using virtio-scsi:

   -device virtio-scsi-pci,id=3Dscsi1 \
   -drive driver=3Draw,node-name=3Dhdb,file=3D/dev/lvm/tmp,if=3Dnone,discar=
d=3Dunmap,id=3Dhd2 \
   -device scsi-hd,drive=3Dhd2,bootindex=3D1 \

Then incorrect values are given:

$ lsblk
...
sdb     8:16   0   256M  0 disk
=E2=94=94=E2=94=80sdb1  8:17   0   255M  0 part /mnt

$ cat /sys/dev/block/8:16/discard_alignment
0
$ cat /sys/dev/block/8:16/queue/discard_granularity
4096
$ cat /sys/dev/block/8:16/queue/discard_max_bytes
1073741824
$ cat /sys/dev/block/8:16/queue/discard_max_hw_bytes
1073741824
$ cat /sys/dev/block/8:16/queue/discard_zeroes_data
0

$ cat /sys/dev/block/8:17/discard_alignment
133169152

And, there isn't even a /sys/dev/block/8:17/queue direcotry.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811543

Title:
  virtio-scsi gives improper discard sysfs entries

Status in QEMU:
  New

Bug description:
  Apologies if this is just an inherent part of paravirtualization that
  should be expected.

  In my host, I have an LVM thin pool with chunk_size 128MB.  Within it,
  I have a thin volume "tmp".  In the host:

  # fdisk -l /dev/lvm/tmp
  Disk /dev/lvm/tmp: 256 MiB, 268435456 bytes, 524288 sectors
  Units: sectors of 1 * 512 =3D 512 bytes
  Sector size (logical/physical): 512 bytes / 4096 bytes
  I/O size (minimum/optimal): 262144 bytes / 134217728 bytes
  Disklabel type: gpt
  Disk identifier: BAE3154E-6E85-F642-8129-BAD7B58B2775

  Device        Start    End Sectors  Size Type
  /dev/lvm/tmp1  2048 524254  522207  255M Linux filesystem

  $ lsblk
  ...
        =E2=94=94=E2=94=80lvm-tmp                      254:13   0   256M  0=
 lvm
          =E2=94=94=E2=94=80lvm-tmp1                   254:14   0   255M  0=
 part

  $ cat /sys/dev/block/254:13/discard_alignment
  0
  $ cat /sys/dev/block/254:13/queue/discard_granularity
  134217728
  $ cat /sys/dev/block/254:13/queue/discard_max_bytes
  17179869184
  $ cat /sys/dev/block/254:13/queue/discard_max_hw_bytes
  0
  $ cat /sys/dev/block/254:13/queue/discard_zeroes_data
  0

  $ cat /sys/dev/block/254:14/discard_alignment
  133169152
  $ cat /sys/dev/block/254:14/queue/discard_granularity
  134217728
  $ cat /sys/dev/block/254:14/queue/discard_max_bytes
  17179869184
  $ cat /sys/dev/block/254:14/queue/discard_max_hw_bytes
  0
  $ cat /sys/dev/block/254:14/queue/discard_zeroes_data
  0

  If this is given to QEMU using virtio-scsi:

     -device virtio-scsi-pci,id=3Dscsi1 \
     -drive driver=3Draw,node-name=3Dhdb,file=3D/dev/lvm/tmp,if=3Dnone,disc=
ard=3Dunmap,id=3Dhd2 \
     -device scsi-hd,drive=3Dhd2,bootindex=3D1 \

  Then incorrect values are given:

  $ lsblk
  ...
  sdb     8:16   0   256M  0 disk
  =E2=94=94=E2=94=80sdb1  8:17   0   255M  0 part /mnt

  $ cat /sys/dev/block/8:16/discard_alignment
  0
  $ cat /sys/dev/block/8:16/queue/discard_granularity
  4096
  $ cat /sys/dev/block/8:16/queue/discard_max_bytes
  1073741824
  $ cat /sys/dev/block/8:16/queue/discard_max_hw_bytes
  1073741824
  $ cat /sys/dev/block/8:16/queue/discard_zeroes_data
  0

  $ cat /sys/dev/block/8:17/discard_alignment
  133169152

  And, there isn't even a /sys/dev/block/8:17/queue direcotry.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811543/+subscriptions
