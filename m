Received: from eggs.gnu.org ([2001:4830:134:3::10]:38075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCcpV-0006dT-3S
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 23:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gCcpT-00079q-La
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 23:49:05 -0400
Date: Wed, 17 Oct 2018 14:28:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181017032859.GB30180@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-6-david@gibson.dropbear.id.au>
	<f21b8a98-3401-cf82-749d-2101fbe69a33@redhat.com>
	<20181013064009.GG16167@umbus.fritz.box>
	<d26f9429-1da8-20d2-e43b-bee1141fb62f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <d26f9429-1da8-20d2-e43b-bee1141fb62f@redhat.com>
Subject: Re: [Qemu-devel] [RFC 5/5] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 09:08:45AM +0200, David Hildenbrand wrote:
> >>> This occurs in practice routinely for POWER KVM systems, since both h=
ost
> >>> and guest typically use 64kiB pages.
> >>>
> >>> To make this safe, without breaking that useful case, we need to
> >>> accumulate 4kiB balloon requests until we have a whole contiguous hos=
t page
> >>> at which point we can discard it.
> >>
> >> ... and if you have a 4k guest it will just randomly report pages and
> >> your 67 LOC tweak is useless.
> >=20
> > Yes.
> >=20
> >> And this can and will easily happen.
> >=20
> > What cases are you thinking of?  For POWER at least, 4k on 64k will be
> > vastly less common than 64k on 64k.
>=20
> Okay, I was wondering why we don't get tons of bug reports for 4k on
> 64k.

Right, and the answer is because 64k has been the normal configuration
on every major ppc64 distro for years (for both host and guest).

> So 64k on 64k while using ballooning is supported and heavily used
> then I guess? Because as you said, 4k on 64k triggers memory corruptions.

Right.

> >>> We could in principle do that across all guest memory, but it would r=
equire
> >>> a large bitmap to track.  This patch represents a compromise: instead=
 we
> >>
> >> Oh god no, no tracking of all memory. (size of bitmap, memory hotplug,
> >> ... migration?)
> >=20
> > Quite, that's why I didn't do it.  Although, I don't actually think
> > migration is such an issue: we *already* essentially lose track of
> > which pages are inside the balloon across migration.
>=20
> Well, we migrate zero pages that get replaces by zero pages on the
> target. So at least KSM could recover them.

Right, but there's no explicit state being transferred.  In a sense,
KSM and zero page handling across migration resets the balloon to a
state optimized for the current memory state of the guest.

> >>> track ballooned subpages for a single contiguous host page at a time.=
  This
> >>> means that if the guest discards all 4kiB chunks of a host page in
> >>> succession, we will discard it.  In particular that means the balloon=
 will
> >>> continue to work for the (host page size) =3D=3D (guest page size) > =
4kiB case.
> >>>
> >>> If the guest scatters 4kiB requests across different host pages, we d=
on't
> >>> discard anything, and issue a warning.  Not ideal, but at least we do=
n't
> >>> corrupt guest memory as the previous version could.
> >>
> >> My take would be to somehow disable the balloon on the hypervisor side
> >> in case the host page size is not 4k. Like not allowing to realize it.
> >> No corruptions, no warnings people will ignore.
> >=20
> > No, that's even worse than just having it silently do nothing on
> > non-4k setups.  Silently being useless we might get away with, we'll
> > just waste memory, but failing the device load will absolutely break
> > existing setups.
>=20
> Silently consume more memory is very very evil. Think about
> auto-ballooning setups
> https://www.ovirt.org/documentation/how-to/autoballooning/

Well, sure, I don't think this is a good idea.

> But on the other hand, this has been broken forever for huge pages
> without printing warnings. Oh man, virtio-balloon ...
>=20
> Disallowing to realize will only break migration from an old host to a
> new host. But migration will bail out right away.

The issue isn't really migration here.  If we prevent the balloon
device from realizing, guests which already had it configured simply
won't be able to start after qemu is updated.

> We could of course
> glue this to a compat machine,

We could, but what would it accomplish?  We'd still have to do
something for the old machine versions - so we're back at either
allowing memory corruption like we do right now, or batch gathering as
my patch proposes.

> but I guess the point you have is that
> customer want to continue using this "works by accident without memory
> corruptions" virtio-balloon implementation.

Right.  That's why I really think we need this batch-gathering
approach, ugly and irritating though it is.

>=20
> >=20
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/virtio/virtio-balloon.c         | 67 +++++++++++++++++++++++++---=
--
> >>>  include/hw/virtio/virtio-balloon.h |  3 ++
> >>>  2 files changed, 60 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>> index 4435905c87..39573ef2e3 100644
> >>> --- a/hw/virtio/virtio-balloon.c
> >>> +++ b/hw/virtio/virtio-balloon.c
> >>> @@ -33,33 +33,80 @@
> >>> =20
> >>>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> >>> =20
> >>> +typedef struct PartiallyBalloonedPage {
> >>> +    RAMBlock *rb;
> >>> +    ram_addr_t base;
> >>> +    unsigned long bitmap[];
> >>> +} PartiallyBalloonedPage;
> >>> +
> >>>  static void balloon_inflate_page(VirtIOBalloon *balloon,
> >>>                                   MemoryRegion *mr, hwaddr offset)
> >>>  {
> >>>      void *addr =3D memory_region_get_ram_ptr(mr) + offset;
> >>>      RAMBlock *rb;
> >>>      size_t rb_page_size;
> >>> -    ram_addr_t ram_offset;
> >>> +    int subpages;
> >>> +    ram_addr_t ram_offset, host_page_base;
> >>> =20
> >>>      /* XXX is there a better way to get to the RAMBlock than via a
> >>>       * host address? */
> >>>      rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> >>>      rb_page_size =3D qemu_ram_pagesize(rb);
> >>> +    host_page_base =3D ram_offset & ~(rb_page_size - 1);
> >>> +
> >>> +    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
> >>> +        /* Easy case */
> >>> =20
> >>> -    /* Silently ignore hugepage RAM blocks */
> >>> -    if (rb_page_size !=3D getpagesize()) {
> >>> +        ram_block_discard_range(rb, ram_offset, rb_page_size);
> >>> +        /* We ignore errors from ram_block_discard_range(), because =
it
> >>> +         * has already reported them, and failing to discard a ballo=
on
> >>> +         * page is not fatal */
> >>>          return;
> >>>      }
> >>> =20
> >>> -    /* Silently ignore unaligned requests */
> >>> -    if (ram_offset & (rb_page_size - 1)) {
> >>> -        return;
> >>> +    /* Hard case
> >>> +     *
> >>> +     * We've put a piece of a larger host page into the balloon - we
> >>> +     * need to keep track until we have a whole host page to
> >>> +     * discard
> >>> +     */
> >>> +    subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> >>> +
> >>> +    if (balloon->pbp
> >>> +        && (rb !=3D balloon->pbp->rb
> >>> +            || host_page_base !=3D balloon->pbp->base)) {
> >>> +        /* We've partially ballooned part of a host page, but now
> >>> +         * we're trying to balloon part of a different one.  Too har=
d,
> >>> +         * give up on the old partial page */
> >>> +        warn_report("Unable to insert a partial page into virtio-bal=
loon");
> >>
> >> I am pretty sure that you can create misleading warnings in case you
> >> migrate at the wrong time. (migrate while half the 64k page is inflate=
d,
> >> on the new host the other part is inflated - a warning when switching =
to
> >> another 64k page).
> >=20
> > Yes we can get bogus warnings across migration with this.  I was
> > considering that an acceptable price, but I'm open to better
> > alternatives.
>=20
> Is maybe reporting a warning on a 64k host when realizing the better
> approach than on every inflation?
>=20
> "host page size does not match virtio-balloon page size. If the guest
> has a different page size than the host, inflating the balloon might not
> effectively free up memory."

That might work - I'll see what I can come up with.  One complication
is that theoretically at least, you can have multiple host page sizes
(main memory in normal pages, a DIMM in hugepages).  That makes the
condition on which the warning should be issued a bit fiddly to work
out.

> Or reporting a warning whenever changing the balloon target size.

I'm not sure what you mean by this.

>=20
> >=20
> >>> +        free(balloon->pbp);
> >>> +        balloon->pbp =3D NULL;
> >>>      }
> >>> =20
> >>> -    ram_block_discard_range(rb, ram_offset, rb_page_size);
> >>> -    /* We ignore errors from ram_block_discard_range(), because it h=
as
> >>> -     * already reported them, and failing to discard a balloon page =
is
> >>> -     * not fatal */
> >>> +    if (!balloon->pbp) {
> >>> +        /* Starting on a new host page */
> >>> +        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned =
long);
> >>> +        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + =
bitlen);
> >>> +        balloon->pbp->rb =3D rb;
> >>> +        balloon->pbp->base =3D host_page_base;
> >>> +    }
> >>> +
> >>> +    bitmap_set(balloon->pbp->bitmap,
> >>> +               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> >>> +               subpages);
> >>> +
> >>> +    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> >>> +        /* We've accumulated a full host page, we can actually disca=
rd
> >>> +         * it now */
> >>> +
> >>> +        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size=
);
> >>> +        /* We ignore errors from ram_block_discard_range(), because =
it
> >>> +         * has already reported them, and failing to discard a ballo=
on
> >>> +         * page is not fatal */
> >>> +
> >>> +        free(balloon->pbp);
> >>> +        balloon->pbp =3D NULL;
> >>> +    }
> >>>  }
> >> No, not a fan of this approach.
> >=20
> > I can see why, but I really can't see what else to do without breaking
> > existing, supported, working (albeit by accident) setups.
>=20
> Is there any reason to use this more complicated "allow random freeing"
> approach over a simplistic sequential freeing I propose? Then we can
> simply migrate the last freed page and should be fine.

Well.. your approach is probably simpler in terms of the calculations
that need to be done, though only very slightly.  I think my approach
is conceptually clearer though, since we're explicitly checking for
exactly the condition we need, rather than something we thing should
match up with that condition.

Even if the extra robustness is strictly theoretical, I prefer the
idea of more robust but slightly longer code versus less robust and
slightly shorter code - at least when the latter will want a long
detailed comment explaining why it's correct.

> As far as I know Linux guests have been freeing and reporting these
> pages sequentially, or is that not true? Are you aware of other
> implementations that we might miss?

No, I'm not aware of any other implementations we're likely to care
about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGrHUACgkQbDjKyiDZ
s5KUFA/7BS/fhc//ALaRahsu+OY6VLck0xf8pE+v653p5FrvyOrvJrF9lN5vfM+D
7eMjs+llRf6ldtgo26PpaIrLCuW8VV4JaGE4p8NjO4HYvjbmjWtipsHwO2EOxWor
2wSIdVXq6I+L01v2T0OB1AP4uoFDYX//ozueRkdLONQ3RH36/KWY1XqHbFCoAcG7
pFPQ6TtZtljgxxO4YnDan+e34uAymjKH2rcSN8fAwkB0dvzgG2dSwFhHBmvK67Rc
yvsn5X2oL9MCDAMEwyT6JzEEwEFPo0Wp8LaUzHhYNZVXcwFEyMWz0eU4ElciHEEf
mxPy2yUM5CuuR0LKb92SBB04MpEvj7I42qAH9HjOEcVNqpmaRideHw9Hf7dFSl2X
UqcowieWY9kH2jmUFtphg2lhgodEiIBXdBe0gRMLRDj2L5gEcc7WjfsN6WLzUUM9
z0dy8tIQOyidzg9/M/zUmxDA5CK3Ykd4TLsgplGG7S12rWBChWBYEpCs5VzOnXwM
lN9GY5iz1KfmaFjnqtd01WPfDe1wHHtcvxGjcTh/0p+c3xRhqWM8Tg5ewzr/Bzfv
Qzyyf+edyHOwCPyzjuAoBYqi5mktro0G0QLZMef2uP5HmnKM7vFLj+4JRVdBjuJX
YsViHWmX4IvqS3G4MPU4xDgh3DKNECwQBYGGMlTLPfICbzxGQsI=
=2ETJ
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
