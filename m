Received: from eggs.gnu.org ([2001:4830:134:3::10]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTAVY-0001df-S9
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 14:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTAVU-0006nv-KO
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 14:00:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gTAVU-0006ne-Dr
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 14:00:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2004720wmh.0
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 11:00:48 -0800 (PST)
References: <1543614312-54253-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2d47b3a-1871-160c-e2bb-802a7f7b0374@redhat.com>
Date: Sat, 1 Dec 2018 20:00:44 +0100
MIME-Version: 1.0
In-Reply-To: <1543614312-54253-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] usb: move
 ehci_create_ich9_with_companions to hw/i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hi Paolo,

On 30/11/18 22:45, Paolo Bonzini wrote:
> This function is only needed when Q35 is in use.  Moving it to
> the same file that uses it lets you disable the entire USB
> subsystem in x86_64-softmmu.mak; of course doing that will
> cause -usb to break horribly, but one thing at a time.

Moving this out of hcd-ehci-pci.c is an improvement.
I'm mitigated about adding this to pc_q35.c, but for the goal you
mentioned, it is enough.

(In a previous work I tried to refactor all ich9 under hw/southbridge/,
keeping q35 clean of it. I might continue after qconfig merged, if this
is worthwhile).

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc_q35.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/usb/hcd-ehci-pci.c | 53 -------------------------------------------------
>  include/hw/usb.h      |  2 --
>  3 files changed, 54 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index ce38129..d2c80c9 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -58,6 +58,59 @@
>  /* ICH9 AHCI has 6 ports */
>  #define MAX_SATA_PORTS     6
>  
> +struct ehci_companions {
> +    const char *name;
> +    int func;
> +    int port;
> +};
> +
> +static const struct ehci_companions ich9_1d[] = {
> +    { .name = "ich9-usb-uhci1", .func = 0, .port = 0 },
> +    { .name = "ich9-usb-uhci2", .func = 1, .port = 2 },
> +    { .name = "ich9-usb-uhci3", .func = 2, .port = 4 },
> +};
> +
> +static const struct ehci_companions ich9_1a[] = {
> +    { .name = "ich9-usb-uhci4", .func = 0, .port = 0 },
> +    { .name = "ich9-usb-uhci5", .func = 1, .port = 2 },
> +    { .name = "ich9-usb-uhci6", .func = 2, .port = 4 },
> +};
> +
> +static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
> +{
> +    const struct ehci_companions *comp;
> +    PCIDevice *ehci, *uhci;
> +    BusState *usbbus;
> +    const char *name;
> +    int i;
> +
> +    switch (slot) {
> +    case 0x1d:
> +        name = "ich9-usb-ehci1";
> +        comp = ich9_1d;
> +        break;
> +    case 0x1a:
> +        name = "ich9-usb-ehci2";
> +        comp = ich9_1a;
> +        break;
> +    default:
> +        return -1;
> +    }
> +
> +    ehci = pci_create_multifunction(bus, PCI_DEVFN(slot, 7), true, name);
> +    qdev_init_nofail(&ehci->qdev);
> +    usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
> +
> +    for (i = 0; i < 3; i++) {
> +        uhci = pci_create_multifunction(bus, PCI_DEVFN(slot, comp[i].func),
> +                                        true, comp[i].name);
> +        qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
> +        qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
> +        qdev_init_nofail(&uhci->qdev);
> +    }
> +    return 0;
> +}
> +
>  /* PC hardware initialisation */
>  static void pc_q35_init(MachineState *machine)
>  {
> @@ -257,7 +310,7 @@ static void pc_q35_init(MachineState *machine)
>          idebus[0] = idebus[1] = NULL;
>      }
>  
> -    if (0 && machine_usb(machine)) {
> +    if (machine_usb(machine)) {

This change shouldn't be unnotified in the commit message.
Maybe this deserves a separate commit?

Except this, I am OK with your patch.

>          /* Should we create 6 UHCI according to ich9 spec? */
>          ehci_create_ich9_with_companions(host_bus, 0x1d);
>      }
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 8c0fc53..69abbf7 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -230,56 +230,3 @@ static void ehci_pci_register_types(void)
>  }
>  
>  type_init(ehci_pci_register_types)
> -
> -struct ehci_companions {
> -    const char *name;
> -    int func;
> -    int port;
> -};
> -
> -static const struct ehci_companions ich9_1d[] = {
> -    { .name = "ich9-usb-uhci1", .func = 0, .port = 0 },
> -    { .name = "ich9-usb-uhci2", .func = 1, .port = 2 },
> -    { .name = "ich9-usb-uhci3", .func = 2, .port = 4 },
> -};
> -
> -static const struct ehci_companions ich9_1a[] = {
> -    { .name = "ich9-usb-uhci4", .func = 0, .port = 0 },
> -    { .name = "ich9-usb-uhci5", .func = 1, .port = 2 },
> -    { .name = "ich9-usb-uhci6", .func = 2, .port = 4 },
> -};
> -
> -int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
> -{
> -    const struct ehci_companions *comp;
> -    PCIDevice *ehci, *uhci;
> -    BusState *usbbus;
> -    const char *name;
> -    int i;
> -
> -    switch (slot) {
> -    case 0x1d:
> -        name = "ich9-usb-ehci1";
> -        comp = ich9_1d;
> -        break;
> -    case 0x1a:
> -        name = "ich9-usb-ehci2";
> -        comp = ich9_1a;
> -        break;
> -    default:
> -        return -1;
> -    }
> -
> -    ehci = pci_create_multifunction(bus, PCI_DEVFN(slot, 7), true, name);
> -    qdev_init_nofail(&ehci->qdev);
> -    usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
> -
> -    for (i = 0; i < 3; i++) {
> -        uhci = pci_create_multifunction(bus, PCI_DEVFN(slot, comp[i].func),
> -                                        true, comp[i].name);
> -        qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
> -        qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
> -        qdev_init_nofail(&uhci->qdev);
> -    }
> -    return 0;
> -}
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index a5080ad..4961405 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -593,8 +593,6 @@ const char *usb_device_get_product_desc(USBDevice *dev);
>  
>  const USBDesc *usb_device_get_usb_desc(USBDevice *dev);
>  
> -int ehci_create_ich9_with_companions(PCIBus *bus, int slot);
> -
>  /* quirks.c */
>  
>  /* In bulk endpoints are streaming data sources (iow behave like isoc eps) */
> 
