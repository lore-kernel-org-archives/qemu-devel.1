Received: from eggs.gnu.org ([2001:4830:134:3::10]:58912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWjqv-0008S1-Vh
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWjqt-00022I-5z
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:12:37 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cWjqs-00020s-UL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:12:35 -0500
Received: by mail-pg0-x244.google.com with SMTP id 75so22381711pgf.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 05:12:33 -0800 (PST)
Date: Thu, 26 Jan 2017 22:12:29 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170126131229.GB16014@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
	<39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Wed, Jan 25, 2017 at 09:27:29AM -0800, Richard Henderson wrote:
> On 01/25/2017 04:34 AM, Stafford Horne wrote:
> > Hmm, I just tried your qemu branch and mine:
> > 
> >   git@github.com:stffrdhrn/qemu.git or1k-fix-sigill
> > 
> > Both of them were able to boot fine.
> > 
> > The opencores,or1200-rtlsvn481 cpu node is in the or1ksim device tree
> > definition.  Are you sure your kernel config has this in it?
> > 
> >   CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> > 
> > Could you send your kernel config?
> > 
> > I have attached mine, just in case.  For next-20170124
> 
> Curious.  The entire diff between our configs is just
> 
> --- ../or-config        2017-01-24 09:14:51.918059107 -0800
> +++ .config     2017-01-25 09:18:14.153999754 -0800
> @@ -18,7 +18,7 @@
>  #
>  CONFIG_BROKEN_ON_SMP=y
>  CONFIG_INIT_ENV_ARG_LIMIT=32
> -CONFIG_CROSS_COMPILE="or1k-linux-musl-"
> +CONFIG_CROSS_COMPILE="or1k-musl-linux-"
>  # CONFIG_COMPILE_TEST is not set
>  CONFIG_LOCALVERSION=""
>  CONFIG_LOCALVERSION_AUTO=y
> 
> So you're saying you *do* get serial port output?
> 
> Perhaps you can just send me your kernel...

I just sent you a mail with a link to my kernel for download.

One thing I noticed is you passed '-append console=ttyS0' I think that
does nothing on openrisc since as far as I know openrisc only gets boot
params from the device tree file. I tried with and without it and got no
differences.

Another thing, I am using a 'late' version of gcc built with musl cross [1]
, I dont think it would make a difference, but maybe?

$ or1k-musl-linux-as --version
GNU assembler (GNU Binutils) 2.26.20160125
Copyright (C) 2015 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `or1k-linux-musl'.

$ or1k-musl-linux-gcc --version
or1k-musl-linux-gcc (GCC) 5.4.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.


[1] https://github.com/openrisc/musl-cross/tree/or1k

Boot sequence I am seeing, this comes out to stdout when running the
qemu command. The panic at the end is expected, if I add initrd it
goes away.

Compiled-in FDT at c03ad120
Linux version 4.10.0-rc5-next-20170124 (shorne@lianli.shorne-pla.net) (gcc version 5.4.0 (GCC) ) #406 Thu Jan 26 22:04:20 JST 2017
CPU: OpenRISC-0 (revision 0) @20 MHz
-- dcache disabled
-- icache disabled
-- dmmu:   64 entries, 1 way(s)
-- immu:   64 entries, 1 way(s)
-- additional features:
-- power management
-- timer
setup_memory: Memory: 0x0-0x2000000
Setting up paging and PTEs.
map_ram: Memory: 0x0-0x2000000
itlb_miss_handler c0002160
dtlb_miss_handler c0002000
OpenRISC Linux -- http://openrisc.io
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4080
Kernel command line: console=uart,mmio,0x90000000,115200
earlycon: uart0 at MMIO 0x90000000 (options '115200')
bootconsole [uart0] enabled
PID hash table entries: 128 (order: -4, 512 bytes)
Dentry cache hash table entries: 4096 (order: 1, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 0, 8192 bytes)
Sorting __ex_table...
Memory: 28672K/32768K available (2883K kernel code, 116K rwdata, 640K rodata, 128K init, 94K bss, 4096K reserved, 0K cma-reserved)
mem_init_done ...........................................
NR_IRQS:32 nr_irqs:32 0
clocksource: openrisc_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 95563022313 ns
40.00 BogoMIPS (lpj=200000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 0, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 0, 8192 bytes)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
NET: Registered protocol family 16
clocksource: Switched to clocksource openrisc_timer
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 0, 8192 bytes)
TCP bind hash table entries: 2048 (order: 0, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
UDP hash table entries: 512 (order: 0, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 0, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -2, 3072 bytes)
workingset: timestamp_bits=30 max_order=12 bucket_order=0
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
libphy: Fixed MDIO Bus: probed
NET: Registered protocol family 17
devtmpfs: mounted
Freeing unused kernel memory: 128K
This architecture does not have kernel memory protection.
Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
---[ end Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
