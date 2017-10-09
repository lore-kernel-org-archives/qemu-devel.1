Received: from eggs.gnu.org ([2001:4830:134:3::10]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1QRk-0005TY-6Q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1QRg-0005MV-6D
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:17:44 -0400
Date: Mon, 9 Oct 2017 13:17:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171009051731.GB2196@pxdev.xzpeter.org>
References: <20171006114624.10771-1-maxime.coquelin@redhat.com>
	<20171006114624.10771-2-maxime.coquelin@redhat.com>
	<1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
	<ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
	<c4c02172-cf19-bd56-d120-f72e043a54e0@redhat.com>
	<7ebed617-f286-5f35-e784-6b4b864e406a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ebed617-f286-5f35-e784-6b4b864e406a@redhat.com>
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

On Fri, Oct 06, 2017 at 03:03:50PM +0200, Maxime Coquelin wrote:
>=20
>=20
> On 10/06/2017 02:48 PM, Paolo Bonzini wrote:
> >On 06/10/2017 14:46, Maxime Coquelin wrote:
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D ((=
iotlb.translated_addr & ~iotlb.addr_mask)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (addr & iotlb.addr_mask));
> >>>>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *plen =3D MIN(*plen, (a=
ddr | iotlb.addr_mask) - addr + 1);
> >>>>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_mask =3D iotlb.add=
r_mask;
> >>>
> >>>Should this be "page_mask &=3D iotlb.addr_mask"?
> >>>
> >>>If you have multiple IOMMUs on top of each other (yeah, I know...) I
> >>>think the smallest size should win.=C2=A0 This is also consistent wi=
th the
> >>>MIN in the line below.
> >>
> >>I agree, but changin to "page_mask &=3D iotlb.addr_mask" will not be
> >>enough, we also have to change the init value. Else we will always en=
d
> >>up with 0xfff.
> >>
> >>Maybe we could do as plen was handled before, i.e. setting page_mask
> >>init value to (hwaddr)(-1), and after the loop set it to
> >>~TARGET_PAGE_MASK if it hasn't been changed.
> >>
> >>Does that sound reasonable?
> >
> >True that, in fact it makes sense for the "IOTLB entry" to represent a=
ll
> >of memory if there's no IOMMU at all.
>=20
> Indeed, that makes sense as no iommu means identity mapping. It would
> moreover improve performance, as the vhost backend will only have a
> single IOTLB entry in its cache.
>=20
> Maybe it is better to wait for Peter to understand the reason he limite=
d
> it to the target page size?

Sorry, just came back from a long holiday.

I was trying to use 4K as default to be safe (but yes the mask was not
correct, thanks for fixing that!), to make sure the translated range
covered by the IOMMUTLBEntry will always be safe to access (I thought
that was how IOTLB was defined, but I may be wrong).  Using (-1) is
good especially from performance POV as long as the caller knows the
real memory boundary, but I'm not sure whether it'll break the IOTLB
scemantic somehow.

If we want to make it -1 for transparent mappings, maybe worth
commenting it in definition of IOMMUTLBEntry.page_mask?

(Btw, thanks again for moving these patches forward; I tried to, but I
 failed :)

--=20
Peter Xu
