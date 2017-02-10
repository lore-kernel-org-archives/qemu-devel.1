Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc6yM-0004Fp-JL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc6yI-0007B8-JD
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cc6yI-0007Al-9w
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 03:54:26 -0500
Date: Fri, 10 Feb 2017 09:54:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170210095421.772c3b1e@nial.brq.redhat.com>
In-Reply-To: <0B9E0F74-743C-4223-8D50-0166EB6D3324@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
	<20170209182316.71d5df5f@nial.brq.redhat.com>
	<e23ba6e2-10b6-0cd2-b42c-0a4c66c706d6@redhat.com>
	<46B6079A-029E-4207-BDE9-354E9B1698D3@skyportsystems.com>
	<38ac53a6-3f10-a4ea-073e-2a65450f4f71@redhat.com>
	<0B9E0F74-743C-4223-8D50-0166EB6D3324@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On Thu, 9 Feb 2017 12:39:30 -0800
Ben Warren <ben@skyportsystems.com> wrote:

> > On Feb 9, 2017, at 12:24 PM, Laszlo Ersek <lersek@redhat.com> wrote:
> >=20
> > On 02/09/17 21:02, Ben Warren wrote: =20
> >>  =20
> >>> On Feb 9, 2017, at 11:27 AM, Laszlo Ersek <lersek@redhat.com
> >>> <mailto:lersek@redhat.com>> wrote:
> >>>=20
> >>> On 02/09/17 18:23, Igor Mammedov wrote: =20
> >>>> On Wed, 8 Feb 2017 01:48:42 +0100
> >>>> Laszlo Ersek <lersek@redhat.com <mailto:lersek@redhat.com>> wrote:
> >>>>  =20
> >>>>> On 02/05/17 10:12, ben@skyportsystems.com
> >>>>> <mailto:ben@skyportsystems.com> wrote: =20
> >>>>>> From: Ben Warren <ben@skyportsystems.com
> >>>>>> <mailto:ben@skyportsystems.com>> =20
> >>>> [...]
> >>>>  =20
> >>>>> (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset=
 40
> >>>>> decimal".
> >>>>>=20
> >>>>> I explained it under points (6) and (7) in the following message:
> >>>>>=20
> >>>>> Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com
> >>>>> <mailto:c16a03d5-820a-f719-81ea-43858f903395@redhat.com>>
> >>>>> URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.h=
tml
> >>>>>=20
> >>>>> The story is that *wherever* an ADD_POINTER command points to -- th=
at
> >>>>> is, at the *exact* target address --, OVMF will look for an ACPI ta=
ble
> >>>>> header, somewhat heuristically. If it finds a byte pattern that (a)=
 fits
> >>>>> into the remaining blob and (b) passes some superficial ACPI table
> >>>>> header checks, such as length and checksum, then OVMF assumes that =
the
> >>>>> blob contains an ACPI table there, and passes the address (again, t=
he
> >>>>> exact, relocated, absolute target address of ADD_POINTER) to
> >>>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().
> >>>>>=20
> >>>>> We want to disable this heuristic for the vmgenid blob. *If* the bl=
ob
> >>>>> contained only 16 bytes (for the GUID), then the heuristic would
> >>>>> automatically disable itself, because the ACPI table header (36 byt=
es)
> >>>>> is larger than 16 bytes, so OVMF wouldn't even look. However, for t=
he
> >>>>> caching and other VMGENID requirements, we need to allocate a full =
page
> >>>>> with the blob (4KB), hence OVMF *will* look. If we placed the GUID =
right
> >>>>> at the start of the page, then OVMF would sanity-check it as an ACPI
> >>>>> table header. The check would *most likely* not pass, so things wou=
ld be
> >>>>> fine in practice, but we can do better than that: just put 40 zero =
bytes
> >>>>> at the front of the blob.
> >>>>>=20
> >>>>> And this is why the ADD_POINTER command has to point to the beginni=
ng of
> >>>>> the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT head=
er
> >>>>> detection". (The other 4 bytes are for arriving at an address divis=
ible
> >>>>> by 8, which is a VMGENID requirement for the GUID.)
> >>>>>=20
> >>>>> The consequence is that both the ADDR method and QEMU's guest memory
> >>>>> access code have to add 40 manually. =20
> >>>> The longer I look "suppress the OVMF ACPI SDT header detection",
> >>>> the less I like approach.
> >>>>=20
> >>>> It looks somewhat backwards where a firmware forces QEMU
> >>>> to use non obvious offsets to workaround OVMF ACPI table detection
> >>>> heuristics. =20
> >>>=20
> >>> This is for historical reasons -- when the linker/loader commands were
> >>> invented, it wasn't considered that in UEFI, ACPI tables cannot just =
be
> >>> linked together in-place, instead they'd have to be passed to
> >>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() one by one, for copying. T=
he
> >>> commands didn't provide dedicated means for identifying individual
> >>> tables in blobs. Hence the heuristics built upon ADD_POINTER.
> >>>=20
> >>> And once you have heuristics, you want to suppress them occasionally,=
 if
> >>> you can find a way.
> >>>  =20
> >>>> Can we add and use explicit flag to mark blobs as ACPI tables,
> >>>> so that OVMF won't have to guess whether to hand off table
> >>>> as ACPI to UEFI stack or just keep it to yourself? =20
> >>>=20
> >>> The ADD_POINTER-based heuristics cannot be turned off for ACPI table
> >>> identification, because a single fw_cfg blob can (and does) contain
> >>> multiple ACPI tables, and OVMF needs to figure out, somehow, where ea=
ch
> >>> of those tables start. Blob-level hints won't help with this.
> >>>=20
> >>> The following could be an improvement though: a blob-level hint (perh=
aps
> >>> in the ALLOCATE command) that the blob contains *no* ACPI tables. In
> >>> this case, OVMF could turn off the table recognition heuristics for
> >>> those ADD_POINTER commands that point into such blobs. (Plus mark the
> >>> blob for permanent preservation at once, and not only when an
> >>> ADD_POINTER "probe" into the blob fails.)
> >>>=20
> >>> OVMF currently ignores the Zone field in the ALLOCATE command, so that
> >>> could be extended / abused for such a hint, without breaking
> >>> compatibility with OVMF. (Not sure about SeaBIOS.)
> >>>  =20
> >> Overloading the ALLOCATE command in theory could be done with a simple
> >> change to SeaBIOS.  Here=E2=80=99s where the zone is handled:
> >>=20
> >>    switch (entry->alloc_zone) {
> >>        case ROMFILE_LOADER_ALLOC_ZONE_HIGH:
> >>            zone =3D &ZoneHigh;
> >>            break;
> >>        case ROMFILE_LOADER_ALLOC_ZONE_FSEG:
> >>            zone =3D &ZoneFSeg;
> >>            break;
> >>        default:
> >>            goto err;
> >>    }
> >>=20
> >> ZONE_HIGH =3D 1, and ZONE_FSEG =3D 2 and alloc_zone is 8 bits.  Steali=
ng the
> >> MSB and masking it off would be dirty, but could work. =20
> >=20
> > Even assuming that we don't horribly break cross-version compatibility
> > with tricks like this, the problem is that such changes only look simple
> > and easy in isolation. They add up, and their testing impact is not sma=
ll.
> >=20
> > This week I've been working practically every waking moment -- I wanted
> > to provide quick and detailed feedback (as far as OVMF was concerned)
> > under both this series and on the topic of DSDT / X_DSDT /
> > multiply-pointed-to tables. I'm also "racing you" to create a good
> > quality OVMF series for WRITE_POINTER (including replay at S3 resume),
> > so that as soon you post v6, we can test it together with OVMF too.
> > (Last night I thought I had WRITE_POINTER ready, and started testing it
> > against your v5, but then I suddenly thought of device reset and S3...
> > Sigh.)
> >=20
> > We can certainly file RFEs for stuff like the above (maybe in RHBZ,
> > maybe in Launchpad), but the scope creep is already significant for
> > VMGENID (it's noone's fault, VMGENID has tentacles into everything).
> > Igor's suggestion is good, it aims to decrease technical debt, but I'm
> > grasping at cycles -- review is very time consuming (albeit just as
> > necessary). Also, for QEMU, the 2.9 soft freeze is around the corner=E2=
=80=A6 =20
>=20
> OK, well I=E2=80=99m fine with things as they are.  I=E2=80=99ll try to g=
et v6 out tomorrow.  This optimization can wait until later.
Agreed,
let forget about this for now, we can later revisit this issue.

(vmgeid is probably not the only one that needs it,
TPM comes in mind and maybe there are other blobs.)

>=20
> > Best I can recommend now is filing an RFE for this.
> >=20
> > Thanks
> > Laszlo
> >  =20
> >>> Otherwise, a new allocation command will be necessary. (Which should
> >>> embed the current ALLOCATE command structure fully, at some offset.)
> >>>=20
> >>> Thanks
> >>> Laszlo =20
> >>  =20
> >  =20
>=20
