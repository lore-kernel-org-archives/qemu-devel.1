Received: from eggs.gnu.org ([2001:4830:134:3::10]:35428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDXaT-0007vw-DF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDXaN-0003Ra-Ff
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:25:21 -0400
MIME-Version: 1.0
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
	<a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
In-Reply-To: <a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 19 Oct 2018 18:25:02 +0200
Message-ID: <CAAdtpL4M9zD3LPOMgQNtN50pKzZAsoKn0c_uBe5vajPFwUMJvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Oct 19, 2018 at 4:40 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 2018-10-19 15:57, Peter Maydell wrote:
> > On 19 October 2018 at 14:14, Thomas Huth <thuth@redhat.com> wrote:
> >> The "unimplemented-device" is currently only used for one arm board.
> >
> > ? It's used in all the MPS boards, several of the imx SoCs,
> > the nrf51 SoC used by the microbit, and by the stellaris boards.
> >
> >> Let's add a CONFIG switch to make sure that we only compile it when
> >> it is really necessary.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  default-configs/arm-softmmu.mak | 1 +
> >>  hw/misc/Makefile.objs           | 2 +-
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> >> index 6f2ffc1..dc9730f 100644
> >> --- a/default-configs/arm-softmmu.mak
> >> +++ b/default-configs/arm-softmmu.mak
> >> @@ -7,6 +7,7 @@ CONFIG_NAND=y
> >>  CONFIG_OR_IRQ=y
> >>  CONFIG_SPLIT_IRQ=y
> >>  CONFIG_REGISTER=y
> >> +CONFIG_UNIMP=y
> >>  CONFIG_ECC=y
> >>  CONFIG_SERIAL=y
> >>  CONFIG_SERIAL_ISA=y
> >
> > This seems awkward to me. The 'unimplemented' device is supposed
> > to be an entirely generic thing usable in any board model.
> > If we only turn it on in the arm-softmmu.mak then it means
> > faffing around with the default-configs/ whenever it gets
> > used in a different architecture.
>
> The device has been added 1.5 years ago, and so far no other target is
> using it yet. So it's very seldom that you've got to expect any changes,
> I think.

I disagree with this (and this patch).

First because I'm using it heavily on MIPS and PPC boards, when no
datashits are available.
I'll submit that during the next merge window, although the MIPS tree
seems now reluctant to that kind of hobbyist work.

Second, because it is very clean when you implement a SoC to first
start with an empty UNIMP region and a cpu core,
then declare the mmio regions for each device (still UNIMP), then you
can slowly add devices one at a time.
This let you (me, so far) push at most a dozen of tiny patches in a
working series, instead of a small series of a dozen of huge patches,
or a series of 100 tiny patches.

See https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06094.html
about this approach.

Regards,

Phil.

> Anyway, it's also not only about speeding up the compilation process for
> people who don't want to use the corresponding targets, this is also
> very useful for downstream distributions of QEMU who want to make sure
> to not compile-in more devices than urgently needed. For example we
> disable this device here and the others in downstream RHEL version of
> QEMU, and I guess it might be interesting for nemu, too. So having more
> flexibility here in the Makefiles would be really great to decrease the
> burden with downstream-specific patches...
>
> > In particular, there's a pull request on the list that uses
> > it in a sparc board, so this patch will break compile on sparc
> > once that pullreq lands.
>
> Ok, then please disregard this patch here, but it would be great if you
> could still consider the other patches of this series.
>
>  Thomas
