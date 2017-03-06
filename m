Received: from eggs.gnu.org ([2001:4830:134:3::10]:42265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckwDn-00007H-B6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckwDm-0001pM-A5
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:14:55 -0500
Date: Mon, 6 Mar 2017 19:14:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170306171427.3gvuduo5hss2good@kozik-lap>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-2-krzk@kernel.org>
	<CAFEAcA-09S5LtTLA6iMf9qYaJvxT2qW=LiTBqnRtUMDy+9BSiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-09S5LtTLA6iMf9qYaJvxT2qW=LiTBqnRtUMDy+9BSiA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/exynos4210: Constify data
 pointed by few arguments and variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Mar 06, 2017 at 09:44:49AM +0000, Peter Maydell wrote:
> On 5 March 2017 at 21:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > In few places the function arguments and local variables are not
> > modifying data passed through pointers so this can be made const for
> > code safeness.  Also the static array exynos4210_uart_regs is not being
> > modified.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  hw/char/exynos4210_uart.c     | 10 +++++-----
> >  hw/intc/exynos4210_combiner.c |  2 +-
> >  hw/intc/exynos4210_gic.c      |  8 ++++----
> >  hw/misc/exynos4210_pmu.c      |  2 +-
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> > index b75f28d473bf..83e1be253255 100644
> > --- a/hw/char/exynos4210_uart.c
> > +++ b/hw/char/exynos4210_uart.c
> > @@ -102,7 +102,7 @@ typedef struct Exynos4210UartReg {
> >      uint32_t            reset_value;
> >  } Exynos4210UartReg;
> >
> > -static Exynos4210UartReg exynos4210_uart_regs[] = {
> > +static const Exynos4210UartReg exynos4210_uart_regs[] = {
> >      {"ULCON",    ULCON,    0x00000000},
> >      {"UCON",     UCON,     0x00003000},
> >      {"UFCON",    UFCON,    0x00000000},
> > @@ -220,7 +220,7 @@ static uint8_t fifo_retrieve(Exynos4210UartFIFO *q)
> >      return  ret;
> >  }
> 
> Constifying this sort of thing is OK...
> 
> > -static int fifo_elements_number(Exynos4210UartFIFO *q)
> > +static int fifo_elements_number(const Exynos4210UartFIFO *q)
> >  {
> >      if (q->sp < q->rp) {
> >          return q->size - q->rp + q->sp;
> > @@ -229,7 +229,7 @@ static int fifo_elements_number(Exynos4210UartFIFO *q)
> >      return q->sp - q->rp;
> >  }
> >
> > -static int fifo_empty_elements_number(Exynos4210UartFIFO *q)
> > +static int fifo_empty_elements_number(const Exynos4210UartFIFO *q)
> >  {
> >      return q->size - fifo_elements_number(q);
> >  }
> > @@ -245,7 +245,7 @@ static void fifo_reset(Exynos4210UartFIFO *q)
> >      q->rp = 0;
> >  }
> >
> > -static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(Exynos4210UartState *s)
> > +static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
> >  {
> >      uint32_t level = 0;
> >      uint32_t reg;
> 
> ...but I disagree here somewhat...

This is a static function not modifying the state. Const in argument is
a clear indication of that for the readers.

> 
> > @@ -488,7 +488,7 @@ static const MemoryRegionOps exynos4210_uart_ops = {
> >
> >  static int exynos4210_uart_can_receive(void *opaque)
> >  {
> > -    Exynos4210UartState *s = (Exynos4210UartState *)opaque;
> > +    const Exynos4210UartState *s = (Exynos4210UartState *)opaque;
> 
> ...and definitely here.
> 
> These are effectively method implementations for QEMU objects,
> and defining the "this" pointer as const in some methods
> because it happens not to be modifying things just makes
> the code look out of line with every other method implementation

I get it, better to keep consistent style.

> in the code base (and means somebody will have to drop the 'const'
> again at some point if the method needs to be updated to
> modify state in the future).

I think the code should be const-correct for current implementation
(following the HACKING guide). If we would have to predict future
changes, then almost no const would be possible to add...

Best regards,
Krzysztof
