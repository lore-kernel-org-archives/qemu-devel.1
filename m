Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOpbT-0002Jv-P3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOpbQ-0005QT-H8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:38706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fOpbQ-0005Pf-Ac
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fOpbO-0006cP-QH
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 19:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C4EDC2E80CB
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 19:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Jun 2018 19:05:41 -0000
From: Fabiano Rosas <1773753@bugs.launchpad.net>
Reply-To: Bug 1773753 <1773753@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152749874146.3829.13327505377905335957.malonedeb@chaenomeles.canonical.com>
Message-Id: <152787994147.24946.17721241640536710670.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1773753] Re: virsh start,
 after virsh managed save hangs and vm goes to paused state with
 qemu version v2.12.0-813-g5a5c383b13-dirty on powerpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could not reproduce with:

qemu - v2.12.0-865-ge609fa7
host/guest kernel - 4.11
libvirt - 4.4.0

and

qemu - v2.12.0-865-ge609fa7
host kernel - v4.17-rc7-22-g3d661e2
guest kernel - 4.11
libvirt - 4.4.0

So I'd say that this is fixed by:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D0efc914


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1773753

Title:
  virsh start, after virsh managed save hangs and vm goes to paused
  state with qemu version v2.12.0-813-g5a5c383b13-dirty on powerpc

Status in QEMU:
  Fix Committed

Bug description:
  Host Env:
  IBM Power8 with Fedora28 base with compiled upstream kernel, qemu, libvir=
t.

  Host Kernel: 4.17.0-rc5-00069-g3acf4e395260

  qemu-kvm(5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b):
  v2.12.0-813-g5a5c383b13-dirty

  libvirt(4804a4db33a37f828d033733bc47f6eff5d262c3):

  Guest Kernel: 4.17.0-rc7

  Steps to recreate:
  Define a guest attached with above setup and start.
  # virsh start avocado-vt-vm1

  guest console;...
  # uname -r
  4.17.0-rc7
  [root@atest-guest ~]# lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              3
  On-line CPU(s) list: 0-2
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           3
  NUMA node(s):        1
  Model:               2.1 (pvr 004b 0201)
  Model name:          POWER8 (architected), altivec supported
  Hypervisor vendor:   KVM
  Virtualization type: para
  L1d cache:           64K
  L1i cache:           32K
  NUMA node0 CPU(s):   0-2

  =

  # virsh managedsave avocado-vt-vm1 =


  Domain avocado-vt-vm1 state saved by libvirt

  # virsh list
   Id    Name                           State
  ----------------------------------------------------

  # virsh start avocado-vt-vm1 ----Hangs forever and vm state goes to
  paused.

  =

  # virsh list
   Id    Name                           State
  ----------------------------------------------------
   87    avocado-vt-vm1                 paused

  =

  P:S:- with same above setup, just changing the qemu-kvm comes bydefault w=
ith F28 works fine.

  /usr/bin/qemu-kvm --version
  QEMU emulator version 2.11.1(qemu-2.11.1-2.fc28)

  Summary: with above other setup.
  machine type pseries-2.12 and qemu-2.11.1-2.fc28 -Works fine.

  machine type pseries-2.12/pseries-2.13 and qemu
  5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b - Does not work.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1773753/+subscriptions
