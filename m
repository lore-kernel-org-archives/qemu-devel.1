Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaj0D-0001Mz-OY
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 10:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaj05-0003SN-Cf
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 10:15:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gaj05-0003Ol-6b
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 10:15:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gaj04-0006t3-21
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 15:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C4E22E80C7
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 15:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Dec 2018 15:08:51 -0000
From: Daniels Umanovskis <1809546@bugs.launchpad.net>
Reply-To: Bug 1809546 <1809546@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154549130563.19742.15114184471142076379.malonedeb@soybean.canonical.com>
Message-Id: <154549133148.25430.6897027174241901313.malone@gac.canonical.com>
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

Adding the link script.

** Attachment added: "linkscript.ld"
   https://bugs.launchpad.net/qemu/+bug/1809546/+attachment/5224337/+files/=
linkscript.ld

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
