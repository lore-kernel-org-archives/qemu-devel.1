Received: from eggs.gnu.org ([2001:4830:134:3::10]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cvnvb-0000Kv-H5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1cvnvZ-0005jS-Ld
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:37:03 -0400
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1cvnvZ-0005j6-Fp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:37:01 -0400
Received: by mail-vk0-x230.google.com with SMTP id z204so11751225vkd.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 09:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <74004942B5DA03468B2B76399A14BF2ED54A885F@XSJ-PSEXMBX01.xlnx.xilinx.com>
References: <CAF++6AOLSd0SYyv_LmnjinEj-jHBbyNZv_hxvdksGqCoDcpmjA@mail.gmail.com>
	<74004942B5DA03468B2B76399A14BF2ED54A885F@XSJ-PSEXMBX01.xlnx.xilinx.com>
From: James Hanley <jhanley@dgtlrift.com>
Date: Wed, 5 Apr 2017 12:36:59 -0400
Message-ID: <CAF++6AO++ygLFqNqDmd2w+gAmBw3a1aZn9w8oPF+h3M_bC0CHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] MTD timeout on bootup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

Thanks Alistair.
Regarding the issue - when I tried to use any of the pre-built images off
of http://www.wiki.xilinx.com/Zynq+Releases none would detect the MTD
device in QEMU - they all had a timeout error.  Single-stepping through
QEMU with GDB as it booted up any of the kernels from Xilinx, I couldn't
see how the SPI queue could be emptied from the fifo otherwise.  It wasn't
until I made the change in the patch flipping the logic that it would
detect the MTD device.

Taking a step back, I was really interested in understanding a working
reference implementation for interaction between SPI and serial flash in
QEMU for myself as I'm attempting to implement the Atmel SAM4C family of
MCUs - so my knowledge of Zynq is limited, and I was really just looking
for an ARM based reference model to use.

As far as patch submitting, I know this is out of scope of this thread, but
"git send-email" seems to fail with Google Mail for GSuite domains.  Google
keeps blocking it with an error that the app is a "less secure app"...
anybody else know the resolution to this?

On Mon, Apr 3, 2017 at 1:32 PM, Alistair Francis <
alistair.francis@xilinx.com> wrote:

> > -----Original Message-----
> > From: James Hanley [mailto:jhanley@dgtlrift.com]
> > Sent: Friday, 31 March 2017 8:29 AM
> > To: Alistair Francis <alistai@xilinx.com>; Peter Crosthwaite
> > <crosthwaite.peter@gmail.com>; qemu-devel <qemu-devel@nongnu.org>
> > Subject: MTD timeout on bootup
> >
> > When trying to bootup a pristine zync image from the zc702 tarball, it
> would always
> > fail with the MTD detection of the serial flash device type command over
> the SPI.  I
> > believe this section of code may have the logic flipped.  Once I changed
> it to the
> > following, I was able to detect the flash type when booting the pristine
> image from
> > Xilinx.
>
> Hey Jim,
>
> First off, thanks for the patch.
>
> In the future do you mind following the guidelines here:
> http://wiki.qemu-project.org/Contribute/SubmitAPatch
>
> If you use git format-patch and git send-email to generate the patch and
> send the result
> to the mailing list it is much easier for people to review and apply.
>
> Looking at the Xilinx Zynq-700 TRM (page 1754) I see that the
> Man_start_com bit
> specifies to manually start the transmission of data, so it looks like the
> logic already in
> the QEMU model is correct. What issue are you seeing that this fixes?
> Maybe the logic
> somewhere else is incorrect.
>
> PS: Sorry about the footer, I had to reply from my corporate email account.
>
> Thanks,
>
> Alistair
>
> > -Jim
> >
> >
> > From baaaacca370c13526fd2b8c7b33c7d9e8a6d7b8d Mon Sep 17 00:00:00 2001
> > From: Jim Hanley <Jim.Hanley@LandisGyr.com>
> > Date: Thu, 23 Mar 2017 10:29:34 -0400
> > Subject: [PATCH] MTD writes from the SPI were never being dequeue...
> > Signed-off-by:
> >
> > ---
> >  hw/ssi/xilinx_spips.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> > index da8adfa..a3af1f7 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -482,8 +482,8 @@ static void xilinx_spips_write(void *opaque, hwaddr
> addr,
> >      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
> >  no_reg_update:
> >      xilinx_spips_update_cs_lines(s);
> > -    if ((man_start_com && s->regs[R_CONFIG] & MAN_START_EN) ||
> > -            (fifo8_is_empty(&s->tx_fifo) && s->regs[R_CONFIG] &
> MAN_START_EN)) {
> > +    if (!((man_start_com && s->regs[R_CONFIG] & MAN_START_EN) ||
> > +            (fifo8_is_empty(&s->tx_fifo) && s->regs[R_CONFIG] &
> MAN_START_EN))) {
> >          xilinx_spips_flush_txfifo(s);
> >      }
> >      xilinx_spips_update_cs_lines(s);
> > --
> > 2.7.4
>
>
>
> This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you are not
> the intended recipient, do not read, copy, or forward this email message or
> any attachments. Delete this email message and any attachments immediately.
>
>
