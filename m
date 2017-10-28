Received: from eggs.gnu.org ([2001:4830:134:3::10]:35289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RL5-0000Wz-QO
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RL1-0005nS-S4
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RL1-0005mI-LU
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:39:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RL0-0004hv-Mo
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:39:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A6E0D2E80CB
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:39:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:27:46 -0000
From: Thomas Huth <1318091@bugs.launchpad.net>
Reply-To: Bug 1318091 <1318091@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140509224205.21323.62439.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919726696.4418.16234050141998552811.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1318091] Re: Perfctr MSRs not available to Guest
 OS on AMD Phenom II
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
https://bugs.launchpad.net/bugs/1318091

Title:
  Perfctr MSRs not available to Guest OS on AMD Phenom II

Status in QEMU:
  Incomplete

Bug description:
  The  AMD Phenom(tm) II X4 965 Processor (family 16, model 4, stepping
  3) has the 4 architecturally supported perf counters at MSRs.  The
  selectors are c001000-c001003, and the counters are c001004-c001007.
  I've verified that the MSRs are there and working by manually setting
  the MSRs with msr-tools to count cycles.

  The processor does not support the extended perfctr or the perfctr_nb.
  These are in cpuid leaf 8000_0001.  Qemu also sees that these cpuid
  flags are not set, when I try launching with  -cpu
  host,perfctr_core,check.  However, this flag is only for the extended
  perfctr MSRs, which also happen to map the original four counters at
  c0010200.

  When I run a Guest OS, that OS is unable to use the perf counter
  registers from c001000-7.  rdmsr and wrmsr complete, but the results
  are always 0.  By contrast, a wrmsr to one of the c0010200 registers
  causes a general protection fault (as it should, since those aren't
  supported).

  Kernel: 3.14.0-gentoo
  Qemu: 2.0.0 (gentoo) and also with 2.0.50 (commit 06b4f00d5)
  Qemu command: qemu-system-x86_64 -enable-kvm -cpu host -smp 8 -m 1024 -no=
graphic -monitor /dev/pts/4 mnt/hdd.img
  cat /proc/cpuinfo:
  processor	: 3
  vendor_id	: AuthenticAMD
  cpu family	: 16
  model		: 4
  model name	: AMD Phenom(tm) II X4 965 Processor
  stepping	: 3
  cpu MHz		: 800.000
  cache size	: 512 KB
  physical id	: 0
  siblings	: 4
  core id		: 3
  cpu cores	: 4
  apicid		: 3
  initial apicid	: 3
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 5
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc extd_apicid pn=
i monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a m=
isalignsse 3dnowprefetch osvw ibs skinit wdt hw_pstate npt lbrv svm_lock nr=
ip_save
  bogomips	: 6803.79
  TLB size	: 1024 4K pages
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 48 bits physical, 48 bits virtual
  power management: ts ttp tm stc 100mhzsteps hwpstate

  thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1318091/+subscriptions
