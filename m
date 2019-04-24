Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAZM-0003Uz-0P
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAZK-0002QZ-63
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:35:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAZJ-0002P1-Uf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:35:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAZH-0003Ho-RJ
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:35:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B0E9C2E80D3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:28:57 -0000
From: Thomas Huth <1810545@bugs.launchpad.net>
Reply-To: Bug 1810545 <1810545@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154662609174.25797.11037697007951339169.malonedeb@chaenomeles.canonical.com>
Message-Id: <155608373907.13615.7742948395298488975.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810545] Re: [alpha] Strange exception address
 reported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810545

Title:
  [alpha] Strange exception address reported

Status in QEMU:
  Fix Released

Bug description:
  For some reason the SIGILL handler receives a different address under
  qemu than it used to on real hardware. I don't know specifics about
  the hardware used back then =E2=80=93 it was some sort of 21264a somewhere
  between 600-800 MHz =E2=80=93, and I cannot say anything about the kernel=
 as
  well, but I know that it delivered the faulting address +4, while
  under qemu it receives +8. I know because CACAO, an early Java JIT
  compiler extracts the address from the SIGILL handler and inspects the
  code at the faulting site, and it has substracted 4 from the handler
  address since the dawn of time, and this used to produce the desired
  result on the Alpha hardware. It actually ran on two different Alpha
  machines over the years, and both behaved identically.

  The handler looks like this:
  void handler_sigill(int sig, siginfo_t *siginfo, void *_p)
  {
    uintptr_t trap_address =3D (uintptr_t) (((ucontext_t*) _p)->uc_mcontext=
.sc_pc) - 4;
  }

  (paraphrasing, the actual code is here: https://bitbucket.org/cacaovm
  /cacao-
  staging/src/c8d3fbab864c3243f97629fcfa8d84ba71f38157/src/vm/jit/alpha/lin=
ux
  /md-os.cpp?at=3Ddefault&fileviewer=3Dfile-view-default#md-os.cpp-65)

  I don't know much about the qemu source code and cannot say where this
  is coming from at first glance. The gen_invalid function uses pc_next,
  which sounds like the next instruction, not the next-to-next ;). In
  theory it could actually be the kernel's fault, although I consider
  this unlikely.

  This is qemu-system-alpha with apparently the last Debian which
  existed for Alpha (lenny). The kernel is 2.6.26-2-alpha-generic
  (Debian 2.6.26-29). Observed with qemu git 1b3e80082b, but I guess it
  is the same with any version.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810545/+subscriptions
