Received: from eggs.gnu.org ([2001:4830:134:3::10]:36321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvX3-0005c1-U9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvWz-0005tw-S5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:52258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBvWz-0005tO-LC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBvWy-0000ND-1l
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 01BBB2E80D2
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 04:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 04:17:31 -0000
From: Launchpad Bug Tracker <1358619@bugs.launchpad.net>
Reply-To: Bug 1358619 <1358619@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140819063553.17571.47743.malonedeb@soybean.canonical.com>
Message-Id: <151002825157.21207.9143886284874650874.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1358619

Title:
  keep savevm/loadvm and migration cause snapshot crash

Status in QEMU:
  Expired

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
