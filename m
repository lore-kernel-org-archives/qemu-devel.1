Received: from eggs.gnu.org ([2001:4830:134:3::10]:46458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBOi-0004xg-AQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBOd-0001yL-5J
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:26:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYBOd-0001xd-0R
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:26:11 -0400
Date: Wed, 27 Jun 2018 16:26:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627162604.2fd0d92c@redhat.com>
In-Reply-To: <ab5d510e-1308-f581-1e2b-12584391d53c@linux.vnet.ibm.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-4-marcandre.lureau@redhat.com>
	<20180627140129.4a751630@redhat.com>
	<ab5d510e-1308-f581-1e2b-12584391d53c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 27 Jun 2018 08:59:55 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 06/27/2018 08:01 AM, Igor Mammedov wrote:
> > On Tue, 26 Jun 2018 14:23:42 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> To avoid having to hard code the base address of the PPI virtual
> >> memory device we introduce a fw_cfg file etc/tpm/config that holds the
> >> base address of the PPI device, the version of the PPI interface and
> >> the version of the attached TPM.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, document=
 it ]
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> ---
> >>
> >> v4:
> >>   - add ACPI only if PPI is enabled
> >> v3:
> >>   - renamed to etc/tpm/config, made it static, document it
> >> ---
> >>   include/hw/acpi/tpm.h |  3 +++
> >>   hw/i386/acpi-build.c  | 19 +++++++++++++++++++
> >>   docs/specs/tpm.txt    | 20 ++++++++++++++++++++
> >>   3 files changed, 42 insertions(+)
> >>
> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> index c082df7d1d..f79d68a77a 100644
> >> --- a/include/hw/acpi/tpm.h
> >> +++ b/include/hw/acpi/tpm.h
> >> @@ -193,4 +193,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >>   #define TPM_PPI_ADDR_SIZE           0x400
> >>   #define TPM_PPI_ADDR_BASE           0xFED45000
> >>  =20
> >> +#define TPM_PPI_VERSION_NONE        0
> >> +#define TPM_PPI_VERSION_1_30        1
> >> +
> >>   #endif /* HW_ACPI_TPM_H */
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 9bc6d97ea1..d9320845ed 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
> >>       bool pcihp_bridge_en;
> >>   } AcpiBuildPciBusHotplugState;
> >>  =20
> >> +typedef struct FWCfgTPMConfig {
> >> +    uint32_t tpmppi_address; =20
> > is 32bit enough (what if on ARM or somewhere else area would be above 4=
Gb)?
> > to be future proof I'd make it 64bit field so we won't have to change A=
BI
> > later on.
> > =20
> >> +    uint8_t tpm_version;
> >> +    uint8_t tpmppi_version;
> >> +} QEMU_PACKED FWCfgTPMConfig;
> >> +
> >>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
> >>   {
> >>       uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_B=
ASE, NULL);
> >> @@ -2873,6 +2879,8 @@ void acpi_setup(void)
> >>       AcpiBuildTables tables;
> >>       AcpiBuildState *build_state;
> >>       Object *vmgenid_dev;
> >> +    TPMIf *tpm;
> >> +    static FWCfgTPMConfig tpm_config;
> >>  =20
> >>       if (!pcms->fw_cfg) {
> >>           ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> >> @@ -2907,6 +2915,17 @@ void acpi_setup(void) =20
> > what about vart-arm machine?
> > (it also has some TPM stuff but it doesn't use acpi_setup())
> > maybe add common helper and reuse it for both? =20
>=20
> I have never used ARM with it. I am not sure whether the firmware on ARM=
=20
> is instrumented to have support for PPI. If someone wanted to enable=20
> that, I would leave these parts up to them.
>=20
> >
> > =20
> >>       fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> >>                       tables.tcpalog->data, acpi_data_len(tables.tcpal=
og));
> >>  =20
> >> +    tpm =3D tpm_find();
> >> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_ab=
ort)) {
> >> +        tpm_config =3D (FWCfgTPMConfig) {
> >> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
> >> +            .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find()))=
, =20
> > Have it actually been tested on big endian host? =20
>=20
> At some point I did, yes.
>=20
> > =20
> >> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE) =20
> > ditto
> >
> > (that's why I don't welcome packed structures in random places) =20
>=20
> I thought a packed structure at least ensures that the offsets of the=20
> fields are agreed upon by 32 and 64bit, no ? So the firmware can use 64=20
> bit or 32bit and the offsets would be ensured.

I think layout for this structure is:
  0-3 : tpmppi_address
    4 : tpm_version
    5 : tpmppi_version

but that's not a problem,

  unit8_t foo =3D cpu_to_le32(bar)

wouldn't it produce different results depending on host endianness?

>=20
> >
> > how about adding unit-tests to series to make sure that it works
> > across different hosts that travis builds on and that thing won't
> > fall apart in future? =20
>=20
> >> +        };
> >> +        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
> >> +                        &tpm_config, sizeof tpm_config);
> >> +    }
> >> +
> >>       vmgenid_dev =3D find_vmgenid_dev();
> >>       if (vmgenid_dev) {
> >>           vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> >> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> >> index c230c4c93e..2ddb768084 100644
> >> --- a/docs/specs/tpm.txt
> >> +++ b/docs/specs/tpm.txt
> >> @@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
> >>    - hw/tpm/tpm_tis.h
> >>  =20
> >>  =20
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
> >>   =3D ACPI Interface =3D
> >>  =20
> >>   The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT=
 and passes =20
>=20
>=20
