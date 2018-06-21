Received: from eggs.gnu.org ([2001:4830:134:3::10]:49638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fW03T-0007QT-Hw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fW03Q-0008DS-F7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:55:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fW03Q-0008DC-9L
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:55:16 -0400
Date: Thu, 21 Jun 2018 15:55:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180621155511.1fe61df5@redhat.com>
In-Reply-To: <CAJ+F1CLYvrddKXdVfqa-Jiw-jr2LrxUbznW4Tn6kDK+O3J-M9Q@mail.gmail.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-3-marcandre.lureau@redhat.com>
	<20180621120056.663f7f25@redhat.com>
	<CAJ+F1CLYvrddKXdVfqa-Jiw-jr2LrxUbznW4Tn6kDK+O3J-M9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Jun 2018 12:10:32 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Jun 21, 2018 at 12:00 PM, Igor Mammedov <imammedo@redhat.com> wro=
te:
> > On Tue, 15 May 2018 14:14:31 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> To avoid having to hard code the base address of the PPI virtual
> >> memory device we introduce a fw_cfg file etc/tpm/config that holds the
> >> base address of the PPI device, the version of the PPI interface and
> >> the version of the attached TPM. =20
> > is it related to TPM_PPI_ADDR_BASE added in previous patch?
> > =20
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, document=
 it ]
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  include/hw/acpi/tpm.h |  3 +++
> >>  hw/i386/acpi-build.c  | 17 +++++++++++++++++
> >>  docs/specs/tpm.txt    | 20 ++++++++++++++++++++
> >>  3 files changed, 40 insertions(+)
> >>
> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> index c082df7d1d..f79d68a77a 100644
> >> --- a/include/hw/acpi/tpm.h
> >> +++ b/include/hw/acpi/tpm.h
> >> @@ -193,4 +193,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >>  #define TPM_PPI_ADDR_SIZE           0x400
> >>  #define TPM_PPI_ADDR_BASE           0xFED45000
> >>
> >> +#define TPM_PPI_VERSION_NONE        0
> >> +#define TPM_PPI_VERSION_1_30        1
> >> +
> >>  #endif /* HW_ACPI_TPM_H */
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 9bc6d97ea1..f6d447f03a 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
> >>      bool pcihp_bridge_en;
> >>  } AcpiBuildPciBusHotplugState;
> >>
> >> +typedef struct FWCfgTPMConfig {
> >> +    uint32_t tpmppi_address;
> >> +    uint8_t tpm_version;
> >> +    uint8_t tpmppi_version;
> >> +} QEMU_PACKED FWCfgTPMConfig;
> >> +
> >>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
> >>  {
> >>      uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BA=
SE, NULL);
> >> @@ -2873,6 +2879,7 @@ void acpi_setup(void)
> >>      AcpiBuildTables tables;
> >>      AcpiBuildState *build_state;
> >>      Object *vmgenid_dev;
> >> +    static FWCfgTPMConfig tpm_config;
> >>
> >>      if (!pcms->fw_cfg) {
> >>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> >> @@ -2907,6 +2914,16 @@ void acpi_setup(void)
> >>      fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> >>                      tables.tcpalog->data, acpi_data_len(tables.tcpalo=
g));
> >>
> >> +    if (tpm_find()) {
> >> +        tpm_config =3D (FWCfgTPMConfig) {
> >> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
> >> +            .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find())),
> >> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
> >> +        };
> >> +        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
> >> +                        &tpm_config, sizeof tpm_config);
> >> +    } =20
> > why it's in ACPI part of the code, shouldn't it be a part of device,
> > could TPM be used without ACPI at all (-noacpi CLI option)?
> >
> > Wouldn't adding fwcfg entry unconditionally break migration? =20
>=20
> Because of unstable entry IDs? that could be problematic. (especially
> during boot time) What do you think Laszlo?
>=20
> I guess we could have a "ppi" device property, that would imply having
> the etc/tpm/config fw_cfg entry. We would enable it by default in
> newer machine types (3.0?)
yep, something like this.
usual practice is to enable it by default and disable it for old
machine types using hw compat props (include/hw/compat.h)

>=20
> > =20
> >> +
> >>      vmgenid_dev =3D find_vmgenid_dev();
> >>      if (vmgenid_dev) {
> >>          vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> >> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> >> index c230c4c93e..2ddb768084 100644
> >> --- a/docs/specs/tpm.txt
> >> +++ b/docs/specs/tpm.txt
> >> @@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
> >>   - hw/tpm/tpm_tis.h
> >>
> >>
> >> +=3D fw_cfg interface =3D
> >> +
> >> +The bios/firmware may use the "etc/tpm/config" fw_cfg entry for
> >> +configuring the guest appropriately.
> >> +
> >> +The entry of 6 bytes has the following content, in little-endian:
> >> +
> >> +    #define TPM_VERSION_UNSPEC          0
> >> +    #define TPM_VERSION_1_2             1
> >> +    #define TPM_VERSION_2_0             2
> >> +
> >> +    #define TPM_PPI_VERSION_NONE        0
> >> +    #define TPM_PPI_VERSION_1_30        1
> >> +
> >> +    struct FWCfgTPMConfig {
> >> +        uint32_t tpmppi_address;         /* PPI memory location */
> >> +        uint8_t tpm_version;             /* TPM version */
> >> +        uint8_t tpmppi_version;          /* PPI version */
> >> +    };
> >> +
> >>  =3D ACPI Interface =3D
> >>
> >>  The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT =
and passes =20
> >
> > =20
>=20
>=20
>=20
