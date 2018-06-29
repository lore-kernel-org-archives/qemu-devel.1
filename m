Received: from eggs.gnu.org ([2001:4830:134:3::10]:59394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYyHf-0002aK-Cb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYyHc-0002VJ-7h
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:38:15 -0400
References: <6aea7155-d453-95de-7ed6-dca7ef135b4d@ilande.co.uk>
	<20180629181815.GA14726@flamenco>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a0d80637-24e1-12fd-d667-0e06f2a80488@ilande.co.uk>
Date: Fri, 29 Jun 2018 19:38:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180629181815.GA14726@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] target/ppc: gdbstub single-step broken since
 TranslatorOps conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 29/06/18 19:18, Emilio G. Cota wrote:

> On Fri, Jun 29, 2018 at 13:17:11 +0100, Mark Cave-Ayland wrote:
>> Whilst trying to debug an issue in OpenBIOS, I noticed that the gdbstub
>> single-step functionality was broken which I bisected down to this commit:
> (snip)
>> commit b0c2d5213a14f8b9d44096ee879a5d7f10fbc505
>> Author: Emilio G. Cota <cota@braap.org>
>> Date:   Thu Feb 15 14:51:49 2018 -0500
>>
>>      target/ppc: convert to TranslatorOps
> (snip)
>> (gdb) c
>> Continuing.
>>
>> Breakpoint 1, ob_pci_init () at
>> /home/build/src/openbios/openbios.git/openbios/drivers/pci.c:2020
>> 2020        pci_config_t config = {}; /* host bridge */
>> (gdb) n
>> 2021        phandle_t phandle_host = 0, intc;
>> (gdb) n
>> 2025        activate_device("/");
>> (gdb) n
>>
>> (hangs)
>>
>>
>> Hitting CTRL-C sometimes allows the single-step to continue but raises a
>> SIGINT at address 0x400 which is in the CPU exception table.
> 
> Thanks for reporting this.
> 
> I'm afraid I can't reproduce this. I'm using gdb-multiarch as follows:
> 
> $ gdb-multiarch ../img/ppc/openbios-qemu.elf.nostrip
> GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ../img/ppc/openbios-qemu.elf.nostrip...done.
> warning: File "/data/src/qemu/.gdbinit" auto-loading has been declined by your `auto-load safe-path' set to "$debugdir:$datadir/auto-load".
> To enable execution of this file add
>          add-auto-load-safe-path /data/src/qemu/.gdbinit
> line to your configuration file "/home/cota/.gdbinit".
> To completely disable this security protection add
>          set auto-load safe-path /
> line to your configuration file "/home/cota/.gdbinit".
> For more information about this security protection see the
> "Auto-loading safe path" section in the GDB manual.  E.g., run from the shell:
>          info "(gdb)Auto-loading safe path"
> (gdb) set arch powerpc:
> 403       603       620       7400      EC603e    a35       common64  e500mc    e5500     rs64ii    titan
> 601       604       630       750       MPC8XX    common    e500      e500mc64  e6500     rs64iii   vle
> (gdb) set arch powerpc:403
> The target architecture is assumed to be powerpc:403
> (gdb) b ob_pci_init
> Breakpoint 1 at 0xfff25c58: file /home/build/src/openbios/openbios.git/openbios/drivers/pci.c, line 2020.
> (gdb) target remote :1234
> Remote debugging using :1234
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> vector.0x100 () at /home/build/src/openbios/openbios.git/openbios/arch/ppc/qemu/start.S:284
> 284     /home/build/src/openbios/openbios.git/openbios/arch/ppc/qemu/start.S: No such file or directory.
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> warning: (Internal error: pc 0xfff00100 in read in psymtab, but not in symtab.)
> 
> (gdb) c
> Continuing.
> 
> Breakpoint 1, ob_pci_init () at /home/build/src/openbios/openbios.git/openbios/drivers/pci.c:2020
> 2020    /home/build/src/openbios/openbios.git/openbios/drivers/pci.c: No such file or directory.
> (gdb) n
> 2021    in /home/build/src/openbios/openbios.git/openbios/drivers/pci.c
> (gdb)
> 2025    in /home/build/src/openbios/openbios.git/openbios/drivers/pci.c
> (gdb)
> 2029    in /home/build/src/openbios/openbios.git/openbios/drivers/pci.c
> 
> Here I can keep executing for a while, with no hangs. Eventually I hit
> (gdb)
> arch_of_init () at /home/build/src/openbios/openbios.git/openbios/arch/ppc/qemu/init.c:939
> 939     in /home/build/src/openbios/openbios.git/openbios/arch/ppc/qemu/init.c
> Cannot access memory at address 0xfff0c054
> 
> I tried the last known good commit (as per your bisect) and get the same results
> as above.
> 
> Is there any other way I could try reproducing this? Also, can you
> reproduce with another gdb version?

Hmmm. Have you got a "git clone" of the OpenBIOS source in roms/ that 
you can add to the gdb source path to make sure that "n" correlates with 
the source file line numbers?

> If I don't manage to reproduce, I can send you off-list some patches to try,
> basically breaking down the diff in the first bad commit into very small chunks,
> to see where the problem was introduced.

If the above doesn't work, please do, and I will test them and report back.


ATB,

Mark.
