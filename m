Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWRfL-0001FD-Nt
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWRfH-0004hs-Jn
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:19:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:53405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dWRfH-0004hi-Dc
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:19:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dWRfF-0000En-TQ
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 18:19:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D640E2E80E6
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 18:19:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Jul 2017 18:05:24 -0000
From: =?utf-8?b?UnViw6luIFJvZHLDrWd1ZXo=?= <1600563@bugs.launchpad.net>
Reply-To: Bug 1600563 <1600563@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160710075125.17855.72473.malonedeb@wampee.canonical.com>
Message-Id: <150014192429.24106.12213370798228841941.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1600563] Re: min_io_size is currently limited to
 size uint16_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The value is set to uint16_t by mistake. The value is passed to Qemu in
bytes, but then it is divided by the sector size and passed to the vm in
sectors through a 16 bit register field. The vm kernel then multiplies
it again by sector size and shows (through /sys/block/x/queue) the value
in bytes. Because of this, the input value from the qemu side should be
uint32_t.

A simple patch is attached, correcting the problem. I think some extra
logic should be added after dividing by the page size, to prevent
overflowing the 16 bit register.

With that patch, I can pass a 4MB min and optimal io sizes successfully,
to match the stripe size used by RBD/Ceph. Sadly though, I see no
improvement coming out of it, but I'll document that in a separate bug
report.

root@cephvm:~# lsblk -t
NAME     ALIGNMENT  MIN-IO  OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE   RA =
WSAME
sda              0 4194304 4194304     512     512    1 noop      128 4096 =
   2G

** Patch added: "min_io_size32.patch"
   https://bugs.launchpad.net/qemu/+bug/1600563/+attachment/4915272/+files/=
min_io_size32.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1600563

Title:
  min_io_size is currently limited to size uint16_t

Status in QEMU:
  New

Bug description:
  I am using LVM VGs on MD-raid1 for hosting my KVM volumes. On the
  host, a VG looks like this:

  Disk /dev/vm/vol202a: 60 GiB, 64424509440 bytes, 125829120 sectors
  Units: sectors of 1 * 512 =3D 512 bytes
  Sector size (logical/physical): 512 bytes / 4096 bytes
  I/O size (minimum/optimal): 131072 bytes / 131072 bytes

  In order to replicate the block device characteristics in the guest, I
  am using the following extra parameters:

  -set device.scsi0-0-0-0.logical_block_size=3D512
  -set device.scsi0-0-0-0.physical_block_size=3D4096
  -set device.scsi0-0-0-0.min_io_size=3D131072

  This doesn't work as qemu complains that min_io_size needs to be of
  type uint16_t.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1600563/+subscriptions
