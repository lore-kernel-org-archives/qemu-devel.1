Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dUc49-00070c-7W
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dUc45-0004H7-8H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:01:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dUc45-0004Gg-1w
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:01:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dUc43-0006px-6h
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:01:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B6E502E819D
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:01:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Jul 2017 16:55:44 -0000
From: Duane Voth <duanev@gmail.com>
Reply-To: Bug 1686170 <1686170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170425183112.19801.4371.malonedeb@soybean.canonical.com>
Message-Id: <149970574423.24281.12856920525299049797.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1686170] Re: qemu-system-x86_64+gdb: unable to
 correctly disassemble "real mode" (i8086) instructions after attaching to
 QEMU started with "-S -s" options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Apparently none of the 32bit x86 modes are supported in 2.9 version of
qemu-system-x86_64.  I realize the desire to simplify the code, and
separate i386 from x86_64, but x86_64 really does need to support all
the modes in which the processor can operate.  True that for major
operating systems the processor is only briefly in any 32bit mode, but
for boot ROM and boot loader work, and non-mainstream kernels we still
very much need 32bit support *in* the x86_64 qemu.

Previously the 'g' RDP query (gdbstub.c:1056) would send a different
length of reg data depending on in which mode the cpu was currently
operating.  Although maybe not a great ABI, it was sufficient to tell
exactly when the cpu changed states and front end debuggers need to know
this.

Unfortunately the much more portable new .xml register definition scheme ne=
eds to be changed to properly support multiple register sets (with differen=
t names sizes etc.), but x86 is not the only processor to have multiple per=
sonalities. =

 An example implementation for x86 could be that the "top" level xml file i=
386-64bit.xml describes all the different possible modes (something like):

<feature name=3D"org.gnu.gdb.i386.64bit">
  <xi:include href=3D"i386-64bit-core.xml"/>
  <xi:include href=3D"i386-64bit-sse.xml"/>
</feature>
<feature name=3D"org.gnu.gdb.i386.32bit.protectedmode">
  <xi:include href=3D"i386-32bit-core.xml"/>
  <xi:include href=3D"i386-32bit-sse.xml"/>
</feature>
<feature name=3D"org.gnu.gdb.i386.32bit.realmode">
  <xi:include href=3D"i386-i8086-core.xml"/>
</feature>

all of which are loaded when the frontend starts.  The 'g' RDP response
should then start with one of the feature names (or an abbreviated
unique id).

In fact, ring0 vs ring1-3 should likely also have different xml files as
the crX config registers need to be sent when in ring 0 as well.


Commit that made this change:

https://github.com/qemu/qemu/commit/00fcd100c3f47445f6a59d39e11601460880cfe4
#diff-b8f1948d6e81e8ccdbe828ba7973c483

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686170

Title:
  qemu-system-x86_64+gdb: unable to correctly disassemble "real mode"
  (i8086) instructions after attaching to QEMU started with "-S -s"
  options

Status in QEMU:
  New

Bug description:
  OS: Void Linux x86_64 (glibc)
  QEMU version: 2.9.0
  GDB version: 7.12.1

  Problem description:

  After I updated QEMU from version 2.8.1 to 2.9.0, I found that when I try=
 to connect GDB to a running QEMU and try to debug Real mode machine code, =
I can no longer set architecture to 'i8086'.
  To be able to connect to QEMU from GDB at all, I have to specify one of t=
he 64 bit architectures, which among other things leads to incorrect disass=
embly listings. This makes debugging Real mode bootloaders, bootsectors and=
 BIOS code much more difficult.

  Steps to reproduce:

  - Run QEMU
  - In another terminal, run GDB
  - In GDB, connect to QEMU
  - In GDB, disassemble some Real mode machine code.

  Expected results (from QEMU version 2.8.1):

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      (gdb) set architecture i8086
      warning: A handler for the OS ABI "GNU/Linux" is not built =

      into this configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x0000fff0 in ?? ()
      (gdb) x/i $cs*16+$eip
         0xffff0:	ljmp   $0xf000,$0xe05b

  Actual results:

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      $ gdb -q
      (gdb) set architecture i8086 =

      warning: A handler for the OS ABI "GNU/Linux" is not built into this =
configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]

  Workarounds tried:

    - Try different architecures
      (gdb) set architecture i386:intel
      The target architecture is assumed to be i386:intel
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]
      (gdb) set architecture i386:x86-64
      The target architecture is assumed to be i386:x86-64
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x000000000000fff0 in ?? ()

  The last try finally allowed me to connect to QEMU, but as can be
  expected from using an incorrect architecture setting, disassembly
  output is complete gibberish:

      (gdb) x/10i $cs*16+$rip
         0xffff0:	(bad)  =

         0xffff1:	pop    %rbx
         0xffff2:	loopne 0xffff4
         0xffff4:	lock xor %dh,(%rsi)
         0xffff7:	(bad)  =

         0xffff8:	xor    (%rbx),%dh
         0xffffa:	(bad)  =

         0xffffb:	cmp    %edi,(%rcx)
         0xffffd:	add    %bh,%ah
         0xfffff:	add    %al,(%rax)

  Discussion:

  I think I've traced the problem to the following commit: "x86: Fix x86_64=
 'g' packet response to gdb from 32-bit mode."[1].
  While I admire the effort to make life for people using GDB to debug QEMU=
 VMs, I think the problem here is with GDB and can't be fixed entirely from=
 the side of QEMU without breaking other features.

  In fact, there is a well-known workaround to this problem published on
  OSDev Wiki (Workaround #1)[2] which doesn't require patching either
  QEMU or GDB. This workaround has worked for me using several previous
  versions of QEMU.

      $ gdb -q
      (gdb) set architecture i8086
      (gdb) target remote :1234
      (gdb) break some_breakpoint_in_32_bit_or_64_bit_code
      (gdb) continue
      [...]
      Remote 'g' packet reply is too long: [...]
      (gdb) disconnect # IMPORTANT STEP #1
      (gdb) set architecture i386:x86-64
      (gdb) target remote :1234 # IMPORTANT STEP #2
      (gdb) continue

  [1]: http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3De3592bc9d841c397eed=
a87f0019fab94ff71004b
  [2]: http://wiki.osdev.org/QEMU_and_GDB_in_long_mode#Workaround_1:_Reconn=
ecting

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686170/+subscriptions
