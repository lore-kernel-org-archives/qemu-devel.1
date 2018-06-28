Received: from eggs.gnu.org ([2001:4830:134:3::10]:43121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYWFy-0007at-0Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYWFw-0003bH-Po
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:38 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fYWFw-0003al-GZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:42:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id z13-v6so8911259wma.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:42:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627162604.2fd0d92c@redhat.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-4-marcandre.lureau@redhat.com>
	<20180627140129.4a751630@redhat.com>
	<ab5d510e-1308-f581-1e2b-12584391d53c@linux.vnet.ibm.com>
	<20180627162604.2fd0d92c@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 28 Jun 2018 14:42:34 +0200
Message-ID: <CAJ+F1CJMfaC04c7UW31ASWoZYJK8VhfLuPK2qCiAp3TNF0Oitw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/4] acpi: add fw_cfg file for TPM and
 PPI virtual memory device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Wed, Jun 27, 2018 at 4:26 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Wed, 27 Jun 2018 08:59:55 -0400
> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
>> On 06/27/2018 08:01 AM, Igor Mammedov wrote:
>> > On Tue, 26 Jun 2018 14:23:42 +0200
>> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>> >
>> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> >>
>> >> To avoid having to hard code the base address of the PPI virtual
>> >> memory device we introduce a fw_cfg file etc/tpm/config that holds th=
e
>> >> base address of the PPI device, the version of the PPI interface and
>> >> the version of the attached TPM.
>> >>
>> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> >> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, documen=
t it ]
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >>
>> >> ---
>> >>
>> >> v4:
>> >>   - add ACPI only if PPI is enabled
>> >> v3:
>> >>   - renamed to etc/tpm/config, made it static, document it
>> >> ---
>> >>   include/hw/acpi/tpm.h |  3 +++
>> >>   hw/i386/acpi-build.c  | 19 +++++++++++++++++++
>> >>   docs/specs/tpm.txt    | 20 ++++++++++++++++++++
>> >>   3 files changed, 42 insertions(+)
>> >>
>> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> >> index c082df7d1d..f79d68a77a 100644
>> >> --- a/include/hw/acpi/tpm.h
>> >> +++ b/include/hw/acpi/tpm.h
>> >> @@ -193,4 +193,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>> >>   #define TPM_PPI_ADDR_SIZE           0x400
>> >>   #define TPM_PPI_ADDR_BASE           0xFED45000
>> >>
>> >> +#define TPM_PPI_VERSION_NONE        0
>> >> +#define TPM_PPI_VERSION_1_30        1
>> >> +
>> >>   #endif /* HW_ACPI_TPM_H */
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> >> index 9bc6d97ea1..d9320845ed 100644
>> >> --- a/hw/i386/acpi-build.c
>> >> +++ b/hw/i386/acpi-build.c
>> >> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
>> >>       bool pcihp_bridge_en;
>> >>   } AcpiBuildPciBusHotplugState;
>> >>
>> >> +typedef struct FWCfgTPMConfig {
>> >> +    uint32_t tpmppi_address;
>> > is 32bit enough (what if on ARM or somewhere else area would be above =
4Gb)?
>> > to be future proof I'd make it 64bit field so we won't have to change =
ABI
>> > later on.
>> >
>> >> +    uint8_t tpm_version;
>> >> +    uint8_t tpmppi_version;
>> >> +} QEMU_PACKED FWCfgTPMConfig;
>> >> +
>> >>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>> >>   {
>> >>       uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_=
BASE, NULL);
>> >> @@ -2873,6 +2879,8 @@ void acpi_setup(void)
>> >>       AcpiBuildTables tables;
>> >>       AcpiBuildState *build_state;
>> >>       Object *vmgenid_dev;
>> >> +    TPMIf *tpm;
>> >> +    static FWCfgTPMConfig tpm_config;
>> >>
>> >>       if (!pcms->fw_cfg) {
>> >>           ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>> >> @@ -2907,6 +2915,17 @@ void acpi_setup(void)
>> > what about vart-arm machine?
>> > (it also has some TPM stuff but it doesn't use acpi_setup())
>> > maybe add common helper and reuse it for both?
>>
>> I have never used ARM with it. I am not sure whether the firmware on ARM
>> is instrumented to have support for PPI. If someone wanted to enable
>> that, I would leave these parts up to them.
>>
>> >
>> >
>> >>       fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>> >>                       tables.tcpalog->data, acpi_data_len(tables.tcpa=
log));
>> >>
>> >> +    tpm =3D tpm_find();
>> >> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_a=
bort)) {
>> >> +        tpm_config =3D (FWCfgTPMConfig) {
>> >> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
>> >> +            .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find())=
),
>> > Have it actually been tested on big endian host?
>>
>> At some point I did, yes.
>>
>> >
>> >> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
>> > ditto
>> >
>> > (that's why I don't welcome packed structures in random places)
>>
>> I thought a packed structure at least ensures that the offsets of the
>> fields are agreed upon by 32 and 64bit, no ? So the firmware can use 64
>> bit or 32bit and the offsets would be ensured.
>
> I think layout for this structure is:
>   0-3 : tpmppi_address
>     4 : tpm_version
>     5 : tpmppi_version
>
> but that's not a problem,
>
>   unit8_t foo =3D cpu_to_le32(bar)
>
> wouldn't it produce different results depending on host endianness?

My understanding of C conversion from longer int to shorter ones is
that excessive higher order bits are dropped.

I think we could just remove the cpu_to_le32() call.
