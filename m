Received: from eggs.gnu.org ([2001:4830:134:3::10]:60130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0zGP-0002D4-SJ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0zGK-0006nI-EX
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:59146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g0zGK-0006mu-8F
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:20:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g0zGJ-0002Wl-07
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 01:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F11D12E806F
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 01:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Sep 2018 01:12:08 -0000
From: Ramiro Polla <ramiro.polla@gmail.com>
Reply-To: Bug 1792659 <1792659@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153697392900.9226.4246206563741650584.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1792659] [NEW] watchpoints might not properly
 stop execution at the right address
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

This bug has been tested with the latest development tree
(19b599f7664b2ebfd0f405fb79c14dd241557452).

I am using qemu-system-i386 with the gdbserver stub. I set a watchpoint
on some address. When the watchpoint is hit, it will be reported by gdb,
but it might happen that eip points to the wrong address (execution has
not properly stopped when the watchpoint was hit).

The setup I used to reproduce it is quite complex, but I believe I have
found the cause of the bug, so I will describe that.

The check_watchpoint() function sets cflags_next_tb in order to force
the execution of only one instruction, and then exits the current tb. It
then expects to be called again after that one instruction is executed,
the watchpoint is hit and it is reported to gdb.

The problem is that another interrupt might have been generated around
the same time as the watchpoint. If the interrupt changes eip and
execution goes on in another address, the value of cflags_next_tb will
be spoiled. When we come back from the interrupt to the address where
the watchpoint is hit, it is possible that a tb with multiple
instructions is been executed, and therefore eip points to the wrong
address, ahead of where it should be.

In my case, the order is as follows:
* i8259 generates an IRQ
  - cpu->interrupt_request contains both CPU_INTERRUPT_TGT_EXT_1 and CPU_IN=
TERRUPT_HARD
* cpu_handle_interrupt() -> x86_cpu_exec_interrupt() is called
  - it deals with CPU_INTERRUPT_TGT_EXT_1
  - execution continues
* I am exactly at the instruction where the watchpoint is hit.
  - check_watchpoint() is called and cflags_next_tb is set to force the exe=
cution of only one instruction.
  - execution breaks out of the loop with siglongjmp()
* cpu_handle_interrupt() -> x86_cpu_exec_interrupt() is called
  - it deals with the IRQ. eip is changed and cflags_next_tb is spoiled
  - execution continues at the IRQ

[...]
* The kernel finishes dealing with the IRQ

* I am back at the instruction where the watchpoint is hit.
  - A tb is created and executed with two instructions instead of one
  - eip is now ahead of the instruction that hit the watchpoint
* cpu_handle_interrupt() is called
  - it deals with CPU_INTERRUPT_DEBUG
  - the watchpoint is reported by gdb, but with the wrong eip.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1792659

Title:
  watchpoints might not properly stop execution at the right address

Status in QEMU:
  New

Bug description:
  This bug has been tested with the latest development tree
  (19b599f7664b2ebfd0f405fb79c14dd241557452).

  I am using qemu-system-i386 with the gdbserver stub. I set a
  watchpoint on some address. When the watchpoint is hit, it will be
  reported by gdb, but it might happen that eip points to the wrong
  address (execution has not properly stopped when the watchpoint was
  hit).

  The setup I used to reproduce it is quite complex, but I believe I
  have found the cause of the bug, so I will describe that.

  The check_watchpoint() function sets cflags_next_tb in order to force
  the execution of only one instruction, and then exits the current tb.
  It then expects to be called again after that one instruction is
  executed, the watchpoint is hit and it is reported to gdb.

  The problem is that another interrupt might have been generated around
  the same time as the watchpoint. If the interrupt changes eip and
  execution goes on in another address, the value of cflags_next_tb will
  be spoiled. When we come back from the interrupt to the address where
  the watchpoint is hit, it is possible that a tb with multiple
  instructions is been executed, and therefore eip points to the wrong
  address, ahead of where it should be.

  In my case, the order is as follows:
  * i8259 generates an IRQ
    - cpu->interrupt_request contains both CPU_INTERRUPT_TGT_EXT_1 and CPU_=
INTERRUPT_HARD
  * cpu_handle_interrupt() -> x86_cpu_exec_interrupt() is called
    - it deals with CPU_INTERRUPT_TGT_EXT_1
    - execution continues
  * I am exactly at the instruction where the watchpoint is hit.
    - check_watchpoint() is called and cflags_next_tb is set to force the e=
xecution of only one instruction.
    - execution breaks out of the loop with siglongjmp()
  * cpu_handle_interrupt() -> x86_cpu_exec_interrupt() is called
    - it deals with the IRQ. eip is changed and cflags_next_tb is spoiled
    - execution continues at the IRQ

  [...]
  * The kernel finishes dealing with the IRQ

  * I am back at the instruction where the watchpoint is hit.
    - A tb is created and executed with two instructions instead of one
    - eip is now ahead of the instruction that hit the watchpoint
  * cpu_handle_interrupt() is called
    - it deals with CPU_INTERRUPT_DEBUG
    - the watchpoint is reported by gdb, but with the wrong eip.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1792659/+subscriptions
