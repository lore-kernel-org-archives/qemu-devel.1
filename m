Received: from eggs.gnu.org ([2001:4830:134:3::10]:43650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwmzz-0004yM-Q1
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwmzw-0000mN-LI
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cwmzw-0000m7-Cp
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:49:36 -0400
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
	<1491612336-31066-2-git-send-email-anthony.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3a267fe-d6bb-c72c-0f88-9fa10551f4fd@redhat.com>
Date: Sat, 8 Apr 2017 17:49:30 +0800
MIME-Version: 1.0
In-Reply-To: <1491612336-31066-2-git-send-email-anthony.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] pam:refactor PAM related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>, qemu-devel@nongnu.org



On 08/04/2017 08:45, Anthony Xu wrote:
> split PAM SMRAM functions in piix.c
> create mch_init_pam in q35.c

Could you further move

    MemoryRegion *ram_memory;
    MemoryRegion *system_memory;
    MemoryRegion *pci_address_space;
    PAMMemoryRegion pam_regions[13];

from the northbridge devices up to PCMachineState, and move the common
code for PIIX and Q35 to hw/pci-host/pam.c?

It looks like you can define a better API than what pam.c currently
provides:

void pc_init_pam(PCMachineState *pc_machine, DeviceState *d);
void pc_update_pam(PCMachineState *pc_machine, uint8_t *pam_config);

or even remove "DeviceState *d" because the owner of the memory regions
can be the PCMachineState.

Thanks,

Paolo

> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> ---
>  hw/pci-host/piix.c | 58 ++++++++++++++++++++++++++++++++++++++--------=
--------
>  hw/pci-host/q35.c  | 23 +++++++++++++---------
>  2 files changed, 55 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index f9218aa..ff4e8b5 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -138,16 +138,11 @@ static int pci_slot_get_pirq(PCIDevice *pci_dev, =
int pci_intx)
>      return (pci_intx + slot_addend) & 3;
>  }
> =20
> -static void i440fx_update_memory_mappings(PCII440FXState *d)
> +static void i440fx_update_smram(PCII440FXState *d)
>  {
> -    int i;
>      PCIDevice *pd =3D PCI_DEVICE(d);
> =20
>      memory_region_transaction_begin();
> -    for (i =3D 0; i < 13; i++) {
> -        pam_update(&d->pam_regions[i], i,
> -                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
> -    }
>      memory_region_set_enabled(&d->smram_region,
>                                !(pd->config[I440FX_SMRAM] & SMRAM_D_OPE=
N));
>      memory_region_set_enabled(&d->smram,
> @@ -155,6 +150,39 @@ static void i440fx_update_memory_mappings(PCII440F=
XState *d)
>      memory_region_transaction_commit();
>  }
> =20
> +static void i440fx_update_pam(PCII440FXState *d)
> +{
> +    int i;
> +    PCIDevice *pd =3D PCI_DEVICE(d);
> +    memory_region_transaction_begin();
> +    pam_update(&d->pam_regions[0], 0,
> +               pd->config[I440FX_PAM]);
> +    for (i =3D 1; i < 13; i++) {
> +        pam_update(&d->pam_regions[i], i,
> +                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
> +    }
> +    memory_region_transaction_commit();
> +}
> +
> +static void i440fx_update_memory_mappings(PCII440FXState *d)
> +{
> +    i440fx_update_pam(d);
> +    i440fx_update_smram(d);
> +}
> +
> +
> +static void i440fx_init_pam(PCII440FXState *d)
> +{
> +    int i;
> +    init_pam(DEVICE(d), d->ram_memory, d->system_memory,
> +             d->pci_address_space, &d->pam_regions[0],
> +             PAM_BIOS_BASE,  PAM_BIOS_SIZE);
> +    for (i =3D 0; i < 12; ++i) {
> +        init_pam(DEVICE(d), d->ram_memory, d->system_memory,
> +                 d->pci_address_space, &d->pam_regions[i + 1],
> +                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
> +    }
> +}
> =20
>  static void i440fx_write_config(PCIDevice *dev,
>                                  uint32_t address, uint32_t val, int le=
n)
> @@ -163,9 +191,12 @@ static void i440fx_write_config(PCIDevice *dev,
> =20
>      /* XXX: implement SMRAM.D_LOCK */
>      pci_default_write_config(dev, address, val, len);
> -    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
> -        range_covers_byte(address, len, I440FX_SMRAM)) {
> -        i440fx_update_memory_mappings(d);
> +    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE)) {
> +        i440fx_update_pam(d);
> +    }
> +
> +    if (range_covers_byte(address, len, I440FX_SMRAM)) {
> +        i440fx_update_smram(d);
>      }
>  }
> =20
> @@ -335,7 +366,6 @@ PCIBus *i440fx_init(const char *host_type, const ch=
ar *pci_type,
>      PCIHostState *s;
>      PIIX3State *piix3;
>      PCII440FXState *f;
> -    unsigned i;
>      I440FXState *i440fx;
> =20
>      dev =3D qdev_create(NULL, host_type);
> @@ -378,13 +408,7 @@ PCIBus *i440fx_init(const char *host_type, const c=
har *pci_type,
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&f->smram), &error_abort);
> =20
> -    init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_spac=
e,
> -             &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
> -    for (i =3D 0; i < 12; ++i) {
> -        init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_=
space,
> -                 &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_=
SIZE,
> -                 PAM_EXPAN_SIZE);
> -    }
> +    i440fx_init_pam(f);
> =20
>      /* Xen supports additional interrupt routes from the PCI devices t=
o
>       * the IOAPIC: the four pins of each PCI device on the bus are als=
o
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 344f77b..8866357 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -460,9 +460,21 @@ static void mch_reset(DeviceState *qdev)
>      mch_update(mch);
>  }
> =20
> -static void mch_realize(PCIDevice *d, Error **errp)
> +static void mch_init_pam(MCHPCIState *mch)
>  {
>      int i;
> +    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
> +             mch->pci_address_space, &mch->pam_regions[0],
> +             PAM_BIOS_BASE, PAM_BIOS_SIZE);
> +    for (i =3D 0; i < 12; ++i) {
> +        init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
> +                 mch->pci_address_space, &mch->pam_regions[i + 1],
> +                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
> +    }
> +}
> +
> +static void mch_realize(PCIDevice *d, Error **errp)
> +{
>      MCHPCIState *mch =3D MCH_PCI_DEVICE(d);
> =20
>      /* setup pci memory mapping */
> @@ -510,14 +522,7 @@ static void mch_realize(PCIDevice *d, Error **errp=
)
>      object_property_add_const_link(qdev_get_machine(), "smram",
>                                     OBJECT(&mch->smram), &error_abort);
> =20
> -    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
> -             mch->pci_address_space, &mch->pam_regions[0],
> -             PAM_BIOS_BASE, PAM_BIOS_SIZE);
> -    for (i =3D 0; i < 12; ++i) {
> -        init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
> -                 mch->pci_address_space, &mch->pam_regions[i+1],
> -                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
> -    }
> +    mch_init_pam(mch);
>  }
> =20
>  uint64_t mch_mcfg_base(void)
>=20
