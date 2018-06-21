Received: from eggs.gnu.org ([2001:4830:134:3::10]:50188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVwXz-0007pu-VT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVwXy-0003Wo-PO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:10:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVwXy-0003WS-FS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:10:34 -0400
Received: by mail-wr0-x242.google.com with SMTP id v13-v6so2523858wrp.13
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:10:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621120056.663f7f25@redhat.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-3-marcandre.lureau@redhat.com>
	<20180621120056.663f7f25@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Jun 2018 12:10:32 +0200
Message-ID: <CAJ+F1CLYvrddKXdVfqa-Jiw-jr2LrxUbznW4Tn6kDK+O3J-M9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/4] acpi: add fw_cfg file for TPM and
 PPI virtual memory device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Jun 21, 2018 at 12:00 PM, Igor Mammedov <imammedo@redhat.com> wrote=
:
> On Tue, 15 May 2018 14:14:31 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> To avoid having to hard code the base address of the PPI virtual
>> memory device we introduce a fw_cfg file etc/tpm/config that holds the
>> base address of the PPI device, the version of the PPI interface and
>> the version of the attached TPM.
> is it related to TPM_PPI_ADDR_BASE added in previous patch?
>
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, document i=
t ]
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/hw/acpi/tpm.h |  3 +++
>>  hw/i386/acpi-build.c  | 17 +++++++++++++++++
>>  docs/specs/tpm.txt    | 20 ++++++++++++++++++++
>>  3 files changed, 40 insertions(+)
>>
>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> index c082df7d1d..f79d68a77a 100644
>> --- a/include/hw/acpi/tpm.h
>> +++ b/include/hw/acpi/tpm.h
>> @@ -193,4 +193,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>>  #define TPM_PPI_ADDR_SIZE           0x400
>>  #define TPM_PPI_ADDR_BASE           0xFED45000
>>
>> +#define TPM_PPI_VERSION_NONE        0
>> +#define TPM_PPI_VERSION_1_30        1
>> +
>>  #endif /* HW_ACPI_TPM_H */
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9bc6d97ea1..f6d447f03a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>>      bool pcihp_bridge_en;
>>  } AcpiBuildPciBusHotplugState;
>>
>> +typedef struct FWCfgTPMConfig {
>> +    uint32_t tpmppi_address;
>> +    uint8_t tpm_version;
>> +    uint8_t tpmppi_version;
>> +} QEMU_PACKED FWCfgTPMConfig;
>> +
>>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>>  {
>>      uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE=
, NULL);
>> @@ -2873,6 +2879,7 @@ void acpi_setup(void)
>>      AcpiBuildTables tables;
>>      AcpiBuildState *build_state;
>>      Object *vmgenid_dev;
>> +    static FWCfgTPMConfig tpm_config;
>>
>>      if (!pcms->fw_cfg) {
>>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>> @@ -2907,6 +2914,16 @@ void acpi_setup(void)
>>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog)=
);
>>
>> +    if (tpm_find()) {
>> +        tpm_config =3D (FWCfgTPMConfig) {
>> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
>> +            .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find())),
>> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
>> +        };
>> +        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
>> +                        &tpm_config, sizeof tpm_config);
>> +    }
> why it's in ACPI part of the code, shouldn't it be a part of device,
> could TPM be used without ACPI at all (-noacpi CLI option)?
>
> Wouldn't adding fwcfg entry unconditionally break migration?

Because of unstable entry IDs? that could be problematic. (especially
during boot time) What do you think Laszlo?

I guess we could have a "ppi" device property, that would imply having
the etc/tpm/config fw_cfg entry. We would enable it by default in
newer machine types (3.0?)

>
>> +
>>      vmgenid_dev =3D find_vmgenid_dev();
>>      if (vmgenid_dev) {
>>          vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
>> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
>> index c230c4c93e..2ddb768084 100644
>> --- a/docs/specs/tpm.txt
>> +++ b/docs/specs/tpm.txt
>> @@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
>>   - hw/tpm/tpm_tis.h
>>
>>
>> +=3D fw_cfg interface =3D
>> +
>> +The bios/firmware may use the "etc/tpm/config" fw_cfg entry for
>> +configuring the guest appropriately.
>> +
>> +The entry of 6 bytes has the following content, in little-endian:
>> +
>> +    #define TPM_VERSION_UNSPEC          0
>> +    #define TPM_VERSION_1_2             1
>> +    #define TPM_VERSION_2_0             2
>> +
>> +    #define TPM_PPI_VERSION_NONE        0
>> +    #define TPM_PPI_VERSION_1_30        1
>> +
>> +    struct FWCfgTPMConfig {
>> +        uint32_t tpmppi_address;         /* PPI memory location */
>> +        uint8_t tpm_version;             /* TPM version */
>> +        uint8_t tpmppi_version;          /* PPI version */
>> +    };
>> +
>>  =3D ACPI Interface =3D
>>
>>  The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT an=
d passes
>
>



--=20
Marc-Andr=C3=A9 Lureau
