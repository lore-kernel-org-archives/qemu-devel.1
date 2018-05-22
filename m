Received: from eggs.gnu.org ([2001:4830:134:3::10]:55569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL3yU-0007nI-HM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL3yR-0002Xf-D8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:52:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fL3yR-0002WN-7T
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:52:55 -0400
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
Date: Tue, 22 May 2018 11:52:43 +0200
MIME-Version: 1.0
In-Reply-To: <ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 05/21/18 13:53, Marcel Apfelbaum wrote:
>=20
>=20
> On 05/20/2018 10:28 AM, Zihan Yang wrote:
>> Currently only q35 host bridge us allocated space in MCFG table. To
>> put pxb host
>> into sepratate pci domain, each of them should have its own
>> configuration space
>> int MCFG table
>>
>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>> ---
>> =C2=A0 hw/i386/acpi-build.c | 83
>> +++++++++++++++++++++++++++++++++++++++-------------
>> =C2=A0 1 file changed, 62 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9bc6d97..808d815 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -89,6 +89,7 @@
>> =C2=A0 typedef struct AcpiMcfgInfo {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mcfg_base;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t mcfg_size;
>> +=C2=A0=C2=A0=C2=A0 struct AcpiMcfgInfo *next;
>> =C2=A0 } AcpiMcfgInfo;
>> =C2=A0 =C2=A0 typedef struct AcpiPmInfo {
>> @@ -2427,14 +2428,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>> *linker, AcpiMcfgInfo *info)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AcpiTableMcfg *mcfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *sig;
>> -=C2=A0=C2=A0=C2=A0 int len =3D sizeof(*mcfg) + 1 * sizeof(mcfg->alloc=
ation[0]);
>> +=C2=A0=C2=A0=C2=A0 int len, count =3D 0;
>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *cfg =3D info;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 while (cfg) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg =3D cfg->next;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 len =3D sizeof(*mcfg) + count * sizeof(mcfg->alloc=
ation[0]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D acpi_data_push(table_data, len=
);
>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].address =3D cpu_to_le64(info->=
mcfg_base);
>> -=C2=A0=C2=A0=C2=A0 /* Only a single allocation so no need to play wit=
h segments */
>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].pci_segment =3D cpu_to_le16(0)=
;
>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].start_bus_number =3D 0;
>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].end_bus_number =3D
>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MCFG is used for ECAM which c=
an be enabled or disabled by
>> guest.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To avoid table size changes (wh=
ich create migration issues),
>> @@ -2448,6 +2450,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>> *linker, AcpiMcfgInfo *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sig =3D "MCFG";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 count =3D 0;
>> +=C2=A0=C2=A0=C2=A0 while (info) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0].=
address =3D
>> cpu_to_le64(info->mcfg_base);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Only a single allocatio=
n so no need to play with segments */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0].=
pci_segment =3D cpu_to_le16(count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0].=
start_bus_number =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count++].allocation[0=
].end_bus_number =3D
>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>=20
> An interesting point is if we want to limit the MMFCG size for PXBs, as
> we may not be
> interested to use all the buses in a specific domain. For each bus we
> require some
> address space that remains unused.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D info->next;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_header(linker, table_data, (void =
*)mcfg, sig, len, 1,
>> NULL, NULL);
>> =C2=A0 }
>> =C2=A0 @@ -2602,26 +2615,52 @@ struct AcpiBuildState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *linker_mr;
>> =C2=A0 } AcpiBuildState;
>> =C2=A0 -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
>> +{
>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *tmp;
>> +=C2=A0=C2=A0=C2=A0 while (mcfg) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D mcfg->next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(mcfg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D tmp;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Object *pci_host;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QObject *o;
>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *head =3D NULL, *tail, *mcfg;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_host =3D acpi_get_i386_pci_h=
ost();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(pci_host);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 o =3D object_property_get_qobject(pci_host,=
 PCIE_HOST_MCFG_BASE,
>> NULL);
>> -=C2=A0=C2=A0=C2=A0 if (!o) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0 while (pci_host) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D g_new0(AcpiMcfgIn=
fo, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg->next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!head) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ta=
il =3D head =3D mcfg;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ta=
il->next =3D mcfg;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ta=
il =3D mcfg;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o =3D object_property_get_=
qobject(pci_host,
>> PCIE_HOST_MCFG_BASE, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!o) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=
eanup_mcfg(head);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
free(mcfg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg->mcfg_base =3D qnum_g=
et_uint(qobject_to(QNum, o));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_unref(o);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o =3D object_property_get_=
qobject(pci_host,
>> PCIE_HOST_MCFG_SIZE, NULL);
>=20
> I'll let Igor to comment on the APCI bits, but the idea of querying eac=
h
> PCI host
> for the MMFCG details and put it into a different table sounds good to =
me.
>=20
> [Adding Laszlo for his insights]

Thanks for the CC -- I don't have many (positive) insights here to
offer, I'm afraid. First, the patch set (including the blurb) doesn't
seem to explain *why* multiple host bridges / ECAM areas are a good
idea. Second, supporting such would take very intrusive patches / large
feature development for OVMF (and that's not just for OvmfPkg and
ArmVirtPkg platform code, but also core MdeModulePkg code).

Obviously I'm not saying this feature should not be implemented for QEMU
+ SeaBIOS, just that don't expect edk2 support for it anytime soon.
Without a convincing use case, even the review impact seems hard to justi=
fy.

Thanks,
Laszlo
