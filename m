Received: from eggs.gnu.org ([2001:4830:134:3::10]:46299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fD7nb-0001YB-0S
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fD7nX-00008x-TI
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:20:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fD7nX-00008B-MG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fD7nW-0003d8-2m
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 12:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 122022E80CD
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 12:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Apr 2018 12:14:44 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
	<ciro.santilli@gmail.com>
Reply-To: Bug 1762179 <1762179@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152319497960.30219.9338727401860906105.malonedeb@gac.canonical.com>
Message-Id: <152509048484.6714.414075052443077564.malone@wampee.canonical.com>
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

@arna35: I have tested this yet unmerged patch:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04286.html and
it solves this problem, I will close this issue once it gets merged.

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
=3Dx86_64-softmmu
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762179/+subscriptions
