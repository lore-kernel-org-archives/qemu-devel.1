Received: from eggs.gnu.org ([2001:4830:134:3::10]:52142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1etpVN-0005un-8p
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1etpVM-0000Wt-Cf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:58:21 -0500
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
Date: Thu, 8 Mar 2018 07:58:03 +0100
MIME-Version: 1.0
In-Reply-To: <1520413694-1271-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Le 07/03/2018 à 10:08, Thomas Huth a écrit :
> The global hack for creating SCSI devices has recently been removed,
> but this apparently broke SCSI devices on some boards that were not
> ready for this change yet. For the 40p machine you now get:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -M 40p -cdrom x.iso
> qemu-system-ppc64: -cdrom x.iso: machine type does not support if=scsi,bus=0,unit=2
> 
> Fix it by providing a lsi53c810_create() function that takes care
> of calling scsi_bus_legacy_handle_cmdline() after creating the
> corresponding SCSI controller.
> 
> Fixes: 1454509726719e0933c800fad00d6999752688ea
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Why is it required?
- because SCSI adapter is not up to date to QEMU standards (QOM, ...)?
- because board is not up to date to QEMU standards (QOM, ...)?
- because board is using SCSI devices by default? (mc->block_default_type = IF_SCSI) ?

In 2 first cases, what is missing?
In third case, maybe it may be better to put it in generic code?
You just fixed 40p and MIPS Jazz machines, but sparc/SS-10 (and other) also have the same problem...

Hervé

> ---
>   hw/ppc/prep.c        | 2 +-
>   hw/scsi/lsi53c895a.c | 7 +++++++
>   include/hw/pci/pci.h | 1 +
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 096d4d4..3361509 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -788,7 +788,7 @@ static void ibm_40p_init(MachineState *machine)
>           qdev_prop_set_uint32(dev, "equipment", 0xc0);
>           qdev_init_nofail(dev);
>   
> -        pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810");
> +        lsi53c810_create(pci_bus, PCI_DEVFN(1, 0));
>   
>           /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>           pci_vga_init(pci_bus);
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index f3d4c4d..160657f 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2279,3 +2279,10 @@ void lsi53c895a_create(PCIBus *bus)
>   
>       scsi_bus_legacy_handle_cmdline(&s->bus);
>   }
> +
> +void lsi53c810_create(PCIBus *bus, int devfn)
> +{
> +    LSIState *s = LSI53C895A(pci_create_simple(bus, devfn, "lsi53c810"));
> +
> +    scsi_bus_legacy_handle_cmdline(&s->bus);
> +}
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index d8c18c7..e255941 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -708,6 +708,7 @@ PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name);
>   PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
>   
>   void lsi53c895a_create(PCIBus *bus);
> +void lsi53c810_create(PCIBus *bus, int devfn);
>   
>   qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
>   void pci_set_irq(PCIDevice *pci_dev, int level);
> 
