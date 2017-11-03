Received: from eggs.gnu.org ([2001:4830:134:3::10]:52875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAerq-0005bT-0e
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAerm-0006Ic-St
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAerm-0006I9-MU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAerl-00037m-Bp
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 16:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 57FC62E8069
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 16:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 16:17:43 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 942659 <942659@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120228144943.7111.8880.malonedeb@gac.canonical.com>
Message-Id: <150972586354.20634.952101131208674695.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 942659] Re: ARM: CORTEX M,
 PRIMASK does not disable interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This long-standing bug has been fixed by the rewrite of the M-profile
exception handling for QEMU 2.9.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/942659

Title:
  ARM: CORTEX M, PRIMASK does not disable interrupts

Status in QEMU:
  Fix Released

Bug description:
  qemu version 0.15.1
  but the same code is in qemu 1.0

  "CPSID I" does not disable interrupts for CORTEX M3

  =

  if (interrupt_request & CPU_INTERRUPT_HARD
                          && ((IS_M(env) && env->regs[15] < 0xfffffff0)
                              || !(env->uncached_cpsr & CPSR_I))) {
                          env->exception_index =3D EXCP_IRQ;
                          do_interrupt(env);
                          next_tb =3D 0;
                      }

  =

  do_interrupt() will be executed even if (env->uncached_cpsr & CPSR_I) =3D=
=3D 1 , disable interrupt bit set.

  =

  then changed to: =


  if (interrupt_request & CPU_INTERRUPT_HARD =

                          && !(env->uncached_cpsr & CPSR_I)
                          && (IS_M(env) ? env->regs[15] < 0xfffffff0: 1) ) {
                          env->exception_index =3D EXCP_IRQ;
                          do_interrupt(env);
                          next_tb =3D 0;
                      }

  works

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/942659/+subscriptions
