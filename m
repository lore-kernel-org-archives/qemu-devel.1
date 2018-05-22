Received: from eggs.gnu.org ([2001:4830:134:3::10]:39529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLDK7-0004FE-IT
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLDK3-0001os-J8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:51:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fLDK3-0001ok-Dh
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:51:51 -0400
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
Date: Tue, 22 May 2018 21:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 05/22/18 21:01, Marcel Apfelbaum wrote:
> Hi Laszlo,
>=20
> On 05/22/2018 12:52 PM, Laszlo Ersek wrote:
>> On 05/21/18 13:53, Marcel Apfelbaum wrote:
>>>
>>> On 05/20/2018 10:28 AM, Zihan Yang wrote:
>>>> Currently only q35 host bridge us allocated space in MCFG table. To
>>>> put pxb host
>>>> into sepratate pci domain, each of them should have its own
>>>> configuration space
>>>> int MCFG table
>>>>
>>>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>>>> ---
>>>> =C2=A0=C2=A0 hw/i386/acpi-build.c | 83
>>>> +++++++++++++++++++++++++++++++++++++++-------------
>>>> =C2=A0=C2=A0 1 file changed, 62 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 9bc6d97..808d815 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -89,6 +89,7 @@
>>>> =C2=A0=C2=A0 typedef struct AcpiMcfgInfo {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mcfg_base;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t mcfg_size;
>>>> +=C2=A0=C2=A0=C2=A0 struct AcpiMcfgInfo *next;
>>>> =C2=A0=C2=A0 } AcpiMcfgInfo;
>>>> =C2=A0=C2=A0 =C2=A0 typedef struct AcpiPmInfo {
>>>> @@ -2427,14 +2428,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinke=
r
>>>> *linker, AcpiMcfgInfo *info)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AcpiTableMcfg *mcfg;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *sig;
>>>> -=C2=A0=C2=A0=C2=A0 int len =3D sizeof(*mcfg) + 1 * sizeof(mcfg->all=
ocation[0]);
>>>> +=C2=A0=C2=A0=C2=A0 int len, count =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *cfg =3D info;
>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 while (cfg) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg =3D cfg->next;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 len =3D sizeof(*mcfg) + count * sizeof(mcfg->all=
ocation[0]);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D acpi_data_push(table_d=
ata, len);
>>>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].address =3D cpu_to_le64(info=
->mcfg_base);
>>>> -=C2=A0=C2=A0=C2=A0 /* Only a single allocation so no need to play w=
ith segments */
>>>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].pci_segment =3D cpu_to_le16(=
0);
>>>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].start_bus_number =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0 mcfg->allocation[0].end_bus_number =3D
>>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MCFG is used for ECAM=
 which can be enabled or disabled by
>>>> guest.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To avoid table size cha=
nges (which create migration issues),
>>>> @@ -2448,6 +2450,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>>>> *linker, AcpiMcfgInfo *info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sig =3D=
 "MCFG";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 count =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 while (info) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0=
].address =3D
>>>> cpu_to_le64(info->mcfg_base);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Only a single allocat=
ion so no need to play with
>>>> segments */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0=
].pci_segment =3D cpu_to_le16(count);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count].allocation[0=
].start_bus_number =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg[count++].allocation=
[0].end_bus_number =3D
>>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>>> An interesting point is if we want to limit the MMFCG size for PXBs, =
as
>>> we may not be
>>> interested to use all the buses in a specific domain. For each bus we
>>> require some
>>> address space that remains unused.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D info->next;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_header(linker, table_data=
, (void *)mcfg, sig, len, 1,
>>>> NULL, NULL);
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -2602,26 +2615,52 @@ struct AcpiBuildState {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *linker_mr;
>>>> =C2=A0=C2=A0 } AcpiBuildState;
>>>> =C2=A0=C2=A0 -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>>>> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *tmp;
>>>> +=C2=A0=C2=A0=C2=A0 while (mcfg) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D mcfg->next;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(mcfg);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D tmp;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +}
>>>> +
>>>> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Object *pci_host;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QObject *o;
>>>> +=C2=A0=C2=A0=C2=A0 AcpiMcfgInfo *head =3D NULL, *tail, *mcfg;
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_host =3D acpi_get_i3=
86_pci_host();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(pci_host);
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 o =3D object_property_get_qobject(p=
ci_host, PCIE_HOST_MCFG_BASE,
>>>> NULL);
>>>> -=C2=A0=C2=A0=C2=A0 if (!o) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>> +=C2=A0=C2=A0=C2=A0 while (pci_host) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg =3D g_new0(AcpiMcfg=
Info, 1);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg->next =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!head) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tail =3D head =3D mcfg;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tail->next =3D mcfg;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tail =3D mcfg;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o =3D object_property_ge=
t_qobject(pci_host,
>>>> PCIE_HOST_MCFG_BASE, NULL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!o) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cleanup_mcfg(head);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
g_free(mcfg);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcfg->mcfg_base =3D qnum=
_get_uint(qobject_to(QNum, o));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_unref(o);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o =3D object_property_ge=
t_qobject(pci_host,
>>>> PCIE_HOST_MCFG_SIZE, NULL);
>>> I'll let Igor to comment on the APCI bits, but the idea of querying e=
ach
>>> PCI host
>>> for the MMFCG details and put it into a different table sounds good
>>> to me.
>>>
>>> [Adding Laszlo for his insights]
>> Thanks for the CC -- I don't have many (positive) insights here to
>> offer, I'm afraid. First, the patch set (including the blurb) doesn't
>> seem to explain *why* multiple host bridges / ECAM areas are a good
>> idea.
>=20
> The issue we want to solve is the hard limitation of 256 PCIe devices
> that can be used in a Q35 machine.

Implying that there are use cases for which ~256 PCIe devices aren't
enough. I remain unconvinced until proved wrong :)

Anyway, a significant source of waste comes from the restriction that we
can only put 1 device (with up to 8 functions) on each non-root-complex
PCI Express bus (such as root ports and downstream ports). This forfeits
a huge portion of the ECAM area (about 31/32th) that we already have.
Rather than spending more MMIO guest-phys address range on new
discontiguous ECAM ranges, I'd prefer if we could look into ARI. I seem
to recall from your earlier presentation that ARI could recover that
lost address space (meaning both ECAM ranges and PCIe B/D/F address space=
).

There are signs that the edk2 core supports ARI if the underlying
platform supports it. (Which is not the case with multiple PCIe domains
/ multiple ECAM ranges.)

ARI support could also help aarch64/virt. Eric (CC'd) has been working
on raising the max PCIe bus count from *16* to 256 for aarch64/virt, and
AFAIR one of the challenges there has been finding a good spot for the
larger ECAM in guest-phys address space. Fiddling with such address maps
is always a pain.

Back to x86, the guest-phys address space is quite crowded too. The
32-bit PCI MMIO aperture (with the neighboring ECAM and platform MMIO
areas such as LAPIC, IO-APIC, HPET, TPM, pflash, ...) is always a scarce
resource. Plus, reaching agreement between OVMF and QEMU on the exact
location of the 32-bit PCI MMIO aperture has always been a huge pain; so
you'd likely shoot for 64-bit.

But 64-bit is ill-partitioned and/or crowded too: first you have the
cold-plugged >4GB DRAM (whose size the firmware can interrogate), then
the hotplug DIMM area up to "etc/reserved-memory-end" (ditto), then the
64-bit PCI MMIO aperture (whose size the firmware decides itself,
because QEMU cannot be asked about it presently). Placing the additional
MMCFGs somewhere would need extending the total order between these
things at the design level, more fw_cfg files, more sanity checks in
platform code in the firmware, and, quite importantly, adding support to
multiple discontiguous MMCFGs to core edk2 code.

I don't know much about ARI but it already looks a whole lot more
attractive to me.

> We can use "PCI functions" to increase
> the number, but then we loose the hot-plugging granularity.
>=20
> Currently pxb-pcie host bridges share the same PCI domain (0)
> bus numbers, so adding more of them will not result in more usable
> devices (each PCIe device resides on its own bus),
> but putting each of them on a different domain removes
> that limitation.
>=20
> Another possible use (there is a good chance I am wrong, adding Alex to
> correct me),
> may be the "modeling" of a multi-function assigned device.
> Currently all the functions of an assigneddevice will be placed on
> different PCIe
> Root Ports "loosing" the connection between them.
>=20
> However, if we put all the functions of the same assigned device in the
> same
> PCI domain we may be able to "re-connect" them.

OK -- why is that useful? What's the current practical problem with the
splitting you describe?

>> =C2=A0 Second, supporting such would take very intrusive patches / lar=
ge
>> feature development for OVMF (and that's not just for OvmfPkg and
>> ArmVirtPkg platform code, but also core MdeModulePkg code).
>>
>> Obviously I'm not saying this feature should not be implemented for QE=
MU
>> + SeaBIOS, just that don't expect edk2 support for it anytime soon.
>> Without a convincing use case, even the review impact seems hard to
>> justify.
>=20
> I understand, thank you for the feedback, the point was to be sure
> we don't decide something that *can't be done* in OVMF.

Semantics :) Obviously, everything "can be done" in software; that's why
it's *soft*ware. Who is going to write it in practice? It had taken
years until the edk2 core gained a universal PciHostBridgeDxe driver
with a well-defined platform customization interface, and that interface
doesn't support multiple domains / segments. It had also taken years
until the same edk2 core driver gained support for nonzero MMIO address
translation (i.e. where the CPU view of system RAM addresses differs
from the PCI device view of the same, for DMA purposes) -- and that's
just a linear translation, not even about IOMMUs. The PCI core
maintainers in edk2 are always very busy, and upstreaming such changes
tends to take forever.

Again, I'm not opposing this feature per se. I just see any potential
support for it in edk2 very difficult. I remain unconvinced that ~256
PCIe devices aren't enough. Even assuming I'm proved plain wrong there,
I'd still much prefer ARI (although I don't know much about it at this
point), because (a) the edk2 core already shows signs that it intends to
support ARI, (b) ARI would help aarch64/virt with nearly the same
effort, (c) it seems that ARI would address the problem (namely, wasting
MMCFG) head-on, rather than throwing yet more MMCFG at it.

My apologies if I'm completely wrong about ARI (although that wouldn't
change anything about the difficulties that are foreseeable in edk2 for
supporting multiple host bridges).

Thanks,
Laszlo
