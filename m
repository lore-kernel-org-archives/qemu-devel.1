Received: from eggs.gnu.org ([2001:4830:134:3::10]:43870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dRviC-0001Fz-3a
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dRvi7-0006u9-MG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:24:00 -0400
Received: from ikerlan-12.ikerlan.es ([193.145.247.1]:49679)
	by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <xormaetxea@ikerlan.es>) id 1dRvi7-0006i0-0m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:23:55 -0400
From: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Date: Mon, 3 Jul 2017 07:23:23 +0000
Message-ID: <B1DA44315104F94D9F3F23C74275EA9D71DB63@Ikerlan-12.ikerlan.es>
Content-Language: es-ES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Launching Standalone in QEMU-Microblaze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello!

I'm trying to run QEMU-Microblaze (Little-endian) with a standalone app in =
some different ways, but none of them works for me:


1)      I have created my own .DTB from my system design (.HDF), just a mic=
roblaze connected to the Uartlite AXI, leds, interrupt controller, and a gp=
io. Using the board support package I've made a simple c-based program (at =
the end of the message):

Run it with ./qemu-system-microblazeel -M microblaze-fdt-plnx -dtb system-t=
op.dtb -kernel fibonacci.elf (-s -S)         #(-s -S just to debug it)

Invalid MicroBlaze version number: (null)           #Don't think it's a pro=
blem
Bar ram offset 9000528f
Aborted (core dumped)


2)      I use a mb.dtb that I found on the internet. Same c-based program. =
Run it with the debugger:

./qemu-system-microblazeel -M microblaze-fdt-plnx -dtb mb.dtb -kernel fibon=
acci.elf (-s -S)

Lets my debug it (doesn't fail booting), but in the first step:
Bad ram pointer

I suppose this isn't my option cause the .dtb is created for another microb=
laze-based design.


3)      I use the same design (.HDF), but run it for the Spartan 3a dsp 180=
0 option:

./qemu-system-microblazeel -kernel fibonacci.elf (-s -S)

Runs "properly" -> I mean properly because I can follow on the debugger tha=
t the steps are correctly made:
_start -> _start1 -> main -> fibonacci -> xil_printf -> xil_printf ... -> x=
il_printf -> _exit

But doesn't print nothing. And doesn't write in memory as asked (*addrPtr =
=3D 0x150) :
In the qemu shell:
(qemu) x 0xC0000000
C0000000: 0x00000000        #When it should be 0x00000150


4)      Modifying my system design to be similar to the Spartan board desig=
n:
MEMORY_BASEADDR 0x90000000
FLASH_BASEADDR 0xa0000000
INTC_BASEADDR 0x81800000
TIMER_BASEADDR 0x83c00000
UARTLITE_BASEADDR 0x84000000
ETHLITE_BASEADDR 0x81000000
                I get exactly the same result as in the (3) case.

So here they go my questions:

-          Am I doing it right? Is this the method of running a standalone =
program over a microblaze?

-          How can I make the program print something?

-          Im not sure if the problem is that it doesn't write on memory, o=
r I am the one who fails reading it from the shell, because if I change the=
 writing position to (0x84000008, uart status position) I get the error (qe=
mu: hardware error: write to UART STATUS?) -> that means im writing (or try=
ing, at least). How can I write on memory (and read after it, so I know it =
works)?

Thank you in advance! Really appreciate your Job! (I'm sorry if my problem =
it's a simple one, I'm new at it)

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

void fibonacci(int d){
       u32 a=3D1;
       u32 b=3D0;
       u32 em=3D0;
       u32 *addrPtr =3D 0xC0000000;

for(int num=3D0; num<d; num++){
       for(int i=3D0; i<a; i++){
       }
       for(int c=3D0; c<b; c++){
       }
       em =3D a+b;
       xil_printf(em);
       *addrPtr =3D 0x150;
       addrPtr+=3D1;
       b=3Da;
       a=3Dem;
       }
}


int main()
{
    init_platform();
    int i=3D35;
    fibonacci(i);
    cleanup_platform();
    return 0;
}
