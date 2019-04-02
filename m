Received: from eggs.gnu.org ([209.51.188.92]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB97E-0007I4-7Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hB97B-0006SA-NT
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:25:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hB976-00069V-5k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:25:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id d24so10557719otl.11
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:25:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
	<CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 2 Apr 2019 04:25:15 +0200
Message-ID: <CAL1e-=jj4y=_ViZPepZ15VQnQQ++tbD2FYcmNST88O59GcjXfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tommy Jin <tjin@wavecomp.com>, qemu-devel@nongnu.org, pburton.wavecomp.com@gmail.com

On Apr 1, 2019 11:39 AM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Mon, 1 Apr 2019 at 16:23, Tommy Jin <tjin@wavecomp.com> wrote:
> >
> > Boston didn't bring up any netcard by default, this is not so
convenient for users who are verifying network related functionalities on
this board.
> > As the linux kernel has already supported virtio_net, now add a virtio
netcard for boston, to make virtio work properly, please:
> > 1. set virtio net options in linux kernel, saying CONFIG_VIRTIO &&
CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
> > 2. specify model=virtio when you start boston in qemu.
> >
> > Signed-off-by: tjin <tjin@wavecomp.com>
> > ---
> >  hw/mips/boston.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> > index cac0e22..5d3239e 100644
> > --- a/hw/mips/boston.c
> > +++ b/hw/mips/boston.c
> > @@ -428,10 +428,10 @@ static void network_init(PCIBus *bus)
> >  {
> >      PCIDevice *eth;
> >
> > -    /*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI &&
CONFIG_VIRTIO_NET
> > -        of Linux kernel.*/
> > +    /* Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI &&
CONFIG_VIRTIO_NET */
> > +    /* of Linux kernel. */
>
> This sort of thing should go in documentation, not as a comment
> in the code.
>
> >      eth = pci_create(bus,
> > -                                        PCI_DEVFN(0, 1),
"virtio-net-pci");
> > +                     PCI_DEVFN(0, 1), "virtio-net-pci");
>
>
> Am I missing something, or is this patch not actually changing
> any code? Maybe you made a mistake somehow when creating it?
>
> I'm not sure if we want to create a default network card
> for this board -- the user (or more usually the management
> layer like libvirt) can create it on the command line, and
> if we always create a virtio-net-pci device in the code then
> the user has no way to say they *don't* want the device.
>
> Also, this board is a model of a real piece of hardware, and
> the real hardware doesn't have a virtio-net device in it.
>
> >
> >      qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
> >      qdev_init_nofail(&eth->qdev);
> > --
>
> thanks
> -- PMM
>

Just adding Paul Burton, the Boston card emulation maintainer.

Aleksandar
