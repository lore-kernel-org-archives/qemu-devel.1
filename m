Received: from eggs.gnu.org ([209.51.188.92]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggZHP-0000FB-Kc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggZHM-0001BM-3J
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:05:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:34904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggZHL-00019W-OY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:05:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggZHK-0006Ul-JI
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 18:05:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 86FE02E8005
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 18:05:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jan 2019 17:57:34 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1810545 <1810545@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154662609174.25797.11037697007951339169.malonedeb@chaenomeles.canonical.com>
Message-Id: <154688385484.19401.18084021166417230504.malone@soybean.canonical.com>
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

The problem seems to be that the PC we report for an OPCDEC is first select=
ed by gen_invalid()/gen-excp() in target/alpha/translate.c, which uses pc_n=
ext (ie the insn's address plus 4). But that is then handed through to our =
custom PALcode (https://git.qemu.org/?p=3Dqemu-palcode.git;a=3Dblob;f=3Dpal=
.S;h=3D1781c4b415700ca3a68af07fdae90ae43e722501;hb=3DHEAD) which does
  addq    p6, 4, p1  // increment past the faulting insn
resulting in insn + 8.

That is, the palcode and the QEMU code have a disagreement about what
the (private) API between them is. I'm not sure which side is wrong and
should be corrected. I think the linux-user code assumes the same thing
that translate.c is doing, so perhaps the palcode.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810545

Title:
  [alpha] Strange exception address reported

Status in QEMU:
  New

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
