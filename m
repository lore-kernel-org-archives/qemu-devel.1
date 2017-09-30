Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dy9KN-0004S8-0n
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dy9KJ-0005ge-Rc
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:24:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dy9KJ-0005fy-HY
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 00:24:31 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 30 Sep 2017 04:24:26 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73931DE83@shsmsx102.ccr.corp.intel.com>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-3-git-send-email-wei.w.wang@intel.com>
	<20170911132710.GB32538@bombadil.infradead.org>
In-Reply-To: <20170911132710.GB32538@bombadil.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v15 2/5] lib/xbitmap: add
 xb_find_next_bit() and xb_zero()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <qemu-devel.nongnu.org>

On Monday, September 11, 2017 9:27 PM, Matthew Wilcox wrote
> On Mon, Aug 28, 2017 at 06:08:30PM +0800, Wei Wang wrote:
> > +/**
> > + *  xb_zero - zero a range of bits in the xbitmap
> > + *  @xb: the xbitmap that the bits reside in
> > + *  @start: the start of the range, inclusive
> > + *  @end: the end of the range, inclusive  */ void xb_zero(struct xb
> > +*xb, unsigned long start, unsigned long end) {
> > +	unsigned long i;
> > +
> > +	for (i =3D start; i <=3D end; i++)
> > +		xb_clear_bit(xb, i);
> > +}
> > +EXPORT_SYMBOL(xb_zero);
>=20
> Um.  This is not exactly going to be quick if you're clearing a range of =
bits.
> I think it needs to be more along the lines of this:
>=20
> void xb_clear(struct xb *xb, unsigned long start, unsigned long end) {
>         struct radix_tree_root *root =3D &xb->xbrt;
>         struct radix_tree_node *node;
>         void **slot;
>         struct ida_bitmap *bitmap;
>=20
>         for (; end < start; start =3D (start | (IDA_BITMAP_BITS - 1)) + 1=
) {
>                 unsigned long index =3D start / IDA_BITMAP_BITS;
>                 unsigned long bit =3D start % IDA_BITMAP_BITS;
>=20
>                 bitmap =3D __radix_tree_lookup(root, index, &node, &slot)=
;
>                 if (radix_tree_exception(bitmap)) {
>                         unsigned long ebit =3D bit + 2;
>                         unsigned long tmp =3D (unsigned long)bitmap;
>                         if (ebit >=3D BITS_PER_LONG)
>                                 continue;
>                         tmp &=3D ... something ...;
>                         if (tmp =3D=3D RADIX_TREE_EXCEPTIONAL_ENTRY)
>                                 __radix_tree_delete(root, node, slot);
>                         else
>                                 rcu_assign_pointer(*slot, (void *)tmp);
>                 } else if (bitmap) {
>                         unsigned int nbits =3D end - start + 1;
>                         if (nbits + bit > IDA_BITMAP_BITS)
>                                 nbits =3D IDA_BITMAP_BITS - bit;
>                         bitmap_clear(bitmap->bitmap, bit, nbits);
>                         if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)=
) {
>                                 kfree(bitmap);
>                                 __radix_tree_delete(root, node, slot);
>                         }
>                 }
>         }
> }
>=20
> Also note that this should be called xb_clear(), not xb_zero() to fit in =
with
> bitmap_clear().  And this needs a thorough test suite testing all values =
for 'start'
> and 'end' between 0 and at least 1024; probably much higher.  And a varia=
ble
> number of bits need to be set before calling
> xb_clear() in the test suite.
>=20
> Also, this implementation above is missing a few tricks.  For example, if=
 'bit' is 0
> and 'nbits' =3D=3D IDA_BITMAP_BITS, we can simply call kfree without firs=
t zeroing
> out the bits and then checking if the whole thing is zero.

Thanks for the optimization suggestions. We've seen significant improvement=
 of
the ballooning time. Some other optimizations (stated in the changelog) hav=
en't
been included in the new version. If possible, we can leave that to a secon=
d step
optimization outside this patch series.

Best,
Wei
