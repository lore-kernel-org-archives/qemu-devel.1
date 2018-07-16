Received: from eggs.gnu.org ([2001:4830:134:3::10]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff4mM-0003iw-47
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff4mJ-0002qO-0l
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:47:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ff4mI-0002qC-RB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:47:06 -0400
Date: Mon, 16 Jul 2018 16:46:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716164659.1ea4b342@redhat.com>
In-Reply-To: <20180716125948.11666-4-marcandre.lureau@redhat.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 3/5] acpi: add fw_cfg file for TPM and
 PPI virtual memory device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S.
	Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 16 Jul 2018 14:59:46 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> To avoid having to hard code the base address of the PPI virtual
> memory device we introduce a fw_cfg file etc/tpm/config that holds the
> base address of the PPI device, the version of the PPI interface and
> the version of the attached TPM.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, document it=
 ]
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/acpi/tpm.h |  3 +++
>  hw/i386/acpi-build.c  | 19 +++++++++++++++++++
>  docs/specs/tpm.txt    | 20 ++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index b8796df916..a6109a97fc 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -194,4 +194,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_PPI_ADDR_SIZE           0x400
>  #define TPM_PPI_ADDR_BASE           0xFED45000
> =20
> +#define TPM_PPI_VERSION_NONE        0
> +#define TPM_PPI_VERSION_1_30        1
> +
>  #endif /* HW_ACPI_TPM_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9e8350c55d..b19575681b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>      bool pcihp_bridge_en;
>  } AcpiBuildPciBusHotplugState;
> =20
> +typedef struct FWCfgTPMConfig {
> +    uint32_t tpmppi_address;
> +    uint8_t tpm_version;
> +    uint8_t tpmppi_version;
> +} QEMU_PACKED FWCfgTPMConfig;
> +
>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE,=
 NULL);
> @@ -2873,6 +2879,8 @@ void acpi_setup(void)
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
> +    TPMIf *tpm;
> +    static FWCfgTPMConfig tpm_config;
> =20
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> @@ -2907,6 +2915,17 @@ void acpi_setup(void)
>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog));
> =20
> +    tpm =3D tpm_find();
> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort=
)) {
> +        tpm_config =3D (FWCfgTPMConfig) {
> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
> +            .tpm_version =3D tpm_get_version(tpm_find()),
> +            .tpmppi_version =3D TPM_PPI_VERSION_NONE
> +        };
> +        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
> +                        &tpm_config, sizeof tpm_config);
> +    }
> +
>      vmgenid_dev =3D find_vmgenid_dev();
>      if (vmgenid_dev) {
>          vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 0e9bbebe1d..de3f8bda56 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
>   - hw/tpm/tpm_tis.h
> =20
> =20
> +=3D fw_cfg interface =3D
> +
> +The bios/firmware may use the "etc/tpm/config" fw_cfg entry for
s/use/read/ to make clear fw may not write into it contract

> +configuring the guest appropriately.
> +
> +The entry of 6 bytes has the following content, in little-endian:
> +
> +    #define TPM_VERSION_UNSPEC          0
> +    #define TPM_VERSION_1_2             1
> +    #define TPM_VERSION_2_0             2
> +
> +    #define TPM_PPI_VERSION_NONE        0
> +    #define TPM_PPI_VERSION_1_30        1
> +
> +    struct FWCfgTPMConfig {
> +        uint32_t tpmppi_address;         /* PPI memory location */
> +        uint8_t tpm_version;             /* TPM version */
> +        uint8_t tpmppi_version;          /* PPI version */
> +    };
> +
>  =3D ACPI Interface =3D
> =20
>  The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and=
 passes
