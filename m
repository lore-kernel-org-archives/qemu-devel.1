Received: from eggs.gnu.org ([2001:4830:134:3::10]:36289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6zg-0001Cr-1Z
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6zY-0008My-QM
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:04:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX6zW-0008LM-Dy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 11:04:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so18227349wrt.7
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:04:05 -0800 (PST)
References: <20180910083222.8245-1-marcandre.lureau@redhat.com>
	<20180910083222.8245-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2554dcc-2f42-a154-5680-45f31726ae90@redhat.com>
Date: Wed, 12 Dec 2018 17:04:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180910083222.8245-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 4/6] acpi: expose TPM/PPI configuration
 parameters to firmware via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Cc'ing Laszlo

On 9/10/18 10:32 AM, Marc-André Lureau wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> To avoid having to hard code the base address of the PPI virtual
> memory device we introduce a fw_cfg file etc/tpm/config that holds the
> base address of the PPI device, the version of the PPI interface and
> the version of the attached TPM.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> [ Marc-André: renamed to etc/tpm/config, made it static, document it ]
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/acpi/tpm.h |  3 +++
>  hw/i386/acpi-build.c  | 19 +++++++++++++++++++
>  docs/specs/tpm.txt    | 20 ++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index b8796df916..a6109a97fc 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -194,4 +194,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_PPI_ADDR_SIZE           0x400
>  #define TPM_PPI_ADDR_BASE           0xFED45000
>  
> +#define TPM_PPI_VERSION_NONE        0
> +#define TPM_PPI_VERSION_1_30        1
> +
>  #endif /* HW_ACPI_TPM_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e1ee8ae9e0..c24f68df02 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>      bool pcihp_bridge_en;
>  } AcpiBuildPciBusHotplugState;
>  
> +typedef struct FWCfgTPMConfig {

FwCfgTPMConfig (lowercase 'w')

> +    uint32_t tpmppi_address;
> +    uint8_t tpm_version;
> +    uint8_t tpmppi_version;
> +} QEMU_PACKED FWCfgTPMConfig;
> +
>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -2877,6 +2883,8 @@ void acpi_setup(void)
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
> +    TPMIf *tpm;
> +    static FWCfgTPMConfig tpm_config;
>  
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> @@ -2911,6 +2919,17 @@ void acpi_setup(void)
>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog));
>  
> +    tpm = tpm_find();
> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
> +        tpm_config = (FWCfgTPMConfig) {
> +            .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
> +            .tpm_version = tpm_get_version(tpm_find()),

               .tpm_version = tpm_get_version(tpm),

> +            .tpmppi_version = TPM_PPI_VERSION_NONE
> +        };
> +        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
> +                        &tpm_config, sizeof tpm_config);
> +    }
> +
>      vmgenid_dev = find_vmgenid_dev();
>      if (vmgenid_dev) {
>          vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 0e9bbebe1d..a5bdd5f26e 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
>   - hw/tpm/tpm_tis.h
>  
>  
> += fw_cfg interface =
> +
> +The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
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
>  = ACPI Interface =
>  
>  The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and passes
> 
