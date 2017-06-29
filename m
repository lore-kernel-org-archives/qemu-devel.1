Received: from eggs.gnu.org ([2001:4830:134:3::10]:34422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dQW1m-00043e-6W
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dQW1k-0005XS-Vs
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:46:22 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1dQW1k-0005VJ-Rm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:46:20 -0400
Received: by mail-oi0-x233.google.com with SMTP id l130so7094617oib.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 02:46:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e41c60b-53b8-b917-108a-7cea8cb9e591@oracle.com>
References: <4e41c60b-53b8-b917-108a-7cea8cb9e591@oracle.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 29 Jun 2017 11:45:58 +0200
Message-ID: <CACXAS8AqFRC+6nXBm86Ed9ReLFxHxNm8FSvmSt3c+13mA2f7VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SPARC64 supported processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi Pasha,

On Tue, Jun 27, 2017 at 7:59 PM, Pasha Tatashin
<pasha.tatashin@oracle.com> wrote:
> Hi,
>
> I am trying to evaluate the current qemu support for sparc64 processors.
> First, it seems -smp is not supported for any processor, is this correct?
> When I set -smp greater than 1, I am getting:
>
> qemu-system-sparc64: Number of SMP CPUs requested (2) exceeds max CPUs
> supported by machine 'sun4u' (1)
>
> I've done some testing for all available sparc64 cpus + latest linux kernel:
>
> Fujitsu Sparc64     Working
> Fujitsu Sparc64 III Exception 0x30 (DAE_side_effect_page) in OpenBios
> Fujitsu Sparc64 IV  Working
> Fujitsu Sparc64 V   Working
> TI UltraSparc I     Working
> TI UltraSparc II    Working
> TI UltraSparc IIi   Working
> TI UltraSparc IIe   Exception 0x28 (division_by_zero) in init_tick_ops
>   Can make it to work if is_hummingbird() is changed
>   to return 0. The IO stick, and OpenBios stick properties
>   are absent, so we have to default to %tick for now.
>
> Sun UltraSparc III  Illegal instruction in cheetah_boot():
>   wr  %g0, %g1, %dcr
>   It appears dispatch control register is not implemented.
>
> Sun UltraSparc IIIi
> Sun UltraSparc IV
> Sun UltraSparc IV+
> Sun UltraSparc IIIi+
>  In these four CPUs, I am getting exception 0x32 in
>  cheetah_generic_boot: stxa  %g0, [ %g3 ] #ASI_DMMU

The UltraSPARC III {,i,i+} and IV(+) MMUs are not implemented. IIi is
the best for the sun4u target, I think.

> Sun UltraSparc T1
> Sun UltraSparc T2

Same here. T2 is pretty much a stub currently. The emulation uses the
same MMU as for T1.

> Both of the above boot pretty far but fail in this function when tmpfs is
> mounted:
>         direct_pcr_write(unsigned long reg_num, u64 val)
>         __asm__ __volatile__("wr %0, 0x0, %%pcr" : : "r" (val));
>
>         Seems like performance counter registers are not supported.

Correct. As discussed off-list they are not.
Btw, you can try to get through even without modifying qemu.
Start qemu-system-sparc64 with -s -S options, connect to it with gdb,
set a breakpoint before the instruction and skip it by modifying the
%pc and %npc registers.


>         needed to add these to kernel parameters:
>         keep_bootcon -> to see where we are panicking
>         lpj=1000 -> jiffers could not calculate for some reason.
>
> NEC UltraSparc I    Working
>
> Does this look right or may be I have missed something, and we can get some
> of the Sun UltraSparc to work for example?
>
> Thank you,
> Pasha
>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
