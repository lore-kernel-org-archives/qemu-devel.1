Received: from eggs.gnu.org ([2001:4830:134:3::10]:48997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqMQf-00029z-7e
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqMQZ-000189-VJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqMQZ-00017s-PF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqMQY-0005cW-Mi
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 16:46:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A107F2E848B
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:46:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Sep 2017 16:30:27 -0000
From: Thomas Huth <1061778@bugs.launchpad.net>
Reply-To: Bug 1061778 <1061778@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121004175127.14632.79087.malonedeb@gac.canonical.com>
Message-Id: <150488822748.23092.16380902656899069235.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1061778] Re: signal mask not reset on exec
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
https://bugs.launchpad.net/bugs/1061778

Title:
  signal mask not reset on exec

Status in QEMU:
  Incomplete

Bug description:
  Seen in qemu-1.0 under 12.04, but AFAICT from current git it hasn't
  changed.

  ./main-loop.c:qemu_signal_init blocks SIGALRM so it can be handled via
  signalfd.

  ./net/tap.c:launch_script does not reset the signal mask before the
  execv() call, and signal masks are inherited. So the script is run
  with SIGALRM blocked (as can be seen in /proc/$$/status, "SigBlk:
  0000000000002000"). One reasonable example of where this bites is an
  interface up script that calls ping with a timeout to give things a
  chance to settle down before continuing, but abort if this doesn't
  happen within a reasonable time). Since ping uses SIGALRM for the
  timeout, this now never terminates.

  qemu-0.14 didn't block SIGALRM, so such scripts worked fine there.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1061778/+subscriptions
