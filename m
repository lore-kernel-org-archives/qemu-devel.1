Received: from eggs.gnu.org ([2001:4830:134:3::10]:49170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cHh4Z-000878-B6
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cHh4U-0006Qa-Dd
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:12:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:53882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cHh4U-0006Pf-3N
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:12:26 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Fri, 16 Dec 2016 01:12:21 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C32A899@shsmsx102.ccr.corp.intel.com>
References: <0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<20161215173901-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161215173901-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

> On Thu, Dec 15, 2016 at 07:34:33AM -0800, Dave Hansen wrote:
> > On 12/14/2016 12:59 AM, Li, Liang Z wrote:
> > >> Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend
> > >> virtio-balloon for fast (de)inflating & fast live migration
> > >>
> > >> On 12/08/2016 08:45 PM, Li, Liang Z wrote:
> > >>> What's the conclusion of your discussion? It seems you want some
> > >>> statistic before deciding whether to  ripping the bitmap from the
> > >>> ABI, am I right?
> > >>
> > >> I think Andrea and David feel pretty strongly that we should remove
> > >> the bitmap, unless we have some data to support keeping it.  I
> > >> don't feel as strongly about it, but I think their critique of it
> > >> is pretty valid.  I think the consensus is that the bitmap needs to =
go.
> > >>
> > >> The only real question IMNHO is whether we should do a power-of-2
> > >> or a length.  But, if we have 12 bits, then the argument for doing
> > >> length is pretty strong.  We don't need anywhere near 12 bits if doi=
ng
> power-of-2.
> > >
> > > Just found the MAX_ORDER should be limited to 12 if use length
> > > instead of order, If the MAX_ORDER is configured to a value bigger
> > > than 12, it will make things more complex to handle this case.
> > >
> > > If use order, we need to break a large memory range whose length is
> > > not the power of 2 into several small ranges, it also make the code
> complex.
> >
> > I can't imagine it makes the code that much more complex.  It adds a
> > for loop.  Right?
> >
> > > It seems we leave too many bit  for the pfn, and the bits leave for
> > > length is not enough, How about keep 45 bits for the pfn and 19 bits
> > > for length, 45 bits for pfn can cover 57 bits physical address, that =
should
> be enough in the near feature.
> > >
> > > What's your opinion?
> >
> > I still think 'order' makes a lot of sense.  But, as you say, 57 bits
> > is enough for x86 for a while.  Other architectures.... who knows?
>=20
> I think you can probably assume page size >=3D 4K. But I would not want t=
o
> make any other assumptions. E.g. there are systems that absolutely requir=
e
> you to set high bits for DMA.
>=20
> I think we really want both length and order.
>=20
> I understand how you are trying to pack them as tightly as possible.
>=20
> However, I thought of a trick, we don't need to encode all possible order=
s.
> For example, with 2 bits of order, we can make them mean:
> 00 - 4K pages
> 01 - 2M pages
> 02 - 1G pages
>=20
> guest can program the sizes for each order through config space.
>=20
> We will have 10 bits left for legth.
>=20

Please don't, we just get rid of the bitmap for simplification. :)

> It might make sense to also allow guest to program the number of bits use=
d
> for order, this will make it easy to extend without host changes.
>=20

There still exist the case if the MAX_ORDER is configured to a large value,=
 e.g. 36 for a system
with huge amount of memory, then there is only 28 bits left for the pfn, wh=
ich is not enough.
Should  we limit the MAX_ORDER? I don't think so.

It seems use order is better.=20

Thanks!
Liang
> --
> MST
