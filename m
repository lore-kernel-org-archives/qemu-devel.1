Received: from eggs.gnu.org ([2001:4830:134:3::10]:53351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fcfDA-0003fG-9c
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fcfD8-0003tt-Eq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:04:52 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:37819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fcfD8-0003td-5q
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:04:50 -0400
Received: by mail-oi0-x234.google.com with SMTP id k81-v6so39062337oib.4
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 16:04:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
	<mvm36ws7mq7.fsf@suse.de>
	<CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 10 Jul 2018 11:04:48 +1200
Message-ID: <CAHNT7Nt4m-6wAtHNtArGFV0PP0f5se5R9U=KCHHv65kw7oqHcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Andreas Schwab <schwab@suse.de>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, Jul 10, 2018 at 9:52 AM, Alistair Francis <alistair23@gmail.com>
wrote:

> On Mon, Jul 9, 2018 at 3:00 AM, Andreas Schwab <schwab@suse.de> wrote:
> > What is the state of the sifive_u emulation?  When I tried to boot a bbl
> > with an included kernel I get these errors:
> >
> > qemu-system-riscv64: plic: invalid register write: 00002090
> > qemu-system-riscv64: plic: invalid register write: 00002094
> > qemu-system-riscv64: plic: invalid register write: 00002098
> > qemu-system-riscv64: plic: invalid register write: 0000209c
> > qemu-system-riscv64: plic: invalid register write: 000020a0
> > qemu-system-riscv64: plic: invalid register write: 000020a4
> > qemu-system-riscv64: plic: invalid register write: 000020a8
> > qemu-system-riscv64: plic: invalid register write: 000020ac
> > qemu-system-riscv64: plic: invalid register write: 000020b0
> > qemu-system-riscv64: plic: invalid register write: 000020b4
>
> I see those as well. I haven't investigated but I assume we are just
> not completely modelling the PLIC. In saying that it should still
> boot. Do you not see the kernel booting?


It could be a PLIC bug or it could be a Linux interrupt controller driver
bug. We can see from the memory map docs for the U54 whether these memory
addresses are in bounds based on the number of configured interrupt
sources. I'm not sure how many sources we have configured on sifive_u. Last
time I booted Linux on sifive_u I did not see these errors. I'd need your
kernel config and to know what tree and branch you are building from. I
will be able to look when I get time... The PLIC however seems stable in
the 'virt' board at least...

Sorry I've been incommunicado for several weeks. I have been working on a
CLIC model (Core Local Interrupt Controller) which replaces the CLINT and
has a CLINT backwards compatibility mode. It is a Core Local vs the PLIC
which is the Platform Level router. Here is the "draft" spec. It will be a
candidate proposed to the RISC-V Fast Interrupts working group for
potential standardisation, however in any case it will be available from
SiFive so we may eventuall want to include our implementation in QEMU:

- https://github.com/sifive/clic-spec/blob/master/clic.adoc

When i'm done with modelling the first iteration of the CLIC I'll go
through my pending patch queue and make a PR for the Reviewed patches. I'll
also do some testing on master to make sure we have not regressed anything
in RISC-V QEMU given QEMU 2.12 and the riscv-qemu trees are both stable.

BTW - with respect to 'sifive_e' and 'sifive_u' SOC changes, we'll have to
see how the model matches SiFive's plans for these virtual machines. We
want to avoid a proliferation of boards, and as I've mentioned before we
want to be able to model the HiFive1, HiFiveU and other SiFive E Series and
U Series Coreplex configurations. There are many permutations from SiFive's
SOC generator so our goal is to avoid hardcoding all of the different SOC
combinations (hence the removal of model numbers in my initial review of
your patches). How we achieve this I do not know. We obviously want to
invest our time in something that is acceptable to upstream, while also
meeting the goal of modelling SiFive's many hardware configurations, given
these boards also model softcore IP such as the e31 arty and u54 on Xilinx
VC707. i.e. they are SiFive models.

I'm not too concerned with the SOC changes assuming we don't regress any
function, as we can always evolve the code in the future to match
configurations from SiFive's SOC generator. At present the models are like
a union of a subset of the real hardware as we are still missing many
emulation models for various parts of the SOCs. After i've finished up this
CLIC work, I'll go back through the list of things we still need to model.

Adding the Cadence GEM to the SiFive U Series is really nice, and so is
adding Xilinx PCI to the SiFive U and GPEX to virt (as discussed, given
virt is generic, we want to use GPEX there).

Thanks,
Michael.

>
> > Andreas.
> >
> > --
> > Andreas Schwab, SUSE Labs, schwab@suse.de
> > GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> > "And now for something completely different."
>
