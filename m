Received: from eggs.gnu.org ([2001:4830:134:3::10]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1zAs-000469-1T
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1zAm-00065P-V9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1zAm-00064P-MJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:22:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AIKfXD129129
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:22:29 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2mx31km-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:22:28 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:22:28 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-41-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:22:23 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-41-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <88ca396e-a976-8abf-f5ab-f5208e0c93f4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 40/42] acpi: change TPM TIS data conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> The device should be exposed if present. It shouldn't have an
> undefined version (or else backend init failed, and device should fail
> too). Finally, make the fields specific to TIS device model.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm.h |  3 +++
>   hw/i386/acpi-build.c | 12 ++++++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 9439330cf1..8223ec621c 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -47,6 +47,9 @@ void tpm_cleanup(void);
>  =20
>   #define TYPE_TPM_TIS                "tpm-tis"
>  =20
> +#define TPM_IS_TIS(chr)                             \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
> +
>   static inline TPMIf *tpm_find(void)
>   {
>       Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 40371b6f75..ee38b00e31 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2038,7 +2038,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>           }
>       }
>  =20
> -    if (misc->tpm_version !=3D TPM_VERSION_UNSPEC) {
> +    if (TPM_IS_TIS(tpm_find())) {
>           aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                      TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>       }
> @@ -2204,7 +2204,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>               /* Scan all PCI buses. Generate tables to support hotplug=
. */
>               build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge=
_en);
>  =20
> -            if (misc->tpm_version !=3D TPM_VERSION_UNSPEC) {
> +            if (TPM_IS_TIS(tpm_find())) {
>                   dev =3D aml_device("ISA.TPM");
>                   aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP=
0C31")));
>                   aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> @@ -2281,8 +2281,12 @@ build_tpm2(GArray *table_data, BIOSLinker *linke=
r)
>       tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr);
>  =20
>       tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    tpm2_ptr->control_area_address =3D cpu_to_le64(0);
> -    tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
> +    if (TPM_IS_TIS(tpm_find())) {
> +        tpm2_ptr->control_area_address =3D cpu_to_le64(0);
> +        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO)=
;
> +    } else {
> +        g_warn_if_reached();
> +    }
>  =20
>       build_header(linker, table_data,
>                    (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL=
, NULL);
