Received: from eggs.gnu.org ([208.118.235.92]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fMFVk-00065d-Sx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fMFVj-0000yQ-N8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:24:12 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1fMFVj-0000x1-DM
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:24:11 -0400
Received: by mail-pl0-x22e.google.com with SMTP id n10-v6so3441782plp.0
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 09:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RkvGiorW3AqJg=DGebmeSdKtcbdXb=oLe2aEN4M5Nzw@mail.gmail.com>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
	<20180518172009.14416-5-peter.maydell@linaro.org>
	<CAFEAcA-RkvGiorW3AqJg=DGebmeSdKtcbdXb=oLe2aEN4M5Nzw@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Fri, 25 May 2018 18:24:09 +0200
Message-ID: <CAAYMZQtBJ5TuNz44R7ussH69CSRoKH2ZPaEfTPOHwBNFkNmVCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PULL 04/32] xlnx-zdma: Add a model of the Xilinx
 ZynqMP generic DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Friday, 25 May 2018, Peter Maydell <peter.maydell@linaro.org> wrote:

> On 18 May 2018 at 18:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> > From: Francisco Iglesias <frasse.iglesias@gmail.com>
> >
> > Add a model of the generic DMA found on Xilinx ZynqMP.
>
> Hi; the latest Coverity run finds a couple of issues in this code:
>
>
> > +static uint64_t zdma_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    XlnxZDMA *s = XLNX_ZDMA(opaque);
> > +    RegisterInfo *r = &s->regs_info[addr / 4];
> > +
> > +    if (!r->data) {
> > +        qemu_log("%s: Decode error: read from %" HWADDR_PRIx "\n",
> > +                 object_get_canonical_path(OBJECT(s)),
> > +                 addr);
>
> object_get_canonical_path() returns a string that the caller
> takes ownership of, so you have to g_free() it when you've
> finished with it. (CID 1391294)
>
> > +        ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
> > +        zdma_ch_imr_update_irq(s);
> > +        return 0;
> > +    }
> > +    return register_read(r, ~0, NULL, false);
> > +}
> > +
> > +static void zdma_write(void *opaque, hwaddr addr, uint64_t value,
> > +                      unsigned size)
> > +{
> > +    XlnxZDMA *s = XLNX_ZDMA(opaque);
> > +    RegisterInfo *r = &s->regs_info[addr / 4];
> > +
> > +    if (!r->data) {
> > +        qemu_log("%s: Decode error: write to %" HWADDR_PRIx "=%" PRIx64
> "\n",
> > +                 object_get_canonical_path(OBJECT(s)),
> > +                 addr, value);
>
> Similarly here. (CID 1391293)
>
> > +        ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, INV_APB, true);
> > +        zdma_ch_imr_update_irq(s);
> > +        return;
> > +    }
> > +    register_write(r, value, ~0, NULL, false);
> > +}
>
> Could you write a patch that adds the missing g_free()s, please?
>
> Hi Peter,

Absolutly! I'll be back with a patch with the corrections asap! Thank you
for explaining the issues!

Brst regards,
Francisco Iglesias





> thanks
> -- PMM
>
