Received: from eggs.gnu.org ([2001:4830:134:3::10]:42299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2Qp-0007Wv-6o
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2Qk-0004zG-0d
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:25:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dq2Qj-0004yG-MX
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:25:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dq2Qh-0000fl-T3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 19:25:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AC5AF2E846C
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 19:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Sep 2017 19:15:39 -0000
From: Thomas Huth <1358619@bugs.launchpad.net>
Reply-To: Bug 1358619 <1358619@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140819063553.17571.47743.malonedeb@soybean.canonical.com>
Message-Id: <150481173947.23563.11720248704613618838.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1358619] Re: keep savevm/loadvm and migration
 cause snapshot crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1358619

Title:
  keep savevm/loadvm and migration cause snapshot crash

Status in QEMU:
  Incomplete

Bug description:
  --Version:  qemu 2.1.0  public release
  --OS:          CentOS release 6.4
  --gcc:         4.4.7

  Hi:
       I found problems when doing some tests on qemu migration and savevm/=
loadvm.
  On my experiment, a quest is migrated between two same host back and fort=
h. =

  Source host would savevm after migration completed and incoming host load=
vm before migration coming.

  image=3D./image/centos-1.qcow2

  =3D=3D=3D=3DMigration Part=3D=3D=3D=3D
  qemu-system-x86_64 \
          -qmp tcp:$host_ip:4451,server,nowait \
          -drive file=3D$image \
          --enable-kvm \
          -monitor stdio \
          -m 8192 \
          -device virtio-net-pci,netdev=3Dnet0,mac=3D$mac \
          -netdev tap,id=3Dnet0,script=3D./qemu-ifup

  =3D=3D=3D=3DIncoming Part=3D=3D=3D=3D
  qemu-system-x86_64 \
          -qmp tcp:$host_ip:4451,server,nowait \
          -incoming tcp:0:4449 \
          --enable-kvm \
          -monitor stdio \
          -drive file=3D$image \
          -m 8192 \
          -device virtio-net-pci,netdev=3Dnet0,mac=3D$mac \
          -netdev tap,id=3Dnet0,script=3D./qemu-ifup

  =

  Command lines:

  host1 $:  qemu-system-x86_64 ........  //migration part
  host2 $:  qemu-system-x86_64 ...incoming... //incoming part

  After finishing boot

  host1 (qemu) : migrate tcp:host2:4449
  host1 (qemu) : savevm s1
  host1 (qemu) : quit
  host1 $: qemu-system-x86_64 ...incoming... //incoming part
  host1 (qemu) : loadvm s1

  host2 (qemu) : migrate tcp:host1:4449
  host2 (qemu) : savevm s2
  host2 (qemu) : quit
  host2 $:  qemu-system-x86_64 ...incoming... //incoming part
  host2 (qemu) : loadvm s2

  host1 (qemu) : migrate tcp:host2:4449
  host1 (qemu) : savevm s3
  host1 (qemu) : quit
  host1 $: qemu-system-x86_64 ...incoming... //incoming part
  host1 (qemu) : loadvm s3

  I wish those operation can be success every time. =

  However problem happened irregularly when loadvm and error messages are n=
ot the same.

  host1 (qemu) :  loadvm s3
  qcow2: Preventing invalid write on metadata (overlaps with active L1 tabl=
e); image marked as corrupt.
  Error -5 while activating snapshot 's3' on 'ide0-hd0'

  or

  host2 (qemu) : loadvm s2
  Error -22 while loading VM state

  =

  I have done some sample test on savevm/loadvm
  On same host
  (qemu) savevm test1
  (qemu) loadvm test1
  (qemu) savevm test2
  (qemu) loadvm test2
  (qemu) savevm test3
  (qemu) loadvm test3
  (qemu) savevm test4
  (qemu) loadvm test4
  (qemu) savevm test5
  (qemu) loadvm test5
  (qemu) savevm test6
  (qemu) loadvm test6

  This is OK. No any problem.

  =

  Any idea? =

  I think it is related to migration.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1358619/+subscriptions
