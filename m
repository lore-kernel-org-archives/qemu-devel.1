Received: from eggs.gnu.org ([2001:4830:134:3::10]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYsLJ-0006FR-BE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYsLI-0004py-1q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:17:37 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6aea7155-d453-95de-7ed6-dca7ef135b4d@ilande.co.uk>
Date: Fri, 29 Jun 2018 13:17:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] target/ppc: gdbstub single-step broken since
 TranslatorOps conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>

Hi all,

Whilst trying to debug an issue in OpenBIOS, I noticed that the gdbstub 
single-step functionality was broken which I bisected down to this commit:


$ git bisect bad
b0c2d5213a14f8b9d44096ee879a5d7f10fbc505 is the first bad commit
commit b0c2d5213a14f8b9d44096ee879a5d7f10fbc505
Author: Emilio G. Cota <cota@braap.org>
Date:   Thu Feb 15 14:51:49 2018 -0500

     target/ppc: convert to TranslatorOps

     A few changes worth noting:

     - Didn't migrate ctx->exception to DISAS_* since the exception field is
       in many cases architecturally relevant.

     - Moved the cross-page check from the end of translate_insn to 
tb_start.

     - Removed the exit(1) after a TCG temp leak; changed the fprintf 
there to
       qemu_log.

     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Emilio G. Cota <cota@braap.org>
     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


The reproducer is fairly easy:

1) Grab a debug-enabled OpenBIOS from 
http://www.ilande.co.uk/tmp/qemu/openbios-qemu.elf.nostrip.

2) Launch QEMU as follows:

./qemu-system-ppc -M mac99 -bios openbios-qemu.elf.nostrip -nographic -s -S

3) From a separate session:

$ powerpc-linux-gdb openbios-qemu.elf.nostrip
GNU gdb (GDB) 8.1
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-pc-linux-gnu 
--target=powerpc-linux".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from obj-ppc/openbios-qemu.elf.nostrip...done.
(gdb) b ob_pci_init
Breakpoint 1 at 0xfff25c58: file 
/home/build/src/openbios/openbios.git/openbios/drivers/pci.c, line 2020.
(gdb) target remote :1234
Remote debugging using :1234
warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

vector.0x100 () at 
/home/build/src/openbios/openbios.git/openbios/arch/ppc/qemu/start.S:284
284             b       _entry
warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in 
symtab.)

(gdb) c
Continuing.

Breakpoint 1, ob_pci_init () at 
/home/build/src/openbios/openbios.git/openbios/drivers/pci.c:2020
2020        pci_config_t config = {}; /* host bridge */
(gdb) n
2021        phandle_t phandle_host = 0, intc;
(gdb) n
2025        activate_device("/");
(gdb) n

(hangs)


Hitting CTRL-C sometimes allows the single-step to continue but raises a 
SIGINT at address 0x400 which is in the CPU exception table.


ATB,

Mark.
