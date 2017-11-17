Received: from eggs.gnu.org ([2001:4830:134:3::10]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFi25-0008In-MD
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFi24-00064g-Aq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:54:17 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:46659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFi24-00063v-6q
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:54:16 -0500
Received: by mail-it0-x244.google.com with SMTP id r127so4312229itb.5
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 06:54:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 15:53:54 +0100
Message-ID: <CACXAS8DL4TPp+Re3KZdOtQk-96apxXoxp_CuXd6w9ZqyqTKJBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/15] sun4u: move ISABus inside of
 EBusState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Since the EBus is effectively a PCI-ISA bridge then the underlying ISA bus
> should be contained within the PCI bridge itself.

While it's like that on the Sabre chipset, the Spitfire chipset (which
I hope to add at some point) has the EBus, but no PCI, so maybe it's
better to model it separately.
On the other hand, the Spitfire has different EBus devices
(particularly different type of the serial ports), so I'm not sure.

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 394b7d6..63b4aaa 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -84,6 +84,7 @@ typedef struct EbusState {
>      /*< private >*/
>      PCIDevice parent_obj;
>
> +    ISABus *isa_bus;
>      MemoryRegion bar0;
>      MemoryRegion bar1;
>  } EbusState;
> @@ -245,8 +246,10 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      EbusState *s = EBUS(pci_dev);
>
> -    if (!isa_bus_new(DEVICE(pci_dev), get_system_memory(),
> -                     pci_address_space_io(pci_dev), errp)) {
> +    s->isa_bus = isa_bus_new(DEVICE(pci_dev), get_system_memory(),
> +                             pci_address_space_io(pci_dev), errp);
> +    if (!s->isa_bus) {
> +        error_setg(errp, "unable to instantiate EBUS ISA bus");
>          return;
>      }
>
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
