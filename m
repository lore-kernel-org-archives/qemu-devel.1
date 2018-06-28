Received: from eggs.gnu.org ([2001:4830:134:3::10]:48576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYWdC-00010X-5J
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYWd7-0003zw-5W
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:06:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYWd6-0003zZ-Vo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:06:33 -0400
Date: Thu, 28 Jun 2018 15:06:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180628150630.2ce03743@redhat.com>
In-Reply-To: <CAJ+F1CJMfaC04c7UW31ASWoZYJK8VhfLuPK2qCiAp3TNF0Oitw@mail.gmail.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-4-marcandre.lureau@redhat.com>
	<20180627140129.4a751630@redhat.com>
	<ab5d510e-1308-f581-1e2b-12584391d53c@linux.vnet.ibm.com>
	<20180627162604.2fd0d92c@redhat.com>
	<CAJ+F1CJMfaC04c7UW31ASWoZYJK8VhfLuPK2qCiAp3TNF0Oitw@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 28 Jun 2018 14:42:34 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Wed, Jun 27, 2018 at 4:26 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Wed, 27 Jun 2018 08:59:55 -0400
> > Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> > =20
> >> On 06/27/2018 08:01 AM, Igor Mammedov wrote: =20
> >> > On Tue, 26 Jun 2018 14:23:42 +0200
> >> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> > =20
> >> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >>
> >> >> To avoid having to hard code the base address of the PPI virtual
> >> >> memory device we introduce a fw_cfg file etc/tpm/config that holds =
the
> >> >> base address of the PPI device, the version of the PPI interface and
> >> >> the version of the attached TPM.
> >> >>
> >> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >> [ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, docum=
ent it ]
> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >>
> >> >> ---
> >> >>
> >> >> v4:
> >> >>   - add ACPI only if PPI is enabled
> >> >> v3:
> >> >>   - renamed to etc/tpm/config, made it static, document it
> >> >> ---
> >> >>   include/hw/acpi/tpm.h |  3 +++
> >> >>   hw/i386/acpi-build.c  | 19 +++++++++++++++++++
> >> >>   docs/specs/tpm.txt    | 20 ++++++++++++++++++++
> >> >>   3 files changed, 42 insertions(+)
> >> >>
> >> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> >> index c082df7d1d..f79d68a77a 100644
> >> >> --- a/include/hw/acpi/tpm.h
> >> >> +++ b/include/hw/acpi/tpm.h
> >> >> @@ -193,4 +193,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >> >>   #define TPM_PPI_ADDR_SIZE           0x400
> >> >>   #define TPM_PPI_ADDR_BASE           0xFED45000
> >> >>
> >> >> +#define TPM_PPI_VERSION_NONE        0
> >> >> +#define TPM_PPI_VERSION_1_30        1
> >> >> +
> >> >>   #endif /* HW_ACPI_TPM_H */
> >> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> >> index 9bc6d97ea1..d9320845ed 100644
> >> >> --- a/hw/i386/acpi-build.c
> >> >> +++ b/hw/i386/acpi-build.c
> >> >> @@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
> >> >>       bool pcihp_bridge_en;
> >> >>   } AcpiBuildPciBusHotplugState;
> >> >>
> >> >> +typedef struct FWCfgTPMConfig {
> >> >> +    uint32_t tpmppi_address; =20
> >> > is 32bit enough (what if on ARM or somewhere else area would be abov=
e 4Gb)?
> >> > to be future proof I'd make it 64bit field so we won't have to chang=
e ABI
> >> > later on.
> >> > =20
> >> >> +    uint8_t tpm_version;
> >> >> +    uint8_t tpmppi_version;
> >> >> +} QEMU_PACKED FWCfgTPMConfig;
> >> >> +
> >> >>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
> >> >>   {
> >> >>       uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_I=
O_BASE, NULL);
> >> >> @@ -2873,6 +2879,8 @@ void acpi_setup(void)
> >> >>       AcpiBuildTables tables;
> >> >>       AcpiBuildState *build_state;
> >> >>       Object *vmgenid_dev;
> >> >> +    TPMIf *tpm;
> >> >> +    static FWCfgTPMConfig tpm_config;
> >> >>
> >> >>       if (!pcms->fw_cfg) {
> >> >>           ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
> >> >> @@ -2907,6 +2915,17 @@ void acpi_setup(void) =20
> >> > what about vart-arm machine?
> >> > (it also has some TPM stuff but it doesn't use acpi_setup())
> >> > maybe add common helper and reuse it for both? =20
> >>
> >> I have never used ARM with it. I am not sure whether the firmware on A=
RM
> >> is instrumented to have support for PPI. If someone wanted to enable
> >> that, I would leave these parts up to them.
> >> =20
> >> >
> >> > =20
> >> >>       fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> >> >>                       tables.tcpalog->data, acpi_data_len(tables.tc=
palog));
> >> >>
> >> >> +    tpm =3D tpm_find();
> >> >> +    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error=
_abort)) {
> >> >> +        tpm_config =3D (FWCfgTPMConfig) {
> >> >> +            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
> >> >> +            .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find(=
))), =20
> >> > Have it actually been tested on big endian host? =20
> >>
> >> At some point I did, yes.
> >> =20
> >> > =20
> >> >> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE) =
=20
> >> > ditto
> >> >
> >> > (that's why I don't welcome packed structures in random places) =20
> >>
> >> I thought a packed structure at least ensures that the offsets of the
> >> fields are agreed upon by 32 and 64bit, no ? So the firmware can use 64
> >> bit or 32bit and the offsets would be ensured. =20
> >
> > I think layout for this structure is:
> >   0-3 : tpmppi_address
> >     4 : tpm_version
> >     5 : tpmppi_version
> >
> > but that's not a problem,
> >
> >   unit8_t foo =3D cpu_to_le32(bar)
> >
> > wouldn't it produce different results depending on host endianness? =20
>=20
> My understanding of C conversion from longer int to shorter ones is
> that excessive higher order bits are dropped.
>=20
> I think we could just remove the cpu_to_le32() call.
Yep, that should fix the bug
