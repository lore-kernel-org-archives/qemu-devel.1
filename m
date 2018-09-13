Received: from eggs.gnu.org ([2001:4830:134:3::10]:57760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0Q3Y-0004nr-0a
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0Q3V-00053W-MG
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g0Q3V-000537-E9
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:05 -0400
Date: Thu, 13 Sep 2018 19:44:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913114455.GI10763@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
	<20180912045233.GE3829@xz-x1>
	<60537599-37af-9a2b-9ddf-f6155624259f@amd.com>
	<8ba3b14e-7045-2a05-da02-d6b704ddd19a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ba3b14e-7045-2a05-da02-d6b704ddd19a@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] x86_iommu/amd: Enable Guest virtual
 APIC support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Sep 13, 2018 at 03:36:28PM +0700, Suravee Suthikulpanit wrote:
> Brijesh/Peter,
>=20
> On 9/13/18 4:14 AM, Brijesh Singh wrote:
> >=20
> >=20
> > On 09/11/2018 11:52 PM, Peter Xu wrote:
> > ...
> >=20
> > > >=20
> > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > index 5c2c638..1cbc8ba 100644
> > > > --- a/hw/i386/acpi-build.c
> > > > +++ b/hw/i386/acpi-build.c
> > > > @@ -2565,7 +2565,8 @@ build_amd_iommu(GArray *table_data, BIOSLin=
ker *linker)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_da=
ta,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (48UL << 30) | /* HATS=C2=A0=C2=A0=
 */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (48UL << 28) | /* GATS=C2=A0=C2=A0=
 */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 2),=C2=A0=C2=A0=C2=A0 /* GTSup=C2=A0 =
*/
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 2)=C2=A0=C2=A0 | /* GTSup=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 6),=C2=A0=C2=A0=C2=A0 /* GASup=C2=A0 =
*/
> > >=20
> > > Sorry if I misunderstood - is this for nested?
> > >=20
> > > I'm a bit confused here... IIUC in your previous patches you didn't
> > > really implement guest_mode=3D=3D1 case in IRTEs.=C2=A0 So if you h=
ave this set
> > > then the guest should be able to setup IRTEs with guest_mode=3D=3D1=
?=C2=A0 How
> > > did it work?
> > >=20
> >=20
> > Yes, sometime spec can be confusing ;) let me see if I can explain it=
.
> >=20
> > Suravee, please correct me if I misunderstood something
> >=20
> > - A legacy interrupt remap support is available on all IOMMU versions=
.
> >=20
> >  =C2=A0 Guest OS makes the decision whether to use the feature. Guest=
 OS
> >  =C2=A0 sets the IV bit in DTE to indicate when there is a valid inte=
rrupt
> >  =C2=A0 map (See Table 7 DTE definition).
> >=20
> >  =C2=A0 In this mode, IRTE is 32-bit. The field details are available
> >  =C2=A0 in Table 20 - Section 2.2.5.2. The third patch in this series
> >  =C2=A0 implements the support for this case.
>=20
> This is correct.
>=20
> >=20
> > - When AVIC is used in the guest, the intr remap logic is different.
> >=20
> >  =C2=A0 Based on the guest_mode, IOMMU and AVIC may need to work toge=
ther
> >  =C2=A0 to remap the interrupts (IOMMU spec refers this as Guest Virt=
ual APIC
> >  =C2=A0 Enabled -- Section 2.2.5.3).
> >=20
> >  =C2=A0 The GASup bit in extended feature register and IVHD IOMMU fea=
ture
> >  =C2=A0 reporting field in IVRS are used to tell whether the IOMMU su=
pports
> >  =C2=A0 intr remap when AVIC is enabled in the guest.
> >=20
> >  =C2=A0 In this mode, the IRTE is 128-bit.
>=20
> GASup is a prereq for GAMSup and several other features in the future.
>=20
> >=20
> >  =C2=A0 To make things interesting, there is a GAMSup bit in extended
> >  =C2=A0 feature register. It is used by IOMMU to tell the AVIC suppor=
ted
> >  =C2=A0 modes:
> >=20
> >  =C2=A0 a) 0 =3D intr_remap only (i.e IOMMU can remap the interrupt o=
n its own)
> >  =C2=A0 b) 1 =3D Both guest AVIC and IOMMU will work together to rema=
p the intr
> >=20
> >  =C2=A0 The patch 5 in the series implements the intr_remap (#a)
> >=20
> >  =C2=A0 I have not implemented the mode=3D1. I am not sure if its wor=
th
> >  =C2=A0 implementing this mode for the emulated IOMMU case.
> >=20
> >  =C2=A0 See Table 21 for control knobs from IOMMU. This patch series
> >  =C2=A0 implements the first three rows.
>=20
> GAMSup is guest virtual APIC mode (aka AVIC), and for vIOMMU case,
> would be used for nested VM. This is not currently supported for vIOMMU=
,

Hi, Brijesh, Suravee,

Thank you for the explanations.  Now with that I understand the states
and, yes, I agree that the patchset has implemented 128bits int remap
so you should have GASup set on both places (and keep GAMSup=3D=3D0).
Then please take mine:

Reviewed-by: Peter Xu <peterx@redhat.com>

Actually I don't quite understand why these information needs to be
declared in two places (ACPI and MMIO region).  More interestingly, I
noticed that there is a note in the ACPI chapter 5:

        Software Implementation Note: Information conveyed in the IVRS
        overrides the corresponding information available through the
        IOMMU hardware registers. System software is required to honor
        the ACPI settings.

Does it mean that there could be chance where both data do not match?
I would be curious why not only declare the capabilities at one place?
AFAIU that's what Intel is doing, e.g., Intel ACPI DRHD structures do
not have the feature bit declarations but they are all in the
capability registers.

Thanks,

--=20
Peter Xu
