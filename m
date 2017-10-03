Received: from eggs.gnu.org ([2001:4830:134:3::10]:49002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1dzRte-0000FU-82
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1dzRtZ-00087z-9B
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:26:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:55613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1dzRtY-0007ys-Uu
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:26:17 -0400
References: <a53dca17-d9c2-d721-d71d-6cacb8481223@gmx.de>
	<9326d662-0b0f-69bd-10f4-307661718525@twiddle.net>
From: Helge Deller <deller@gmx.de>
Message-ID: <6e669ffe-70c5-3931-f30f-edc76ea202da@gmx.de>
Date: Tue, 3 Oct 2017 20:26:07 +0200
MIME-Version: 1.0
In-Reply-To: <9326d662-0b0f-69bd-10f4-307661718525@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-hppa first steps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 02.10.2017 17:36, Richard Henderson wrote:
> On 10/01/2017 04:27 PM, Helge Deller wrote:
>> What I'm absolutely missing knowledge in is the emulation code in
>> qemu to really be able to emulate the missing hppa assembler instructions.
>> For example, the space registers, some other PSW bits, and so on.
> 
> [CC-ing the list for posterity]
> 
> For emulating system, I believe that we will require TARGET_LONG_BITS == 64
> (even for pa1.1), and make our space registers 32 bits wide (even for pa2.0).
> Thus we will always have a 64-bit virtual address space and never (as is
> architecturally allowable) a 96-bit virtual address space.
> 
> There may be clever things we can do with mmu_idx to speed things up for
> running Linux, which makes very little use of space registers.  However to
> begin let us open-code exactly what the hardware does and afterward see what
> needs to be optimized:
> 
>    pa1.1 or pa2.0 with psw.w=0:
> 	gva = space{0:31} : offset{0:31}
>              = (space << 32) | (offset & 0x0000_0000_ffff_ffff)
> 
>    pa2.0 with psw.w=1:
> 	gva = space{0:1} : (space{2:31} | offset{2:31}) : offset{32:63}
>              = (space << 32) | (offset & 0x3fff_ffff_ffff_ffff)

Sounds good.
  
> We may want to store the space registers in env pre-shifted as a uint64_t to
> minimize the operations required to compute the GVA at runtime.

True.
I'll see if I can change that.
My current implementation has those still as 32bit values...

> You'll want helper functions to compute this both directly in C and with TCG
> operations for the translator.  They'd be no-ops for -linux-user.

Yep.
  
> Implementing the space registers themselves should be straight-forward.  There
> are comments in many (most?) of the places that should be modified.  Take care
> to leave -linux-user unmodified.

I've done that today.
Now the machine is booting up completely by loading firmware and kernel,
running throught the firmware, jumping to the kernel, all kernel initialization
code (e.g. setting space registers), and up to the "rfi" call which does
the hypercall to activate the MMU.

> Let's take the rest case-by-case as it comes up?

Yes.

For the people on the list:
I used SeaBIOS and modified (hacked) it for parisc. Only basic things
like one serial port is implemented yet.
My trees are here:
https://github.com/hdeller/qemu-hppa
https://github.com/hdeller/seabios-hppa

Current boot log shows:

[deller@ls3530 qemu]$ ./hppa-softmmu/qemu-system-hppa  -kernel vmlinux -m 4095 -nographic  -serial mon:stdio
Serial port created at 0xfff83800
Firmware loaded at 0xfffffffff0000000-0xfffffffff000c348, entry at fffffffff0000000
LOADING kernel vmlinux
Kernel entry at 0xe0000, kernel size 4924 kB

PARISC Firmware started, 4095 MB RAM.
SeaBIOS (version rel-1.10.0-75-gffdb369)
BUILD: gcc: (GCC) 7.0.1 20170309 (Red Hat Cross 7.0.1-0.4) binutils: version 2.28-1.fc26
init serial
Found 1 serial ports
Uncompressing kernel ...
startcode_end = 0xe0078
commandline   = 0xf000c348
rd_start      = 0x0
rd_end        = 0x0
free_ptr      = 0x1314000
free_ptr_end  = 0x0
input_data    = 0xc48a6c
input_len     = 0x4c7a8d
output        = 0x100000
output_len    = 0xb4479c
output_max    = 0xb45000
Booting kernel ...

rfi -> (enable MMU)
Segmentation fault (core dumped)
