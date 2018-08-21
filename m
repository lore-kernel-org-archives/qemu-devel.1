Received: from eggs.gnu.org ([2001:4830:134:3::10]:58057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fsCfu-0003kD-1P
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fsCfp-0004jW-TA
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:43332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fsCfl-0004ew-Cz
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:50:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fsCfj-0005YM-1m
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 19:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 097CF2E8023
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 19:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 19:40:07 -0000
From: Eduardo Habkost <ehabkost@redhat.com>
Reply-To: Bug 1788275 <1788275@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153488040782.4713.14154400799820003858.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788275] [NEW] -cpu ...,
 +topoext works only with EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

See bug report at:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1615682

Probably this is caused by the inconsistent legacy cache information on
all CPU models except EPYC.

---------------------------------------------
Description of problem:
Guest should get 2 threads per core and all of them should be on-line when =
booting guest with old amd cpu model + smt

Steps to Reproduce:
1.Boot rhel7.6 guest with cli:
/usr/libexec/qemu-kvm -name rhel7.6 -m 16G -machine pc,accel=3Dkvm \
        -S \
        -cpu Opteron_G3,+topoext,xlevel=3D0x8000001e,enforce \
        -smp 2,threads=3D2 \
        -monitor stdio \
        -qmp unix:/tmp/qmp2,server,nowait \
        -device VGA \
        -vnc :0 \
        -serial unix:/tmp/console2,server,nowait \
        -uuid 115e11b2-a869-41b5-91cd-6a32a907be7f \
        -drive file=3Drhel7.6-20180812.qcow2,if=3Dnone,id=3Ddrive-scsi-disk=
0,format=3Dqcow2,cache=3Dnone,werror=3Dstop,rerror=3Dstop -device ide-hd,dr=
ive=3Ddrive-scsi-disk0,id=3Dscsi-disk0 \
        -netdev tap,id=3DidinWyYY,vhost=3Don -device virtio-net-pci,mac=3D2=
e:39:fa:ff:88:a1,id=3Didlbq7eA,netdev=3DidinWyYY \

2.check cpu info inside guest
3.

Actual results:
Guest gets one online cpu, one offline cpu and one thread per core:
# lscpu
lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                2
On-line CPU(s) list:   0
Off-line CPU(s) list:  1
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
Vendor ID:             AuthenticAMD
CPU family:            16
Model:                 2
Model name:            AMD Opteron 23xx (Gen 3 Class Opteron)
Stepping:              3
CPU MHz:               2096.060
BogoMIPS:              4192.12
Hypervisor vendor:     KVM
Virtualization type:   full
L1d cache:             64K
L1i cache:             64K
L2 cache:              512K
L3 cache:              16384K
NUMA node0 CPU(s):     0
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx lm art rep_good=
 nopl extd_apicid pni cx16 x2apic popcnt hypervisor lahf_lm cmp_legacy abm =
sse4a misalignsse topoext retpoline_amd ibp_disable vmmcall


Expected results:
Guest should get 2 threads per core and all of them should be on-line

---------------------------------------------

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788275

Title:
  -cpu ...,+topoext works only with EPYC CPU model

Status in QEMU:
  New

Bug description:
  See bug report at:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1615682

  Probably this is caused by the inconsistent legacy cache information
  on all CPU models except EPYC.

  ---------------------------------------------
  Description of problem:
  Guest should get 2 threads per core and all of them should be on-line whe=
n booting guest with old amd cpu model + smt

  Steps to Reproduce:
  1.Boot rhel7.6 guest with cli:
  /usr/libexec/qemu-kvm -name rhel7.6 -m 16G -machine pc,accel=3Dkvm \
          -S \
          -cpu Opteron_G3,+topoext,xlevel=3D0x8000001e,enforce \
          -smp 2,threads=3D2 \
          -monitor stdio \
          -qmp unix:/tmp/qmp2,server,nowait \
          -device VGA \
          -vnc :0 \
          -serial unix:/tmp/console2,server,nowait \
          -uuid 115e11b2-a869-41b5-91cd-6a32a907be7f \
          -drive file=3Drhel7.6-20180812.qcow2,if=3Dnone,id=3Ddrive-scsi-di=
sk0,format=3Dqcow2,cache=3Dnone,werror=3Dstop,rerror=3Dstop -device ide-hd,=
drive=3Ddrive-scsi-disk0,id=3Dscsi-disk0 \
          -netdev tap,id=3DidinWyYY,vhost=3Don -device virtio-net-pci,mac=
=3D2e:39:fa:ff:88:a1,id=3Didlbq7eA,netdev=3DidinWyYY \

  2.check cpu info inside guest
  3.

  Actual results:
  Guest gets one online cpu, one offline cpu and one thread per core:
  # lscpu
  lscpu
  Architecture:          x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Byte Order:            Little Endian
  CPU(s):                2
  On-line CPU(s) list:   0
  Off-line CPU(s) list:  1
  Thread(s) per core:    1
  Core(s) per socket:    1
  Socket(s):             1
  NUMA node(s):          1
  Vendor ID:             AuthenticAMD
  CPU family:            16
  Model:                 2
  Model name:            AMD Opteron 23xx (Gen 3 Class Opteron)
  Stepping:              3
  CPU MHz:               2096.060
  BogoMIPS:              4192.12
  Hypervisor vendor:     KVM
  Virtualization type:   full
  L1d cache:             64K
  L1i cache:             64K
  L2 cache:              512K
  L3 cache:              16384K
  NUMA node0 CPU(s):     0
  Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx lm art rep_go=
od nopl extd_apicid pni cx16 x2apic popcnt hypervisor lahf_lm cmp_legacy ab=
m sse4a misalignsse topoext retpoline_amd ibp_disable vmmcall

  =

  Expected results:
  Guest should get 2 threads per core and all of them should be on-line

  ---------------------------------------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788275/+subscriptions
