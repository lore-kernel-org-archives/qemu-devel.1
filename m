Received: from eggs.gnu.org ([2001:4830:134:3::10]:44692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmH3Y-00005X-WD
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmH3V-0003GT-Lr
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:41:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmH3V-0003FN-FE
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:41:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmH3T-0001Tk-T3
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 09:41:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 12A722E81FF
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 09:41:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Mar 2017 09:28:49 -0000
From: Rudolf Marek <1645355@bugs.launchpad.net>
Reply-To: Bug 1645355 <1645355@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161128150552.28561.31457.malonedeb@soybean.canonical.com>
Message-Id: <20170310092849.25439.46661.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1645355] Re: x86: singlestepping through SYSCALL
 instruction causes exception in kernelspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Andreas, man thanks for your reply. I can confirm that applying the
two patches fixes my problem in the older version of the QEMU.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1645355

Title:
  x86: singlestepping through SYSCALL instruction causes exception in
  kernelspace

Status in QEMU:
  Fix Committed

Bug description:
  Hi,

  The bug was originally reported [1] and [2] here. There is a problem
  inside QEMU with singlestepping from userspace until SYSCALL
  instruction is reached. The OS has in FMASK TF bit set, therefore
  there should be no singlestepping exception when transitioning to
  kernelmode. But, inside QEMU there is (TF is clear seems FMASK is
  applied). See below for further details.

  The reproducer is available at [2].

  Here is the original text with some minor clarifications:

  It seems that there is something wrong with QEMU with respect to
  handle the singlestepping and AMD64 syscall instruction.

  The AMD "syscall" instruction will clear defined flag in the FMASK
  MSR. Normally the TF flag is set there, so the first instruction when
  kernel is entered after syscall won't cause single step exception in
  the kernel.

  The observed scenario is a unhandled singlestep fault in the kernel or
  host reboot or QEMU crash.

  The possible way how to reproduce it is to single step through any
  function (in userspace) which does "syscall" instruction. After
  syscall is entered QEMU will trigger singlestepping exception in the
  kernel despite that the TF is set in FMASK MSR. Real HW behaves
  correctly and does not trigger this exception.

  =

  What is interesting is that I was not able to trigger it if I just enable=
d TF and did the syscall instruction, perhaps for this bug is somewhat impo=
rtant to have TF set for previous few instruction.

  =

  I have stumbled to this problem while working with our custom OS. However=
 after some googling I found out that the NetBSD guys (CCed) are having ver=
y similar problem and I asked them to prepare a ISO image where the problem=
 ends with QEMU SIGSEGV or host reboot. =


  Thanks
  Rudolf

  [1] https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg02289.html
  [2] http://gnats.netbsd.org/49603

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1645355/+subscriptions
