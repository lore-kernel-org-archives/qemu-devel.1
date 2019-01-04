Received: from eggs.gnu.org ([208.118.235.92]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gfQel-0007eN-1m
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gfQeY-00042b-I8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:40:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gfQeY-00040n-6M
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:40:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gfQeW-00032Z-48
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 168FF2E80C8
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 14:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Jan 2019 14:32:43 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1809546 <1809546@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154549130563.19742.15114184471142076379.malonedeb@soybean.canonical.com>
Message-Id: <154661236365.24592.4459076250031488554.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809546] Re: Writing a byte to a pl011 SFR
 overwrites the whole SFR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, our PL011 implementation assumes that you only ever access the
32-bit registers with full width 32-bit word reads and writes. Don't try
to do byte accesses to them. The PL011 data sheet doesn't specifically
say that partial-width accesses to registers are permitted, so I think
that trying to access offset 0x39 falls under the general note in
section 3.1 that attempting to access reserved or unused address
locations can result in unpredictable behaviour.

You need to make sure you write your C code in a manner which enforces
that accesses to device registers are done as single 32-bit accesses,
and the compiler does not silently break them down into multiple reads
and writes, or you will be in for a lot of pain trying to figure out
what is going on if the compiler ever does it with registers that are
write-to-clear or similar behaviour. Linux, for instance, does this by
having readl() and writel() functions that end up doing inline asm of
ldr/str instructions.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809546

Title:
  Writing a byte to a pl011 SFR overwrites the whole SFR

Status in QEMU:
  New

Bug description:
  The bug is present in QEMU 2.8.1 and, if my analysis is correct, also
  on master.

  I first noticed that a PL011 UART driver, which is fine on real
  hardware, fails to enable the RX interrupt in the IMSC register when
  running in QEMU. However, the problem only comes up if the code is
  compiled without optimizations. I think I've narrowed it down to a
  minimal example that will exhibit the problem if run as a bare-metal
  application.

  Given:

  pl011_addr: .word 0x10009000

  The following snippet will be problematic:

       ldr r3, pl011_addr
       ldrb r2, [r3, #0x38]        // IMSC
       mov r2, #0
       orr r2, r2, #0x10           // R2 =3D=3D 0x10
       strb r2, [r3, #0x38]        // Whole word reads correctly after this
       ldrb r2, [r3, #0x39]
       mov r2, #0
       strb r2, [r3, #0x39]        // Problem here! Overwrites offset 0x38 =
as well

  After the first strb instruction, which writes to 0x10009038,
  everything is fine. It can be seen in the QEMU monitor:

  (qemu) xp 0x10009038
  0000000010009038: 0x00000010

  After the second strb instruction, the write to 0x10009039 clears the
  entire word:

  (qemu) xp 0x10009038
  0000000010009038: 0x00000000

  QEMU command-line, using the vexpress-a9 which has the PL011 at
  0x10009000:

  qemu-system-arm -S -M vexpress-a9 -m 32M -no-reboot -nographic
  -monitor telnet:127.0.0.1:1234,server,nowait -kernel pl011-sfr.bin
  -gdb tcp::2159 -serial mon:stdio

  Compiling the original C code with optimizations makes the driver
  work. It compiles down to assembly that only does a single write:

      ldr r3, pl011_addr
      mov r2, #0x10
      str r2, [r3, #0x38]

  Attached is the an assembly file, and linkscript, that shows the
  problem, and also includes the working code.

  I haven't debugged inside of QEMU itself but it seems to me that the
  problem is in pl011_write in pl011.c - the functions looks at which
  offset is being written, and then writes the entire SFR that offset
  falls under, which means that changing a single byte will change the
  whole SFR.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809546/+subscriptions
