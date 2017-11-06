Received: from eggs.gnu.org ([2001:4830:134:3::10]:40753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBifY-00008w-08
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBifT-0002f3-3Q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:46:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:47984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBifS-0002eK-TU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:46:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBifQ-0000WM-72
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:46:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D0102E80DB
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 14:46:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 14:35:25 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1216845 <1216845@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130826101205.25802.19011.malonedeb@soybean.canonical.com>
Message-Id: <150997892555.20053.10758617713462098853.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1216845] Re: qemu-system-arm semihosting always
 calls exit(0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With the new 2.0 ARM semihosting ABI, there is an optional extension
SYS_EXIT_EXTENDED which can be used to implement returning a non-zero
exit code for 32-bit ARM programs:

https://developer.arm.com/docs/100863/latest/semihosting-operations
/sys_exit_extended-0x20#sh-ext-exit-extended

QEMU should implement this.


** Changed in: qemu
       Status: New =3D> Confirmed

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1216845

Title:
  qemu-system-arm semihosting always calls exit(0)

Status in QEMU:
  Confirmed

Bug description:
  In my embedded ARM project I have a bunch of unit tests that I run in
  a POSIX synthetic environment, and, as usual for POSIX processes,
  these tests return 0 for success and !=3D0 for error.

  Now I expanded the testing environment to run some of these tests
  compiled for ARM, under QEMU, with the tracing messages forwarded via
  the semihosting API.

  Up to now everything is fine with the emulation.

  However I have a problem with passing the failure code back to the
  operating system, to drive the continuous integration framework.

  I checked the arm-semi.c code and for SYS_EXIT and I discovered that
  the parameter passed is ignored and it always calls exit(0):

      case SYS_EXIT:
          gdb_exit(env, 0);
          exit(0);

  To solve my problem I temporarily made a patch, and for cases that
  should return non zero codes, I call an unsupported BKPT instruction,
  which makes QEMU abort, and pass an non zero code (1) back to the
  operating system.

      qemu: Unsupported SemiHosting SWI 0xf1

  This kludge is more or less functional, but is quite inconvenient.

  After checking the ARM manuals, I discovered that SYS_EXIT is not
  standard, and the 0x18 code used for it originally was used for
  angel_SWIreason_ReportException, which has a slightly different
  purpose.

  Now the question:

  Would it be possible to no longer ignore the code passed to 0x18, and
  if it is non zero, to call exit() with a different value?

  The suggested rule would be:

  if (code =3D=3D0 || code =3D=3D 0x20026)
    exit(0);
  elif (code < 256)
    exit(code);
  else
    exit(1);

  The value 0x20026 means ADP_Stopped_ApplicationExit, and, if I
  understood it right, it means that the program terminated
  successfully. If this is not true, it can be removed from the first
  conditional statement.

  What do you think? Can this be added to arm-semi.c?

  =

  Regards,

  Liviu

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1216845/+subscriptions
