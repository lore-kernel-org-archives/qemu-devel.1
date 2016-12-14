Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cH5Pq-0004EI-9P
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cH5Pn-0003Qu-84
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:25319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cH5Pm-0003Pq-UL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:59:55 -0500
From: "Li, Liang Z" <liang.z.li@intel.com>
Date: Wed, 14 Dec 2016 08:59:47 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
In-Reply-To: <060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

> Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
> fast (de)inflating & fast live migration
>=20
> On 12/08/2016 08:45 PM, Li, Liang Z wrote:
> > What's the conclusion of your discussion? It seems you want some
> > statistic before deciding whether to  ripping the bitmap from the ABI,
> > am I right?
>=20
> I think Andrea and David feel pretty strongly that we should remove the
> bitmap, unless we have some data to support keeping it.  I don't feel as
> strongly about it, but I think their critique of it is pretty valid.  I t=
hink the
> consensus is that the bitmap needs to go.
>=20
> The only real question IMNHO is whether we should do a power-of-2 or a
> length.  But, if we have 12 bits, then the argument for doing length is p=
retty
> strong.  We don't need anywhere near 12 bits if doing power-of-2.

Just found the MAX_ORDER should be limited to 12 if use length instead of o=
rder,
If the MAX_ORDER is configured to a value bigger than 12, it will make thin=
gs more
complex to handle this case.=20

If use order, we need to break a large memory range whose length is not the=
 power of 2 into several
small ranges, it also make the code complex.

It seems we leave too many bit  for the pfn, and the bits leave for length =
is not enough,
How about keep 45 bits for the pfn and 19 bits for length, 45 bits for pfn =
can cover 57 bits
physical address, that should be enough in the near feature.=20

What's your opinion?


thanks!
Liang

=20
