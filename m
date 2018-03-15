Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewWAI-0002V7-Mp
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewWAH-0000pz-Ju
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:55:42 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewWAH-0000pc-Eh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:55:41 -0400
Received: by mail-ot0-x231.google.com with SMTP id 108-v6so7582707otv.3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 09:55:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 16:55:19 +0000
Message-ID: <CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2018 at 00:39,  <alarson@ddci.com> wrote:
> When porting our RTOS from QEMU 2.8 to 2.10/2.11, I ran into a problem
> where 16-bit writes to the "bochs dispi interface" were being reported
> differently depending on whether or not "-icount" was given to QEMU.
>
> For example, info mtree:
>   ...
>   11000500-11000515 (prio 0, i/o): bochs dispi interface
>
> A 16-bit write to 0x11000500 was delivered to pci_vga_bochs_write() as
> having
> address 0, when -icount was not specified, but as address 2 when
> -icount was specified.  Correspondingly writes to 0x11000502 were 2
> and 0 respectively.  Essentially the words were swapped depending on
> the presence of -icount.
>
> I suspect a similar problem for the AARCH64 GIC (generic interrupt
> controller), but other than observing the GIC changing from working to
> non-working depending on the absence/presence of -icount I haven't
> confirmed the underlying cause.
>
> 2.10 and 2.11 were built from source on Cygwin using mingw, 2.8 from a
> "native" MinGW.  The results are consistent for 2.10 and 2.11.  2.8
> does not have the -icount dependency.  The "broken" command line was:
>
> qemu-system-aarch64 -m 1077 -name "arm" -M virt,virtualization=on
>   -cpu cortex-a53 -icount align=off,shift=0,sleep=on
>   -vga std -device secondary-vga
>   -device
> virtio-net,netdev=vlan0,addr=2,disable-modern=false,mac=52:54:00:12:67:56
>   -kernel ...deosBoot.bin -initrd "deosBoot.qemu" -netdev
> tap,id=vlan0,ifname="DDCI-tap0"
>
> The "working" command line omitted -icount and its argument.
>
> FWIW, the error from the GIC with -icount was:
>
>   qemu: fatal: IO on conditional branch instruction
>
> Any pointers?

Can you try with this patch applied?
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06595.html
(that will go into git master within the next week or so but isn't
yet applied; it does fix at least some -icount related problems).

If that doesn't help, can you provide a demonstration test
binary that I can use to reproduce the bug?

thanks
-- PMM
