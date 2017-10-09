Received: from eggs.gnu.org ([2001:4830:134:3::10]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1Tj3-0007dg-VA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1Tiz-0002cs-PD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:47:50 -0400
Date: Mon, 9 Oct 2017 16:47:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171009084736.GF2196@pxdev.xzpeter.org>
References: <20171006114624.10771-1-maxime.coquelin@redhat.com>
	<20171006114624.10771-2-maxime.coquelin@redhat.com>
	<1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
	<ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
	<c4c02172-cf19-bd56-d120-f72e043a54e0@redhat.com>
	<7ebed617-f286-5f35-e784-6b4b864e406a@redhat.com>
	<20171009051731.GB2196@pxdev.xzpeter.org>
	<0cb9b9c6-0d13-8136-2796-c564213ca8e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cb9b9c6-0d13-8136-2796-c564213ca8e5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] exec: add page_mask for
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Mon, Oct 09, 2017 at 10:30:07AM +0200, Maxime Coquelin wrote:
> Hi Peter,
>=20
> On 10/09/2017 07:17 AM, Peter Xu wrote:
> >On Fri, Oct 06, 2017 at 03:03:50PM +0200, Maxime Coquelin wrote:
> >>
> >>
> >>On 10/06/2017 02:48 PM, Paolo Bonzini wrote:
> >>>On 06/10/2017 14:46, Maxime Coquelin wrote:
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D =
((iotlb.translated_addr & ~iotlb.addr_mask)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (addr & iotlb.addr_mask));
> >>>>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *plen =3D MIN(*plen, =
(addr | iotlb.addr_mask) - addr + 1);
> >>>>>>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_mask =3D iotlb.a=
ddr_mask;
> >>>>>
> >>>>>Should this be "page_mask &=3D iotlb.addr_mask"?
> >>>>>
> >>>>>If you have multiple IOMMUs on top of each other (yeah, I know...)=
 I
> >>>>>think the smallest size should win.=C2=A0 This is also consistent =
with the
> >>>>>MIN in the line below.
> >>>>
> >>>>I agree, but changin to "page_mask &=3D iotlb.addr_mask" will not b=
e
> >>>>enough, we also have to change the init value. Else we will always =
end
> >>>>up with 0xfff.
> >>>>
> >>>>Maybe we could do as plen was handled before, i.e. setting page_mas=
k
> >>>>init value to (hwaddr)(-1), and after the loop set it to
> >>>>~TARGET_PAGE_MASK if it hasn't been changed.
> >>>>
> >>>>Does that sound reasonable?
> >>>
> >>>True that, in fact it makes sense for the "IOTLB entry" to represent=
 all
> >>>of memory if there's no IOMMU at all.
> >>
> >>Indeed, that makes sense as no iommu means identity mapping. It would
> >>moreover improve performance, as the vhost backend will only have a
> >>single IOTLB entry in its cache.
> >>
> >>Maybe it is better to wait for Peter to understand the reason he limi=
ted
> >>it to the target page size?
> >
> >Sorry, just came back from a long holiday.
>=20
> No problem.
>=20
> >I was trying to use 4K as default to be safe (but yes the mask was not
> >correct, thanks for fixing that!), to make sure the translated range
> >covered by the IOMMUTLBEntry will always be safe to access (I thought
> >that was how IOTLB was defined, but I may be wrong).  Using (-1) is
> >good especially from performance POV as long as the caller knows the
> >real memory boundary, but I'm not sure whether it'll break the IOTLB
> >scemantic somehow.
>=20
> Good point.
> Maybe it would be safer to wrap the IOTLB entry to the memory region?

The problem is that MR size may not be aligned with address masks.  I
see it less meaningful if we need to further man-made a smaller mask.

And wait, since you mentioned about MR... I think using -1 here may be
wrong.  Although current MR is transparently mapped (the MR that
covers the address to be translated), it does not mean the whole
address space is transparently mapped.  SPAPR should be a good example
that some ranges of the address space are mapped by IOMMU but some are
not.

>=20
> >If we want to make it -1 for transparent mappings, maybe worth
> >commenting it in definition of IOMMUTLBEntry.page_mask?
>=20
> Yes, that makes sense.

According to above, I would vote for your previous solution: first use
-1 to get the minimum mask, then switch to PAGE_MASK before returning
when needed.

>=20
> >(Btw, thanks again for moving these patches forward; I tried to, but I
> >  failed :)
>=20
> I'm a bit faulty not to have reviewed/tested it in the first place ;)

:-)

Thanks!

>=20
> Thanks,
> Maxime

--=20
Peter Xu
