Received: from eggs.gnu.org ([2001:4830:134:3::10]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSOSo-0002ST-UD
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSOSn-0003Ga-W6
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:38:18 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSOSn-0003Fv-PM
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:38:17 -0500
Received: by mail-wm0-x241.google.com with SMTP id i11so21976526wmf.4
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 06:38:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513953351-22002-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513953351-22002-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 15:38:15 +0100
Message-ID: <CAJ+F1CK=s8BD=qFyWLg_GJNDR7xdpRcJvMQ6xuooc9JqBOWQPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] acpi: Update TPM2 ACPI table to more
 recent specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com>

On Fri, Dec 22, 2017 at 3:35 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> From: Stefan Berger <Stefan Berger stefanb@linux.vnet.ibm.com>
>
> More recent specs of the TPM2 ACPI table add fields for the log area
> start address and the log area minimum size, which we already use
> for the TCPA table.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

I think ACPI tables change shouldn't fail migration, since tables are
loaded by firmware,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/i386/acpi-build.c        | 19 ++++++++++++++-----
>  include/hw/acpi/acpi-defs.h |  7 +++++--
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5a6dee0..18b939e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2274,16 +2274,25 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *li=
nker, GArray *tcpalog)
>  }
>
>  static void
> -build_tpm2(GArray *table_data, BIOSLinker *linker)
> +build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  {
> -    Acpi20TPM2 *tpm2_ptr;
> -
> -    tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr);
> +    Acpi20TPM2 *tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr=
);
> +    unsigned log_addr_size =3D sizeof(tpm2_ptr->log_area_start_address);
> +    unsigned log_addr_offset =3D
> +        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>
>      tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
>      if (TPM_IS_TIS(tpm_find())) {
>          tpm2_ptr->control_area_address =3D cpu_to_le64(0);
>          tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
> +
> +        tpm2_ptr->log_area_minimum_length =3D
> +            cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +
> +        /* log area start address to be filled by Guest linker */
> +        bios_linker_loader_add_pointer(linker,
> +            ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
> +            ACPI_BUILD_TPMLOG_FILE, 0);
>      } else {
>          g_warn_if_reached();
>      }
> @@ -2695,7 +2704,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
>
>          if (misc.tpm_version =3D=3D TPM_VERSION_2_0) {
>              acpi_add_table(table_offsets, tables_blob);
> -            build_tpm2(tables_blob, tables->linker);
> +            build_tpm2(tables_blob, tables->linker, tables->tcpalog);
>          }
>      }
>      if (pcms->numa_nodes) {
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 72be675..80c8099 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -558,8 +558,8 @@ typedef struct Acpi20Tcpa Acpi20Tcpa;
>  /*
>   * TPM2
>   *
> - * Following Level 00, Rev 00.37 of specs:
> - * http://www.trustedcomputinggroup.org/resources/tcg_acpi_specification
> + * Following Version 1.2, Revision 8 of specs:
> + * https://trustedcomputinggroup.org/tcg-acpi-specification/
>   */
>  struct Acpi20TPM2 {
>      ACPI_TABLE_HEADER_DEF
> @@ -567,6 +567,9 @@ struct Acpi20TPM2 {
>      uint16_t reserved;
>      uint64_t control_area_address;
>      uint32_t start_method;
> +    uint8_t start_method_params[12];
> +    uint32_t log_area_minimum_length;
> +    uint64_t log_area_start_address;
>  } QEMU_PACKED;
>  typedef struct Acpi20TPM2 Acpi20TPM2;
>
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
