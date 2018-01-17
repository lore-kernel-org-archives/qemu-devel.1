Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebq1O-0002ht-E1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebq1K-00006W-ID
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:53:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:4674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebq1J-00005G-Qe
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:52:58 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 15:52:52 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393CF34B@shsmsx102.ccr.corp.intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
	<1516170720-4948-2-git-send-email-wei.w.wang@intel.com>
	<878tcw4ssp.fsf@secure.laptop>
In-Reply-To: <878tcw4ssp.fsf@secure.laptop>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "quintela@redhat.com" <quintela@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>

On Wednesday, January 17, 2018 7:41 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
> > +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t
> offset,
> > +                                       size_t len) {
> > +    long start =3D offset >> TARGET_PAGE_BITS,
> > +         nr =3D len >> TARGET_PAGE_BITS;
> > +
> > +    bitmap_clear(block->bmap, start, nr);
>=20
> But what assures us that all the nr pages are dirty?

Actually the free page optimization is used for the bulk stage, where all t=
he pages are treated as dirty. In patch 2, we have:

+            if (rs->free_page_support) {
+                bitmap_set(block->bmap, 1, pages);
+            } else {
+                bitmap_set(block->bmap, 0, pages);
+            }


>=20
> > +    ram_state->migration_dirty_pages -=3D nr;
>=20
> This should be
> ram_state->migration_dirty_pages -=3D
>      count_ones(block->bmap, start, nr);
>=20
> For a count_ones function, no?

Not really. "nr" is the number of bits to clear from the bitmap, so "migrat=
ion_dirty_pages -=3D nr" shows how many dirty bits left in the bitmap.

One cornercase I'm thinking about is when we do=20
bitmap_clear(block->bmap, start, nr);
would it be possible that "start + nr" exceeds the bitmap size? that is, wo=
uld it be possible that the free page block (e.g. 2MB) from the guest cross=
es the QEMU ram block boundary?


> Furthermore, we have one "optimization" and this only works for the secon=
d
> stages onward:
>=20
> static inline
> unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>                                           unsigned long start) {
>     unsigned long size =3D rb->used_length >> TARGET_PAGE_BITS;
>     unsigned long *bitmap =3D rb->bmap;
>     unsigned long next;
>=20
>     if (rs->ram_bulk_stage && start > 0) {
>         next =3D start + 1;
>     } else {
>         next =3D find_next_bit(bitmap, size, start);
>     }
>=20
>     return next;
> }
>=20
> So, for making this really work, we have more work to do.
>=20
> Actually, what I think we should do was to _ask_ the guest which pages ar=
e
> used at the beggining, instead of just setting all pages as dirty, but th=
at
> requires kernel changes and lot of search of corner cases.
>=20

This series optimizes the bulk stage memory transfer. Do you mean you have =
another idea to optimize the second round and onward? How would you let the=
 guest track pages that are written?

Best,
Wei
