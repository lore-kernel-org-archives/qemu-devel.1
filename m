Received: from eggs.gnu.org ([2001:4830:134:3::10]:44463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cIEGd-0007ih-FJ
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cIEGa-0006lL-CW
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:39:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:1869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cIEGa-0006hp-0c
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:39:08 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Sat, 17 Dec 2016 12:39:01 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C32C4D5@shsmsx102.ccr.corp.intel.com>
References: <b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32985A@shsmsx102.ccr.corp.intel.com>
	<f517bfbe-18b8-6962-5c57-545f6ef47ad0@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32A8D6@shsmsx102.ccr.corp.intel.com>
	<84ac9822-880d-b998-52ca-6aa87e0f7a43@intel.com>
	<20161216160112.GC6168@redhat.com>
In-Reply-To: <20161216160112.GC6168@redhat.com>
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
To: Andrea Arcangeli <aarcange@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

> Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
> fast (de)inflating & fast live migration
>=20
> On Thu, Dec 15, 2016 at 05:40:45PM -0800, Dave Hansen wrote:
> > On 12/15/2016 05:38 PM, Li, Liang Z wrote:
> > >
> > > Use 52 bits for 'pfn', 12 bits for 'length', when the 12 bits is not =
long
> enough for the 'length'
> > > Set the 'length' to a special value to indicate the "actual length in=
 next 8
> bytes".
> > >
> > > That will be much more simple. Right?
> >
> > Sounds fine to me.
> >
>=20
> Sounds fine to me too indeed.
>=20
> I'm only wondering what is the major point for compressing gpfn+len in
> 8 bytes in the common case, you already use sg_init_table to send down tw=
o
> pages, we could send three as well and avoid all math and bit shifts and =
ors,
> or not?
>=20

Yes, we can use more pages for that.

> I agree with the above because from a performance prospective I tend to
> think the above proposal will run at least theoretically faster because t=
he
> other way is to waste double amount of CPU cache, and bit mangling in the
> encoding and the later decoding on qemu side should be faster than
> accessing an array of double size, but then I'm not sure if it's measurab=
le
> optimization. So I'd be curious to know the exact motivation and if it is=
 to
> reduce the CPU cache usage or if there's some other fundamental reason to
> compress it.
> The header already tells qemu how big is the array payload, couldn't we j=
ust
> add more pages if one isn't enough?
>=20

The original intention to compress the PFN and length it's to reduce the me=
mory required.
Even the code was changed a lot from the previous versions, I think this is=
 still true.

Now we allocate a specified buffer size to save the 'PFN|length', when the =
buffer is not big
enough to save all the page info for a specified order. A double size buffe=
r will be allocated.
This is what we want to avoid because the allocation may fail and allocatio=
n takes some time,
for fast live migration, time is a critical factor we have to consider, mor=
e time takes means
more unnecessary pages are sent, because live migration starts before the r=
equest for unused
 pages get response.=20

Thanks

Liang

> Thanks,
> Andrea
