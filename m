Received: from eggs.gnu.org ([2001:4830:134:3::10]:50005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOfva-0007rS-6r
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOfvW-0008DE-5u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:00:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fOfvV-0008CT-QZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fOfvU-0007eK-Si
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CE9522E80C8
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 09:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Jun 2018 08:50:27 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reply-To: Bug 1774605 <1774605@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152784273656.31479.153660947051184788.malonedeb@soybean.canonical.com>
Message-Id: <152784302714.24827.17278453901114931202.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774605] Re: PowerPC guest does not emulate L2
 and L3 cache for KVM vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Guest xml(cpu portion):

...
   <vcpu placement=3D'static' current=3D'16'>32</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'ppc64le' machine=3D'pseries-2.13'>hvm</type>
    <kernel>/home/kvmci/linux/vmlinux</kernel>
    <cmdline>root=3D/dev/sda2 rw console=3Dtty0 console=3DttyS0,115200 init=
=3D/sbin/init initcall_debug</cmdline>
    <boot dev=3D'hd'/>
  </os>
  <cpu mode=3D'host-passthrough' check=3D'none'>
    <topology sockets=3D'2' cores=3D'2' threads=3D'8'/>
  </cpu>
...


Host lscpu:
# lscpu
Architecture:         ppc64le
Byte Order:           Little Endian
CPU(s):               80
On-line CPU(s) list:  0,8,16,24,32,40,48,56,64,72
Off-line CPU(s) list: 1-7,9-15,17-23,25-31,33-39,41-47,49-55,57-63,65-71,73=
-79
Thread(s) per core:   1
Core(s) per socket:   5
Socket(s):            2
NUMA node(s):         2
Model:                2.1 (pvr 004b 0201)
Model name:           POWER8E (raw), altivec supported
CPU max MHz:          3690.0000
CPU min MHz:          2061.0000
L1d cache:            64K
L1i cache:            32K
L2 cache:             512K
L3 cache:             8192K
NUMA node0 CPU(s):    0,8,16,24,32
NUMA node1 CPU(s):    40,48,56,64,72

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774605

Title:
  PowerPC guest does not emulate L2 and L3 cache for KVM vCPUs

Status in QEMU:
  New

Bug description:
  PowerPC KVM guest does not emulate L2 and L2 caches for vCPU, it would
  be good to have them enabled if not any known issues/limitation
  already with PowerPC.

  Host Env:
  kernel: 4.17.0-rc7-00045-g0512e0134582
  qemu: v2.12.0-923-gc181ddaa17-dirty
  #libvirtd -V
  libvirtd (libvirt) 4.4.0

  =

  Guest Kernel:
  # uname -a
  Linux atest-guest 4.17.0-rc7-00045-g0512e0134582 #9 SMP Fri Jun 1 02:55:5=
0 EDT 2018 ppc64le ppc64le ppc64le GNU/Linux

  Guest:
  # lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              16
  On-line CPU(s) list: 0-15
  Thread(s) per core:  8
  Core(s) per socket:  2
  Socket(s):           1
  NUMA node(s):        1
  Model:               2.1 (pvr 004b 0201)
  Model name:          POWER8 (architected), altivec supported
  Hypervisor vendor:   KVM
  Virtualization type: para
  L1d cache:           64K
  L1i cache:           32K
  NUMA node0 CPU(s):   0-15


  background: x86 enabling cpu L2 cache bydefault and L3 cache on demand fo=
r kvm guest
  and claims performance improvement as vcpus can be =

  benefited with lesser `vmexits due to guest send IPIs.` with L3 cache ena=
bled, below was patch for same.

  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D14c985cffa6cb177fc01a16=
3d8bcf227c104718c

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774605/+subscriptions
