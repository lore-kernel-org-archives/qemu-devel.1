Received: from eggs.gnu.org ([2001:4830:134:3::10]:46963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUcOl-0000gs-Dm
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUcOg-0008Ic-Aq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:50:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:45959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUcOg-0008Hf-21
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:50:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUcOd-0003kQ-RO
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 124E42E80DB
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 16:39:46 -0000
From: Francois Gouget <1658141@bugs.launchpad.net>
Reply-To: Bug 1658141 <1658141@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170120163946.25029.76236.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658141] [NEW] QEMU's default msrs handling
 causes Windows 10 64 bit to crash
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

Wine uses QEMU to run its conformance test suite on Windows virtual
machines. Wine's conformance tests check the behavior of various Windows
APIs and verify that they behave as expected.

One such test checks handling of exceptions down. When run on Windows 10 64=
 bit in QEMU it triggers a "KMOD_EXCEPTION_NOT_HANDLED" BSOD in the VM. See:
https://bugs.winehq.org/show_bug.cgi?id=3D40240


To reproduce this bug:
* Pick a Windows 10 64 bit VM on an Intel host.

* Start the VM. I'm pretty sure any qemu command will do but here's what I =
used:
  qemu-system-x86_64 -machine pc-i440fx-2.1,accel=3Dkvm -cpu core2duo,+nx -=
m 2048 -hda /var/lib/libvirt/images/wtbw1064.qcow2

* Grab the attached source code. The tar file is a bit big at 85KB
because I had to include some Wine headers. However the source file
proper, exception.c, is only 85 lines, including the LGPL header.

* Compile the source code with MinGW by typing 'make'. This produces a
32 bit exception.exe executable. I'll attach it for good measure.

* Put exception.exe on the VM and run it.


After investigation it turns out this happens:
 * Only for Windows 10 64 bit guests. Windows 10 32 bit and older Windows v=
ersions are unaffected.

 * Only on Intel hosts. At least both my Xeon E3-1226 v3 and i7-4790K
hosts are impacted but not my Opteron 6128 one.

 * It does not seem to depend on the emulated CPU type: on the Intel hosts =
this happened with both =

core2duo,nx and 'copy the host configuration' and did not depend on the num=
ber of emulated cpus/cores.

 * This happened with both QEMU 2.1 and 2.7, and both the 3.16.0 and
4.8.11 Linux kernels, both on Debian 8.6 and Debian Testing.


After searching for quite some time I discovered that the kvm kernel module=
 was sneaking the following messages into /var/log/syslog precisely when th=
e BSOD happens:

Dec 16 13:43:48 vm3 kernel: [  191.624802] kvm [2064]: vcpu0, guest rIP: 0x=
fffff803cb3c0bf3 kvm_set_msr_common: MSR_IA32_DEBUGCTLMSR 0x1, nop
Dec 16 13:43:48 vm3 kernel: [  191.624835] kvm [2064]: vcpu0, guest rIP: 0x=
fffff803cb3c0c5c unhandled rdmsr: 0x1c9

A search on the Internet turned up a post suggesting to change kvm's
ignore_msrs setting:

   echo 1 >/sys/module/kvm/parameters/ignore_msrs

https://www.reddit.com/r/VFIO/comments/42dj7n/some_games_crash_to_biosboot_=
on_launch/

This does actually work and provides a workaround at least.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Source code to reproduce this bug"
   https://bugs.launchpad.net/bugs/1658141/+attachment/4806829/+files/excep=
tion.tar.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658141

Title:
  QEMU's default msrs handling causes Windows 10 64 bit to crash

Status in QEMU:
  New

Bug description:
  Wine uses QEMU to run its conformance test suite on Windows virtual
  machines. Wine's conformance tests check the behavior of various
  Windows APIs and verify that they behave as expected.

  One such test checks handling of exceptions down. When run on Windows 10 =
64 bit in QEMU it triggers a "KMOD_EXCEPTION_NOT_HANDLED" BSOD in the VM. S=
ee:
  https://bugs.winehq.org/show_bug.cgi?id=3D40240

  =

  To reproduce this bug:
  * Pick a Windows 10 64 bit VM on an Intel host.

  * Start the VM. I'm pretty sure any qemu command will do but here's what =
I used:
    qemu-system-x86_64 -machine pc-i440fx-2.1,accel=3Dkvm -cpu core2duo,+nx=
 -m 2048 -hda /var/lib/libvirt/images/wtbw1064.qcow2

  * Grab the attached source code. The tar file is a bit big at 85KB
  because I had to include some Wine headers. However the source file
  proper, exception.c, is only 85 lines, including the LGPL header.

  * Compile the source code with MinGW by typing 'make'. This produces a
  32 bit exception.exe executable. I'll attach it for good measure.

  * Put exception.exe on the VM and run it.

  =

  After investigation it turns out this happens:
   * Only for Windows 10 64 bit guests. Windows 10 32 bit and older Windows=
 versions are unaffected.

   * Only on Intel hosts. At least both my Xeon E3-1226 v3 and i7-4790K
  hosts are impacted but not my Opteron 6128 one.

   * It does not seem to depend on the emulated CPU type: on the Intel host=
s this happened with both =

  core2duo,nx and 'copy the host configuration' and did not depend on the n=
umber of emulated cpus/cores.

   * This happened with both QEMU 2.1 and 2.7, and both the 3.16.0 and
  4.8.11 Linux kernels, both on Debian 8.6 and Debian Testing.

  =

  After searching for quite some time I discovered that the kvm kernel modu=
le was sneaking the following messages into /var/log/syslog precisely when =
the BSOD happens:

  Dec 16 13:43:48 vm3 kernel: [  191.624802] kvm [2064]: vcpu0, guest rIP: =
0xfffff803cb3c0bf3 kvm_set_msr_common: MSR_IA32_DEBUGCTLMSR 0x1, nop
  Dec 16 13:43:48 vm3 kernel: [  191.624835] kvm [2064]: vcpu0, guest rIP: =
0xfffff803cb3c0c5c unhandled rdmsr: 0x1c9

  A search on the Internet turned up a post suggesting to change kvm's
  ignore_msrs setting:

     echo 1 >/sys/module/kvm/parameters/ignore_msrs

  https://www.reddit.com/r/VFIO/comments/42dj7n/some_games_crash_to_biosboo=
t_on_launch/

  This does actually work and provides a workaround at least.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658141/+subscriptions
