Received: from eggs.gnu.org ([2001:4830:134:3::10]:45195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dRxOw-0006A2-Kw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dRxOo-0005yg-LY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:12:14 -0400
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:33903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dRxOo-0005we-B5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:12:06 -0400
Received: by mail-lf0-x230.google.com with SMTP id l13so98994400lfl.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 02:12:03 -0700 (PDT)
Date: Mon, 3 Jul 2017 11:12:00 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170703091200.GF2201@toto>
References: <B1DA44315104F94D9F3F23C74275EA9D71DB63@Ikerlan-12.ikerlan.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1DA44315104F94D9F3F23C74275EA9D71DB63@Ikerlan-12.ikerlan.es>
Subject: Re: [Qemu-devel] Launching Standalone in QEMU-Microblaze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Jul 03, 2017 at 07:23:23AM +0000, Ormaetxea Xabier wrote:
> Hello!

Hi!

> 
> I'm trying to run QEMU-Microblaze (Little-endian) with a standalone app in some different ways, but none of them works for me:
> 
> 
> 1)      I have created my own .DTB from my system design (.HDF), just a microblaze connected to the Uartlite AXI, leds, interrupt controller, and a gpio. Using the board support package I've made a simple c-based program (at the end of the message):
> 
> Run it with ./qemu-system-microblazeel -M microblaze-fdt-plnx -dtb system-top.dtb -kernel fibonacci.elf (-s -S)         #(-s -S just to debug it)
> 
> Invalid MicroBlaze version number: (null)           #Don't think it's a problem
> Bar ram offset 9000528f
> Aborted (core dumped)


This indicates that you've linked your standalone app to some RAM you expect
to exist at around 0x90005000, but there's none.
You'll need to check that you are linking your standalone program correctly.
The baremetal BSP needs to match the HW.

> 
> 
> 2)      I use a mb.dtb that I found on the internet. Same c-based program. Run it with the debugger:
> 
> ./qemu-system-microblazeel -M microblaze-fdt-plnx -dtb mb.dtb -kernel fibonacci.elf (-s -S)
> 
> Lets my debug it (doesn't fail booting), but in the first step:
> Bad ram pointer
> 
> I suppose this isn't my option cause the .dtb is created for another microblaze-based design.
> 
> 
> 3)      I use the same design (.HDF), but run it for the Spartan 3a dsp 1800 option:
> 
> ./qemu-system-microblazeel -kernel fibonacci.elf (-s -S)
> 
> Runs "properly" -> I mean properly because I can follow on the debugger that the steps are correctly made:
> _start -> _start1 -> main -> fibonacci -> xil_printf -> xil_printf ... -> xil_printf -> _exit
> 
> But doesn't print nothing. And doesn't write in memory as asked (*addrPtr = 0x150) :
> In the qemu shell:
> (qemu) x 0xC0000000
> C0000000: 0x00000000        #When it should be 0x00000150


Try adding the -serial stdio commandline option to QEMU.

> 
> 
> 4)      Modifying my system design to be similar to the Spartan board design:
> MEMORY_BASEADDR 0x90000000
> FLASH_BASEADDR 0xa0000000
> INTC_BASEADDR 0x81800000
> TIMER_BASEADDR 0x83c00000
> UARTLITE_BASEADDR 0x84000000
> ETHLITE_BASEADDR 0x81000000
>                 I get exactly the same result as in the (3) case.
> 
> So here they go my questions:
> 
> -          Am I doing it right? Is this the method of running a standalone program over a microblaze?

Kind of but I get the impression that your bare-metal application is targeting
different hardware than what you are instructing QEMU to create.


> 
> -          How can I make the program print something?
> 
> -          Im not sure if the problem is that it doesn't write on memory, or I am the one who fails reading it from the shell, because if I change the writing position to (0x84000008, uart status position) I get the error (qemu: hardware error: write to UART STATUS?) -> that means im writing (or trying, at least). How can I write on memory (and read after it, so I know it works)?

I didn't quite understand why you wrote to 0xC0000000?
The spartan design in QEMU has nothing at that address.
Try 0x90000000 instead.

Best regards,
Edgar


> 
> Thank you in advance! Really appreciate your Job! (I'm sorry if my problem it's a simple one, I'm new at it)
> 
> #include <stdio.h>
> #include "platform.h"
> #include "xil_printf.h"
> 
> void fibonacci(int d){
>        u32 a=1;
>        u32 b=0;
>        u32 em=0;
>        u32 *addrPtr = 0xC0000000;
> 
> for(int num=0; num<d; num++){
>        for(int i=0; i<a; i++){
>        }
>        for(int c=0; c<b; c++){
>        }
>        em = a+b;
>        xil_printf(em);
>        *addrPtr = 0x150;
>        addrPtr+=1;
>        b=a;
>        a=em;
>        }
> }
> 
> 
> int main()
> {
>     init_platform();
>     int i=35;
>     fibonacci(i);
>     cleanup_platform();
>     return 0;
> }
