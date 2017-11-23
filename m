Received: from eggs.gnu.org ([2001:4830:134:3::10]:38535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHmqC-0004uM-4b
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHmq8-0004Ab-VU
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:26:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHmq8-00048r-Pj
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:26:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHmq7-0006sg-PW
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:26:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF51C2E80C7
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:26:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2017 08:12:07 -0000
From: Matt Keys <1329956@bugs.launchpad.net>
Reply-To: Bug 1329956 <1329956@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140613211439.4618.98205.malonedeb@soybean.canonical.com>
Message-Id: <151142472744.14642.7314929147361249358.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1329956] Re: multi-core FreeBSD guest hangs after
 warm reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm able to reproduce this issue, but using latest debian 9.

Debian 9
qemu version: 1:2.8+dfsg-6+deb9u3
kernel version: Linux vm2 4.9.0-3-amd64 #1 SMP Debian 4.9.30-2+deb9u5 (2017=
-09-19) x86_64 GNU/Linux

I'm attempting to cold boot, or warm reboot, pfsense 2.4.2 amd64 iso
image guest. If I have > 1 in virt-manager view -> details -> cpu ->
allocation and maximum allocation, then the guest will not boot. My
workaround was to set those both to 1, then in configuration I needed to
uncheck "Copy Host CPU Configuration" (pfsense used to need this for
hardware crypto support) and set the model to "clear cpu configuration"
in order for it to boot. This doesn't appear to be Intel specific. I'm
running amd ..

/proc/cpuinfo :

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 1
model name	: AMD FX(tm)-8120 Eight-Core Processor
stepping	: 2
microcode	: 0x6000629
cpu MHz		: 1400.000
cache size	: 2048 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf eagerfpu=
 pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_l=
m cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osv=
w ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core perfctr_nb cp=
b hw_pstate vmmcall arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean f=
lushbyasid decodeassists pausefilter pfthreshold
bugs		: fxsave_leak sysret_ss_attrs null_seg
bogomips	: 6241.40
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1329956

Title:
  multi-core FreeBSD guest hangs after warm reboot

Status in QEMU:
  Fix Released
Status in Debian:
  New

Bug description:
  On some Linux KVM hosts in our environment, FreeBSD guests fail to
  reboot properly if they have more than one CPU (socket, core, and/or
  thread). They will boot fine the first time, but after issuing a
  "reboot" command via the OS the guest starts to boot but hangs during
  SMP initialization. Fully shutting down and restarting the guest works
  in all cases.

  The only meaningful difference between hosts with the problem and those w=
ithout is the CPU. Hosts with Xeon E5-26xx v2 processors have the problem, =
including at least the "Intel(R) Xeon(R) CPU E5-2667 v2" and the "Intel(R) =
Xeon(R) CPU E5-2650 v2".
  Hosts with any other CPU, including "Intel(R) Xeon(R) CPU E5-2650 0", "In=
tel(R) Xeon(R) CPU E5-2620 0", or "AMD Opteron(TM) Processor 6274" do not h=
ave the problem. Note the "v2" in the names of the problematic CPUs.

  On hosts with a "v2" Xeon, I can reproduce the problem under Linux
  kernel 3.10 or 3.12 and Qemu 1.7.0 or 2.0.0.

  The problem occurs with all currently-supported versions of FreeBSD,
  including 8.4, 9.2, 10.0 and 11-CURRENT.

  On a Linux KVM host with a "v2" Xeon, this command line is adequate to
  reproduce the problem:

  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name bsdtest -m 512
  -smp 2,sockets=3D1,cores=3D1,threads=3D2 -drive
  file=3D./20140613_FreeBSD_9.2-RELEASE_ufs.qcow2,if=3Dnone,id=3Ddrive0,for=
mat=3Dqcow2
  -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive0 -vnc 0.0.0.0:0 -net none

  I have tried many variations including different models of -machine
  and -cpu for the guest with no visible difference.

  A native FreeBSD installation on a host with a "v2" Xeon does not have
  the problem, nor do a paravirtualized FreeBSD guests under bhyve (the
  BSD legacy-free hypervisor) using the same FreeBSD disk images as on
  the Linux hosts. So it seems unlikely the cause is on the FreeBSD side
  of things.

  I would greatly appreciate any feedback or developer attention to
  this. I am happy to provide additional details, test patches, etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1329956/+subscriptions
