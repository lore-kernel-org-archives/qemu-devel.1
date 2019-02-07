Received: from eggs.gnu.org ([209.51.188.92]:48902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1grlSo-0001HR-8E
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1grlSn-0008DZ-CP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:19:42 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Thu, 7 Feb 2019 15:19:22 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392B2D8D@lhreml524-mbs.china.huawei.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-11-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-11-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 10/18] hw/arm/virt: Bump the 255GB
 initial RAM limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "david@redhat.com" <david@redhat.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "drjones@redhat.com" <drjones@redhat.com>

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 05 February 2019 17:33
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> imammedo@redhat.com; david@redhat.com
> Cc: dgilbert@redhat.com; david@gibson.dropbear.id.au; drjones@redhat.com
> Subject: [PATCH v6 10/18] hw/arm/virt: Bump the 255GB initial RAM limit
>=20
> Now we have the extended memory map (high IO regions beyond the
> scalable RAM) and dynamic IPA range support at KVM/ARM level
> we can bump the legacy 255GB initial RAM limit. The actual maximum
> RAM size now depends on the physical CPU and host kernel.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b90ffc2e5d..f01886da22 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -93,22 +93,9 @@
>=20
>  #define PLATFORM_BUS_NUM_IRQS 64
>=20
> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
> - * address space unallocated and free for future use between 256G and 51=
2G.
> - * If we need to provide more RAM to VMs in the future then we need to:
> - *  * allocate a second bank of RAM starting at 2TB and working up
> - *  * fix the DT and ACPI table generation code in QEMU to correctly
> - *    report two split lumps of RAM to the guest
> - *  * fix KVM in the host kernel to allow guests with >40 bit address sp=
aces
> - * (We don't want to fill all the way up to 512GB with RAM because
> - * we might want it for non-RAM purposes later. Conversely it seems
> - * reasonable to assume that anybody configuring a VM with a quarter
> - * of a terabyte of RAM will be doing it on a host with more than a
> - * terabyte of physical address space.)
> - */
> -#define RAMLIMIT_GB 255
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
> +/* Legacy RAM limit in GB (< version 4.0) */
> +#define LEGACY_RAMLIMIT_GB 255
> +#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>=20
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such =
as
> UEFI.
> @@ -149,7 +136,7 @@ static const MemMapEntry a15memmap[] =3D {
>      [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
>      [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
>      [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
> -    [VIRT_MEM] =3D                { 0x40000000, RAMLIMIT_BYTES },
> +    [VIRT_MEM] =3D                { 0x40000000,
> LEGACY_RAMLIMIT_BYTES },
>  };
>=20
>  /*
> @@ -1483,8 +1470,9 @@ static void machvirt_init(MachineState *machine)
>=20
>      vms->smp_cpus =3D smp_cpus;
>=20
> -    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
> -        error_report("mach-virt: cannot model more than %dGB RAM",
> RAMLIMIT_GB);
> +    if (!vms->extended_memmap && machine->ram_size >
> LEGACY_RAMLIMIT_GB) {

Just hit this while testing, should this check be against LEGACY_RAMLIMIT_B=
YTES?

Thanks,
Shameer

> +        error_report("mach-virt: cannot model more than %dGB RAM",
> +                     LEGACY_RAMLIMIT_GB);
>          exit(1);
>      }
>=20
> --
> 2.20.1
