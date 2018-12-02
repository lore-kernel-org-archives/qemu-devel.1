Received: from eggs.gnu.org ([2001:4830:134:3::10]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTRks-0001Qb-1a
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 08:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTRko-0006LW-TV
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 08:25:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gTRko-0006Kp-Nn
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 08:25:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gTRkl-0000p1-NJ
	for <qemu-devel@nongnu.org>; Sun, 02 Dec 2018 13:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 204E82E80D3
	for <qemu-devel@nongnu.org>; Sun,  2 Dec 2018 13:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Dec 2018 13:15:52 -0000
From: Vincent Hamp <1806243@bugs.launchpad.net>
Reply-To: Bug 1806243 <1806243@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154375655274.15827.14642274888173069615.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806243] [NEW] ARM conditional branch after
 if-then instruction not working
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

Hello

There seems to be an issue with QEMU when debugging if-then condition
blocks from the thumb2 instruction set. The following snippet runs fine
during normal execution, but keeps hanging at the conditional branch
when debugging. The jump at the branch should only be executed as long
as $r0 is lower than $r1. Problem is that once both are equal, the
execution is not continued past the branch and the program counter never
gets popped.

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
20004092:   blt.w   0x20004082      ; unpredictable <IT:lt>  // <-- GDB han=
gs here
20004096:   pop     {pc}

I have tried to reproduce the problem with inline assembly but for some
reason the following example just worked:

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

Quickly reading through already reported ARM bugs I think this might be rel=
ated:
https://bugs.launchpad.net/qemu/+bug/1364501
At least the symptoms sound identical.


The versions I'm running are:
QEMU 3.0.0
arm-none-eabi-gdb 8.2

I've also captured some trace output for single stepping from the pushlt
to the blt.w instruction with the trace arguments unimp, guest_errors,
op, int, exec.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm cortexm

** Attachment added: "QEMU trace output"
   https://bugs.launchpad.net/bugs/1806243/+attachment/5218134/+files/qemu_=
trace_output.txt

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
