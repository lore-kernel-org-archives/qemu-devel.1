Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gRKK3-00077k-Rq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gRKK0-0002JX-JF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:05:23 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 26 Nov 2018 17:04:56 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83885CFB0@FRAEML521-MBB.china.huawei.com>
References: <20181126154616.18173-1-eric.auger@redhat.com>
In-Reply-To: <20181126154616.18173-1-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3
 ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Cc: "xuwei (O)" <xuwei5@huawei.com>

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 26 November 2018 15:46
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3 ACPI integrat=
ion
>=20
> The AcpiIortSmmu3 misses 2 32b fields corresponding to the
> proximity domain and the device id mapping index.
>=20
> Also let's report IO-coherent access is supported for
> translation table walks, descriptor fetches and queues by
> setting the COHACC override flag. Without that, we observe
> wrong command opcodes. The DT description also advertises
> the dma coherency.

Ah..that explains the "IDR0.COHACC overridden" and "CMD_SYNC timeout "
entries in the boot log.  Thanks for the fix and I can confirm this fixes t=
he issue
reported earlier[1].=20

FWIW:
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Thanks,
Shameer

[1] https://patchwork.kernel.org/cover/10609261/

> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT
> table")
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c    | 1 +
>  include/hw/acpi/acpi-defs.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 5785fb697c..aa177ba64d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -448,6 +448,7 @@ build_iort(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
>          smmu->mapping_count =3D cpu_to_le32(1);
>          smmu->mapping_offset =3D cpu_to_le32(sizeof(*smmu));
>          smmu->base_address =3D cpu_to_le64(vms->memmap[VIRT_SMMU].base);
> +        smmu->flags =3D ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>          smmu->event_gsiv =3D cpu_to_le32(irq);
>          smmu->pri_gsiv =3D cpu_to_le32(irq + 1);
>          smmu->gerr_gsiv =3D cpu_to_le32(irq + 2);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index af8e023968..c3ee1f517b 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -628,6 +628,12 @@ struct AcpiIortItsGroup {
>  } QEMU_PACKED;
>  typedef struct AcpiIortItsGroup AcpiIortItsGroup;
>=20
> +enum {
> +    ACPI_IORT_SMMU_V3_COHACC_OVERRIDE =3D 1 << 0,
> +    ACPI_IORT_SMMU_V3_HTTU_OVERRIDE   =3D 3 << 1,
> +    ACPI_IORT_SMMU_V3_PXM_VALID       =3D 1 << 3
> +};
> +
>  struct AcpiIortSmmu3 {
>      ACPI_IORT_NODE_HEADER_DEF
>      uint64_t base_address;
> @@ -639,6 +645,8 @@ struct AcpiIortSmmu3 {
>      uint32_t pri_gsiv;
>      uint32_t gerr_gsiv;
>      uint32_t sync_gsiv;
> +    uint32_t pxm;
> +    uint32_t id_mapping_index;
>      AcpiIortIdMapping id_mapping_array[0];
>  } QEMU_PACKED;
>  typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
> --
> 2.17.2
