Received: from eggs.gnu.org ([2001:4830:134:3::10]:58845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHTRC-0004m2-UU
	for qemu-devel@nongnu.org; Sat, 12 May 2018 08:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHTR9-0001Ye-NJ
	for qemu-devel@nongnu.org; Sat, 12 May 2018 08:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:58928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fHTR9-0001XI-DY
	for qemu-devel@nongnu.org; Sat, 12 May 2018 08:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fHTR8-0005JS-CF
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 12:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 59A3A2E8F39
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 12:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 May 2018 12:10:29 -0000
From: "Vladislav K. Valtchev" <1686170@bugs.launchpad.net>
Reply-To: Bug 1686170 <1686170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170425183112.19801.4371.malonedeb@soybean.canonical.com>
Message-Id: <152612702922.28182.3849440106401436.malone@wampee.canonical.com>
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

Hi,
are there any updates on this issue?

I'm using qemu 2.11.1 and I believe I'm experiencing the same problem expla=
ined by Duane.
I'm unable to debug with gdb 32-bit kernel code using qemu-system-x86_64. G=
DB complains that the target architecture is x86_64, even if VM's CPU is cu=
rrently running in 32-bit protected mode.

Steps to reproduce:
- qemu-system-x86_64 -s -hda <a bootable image using PM32> [note: no need t=
o use -S]
- gdb
- (in gdb): set arch i386
- (in gdb): target remote localhost:1234 [note: no need to specify an ELF b=
inary]

I get:
Remote debugging using localhost:1234
warning: Selected architecture i386 is not compatible with reported target =
architecture i386:x86-64
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
Remote 'g' packet reply is too long (expected 312 bytes, got 536 bytes): [S=
KIPPING the raw data]

Unfortunately, I was unable to find any workaround.
Not even patching GDB as suggested here https://wiki.osdev.org/QEMU_and_GDB=
_in_long_mode
really works (because forcing GDB to ignore the exceeding data, does not re=
ally solve the whole problem).

I remember that with older versions of qemu the behavior was different
and by just using gdb's "set arch" command I was able to debug both
32-bit and 64-bit code running on a x86_64 qemu VM.

Could the older behavior be restored somehow? Even by adding an ad-hoc
command-line option would be OK.

Thanks a lot,
Vlad

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
