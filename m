Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9bd6-0002Ca-8u
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9bd5-0001ZL-Ae
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:55:48 -0400
Date: Mon, 8 Oct 2018 21:55:21 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181008195521.GB4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9_EOFV=5i-4S1GWVgewAa89hJDTegnf9Ot3w7rfkZWYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9_EOFV=5i-4S1GWVgewAa89hJDTegnf9Ot3w7rfkZWYA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Mon, Oct 08, 2018 at 01:30:20PM +0100, Peter Maydell wrote:
> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Add support for selecting the Memory Region that the GEM
> > will do DMA to.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c         | 63 ++++++++++++++++++++++++++++----------------
> >  include/hw/net/cadence_gem.h |  2 ++
> >  2 files changed, 43 insertions(+), 22 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 759c1d7..ab02515 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -28,6 +28,7 @@
> >  #include "hw/net/cadence_gem.h"
> >  #include "qapi/error.h"
> >  #include "qemu/log.h"
> > +#include "sysemu/dma.h"
> >  #include "net/checksum.h"
> >
> >  #ifdef CADENCE_GEM_ERR_DEBUG
> > @@ -835,9 +836,9 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
> >  {
> >      DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
> >      /* read current descriptor */
> > -    cpu_physical_memory_read(s->rx_desc_addr[q],
> > -                             (uint8_t *)s->rx_desc[q],
> > -                             sizeof(uint32_t) * gem_get_desc_len(s, true));
> > +    address_space_read(s->dma_as, s->rx_desc_addr[q], MEMTXATTRS_UNSPECIFIED,
> > +                       (uint8_t *)s->rx_desc[q],
> > +                       sizeof(uint32_t) * gem_get_desc_len(s, true));
> 
> At some point you might want to add support for handling "descriptor
> read/write failed", incidentally: address_space_read/write return a
> MemTxResult which you can check for != MEMTX_OK.

Yes, the GEM can report those errors to SW so that's a nice feature to follow up with.

Thanks,
Edgar
