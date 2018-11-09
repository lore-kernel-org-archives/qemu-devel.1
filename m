Received: from eggs.gnu.org ([2001:4830:134:3::10]:51213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL7lG-0001a7-U5
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL7lF-0003Zw-W1
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:27:50 -0500
Date: Fri, 9 Nov 2018 15:27:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181109152716.236d3c6e@redhat.com>
In-Reply-To: <20181105014047.26447-3-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-3-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 02/24] hw: acpi: Export ACPI build
 alignment API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Mon,  5 Nov 2018 02:40:25 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> This is going to be needed by the Hardware-reduced ACPI routines.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
the patch is probably misplaced withing series,
if there is an external user within this series then this patch should
be squashed there, otherwise it doesn't belong to this series.

> ---
>  include/hw/acpi/aml-build.h | 2 ++
>  hw/acpi/aml-build.c         | 8 ++++++++
>  hw/i386/acpi-build.c        | 8 --------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 6c36903c0a..73fc6659f2 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -384,6 +384,8 @@ build_header(BIOSLinker *linker, GArray *table_data,
>               const char *oem_id, const char *oem_table_id);
>  void *acpi_data_push(GArray *table_data, unsigned size);
>  unsigned acpi_data_len(GArray *table);
> +/* Align AML blob size to a multiple of 'align' */
> +void acpi_align_size(GArray *blob, unsigned align);
>  void acpi_add_table(GArray *table_offsets, GArray *table_data);
>  void acpi_build_tables_init(AcpiBuildTables *tables);
>  void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..51b608432f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1565,6 +1565,14 @@ unsigned acpi_data_len(GArray *table)
>      return table->len;
>  }
> =20
> +void acpi_align_size(GArray *blob, unsigned align)
> +{
> +    /* Align size to multiple of given size. This reduces the chance
> +     * we need to change size in the future (breaking cross version migr=
ation).
> +     */
> +    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> +}
> +
>  void acpi_add_table(GArray *table_offsets, GArray *table_data)
>  {
>      uint32_t offset =3D table_data->len;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d0362e1382..81d98fa34f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -282,14 +282,6 @@ static void acpi_get_pci_holes(Range *hole, Range *h=
ole64)
>                                                 NULL));
>  }
> =20
> -static void acpi_align_size(GArray *blob, unsigned align)
> -{
> -    /* Align size to multiple of given size. This reduces the chance
> -     * we need to change size in the future (breaking cross version migr=
ation).
> -     */
> -    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> -}
> -
>  /* FACS */
>  static void
>  build_facs(GArray *table_data, BIOSLinker *linker)
