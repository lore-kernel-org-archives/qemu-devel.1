Received: from eggs.gnu.org ([2001:4830:134:3::10]:52163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5aO3-0006nE-Jl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5aNz-0004l8-KC
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:10:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:58017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5aNz-0004jd-5Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5aNy-0002uz-3a
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 16:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C1C92E80C2
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 16:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 May 2017 15:53:11 -0000
From: Florian Strankowski <1687653@bugs.launchpad.net>
Reply-To: Bug 1687653 <1687653@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170502155311.4290.95799.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687653] [NEW] QEMU-KVM / detect_zeroes causes
 KVM to start unlimited number of threads on Guest-Sided High-IO with big
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

*** This bug is a security vulnerability ***

Public security bug reported:

QEMU-KVM in combination with "detect_zeroes=3Don" makes a Guest able to
DoS the Host. This is possible if the Host itself has "detect_zeroes"
enabled and the Guest writes a large Chunk of data with a huge blocksize
onto the drive.

E.g.: dd if=3D/dev/zero of=3D/tmp/DoS bs=3D1G count=3D1 oflag=3Ddirect

All QEMU-Versions after implementation of detect_zeroes are affected.
Prior are unaffected. This is absolutely critical, please fix this ASAP!

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

** Affects: qemu
     Importance: Undecided
         Status: Confirmed


** Tags: critical denial dos of service vuln

** Attachment added: "damn.png"
   https://bugs.launchpad.net/bugs/1687653/+attachment/4870894/+files/damn.=
png

** Information type changed from Private Security to Public

** Information type changed from Public to Public Security

** Information type changed from Public Security to Private Security

** Information type changed from Private Security to Public Security

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687653

Title:
  QEMU-KVM / detect_zeroes causes KVM to start unlimited number of
  threads on Guest-Sided High-IO with big Blocksize

Status in QEMU:
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
