Received: from eggs.gnu.org ([2001:4830:134:3::10]:58811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYYnU-0007ER-LB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYYnP-0002Be-JH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:47185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYYnP-00029W-9j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:20:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYYnM-0003L0-GS
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A2082E806B
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 14:09:51 -0000
From: hbagdi <1705717@bugs.launchpad.net>
Reply-To: Bug 1705717 <1705717@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150064619170.15700.7661736805405042031.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1705717] [NEW] Live migration fails with 'host'
 cpu when KVM is inserted with nested=1
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

Qemu v2.9.0
Linux kernel 4.9.34

Live migration(pre-copy) being done from one physical host to another:

Source Qemu:
sudo qemu-system-x86_64 -drive file=3D${IMAGE_DIR}/${IMAGE_NAME},if=3Dvirti=
o -m 2048 -smp 1 -net nic,model=3Dvirtio,macaddr=3D${MAC} -net tap,ifname=
=3Dqtap0,script=3Dno,downscript=3Dno -vnc :1 --enable-kvm -cpu kvm64 -qmp t=
cp:*:4242,server,nowait

And KVM is inserted with nested=3D1 on both source and destination
machine.

Migration fails with a nested specific assertion failure on destination
at target/i386/kvm.c +1629

Migration is successful in the following cases-

A) cpu model is 'host' and kvm is inserted without nested=3D1 parameter
B) If instead of 'host' cpu model, 'kvm64' is used (KVM nested=3D1)
C) If instead of 'host' cpu model, 'kvm64' is used (KVM nested=3D0)
D) Between an L0 and a guest Hypervisor L1, with 'kvm64' as CPU type (and n=
ested=3D1 for L0 KVM)

Physical host(s)-
$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                12
On-line CPU(s) list:   0-11
Thread(s) per core:    1
Core(s) per socket:    6
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 62
Model name:            Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
Stepping:              4
CPU MHz:               1200.091
CPU max MHz:           2600.0000
CPU min MHz:           1200.0000
BogoMIPS:              4203.28
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              15360K
NUMA node0 CPU(s):     0-5
NUMA node1 CPU(s):     6-11
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=
 nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtop=
ology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl v=
mx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt ts=
c_deadline_timer aes xsave avx f16c rdrand lahf_lm epb tpr_shadow vnmi flex=
priority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1705717

Title:
  Live migration fails with 'host' cpu when KVM is inserted with
  nested=3D1

Status in QEMU:
  New

Bug description:
  Qemu v2.9.0
  Linux kernel 4.9.34

  Live migration(pre-copy) being done from one physical host to another:

  Source Qemu:
  sudo qemu-system-x86_64 -drive file=3D${IMAGE_DIR}/${IMAGE_NAME},if=3Dvir=
tio -m 2048 -smp 1 -net nic,model=3Dvirtio,macaddr=3D${MAC} -net tap,ifname=
=3Dqtap0,script=3Dno,downscript=3Dno -vnc :1 --enable-kvm -cpu kvm64 -qmp t=
cp:*:4242,server,nowait

  And KVM is inserted with nested=3D1 on both source and destination
  machine.

  Migration fails with a nested specific assertion failure on
  destination at target/i386/kvm.c +1629

  Migration is successful in the following cases-

  A) cpu model is 'host' and kvm is inserted without nested=3D1 parameter
  B) If instead of 'host' cpu model, 'kvm64' is used (KVM nested=3D1)
  C) If instead of 'host' cpu model, 'kvm64' is used (KVM nested=3D0)
  D) Between an L0 and a guest Hypervisor L1, with 'kvm64' as CPU type (and=
 nested=3D1 for L0 KVM)

  Physical host(s)-
  $ lscpu
  Architecture:          x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Byte Order:            Little Endian
  CPU(s):                12
  On-line CPU(s) list:   0-11
  Thread(s) per core:    1
  Core(s) per socket:    6
  Socket(s):             2
  NUMA node(s):          2
  Vendor ID:             GenuineIntel
  CPU family:            6
  Model:                 62
  Model name:            Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
  Stepping:              4
  CPU MHz:               1200.091
  CPU max MHz:           2600.0000
  CPU min MHz:           1200.0000
  BogoMIPS:              4203.28
  Virtualization:        VT-x
  L1d cache:             32K
  L1i cache:             32K
  L2 cache:              256K
  L3 cache:              15360K
  NUMA node0 CPU(s):     0-5
  NUMA node1 CPU(s):     6-11
  Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sysca=
ll nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl=
 vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm epb tpr_shadow vnmi fl=
expriority ept vpid fsgsbase smep erms xsaveopt dtherm ida arat pln pts

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1705717/+subscriptions
