Received: from eggs.gnu.org ([2001:4830:134:3::10]:55106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAssG-0005Sd-GT
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAssD-0001AD-88
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:32:44 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-6-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2ac28cb3-376c-8137-41f5-8dc6216eef1e@redhat.com>
Date: Fri, 12 Oct 2018 10:32:34 +0200
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
>=20
> This occurs in practice routinely for POWER KVM systems, since both hos=
t
> and guest typically use 64kiB pages.
>=20
> To make this safe, without breaking that useful case, we need to
> accumulate 4kiB balloon requests until we have a whole contiguous host =
page
> at which point we can discard it.
>=20
> We could in principle do that across all guest memory, but it would req=
uire
> a large bitmap to track.  This patch represents a compromise: instead w=
e
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

BTW, it might be easier to only remember the last inflated page and
incrementing it when you see the successor.

initialize last_page to -1ull on realize/reset


if (QEMU_IS_ALIGNED(addr, PAGE_SIZE)) {
	/* start of a new potential page block */
	last_page =3D=3D addr;
} else if (addr =3D=3D last_page + BALLOON_PAGE_SIZE) {
	/* next successor */
	last_page =3D=3D addr;
	if (QEMU_IS_ALIGNED(last_page + BALLOON_PAGE_SIZE, PAGE_SIZE)) {
		ramblock_discard()....
	}
} else {
	last_page =3D -1ull;
}


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
> =20
>  static const char *balloon_stat_names[] =3D {
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
> index e0df3528c8..99dcd6d105 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -30,6 +30,8 @@ typedef struct virtio_balloon_stat_modern {
>         uint64_t val;
>  } VirtIOBalloonStatModern;
> =20
> +typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> +
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
>      VirtQueue *ivq, *dvq, *svq;
> @@ -42,6 +44,7 @@ typedef struct VirtIOBalloon {
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
>      uint32_t host_features;
> +    PartiallyBalloonedPage *pbp;
>  } VirtIOBalloon;
> =20
>  #endif
>=20


--=20

Thanks,

David / dhildenb
