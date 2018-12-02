Received: from eggs.gnu.org ([2001:4830:134:3::10]:56106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTT9o-0007wI-O1
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 09:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTT9i-0006PM-Gy
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 09:55:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:40600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gTT9i-0006P0-Aj
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 09:55:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gTT9h-00076W-2j
	for <qemu-devel@nongnu.org>; Sun, 02 Dec 2018 14:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 11C642E80C7
	for <qemu-devel@nongnu.org>; Sun,  2 Dec 2018 14:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Dec 2018 14:50:15 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1806243 <1806243@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154375655274.15827.14642274888173069615.malonedeb@gac.canonical.com>
Message-Id: <154376221570.10384.1481401012973013541.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806243] Re: ARM conditional branch after if-then
 instruction not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The disassembler is giving you a hint here:

2000408e: itt lt
20004090: pushlt {r0, r1}
20004092: blt.w 0x20004082 ; unpredictable <IT:lt> // <-- GDB hangs here

Your code has a "blt" instruction inside an IT block in a way that is
archictecturally UNPREDICTABLE, and the CPU is allowed to not behave in
the way you might expect it to.

Your attempt to reproduce the problem is likely generating different
instructions (specifically probably a different encoding of the branch
instruction).

On the other hand having QEMU behave differently in singlestep mode and
just hang (rather than, say, making the insn UNDEF or treating it as a
condition-failed or a condition-passed) is not ideal.

Do you have a sample binary and QEMU command line that reproduces this?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806243

Title:
  ARM conditional branch after if-then instruction not working

Status in QEMU:
  New

Bug description:
  Hello

  There seems to be an issue with QEMU when debugging if-then condition
  blocks from the thumb2 instruction set. The following snippet runs
  fine during normal execution, but keeps hanging at the conditional
  branch when debugging. The jump at the branch should only be executed
  as long as $r0 is lower than $r1. Problem is that once both are equal,
  the execution is not continued past the branch and the program counter
  never gets popped.

  2000407a:   push    {lr}
  2000407c:   movs    r0, r6
  2000407e:   ldmia   r7!, {r1, r6}
  20004080:   push    {r0, r1}
  20004082:   str.w   r6, [r7, #-4]!
  20004086:   ldr     r6, [sp, #0]
  20004088:   pop     {r0, r1}
  2000408a:   adds    r0, #1
  2000408c:   cmp     r0, r1
  2000408e:   itt     lt
  20004090:   pushlt  {r0, r1}
  20004092:   blt.w   0x20004082      ; unpredictable <IT:lt>  // <-- GDB h=
angs here
  20004096:   pop     {pc}

  I have tried to reproduce the problem with inline assembly but for
  some reason the following example just worked:

  void f() {
    static uint8_t stack[256]{};
    stack[255] =3D 4;

    asm volatile("\n\t"
                 "push    {lr}"
                 "\n\t"

                 // pre-conditions
                 "movs    r7, %[stack]"
                 "\n\t"
                 "movs    r6, #1"
                 "\n\t"

                 "movs    r0, r6"
                 "\n\t"
                 "ldmia   r7!, {r1, r6}"
                 "\n\t"
                 "push    {r0, r1}"
                 "\n\t"
                 "1:"
                 "\n\t"
                 "str.w   r6, [r7, #-4]!"
                 "\n\t"
                 "ldr     r6, [sp, #0]"
                 "\n\t"
                 "pop     {r0, r1}"
                 "\n\t"
                 "adds    r0, #1"
                 "\n\t"
                 "cmp     r0, r1"
                 "\n\t"
                 "itt     lt"
                 "\n\t"
                 "pushlt  {r0, r1}"
                 "\n\t"

                 // Original instruction
                 //"blt.w   0x20004082"  //   ; unpredictable <IT:lt>

                 // Trying to fake it
                 "blt.w   1b"
                 "\n\t"

                 "pop     {pc}"
                 "\n\t"
                 :
                 : [stack] "r"(&stack[255]));
  }

  The only real major difference I see to the other code snipped is that
  the inline assembly is running from flash memory where as the original
  code runs in ram? Maybe that's a clue somehow?

  Quickly reading through already reported ARM bugs I think this might be r=
elated:
  https://bugs.launchpad.net/qemu/+bug/1364501
  At least the symptoms sound identical.

  =

  The versions I'm running are:
  QEMU 3.0.0
  arm-none-eabi-gdb 8.2

  I've also captured some trace output for single stepping from the
  pushlt to the blt.w instruction with the trace arguments unimp,
  guest_errors, op, int, exec.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806243/+subscriptions
