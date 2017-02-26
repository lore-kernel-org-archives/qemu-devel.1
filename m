Received: from eggs.gnu.org ([2001:4830:134:3::10]:34544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ci6P3-0008Qn-FP
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ci6Oz-0000dm-HW
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:54742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ci6Oz-0000dc-Bi
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 16:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ci6Oy-00083b-4E
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C1AE2E80C4
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Feb 2017 21:21:13 -0000
From: Marc Bommert <1668103@bugs.launchpad.net>
Reply-To: Bug 1668103 <1668103@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170226205013.23267.77116.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170226212114.27786.14852.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1668103] Re: Possible off-by-one error in
 priority handling of hw/PL190.c
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
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1668103

Title:
  Possible off-by-one error in priority handling of hw/PL190.c

Status in QEMU:
  Fix Committed

Bug description:
  I have a problem when reading back VECTADDR in my proprietary OS's
  interrupt handler.

  Example client code:

   1) Write INTENCLEAR to clear all interrupt enable bits
   2) Set all 16 vector control registers to zero
   3) Set vector address #2 to value 2
   4) Set vector control #2 to 0x21 (vector_interrupt_enable(0x20) | vector=
_interrupt_source(0x1) )
   5) Enable interrupt 1 by writing 0x2 to INTENABLE
   6) In interrupt handler: read VECTADDR [should read 0x2 (active IRQs vec=
tor address as set in step 3), reads 0x0 (active vector address index 3 ins=
tead of index 2)]

  Problem:

  So, for me, the block commented with /* Read vector address at the
  start of an ISR...  */ in hw/pl190.c has an off by-one error and does
  not return the vector address of the pending interrupt, but of the
  next one in the list of priorities (i.e. vector address 3).

  Solution:

  In pl190_update_vectors(), also set the priority bit for the current
  priority (1<<i) interrupt (if enabled) in s->prio_mask[i] in addition
  to those of higher priority enabled interrupts. This will cause the
  loop in the read handling of VECTADDR to terminate an iteration
  earlier and will deliver the correct interrupt priority as iteration
  variable i subsequently used for addressing.

  I'll try to provide a patch for this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1668103/+subscriptions
