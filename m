Received: from eggs.gnu.org ([2001:4830:134:3::10]:33714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5rwj-0007JS-HQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5rwf-0007mQ-Jf
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:55:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:59321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5rwf-0007lm-6G
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:55:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5rwd-0007Xx-IP
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 10:55:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 67FD82E80DA
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 10:55:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 May 2017 10:46:45 -0000
From: Florian Strankowski <1687653@bugs.launchpad.net>
Reply-To: Bug 1687653 <1687653@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170502155311.4290.95799.malonedeb@soybean.canonical.com>
Message-Id: <20170503104645.4185.99727.malone@soybean.canonical.com>
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

Please be so kind and go for a 6G LVM-Vol and do "dd if=3D/dev/zero
of=3D/dev/sdb bs=3D3G count=3D2 oflag=3Ddirect". Please keep an eye on your
processor usage in comparison to the threads created. Its harder to
knock-down an SSD-Backed system than one with spinners.

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
