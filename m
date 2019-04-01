Received: from eggs.gnu.org ([209.51.188.92]:47788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hAtPC-0000ju-Pt
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hAtPB-0004hp-RF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:39:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hAtPB-0004hF-Fh
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:39:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id o74so8029617ota.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 02:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
	<1554099897-28606-2-git-send-email-tjin@wavecomp.com>
In-Reply-To: <1554099897-28606-2-git-send-email-tjin@wavecomp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2019 09:38:46 +0000
Message-ID: <CAFEAcA8eVfmLdPQs0YKsAUYP5LzsFrcF96xknjfKtzbzY97BNw@mail.gmail.com>
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
To: Tommy Jin <tjin@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 1 Apr 2019 at 16:23, Tommy Jin <tjin@wavecomp.com> wrote:
>
> Boston didn't bring up any netcard by default, this is not so convenient for users who are verifying network related functionalities on this board.
> As the linux kernel has already supported virtio_net, now add a virtio netcard for boston, to make virtio work properly, please:
> 1. set virtio net options in linux kernel, saying CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
> 2. specify model=virtio when you start boston in qemu.
>
> Signed-off-by: tjin <tjin@wavecomp.com>
> ---
>  hw/mips/boston.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index cac0e22..5d3239e 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -428,10 +428,10 @@ static void network_init(PCIBus *bus)
>  {
>      PCIDevice *eth;
>
> -    /*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
> -        of Linux kernel.*/
> +    /* Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET */
> +    /* of Linux kernel. */

This sort of thing should go in documentation, not as a comment
in the code.

>      eth = pci_create(bus,
> -                                        PCI_DEVFN(0, 1), "virtio-net-pci");
> +                     PCI_DEVFN(0, 1), "virtio-net-pci");


Am I missing something, or is this patch not actually changing
any code? Maybe you made a mistake somehow when creating it?

I'm not sure if we want to create a default network card
for this board -- the user (or more usually the management
layer like libvirt) can create it on the command line, and
if we always create a virtio-net-pci device in the code then
the user has no way to say they *don't* want the device.

Also, this board is a model of a real piece of hardware, and
the real hardware doesn't have a virtio-net device in it.

>
>      qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
>      qdev_init_nofail(&eth->qdev);
> --

thanks
-- PMM
