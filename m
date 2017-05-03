Received: from eggs.gnu.org ([2001:4830:134:3::10]:55058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5rYd-0005u3-Mo
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5rYY-00046O-P3
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:55627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5rYY-00046D-ID
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:30:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5rYW-0005xI-AP
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 10:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 432022E80C7
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 10:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 May 2017 10:23:24 -0000
From: Stefan Hajnoczi <1687653@bugs.launchpad.net>
Reply-To: Bug 1687653 <1687653@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170502155311.4290.95799.malonedeb@soybean.canonical.com>
Message-Id: <20170503102324.2762.37164.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687653] Re: QEMU-KVM / detect_zeroes causes KVM
 to start unlimited number of threads on Guest-Sided High-IO with big
 Blocksize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm unable to reproduce this issue.  The host stays responsive and the
dd command completes in a reasonable amount of time.  QEMU does not
exceed the 64-thread pool size.

Please post steps to reproduce the issue using a minimal command-line
without libvirt.

Here is information on my attempt to reproduce the problem:

Guest: Kernel 4.10.8-200.fc25.x86_64
Host: 4.10.11-200.fc25.x86_64
QEMU: qemu.git/master (e619b14746e5d8c0e53061661fd0e1da01fd4d60)

The LV is 1 GB on top of LUKS on a Samsung MZNLN256HCHP SATA SSD drive.

mpstat -P ALL 5 output:
11:02:02 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %=
guest  %gnice   %idle
11:02:07 AM  all    3.36    0.00    6.22   34.54    0.25    0.50    0.00   =
 3.11    0.00   52.03
11:02:07 AM    0    2.82    0.00    5.63   32.39    0.80    1.21    0.00   =
 3.22    0.00   53.92
11:02:07 AM    1    3.02    0.00    6.04   28.77    0.20    0.20    0.00   =
 3.02    0.00   58.75
11:02:07 AM    2    3.56    0.00    7.71   44.27    0.20    0.40    0.00   =
 2.37    0.00   41.50
11:02:07 AM    3    3.81    0.00    5.61   32.46    0.00    0.40    0.00   =
 4.01    0.00   53.71

vmstat 5 output:
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu=
-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id =
wa st
 0  0      0 1617404   6484 3541468    0    0  2145 84794 1976 8814  8  8 6=
4 20  0
 0  0      0 1619492   6484 3538592    0    0   613 69340 1518 7430  6  7 7=
0 17  0
 0  0      0 1618920   6484 3538680    0    0   280 75199 1421 6811  6  7 5=
2 35  0

pidstat -v -p $PID_OF_QEMU 5 output:
11:01:08 AM   UID       PID threads   fd-nr  Command
11:02:03 AM     0     13043      67      37  qemu-system-x86
11:02:08 AM     0     13043      67      37  qemu-system-x86
11:02:13 AM     0     13043      67      37  qemu-system-x86

$ sudo x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 1024 -cpu host \
        -device virtio-scsi-pci,id=3Dscsihw0,bus=3Dpci.0,addr=3D0x5 \
        -drive file=3Dtest.img,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cach=
e=3Dnone,aio=3Dnative,detect-zeroes=3Don \
        -device scsi-hd,bus=3Dscsihw0.0,channel=3D0,scsi-id=3D0,lun=3D0,dri=
ve=3Ddrive-scsi0,id=3Dscsi0,bootindex=3D100 \
        -drive file=3D/dev/path/to/testlv,if=3Dnone,id=3Ddrive-scsi1,format=
=3Draw,cache=3Dnone,aio=3Dnative,detect-zeroes=3Don \
        -device scsi-hd,bus=3Dscsihw0.0,channel=3D0,scsi-id=3D0,lun=3D1,dri=
ve=3Ddrive-scsi1,id=3Dscsi1,bootindex=3D101 \
        -nographic

guest# dd if=3D/dev/zero of=3D/dev/sdb bs=3D1G count=3D1 oflag=3Ddirect
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 15.0681 s, 71.3 MB/s

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687653

Title:
  QEMU-KVM / detect_zeroes causes KVM to start unlimited number of
  threads on Guest-Sided High-IO with big Blocksize

Status in QEMU:
  Confirmed
Status in Ubuntu:
  Confirmed

Bug description:
  QEMU-KVM in combination with "detect_zeroes=3Don" makes a Guest able to
  DoS the Host. This is possible if the Host itself has "detect_zeroes"
  enabled and the Guest writes a large Chunk of data with a huge
  blocksize onto the drive.

  E.g.: dd if=3D/dev/zero of=3D/tmp/DoS bs=3D1G count=3D1 oflag=3Ddirect

  All QEMU-Versions after implementation of detect_zeroes are affected.
  Prior are unaffected. This is absolutely critical, please fix this
  ASAP!

  #####

  Provided by Dominik Csapak:

  source    , bs   , count     ,    O_DIRECT, behaviour

  urandom   , bs 1M, count 1024,    O_DIRECT: OK
  file      , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1M, count 1024,    O_DIRECT: OK
  zero file , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1G, count    1,    O_DIRECT: NOT OK
  zero file , bs 1G, count    1,    O_DIRECT: NOT OK
  zero file , bs 1G, count    1, no O_DIRECT: NOT OK
  rand file , bs 1G, count    1,    O_DIRECT: OK
  rand file , bs 1G, count    1, no O_DIRECT: OK

  discard on:

  urandom   , bs 1M, count 1024,    O_DIRECT: OK
  rand file , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1M, count 1024,    O_DIRECT: OK
  zero file , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1G, count    1,    O_DIRECT: NOT OK
  zero file , bs 1G, count    1,    O_DIRECT: NOT OK
  zero file , bs 1G, count    1, no O_DIRECT: NOT OK
  rand file , bs 1G, count    1,    O_DIRECT: OK
  rand file , bs 1G, count    1, no O_DIRECT: OK

  detect_zeros off:

  urandom   , bs 1M, count 1024,    O_DIRECT: OK
  rand file , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1M, count 1024,    O_DIRECT: OK
  zero file , bs 1M, count 1024,    O_DIRECT: OK
  /dev/zero , bs 1G, count    1,    O_DIRECT: OK
  zero file , bs 1G, count    1,    O_DIRECT: OK
  zero file , bs 1G, count    1, no O_DIRECT: OK
  rand file , bs 1G, count    1,    O_DIRECT: OK
  rand file , bs 1G, count    1, no O_DIRECT: OK

  #####

  Provided by Florian Strankowski

  bs   -    count   -    io-threads

  512K -    2048    -    2
  1M   -    1024    -    2
  2M   -     512    -    4
  4M   -     256    -    6
  8M   -     128    -    10
  16M  -      64    -    18
  32M  -      32    -    uncountable

  Please refer to further information here:

  https://bugzilla.proxmox.com/show_bug.cgi?id=3D1368

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687653/+subscriptions
