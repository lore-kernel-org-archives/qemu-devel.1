Received: from eggs.gnu.org ([2001:4830:134:3::10]:60048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa2B-0000AW-HP
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa28-0006Vd-Du
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:33:59 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGa28-0006VR-AV
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:33:56 -0500
Received: by mail-qt0-x241.google.com with SMTP id n32so12982279qtb.2
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:33:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f478088-54e0-eef1-e12e-82463bcd543a@amsat.org>
Date: Sun, 19 Nov 2017 11:53:42 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> Since the EBus is effectively a PCI-ISA bridge then the underlying ISA bus
> should be contained within the PCI bridge itself.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
