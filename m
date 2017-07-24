Received: from eggs.gnu.org ([2001:4830:134:3::10]:59122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZh8m-0000u2-8w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZh8h-00016U-Fd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dZh8h-00015w-6h
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:27:27 -0400
Date: Mon, 24 Jul 2017 18:27:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170724172717.GF2127@work-vm>
References: <20170724165125.29887-1-dgilbert@redhat.com>
	<a5e0101c-8288-683d-ad27-bd0d3eff6818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a5e0101c-8288-683d-ad27-bd0d3eff6818@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] cpu_physical_memory_sync_dirty_bitmap:
 Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, alex.bennee@linaro.org, haozhong.zhang@intel.com, peterx@redhat.com, lvivier@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 24/07/2017 18:51, Dr. David Alan Gilbert (git) wrote:
> > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > This code has an optimised, word aligned version, and a boring
> > unaligned version.  Recently 084140bd498909 fixed a missing offset
> > addition from the core of both versions.  However, the offset isn't
> > necessarily aligned and thus the choice between the two versions
> > needs fixing up to also include the offset.
> >=20
> > Symptom:
> >   A few stuck unsent pages during migration; not normally noticed
> > unless under very low bandwidth in which case the migration may get
> > stuck never ending and never performing a 2nd sync; noticed by
> > a hanging postcopy-test on a very heavily loaded system.
> >=20
> > Fixes: 084140bd498909
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reported-by: Alex Benne=E9 <alex.benee@linaro.org>
> > Tested-by: Alex Benne=E9 <alex.benee@linaro.org>
> >=20
> > --
> > v2
> >   Move 'page' inside the if (Comment from Paolo)
> > ---
> >  include/exec/ram_addr.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index c04f4f67f6..d017639f7e 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -377,19 +377,20 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(=
RAMBlock *rb,
> >                                                 uint64_t *real_dirty_=
pages)
> >  {
> >      ram_addr_t addr;
> > -    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
> > +    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_P=
AGE_BITS);
> >      uint64_t num_dirty =3D 0;
> >      unsigned long *dest =3D rb->bmap;
> > =20
> >      /* start address is aligned at the start of a word? */
> > -    if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) {
> > +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
> > +         (start + rb->offset)) {
> >          int k;
> >          int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
> >          unsigned long * const *src;
> > -        unsigned long word =3D BIT_WORD((start + rb->offset) >> TARG=
ET_PAGE_BITS);
> >          unsigned long idx =3D (word * BITS_PER_LONG) / DIRTY_MEMORY_=
BLOCK_SIZE;
> >          unsigned long offset =3D BIT_WORD((word * BITS_PER_LONG) %
> >                                          DIRTY_MEMORY_BLOCK_SIZE);
> > +        unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
> > =20
> >          rcu_read_lock();
> > =20
> >=20
>=20
>=20
> Thanks, do you want me to queue this patch?

Yes please.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
