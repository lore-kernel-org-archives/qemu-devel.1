Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNGtX-000855-Nc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNGtW-0007rr-K8
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:37:15 -0500
Date: Thu, 15 Nov 2018 13:36:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181115133658.2cdbd918@redhat.com>
In-Reply-To: <20181105014047.26447-13-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-13-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 12/24] hw: acpi: Export the MCFG getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Yang Zhong <yang.zhong@intel.com>

On Mon,  5 Nov 2018 02:40:35 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> From: Yang Zhong <yang.zhong@intel.com>
>=20
> The ACPI MCFG getter is not x86 specific and could be called from
> anywhere within generic ACPI API, so let's export it.
So far it's x86 or more exactly q35 specific thing,
for example it won't work with arm/virt without refactoring
the later.

We probably over-engineered it and could get by without
properties here at all, but that's not related to this series.

So for now I'd suggest to move it to x86/acpi-pci.c for now
and we can generalize the way we get address/size later,
but if you feel like replacing all this property complications
and making it simpler go ahead.


=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  include/hw/acpi/aml-build.h |  1 +
>  hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
>  hw/i386/acpi-build.c        | 22 ----------------------
>  3 files changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 1861e37ebf..64ea371656 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -408,6 +408,7 @@ void *acpi_data_push(GArray *table_data, unsigned siz=
e);
>  unsigned acpi_data_len(GArray *table);
>  Object *acpi_get_pci_host(void);
>  void acpi_get_pci_holes(Range *hole, Range *hole64);
> +bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
>  /* Align AML blob size to a multiple of 'align' */
>  void acpi_align_size(GArray *blob, unsigned align);
>  void acpi_add_table(GArray *table_offsets, GArray *table_data);
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 869ed70db3..2c5446ab23 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -32,6 +32,8 @@
>  #include "hw/i386/pc.h"
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
> +#include "qom/qom-qobject.h"
> +#include "qapi/qmp/qnum.h"
> =20
>  #define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8
>  #define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000
> @@ -1657,6 +1659,28 @@ void acpi_get_pci_holes(Range *hole, Range *hole64)
>                                                 NULL));
>  }
> =20
> +bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> +{
> +    Object *pci_host;
> +    QObject *o;
> +
> +    pci_host =3D acpi_get_pci_host();

it would be better to get bus from struct AcpiPciBus
instead of doing lookup again. (that's a separate patch from moving functio=
n around)

> +    g_assert(pci_host);
> +
> +    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NUL=
L);
> +    if (!o) {
> +        return false;
> +    }
> +    mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
> +    qobject_unref(o);
> +
> +    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
> +    assert(o);
> +    mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> +    qobject_unref(o);
> +    return true;
> +}
> +
>  static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t =
limit)
>  {
>      CrsRangeEntry *entry;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 14e2624d14..d8bba16776 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1856,28 +1856,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *li=
nker)
>                   "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
>  }
> =20
> -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> -{
> -    Object *pci_host;
> -    QObject *o;
> -
> -    pci_host =3D acpi_get_pci_host();
> -    g_assert(pci_host);
> -
> -    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NUL=
L);
> -    if (!o) {
> -        return false;
> -    }
> -    mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
> -
> -    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
> -    assert(o);
> -    mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
> -    return true;
> -}
> -
>  static
>  void acpi_build(AcpiBuildTables *tables,
>                  MachineState *machine, AcpiConfiguration *acpi_conf)
