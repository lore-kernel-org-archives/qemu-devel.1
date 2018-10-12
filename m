Received: from eggs.gnu.org ([2001:4830:134:3::10]:49007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAsTL-0004tw-Lw
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAsTJ-0002ll-BP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:06:59 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-6-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f21b8a98-3401-cf82-749d-2101fbe69a33@redhat.com>
Date: Fri, 12 Oct 2018 10:06:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181012032431.32693-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/10/2018 05:24, David Gibson wrote:
> The virtio-balloon always works in units of 4kiB (BALLOON_PAGE_SIZE), b=
ut
> on the host side, we can only actually discard memory in units of the h=
ost
> page size.
>=20
> At present we handle this very badly: we silently ignore balloon reques=
ts
> that aren't host page aligned, and for requests that are host page alig=
ned
> we discard the entire host page.  The latter potentially corrupts guest
> memory if its page size is smaller than the host's.
>=20
> We could just disable the balloon if the host page size is not 4kiB, bu=
t
> that would break a the special case where host and guest have the same =
page
> size, but that's larger than 4kiB.  Thius case currently works by accid=
ent:
> when the guest puts its page into the balloon, it will submit balloon
> requests for each 4kiB subpage.  Most will be ignored, but the one whic=
h
> happens to be host page aligned will discard the whole lot.

Actually I would vote for disabling it if the host page size is not 4k.
This is broken by design and should not be worked around.

I consider 64k a similar case as huge pages in the hypervisor (from a
virtio-balloon interface point of view - which is broken by design for
these cases).

>=20
> This occurs in practice routinely for POWER KVM systems, since both hos=
t
> and guest typically use 64kiB pages.
>=20
> To make this safe, without breaking that useful case, we need to
> accumulate 4kiB balloon requests until we have a whole contiguous host =
page
> at which point we can discard it.

... and if you have a 4k guest it will just randomly report pages and
your 67 LOC tweak is useless. And this can and will easily happen.

>=20
> We could in principle do that across all guest memory, but it would req=
uire
> a large bitmap to track.  This patch represents a compromise: instead w=
e

Oh god no, no tracking of all memory. (size of bitmap, memory hotplug,
... migration?)

> track ballooned subpages for a single contiguous host page at a time.  =
This
> means that if the guest discards all 4kiB chunks of a host page in
> succession, we will discard it.  In particular that means the balloon w=
ill
> continue to work for the (host page size) =3D=3D (guest page size) > 4k=
iB case.
>=20
> If the guest scatters 4kiB requests across different host pages, we don=
't
> discard anything, and issue a warning.  Not ideal, but at least we don'=
t
> corrupt guest memory as the previous version could.

My take would be to somehow disable the balloon on the hypervisor side
in case the host page size is not 4k. Like not allowing to realize it.
No corruptions, no warnings people will ignore.

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c         | 67 +++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-balloon.h |  3 ++
>  2 files changed, 60 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 4435905c87..39573ef2e3 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -33,33 +33,80 @@
> =20
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> =20
> +typedef struct PartiallyBalloonedPage {
> +    RAMBlock *rb;
> +    ram_addr_t base;
> +    unsigned long bitmap[];
> +} PartiallyBalloonedPage;
> +
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>                                   MemoryRegion *mr, hwaddr offset)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + offset;
>      RAMBlock *rb;
>      size_t rb_page_size;
> -    ram_addr_t ram_offset;
> +    int subpages;
> +    ram_addr_t ram_offset, host_page_base;
> =20
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
>      rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> +    host_page_base =3D ram_offset & ~(rb_page_size - 1);
> +
> +    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
> +        /* Easy case */
> =20
> -    /* Silently ignore hugepage RAM blocks */
> -    if (rb_page_size !=3D getpagesize()) {
> +        ram_block_discard_range(rb, ram_offset, rb_page_size);
> +        /* We ignore errors from ram_block_discard_range(), because it
> +         * has already reported them, and failing to discard a balloon
> +         * page is not fatal */
>          return;
>      }
> =20
> -    /* Silently ignore unaligned requests */
> -    if (ram_offset & (rb_page_size - 1)) {
> -        return;
> +    /* Hard case
> +     *
> +     * We've put a piece of a larger host page into the balloon - we
> +     * need to keep track until we have a whole host page to
> +     * discard
> +     */
> +    subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> +
> +    if (balloon->pbp
> +        && (rb !=3D balloon->pbp->rb
> +            || host_page_base !=3D balloon->pbp->base)) {
> +        /* We've partially ballooned part of a host page, but now
> +         * we're trying to balloon part of a different one.  Too hard,
> +         * give up on the old partial page */
> +        warn_report("Unable to insert a partial page into virtio-ballo=
on");

I am pretty sure that you can create misleading warnings in case you
migrate at the wrong time. (migrate while half the 64k page is inflated,
on the new host the other part is inflated - a warning when switching to
another 64k page).

> +        free(balloon->pbp);
> +        balloon->pbp =3D NULL;
>      }
> =20
> -    ram_block_discard_range(rb, ram_offset, rb_page_size);
> -    /* We ignore errors from ram_block_discard_range(), because it has
> -     * already reported them, and failing to discard a balloon page is
> -     * not fatal */
> +    if (!balloon->pbp) {
> +        /* Starting on a new host page */
> +        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned lo=
ng);
> +        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bi=
tlen);
> +        balloon->pbp->rb =3D rb;
> +        balloon->pbp->base =3D host_page_base;
> +    }
> +
> +    bitmap_set(balloon->pbp->bitmap,
> +               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +               subpages);
> +
> +    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> +        /* We've accumulated a full host page, we can actually discard
> +         * it now */
> +
> +        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
> +        /* We ignore errors from ram_block_discard_range(), because it
> +         * has already reported them, and failing to discard a balloon
> +         * page is not fatal */
> +
> +        free(balloon->pbp);
> +        balloon->pbp =3D NULL;
> +    }
>  }
No, not a fan of this approach.

--=20

Thanks,

David / dhildenb
