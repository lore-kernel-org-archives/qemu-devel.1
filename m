Received: from eggs.gnu.org ([2001:4830:134:3::10]:43772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHolF-0005ye-8b
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHolC-0001Rg-2q
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:25:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:39812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHolB-0001QR-Tr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:25:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHolA-0001mF-N9
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:25:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA3992E80C3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:25:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Dec 2016 09:14:05 -0000
From: Thomas Huth <1068900@bugs.launchpad.net>
Reply-To: Bug 1068900 <1068900@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121019232243.16004.28788.malonedeb@wampee.canonical.com>
Message-Id: <20161216091405.20599.3964.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1068900] Re: Thread cancellation broken in
 app-level emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The URL from comment #1 is unfortunately not valid anymore. If this
issue is still pending, could you please post your patch again to the
qemu-devel mailing list to get it discussed and included? Thanks!

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1068900

Title:
  Thread cancellation broken in app-level emulation

Status in QEMU:
  Incomplete

Bug description:
  Thread cancellation (and certain other implementation-internal things
  such as set*id() and timers) are implemented in userspace on Linux by
  stealing a couple of the realtime signals for internal use by the
  implementation, leaving them unavailable to applications.
  Unfortunately, this bites qemu application-level emulation when the
  application being run uses thread cancellation or other features that
  need such signals. The signal handler is unable to be set (because
  sigaction on the host rejects the signal numbers) and attempts to send
  the signals result in it being received not by the emulated
  application code, but by the libc/libpthread code on which qemu is
  running; this in turn seems to cause qemu to crash.

  The best solution I can think of is for qemu to steal one of the
  realtime signals for its own use, and multiplex signal numbers outside
  the range SIGRTMIN..SIGRTMAX, as well as the stolen signal itself, on
  top of this stolen signal. This would both allow cancellation to work,
  and would allow applications the full range of realtime signals when
  the guest has more signals than the host (e.g. MIPS running on x86
  host).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1068900/+subscriptions
