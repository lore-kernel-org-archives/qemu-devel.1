Received: from eggs.gnu.org ([2001:4830:134:3::10]:41176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOuO-00065Q-0d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOuL-0002oF-DC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:12:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXOuL-0002nM-62
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:11:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so1955741wmd.2
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:11:57 -0800 (PST)
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
	<20181212222648.595-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7557dd5c-e3fb-f8b4-6263-547a76fe9b95@redhat.com>
Date: Thu, 13 Dec 2018 12:11:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181212222648.595-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 3/6] acpi: expose TPM/PPI configuration
 parameters to firmware via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, f4bug@amsat.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On 12/12/18 11:26 PM, Marc-André Lureau wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/acpi/tpm.h |  3 +++
>  hw/i386/acpi-build.c  | 19 +++++++++++++++++++
>  docs/specs/tpm.txt    | 19 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
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
> index 236a20eaa8..7b5c67e202 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>      bool pcihp_bridge_en;
>  } AcpiBuildPciBusHotplugState;
>  
> +typedef struct FwCfgTPMConfig {
> +    uint32_t tpmppi_address;
> +    uint8_t tpm_version;
> +    uint8_t tpmppi_version;
> +} QEMU_PACKED FwCfgTPMConfig;
> +
>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -2855,6 +2861,8 @@ void acpi_setup(void)
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
> +    TPMIf *tpm;
> +    static FwCfgTPMConfig tpm_config;
>  
>      if (!pcms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> @@ -2889,6 +2897,17 @@ void acpi_setup(void)
>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog));
>  
> +    tpm = tpm_find();
> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
> +        tpm_config = (FwCfgTPMConfig) {
> +            .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
> +            .tpm_version = tpm_get_version(tpm),
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
> index 1af82bba86..e4bb094700 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -34,6 +34,25 @@ The CRB interface makes a memory mapped IO region in the area 0xfed40000 -
>  QEMU files related to TPM CRB interface:
>   - hw/tpm/tpm_crb.c
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
> +    struct FwCfgTPMConfig {
> +        uint32_t tpmppi_address;         /* PPI memory location */
> +        uint8_t tpm_version;             /* TPM version */
> +        uint8_t tpmppi_version;          /* PPI version */
> +    };
>  
>  = ACPI Interface =
>  
> 
