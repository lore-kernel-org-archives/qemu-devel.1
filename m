Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5fJM-0006jg-Iw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5fJJ-00062M-CU
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:30:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:60996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5fJJ-00060w-6J
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5fJH-0002cs-8c
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 22:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D511A2E80C9
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 22:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Apr 2018 22:24:19 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
	<ciro.santilli@gmail.com>
Reply-To: Bug 1762179 <1762179@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152319497960.30219.9338727401860906105.malonedeb@gac.canonical.com>
Message-Id: <152331266025.9302.7854324506833251353.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1762179] Re: Record and replay replay fails with:
 "ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

- QEMU master at 08e173f29461396575c85510eb41474b993cb1fb Ubuntu 17.10
+ QEMU master at 915d34c5f99b0ab91517c69f54272bfdb6ca2b32 Ubuntu 17.10
  host.
  =

  QEMU commands:
  =

  ```
  #!/usr/bin/env bash
  cmd=3D"\
  time \
  ./x86_64-softmmu/qemu-system-x86_64 \
  -append 'root=3D/dev/sda console=3DttyS0 nokaslr printk.time=3Dy - lkmc_e=
val=3D\"/rand_check.out;/sbin/ifup -a;wget -S google.com;/poweroff.out;\"' \
  -kernel 'out/x86_64/buildroot/images/bzImage' \
  -nographic \
  \
  -drive file=3Dout/x86_64/buildroot/images/rootfs.ext2.qcow2,if=3Dnone,id=
=3Dimg-direct,format=3Dqcow2 \
  -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay=
 \
  -device ide-hd,drive=3Dimg-blkreplay \
  \
  -netdev user,id=3Dnet1 \
  -device rtl8139,netdev=3Dnet1 \
  -object filter-replay,id=3Dreplay,netdev=3Dnet1 \
  "
  echo "$cmd"
  eval "$cmd -icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin'"
  eval "$cmd -icount 'shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin'"
  ```
  =

  This tries to stay as close as possible to the documented commands:
  https://github.com/qemu/qemu/blob/08e173f29461396575c85510eb41474b993cb1f=
b/docs/replay.txt#L28
  =

  Images uploaded to: https://github.com/cirosantilli/linux-kernel-module-
  cheat/releases/download/test-replay-arm/images4.zip
  =

  Images generated with: https://github.com/cirosantilli/linux-kernel-
  module-cheat/tree/9513c162ef57e6cb70006dfe870856f94ee9a133
  =

  The replay failed straight out with:
  =

  ```
  ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed: (repla=
y_file && replay_mutex_locked())
  ```
  =

  QEMU configure:
  =

  ```
  ./configure --enable-debug --enable-trace-backends=3Dsimple --target-list=
=3D"x86_64-softmmu"
  ```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1762179

Title:
  Record and replay replay fails with: "ERROR:replay/replay-
  time.c:49:replay_read_clock: assertion failed"

Status in QEMU:
  New

Bug description:
  QEMU master at 915d34c5f99b0ab91517c69f54272bfdb6ca2b32 Ubuntu 17.10
  host.

  QEMU commands:

  ```
  #!/usr/bin/env bash
  cmd=3D"\
  time \
  ./x86_64-softmmu/qemu-system-x86_64 \
  -append 'root=3D/dev/sda console=3DttyS0 nokaslr printk.time=3Dy - lkmc_e=
val=3D\"/rand_check.out;/sbin/ifup -a;wget -S google.com;/poweroff.out;\"' \
  -kernel 'out/x86_64/buildroot/images/bzImage' \
  -nographic \
  \
  -drive file=3Dout/x86_64/buildroot/images/rootfs.ext2.qcow2,if=3Dnone,id=
=3Dimg-direct,format=3Dqcow2 \
  -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay=
 \
  -device ide-hd,drive=3Dimg-blkreplay \
  \
  -netdev user,id=3Dnet1 \
  -device rtl8139,netdev=3Dnet1 \
  -object filter-replay,id=3Dreplay,netdev=3Dnet1 \
  "
  echo "$cmd"
  eval "$cmd -icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin'"
  eval "$cmd -icount 'shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin'"
  ```

  This tries to stay as close as possible to the documented commands:
  https://github.com/qemu/qemu/blob/08e173f29461396575c85510eb41474b993cb1f=
b/docs/replay.txt#L28

  Images uploaded to: https://github.com/cirosantilli/linux-kernel-
  module-cheat/releases/download/test-replay-arm/images4.zip

  Images generated with: https://github.com/cirosantilli/linux-kernel-
  module-cheat/tree/9513c162ef57e6cb70006dfe870856f94ee9a133

  The replay failed straight out with:

  ```
  ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed: (repla=
y_file && replay_mutex_locked())
  ```

  QEMU configure:

  ```
  ./configure --enable-debug --enable-trace-backends=3Dsimple --target-list=
=3D"x86_64-softmmu"
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762179/+subscriptions
