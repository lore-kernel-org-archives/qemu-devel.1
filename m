Received: from eggs.gnu.org ([2001:4830:134:3::10]:48206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXgRM-0001er-4W
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 23:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXgRI-00012A-4A
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 23:50:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:35334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eXgRH-00010r-Uc
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 23:50:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eXgRG-0006eW-PJ
	for <qemu-devel@nongnu.org>; Sat, 06 Jan 2018 04:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B470A2E8071
	for <qemu-devel@nongnu.org>; Sat,  6 Jan 2018 04:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jan 2018 04:45:11 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reply-To: Bug 1739413 <1739413@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151377269069.19770.3703612061677458311.malonedeb@chaenomeles.canonical.com>
Message-Id: <151521391166.3110.17686487725249728553.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739413] Re: Hotplugged vcpu does not guarantee
 cpu compat mode(power8) on power9 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Upstream patch from David Gibson @ https://lists.nongnu.org/archive/html
/qemu-devel/2018-01/msg00587.html

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739413

Title:
  Hotplugged vcpu does not guarantee cpu compat mode(power8) on power9
  host

Status in QEMU:
  In Progress

Bug description:
  ./ppc64-softmmu/qemu-system-ppc64 -version
  QEMU emulator version 2.11.50 (v2.11.0-254-gaf35267)

  1. Boot a power8 compat mode guest power9 HW.
  ./ppc64-softmmu/qemu-system-ppc64 -machine pseries,accel=3Dkvm,max-cpu-co=
mpat=3Dpower8 -m 4096 /home/sath/images/guest.qcow2 -smp 1,maxcpus=3D2 -ser=
ial /dev/pts/8  -monitor stdio -vga none -nographic
  QEMU 2.11.50 monitor - type 'help' for more information
  (qemu) =


  2. Check for cpuinfo

  # cat /proc/cpuinfo =

  processor	: 0
  cpu		: POWER8 (architected), altivec supported
  clock		: 2200.000000MHz
  revision	: 2.1 (pvr 004e 1201)

  timebase	: 512000000
  platform	: pSeries
  model		: IBM pSeries (emulated by qemu)
  machine		: CHRP IBM pSeries (emulated by qemu)
  MMU		: Hash

  =

  3. Run a small program invoking isa v3.0 instruction, it should complain =
'Illegal instruction' as it is a power8 compat guest
  # cat 1.c =

  #include <stdio.h>
  void main()
      {
      asm volatile (".long 0x7c0005e6");
      }
  # ./a.out =

  [   59.352795] a.out[1741]: unhandled signal 4 at 0000000010000600 nip 00=
00000010000600 lr 00007fffb4da5080 code 1
  Illegal instruction =


  4. Hotplug a vcpu
  (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
  (qemu) info cpus
  * CPU #0: nip=3D0xc0000000000de42c thread_id=3D113110
    CPU #1: nip=3D0xc0000000000de42c thread_id=3D113348

  5. Try running the same program in the hotplugged vcpu and it does not
  complain as 'Illegal instruction'

  #taskset -c 1 ./a.out ----------------------NOK
  #  =


  # taskset -c 0 ./a.out =

  [  356.618031] a.out[1755]: unhandled signal 4 at 0000000010000600 nip 00=
00000010000600 lr 00007fffae7f5080 code 1
  Illegal instruction

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739413/+subscriptions
