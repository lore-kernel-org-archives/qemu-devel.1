Received: from eggs.gnu.org ([2001:4830:134:3::10]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e7Gpr-0008VL-QW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e7Gpn-0001fu-Rt
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:14:47 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:42882)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e7Gpn-0001dl-8Y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:14:43 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Wed, 25 Oct 2017 09:40:35 +0200
References: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
	<cbfe4b03919c677d132971ed0c352b0d90de5015.1508885974.git.pisa@cmp.felk.cvut.cz>
	<083391ca-0827-fa22-92e3-7522e8722b0c@adacore.com>
In-Reply-To: <083391ca-0827-fa22-92e3-7522e8722b0c@adacore.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201710250940.35415.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 4/6] Fixed IRQ problem for CAN device
 can_pcm3680_pci.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>

On Wednesday 25 of October 2017 08:53:07 KONRAD Frederic wrote:
> Can't this be merged in the previous patch?

Yes, my intention has been to keep other authors
patches fully documenting their effort.

So I cleaned and keep in logical chunks mine patches
and do only formating of others. But I am happy
to collapse these to into single one.

If the rest goes OK, then if the core and standalone
usable patches

  [PATCH 1/6] CAN bus simple SJA1000 PCI card emulation for QEMU
  [PATCH 2/6] CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.

are accepted I prepare updated series.

If review leads to need update whole series, I merge
this to previous one before posting.

Thanks much for your time,

Pavel

> On 10/25/2017 01:29 AM, pisa@cmp.felk.cvut.cz wrote:
> > From: Deniz Eren <deniz.eren@icloud.com>
> >
> > Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> > ---
> >   hw/can/can_pcm3680_pci.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
> > index 77523f2ddb..bc6b164ea7 100644
> > --- a/hw/can/can_pcm3680_pci.c
> > +++ b/hw/can/can_pcm3680_pci.c
> > @@ -61,6 +61,7 @@ typedef struct Pcm3680iPCIState {
> >       MemoryRegion    sja_io[2];
> >
> >       CanSJA1000State sja_state[2];
> > +    qemu_irq        irq;
> >
> >       char            *model; /* The model that support, only SJA1000
> > now. */ char            *canbus[2];
> > @@ -69,10 +70,16 @@ typedef struct Pcm3680iPCIState {
> >
> >   static void pcm3680i_pci_irq_raise(void *opaque)
> >   {
> > +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
> > +
> > +    qemu_irq_raise(d->irq);
> >   }
> >
> >   static void pcm3680i_pci_irq_lower(void *opaque)
> >   {
> > +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
> > +
> > +    qemu_irq_lower(d->irq);
> >   }
> >
> >   static void
> > @@ -206,6 +213,8 @@ static int pcm3680i_pci_init(PCIDevice *pci_dev)
> >       pci_conf = pci_dev->config;
> >       pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
> >
> > +    d->irq = pci_allocate_irq(&d->dev);
> > +
> >       can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower,
> > d); can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
> >
> > @@ -254,6 +263,8 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
> >
> >       can_sja_exit(s1);
> >       can_sja_exit(s2);
> > +
> > +    qemu_free_irq(d->irq);
> >   }
> >
> >   static const VMStateDescription vmstate_pcm3680i_pci = {
