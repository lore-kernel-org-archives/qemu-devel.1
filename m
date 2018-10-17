Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gCluW-0001QM-M2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gCluV-0004Za-Qo
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:30:52 -0400
Date: Wed, 17 Oct 2018 15:30:25 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181017133025.GC4229@toto>
References: <20181011021931.4249-1-edgar.iglesias@gmail.com>
	<20181011021931.4249-3-edgar.iglesias@gmail.com>
	<CAFEAcA_c8YiyTtb1pE_ToSF_r6DGjCbjbDHF+6OQeCccbwpc=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_c8YiyTtb1pE_ToSF_r6DGjCbjbDHF+6OQeCccbwpc=A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/12] net: cadence_gem: Announce
 availability of priority queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Tue, Oct 16, 2018 at 05:15:36PM +0100, Peter Maydell wrote:
> On 11 October 2018 at 03:19, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Announce the availability of the various priority queues.
> > This fixes an issue where guest kernels would miss to
> > configure secondary queues due to inproper feature bits.
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index e560b7a142..901c173970 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -1213,6 +1213,7 @@ static void gem_reset(DeviceState *d)
> >      int i;
> >      CadenceGEMState *s = CADENCE_GEM(d);
> >      const uint8_t *a;
> > +    uint32_t queues_mask;
> >
> >      DB_PRINT("\n");
> >
> > @@ -1229,7 +1230,10 @@ static void gem_reset(DeviceState *d)
> >      s->regs[GEM_DESCONF] = 0x02500111;
> >      s->regs[GEM_DESCONF2] = 0x2ab13fff;
> >      s->regs[GEM_DESCONF5] = 0x002f2045;
> > -    s->regs[GEM_DESCONF6] = 0x00000200;
> > +    s->regs[GEM_DESCONF6] = 0x0;
> > +
> > +    queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
> > +    s->regs[GEM_DESCONF6] |= queues_mask;
> 
> This causes the clang runtime sanitizer to complain:
>   /aarch64/qom/xilinx-zynq-a9:
> /home/petmay01/linaro/qemu-for-merges/hw/net/cadence_gem.c:1306:19:
> runtime error: shift exponent 64 is too large for 64-bit type
> 'unsigned long long'

Argh, my bad.


> 
> because s->num_priority_queues is 1, and so you've
> asked for a zero-width mask, which MAKE_64BIT_MASK
> doesn't permit. What was the intention of the code here?


The intention was a mask with zero bits set when only 1 queue is available.

DESCONF6 has a bit set per queue that is available,
except for queue 0, for which bit 0 is always 0.

For example configuration with 1 queue:
..000000

2 queues:
..000010

3 queues:
..000110

4 queues:
..001110

etc.

I'll post a v3 with this fixed.


> I don't think any value of num_priority_queues can
> produce the old 0x200 value for this ID register.

Right, the 0x200 value was bogus.

> 
> I'm going to drop this patch and "net: cadence_gem:
> Announce 64bit addressing support" (which depends
> on this one) from my pullreq.


Best regards,
Edgar
