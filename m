Received: from eggs.gnu.org ([2001:4830:134:3::10]:42362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUS5g-0007q6-Rx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 02:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUS5d-0008DM-JD
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 02:59:28 -0500
References: <20181205050641.864-1-david@gibson.dropbear.id.au>
	<20181205050641.864-5-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <587369f0-d3aa-3494-33a9-f634dae65213@redhat.com>
Date: Wed, 5 Dec 2018 08:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181205050641.864-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFCv2 for-4.0 4/5] virtio-balloon: Use
 ram_block_discard_range() instead of raw madvise()
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

On 05.12.18 06:06, David Gibson wrote:
> Currently, virtio-balloon uses madvise() with MADV_DONTNEED to actually
> discard RAM pages inserted into the balloon.  This is basically a Linux
> only interface (MADV_DONTNEED exists on some other platforms, but doesn=
't
> always have the same semantics).  It also doesn't work on hugepages and=
 has
> some other limitations.
>=20
> It turns out that postcopy also needs to discard chunks of memory, and =
uses
> a better interface for it: ram_block_discard_range().  It doesn't cover
> every case, but it covers more than going direct to madvise() and this
> gives us a single place to update for more possibilities in future.
>=20
> There are some subtleties here to maintain the current balloon behaviou=
r:
>=20
> * For now, we just ignore requests to balloon in a hugepage backed regi=
on.
>   That matches current behaviour, because MADV_DONTNEED on a hugepage w=
ould
>   simply fail, and we ignore the error.
>=20
> * If host page size is > BALLOON_PAGE_SIZE we can frequently call this =
on
>   non-host-page-aligned addresses.  These would also fail in madvise(),
>   which we then ignored.  ram_block_discard_range() error_report()s cal=
ls
>   on unaligned addresses, so we explicitly check that case to avoid
>   spamming the logs.
>=20
> * We now call ram_block_discard_range() with the *host* page size, wher=
eas
>   we previously called madvise() with BALLOON_PAGE_SIZE.  Surprisingly,
>   this also matches existing behaviour.  Although the kernel fails madv=
ise
>   on unaligned addresses, it will round unaligned sizes *up* to the hos=
t
>   page size.  Yes, this means that if BALLOON_PAGE_SIZE < guest page si=
ze
>   we can incorrectly discard more memory than the guest asked us to.  I=
'm
>   planning to address that soon.
>=20
> Errors other than the ones discussed above, will now be reported by
> ram_block_discard_range(), rather than silently ignored, which means we
> have a much better chance of seeing when something is going wrong.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index c3a19aa27d..4435905c87 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -37,8 +37,29 @@ static void balloon_inflate_page(VirtIOBalloon *ball=
oon,
>                                   MemoryRegion *mr, hwaddr offset)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + offset;
> +    RAMBlock *rb;
> +    size_t rb_page_size;
> +    ram_addr_t ram_offset;
> =20
> -    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
> +    /* XXX is there a better way to get to the RAMBlock than via a
> +     * host address? */

We have qemu_get_ram_block(). That one should work as long as we know
that it is a valid guest ram address. (would have to make it !static)

Then we would only have to pass to this function the original ram_addr_t
handed over by the guest (which looks somewhat cleaner to me than going
via memory regions)

> +    rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> +    rb_page_size =3D qemu_ram_pagesize(rb);
> +
> +    /* Silently ignore hugepage RAM blocks */
> +    if (rb_page_size !=3D getpagesize()) {
> +        return;
> +    }
> +
> +    /* Silently ignore unaligned requests */
> +    if (ram_offset & (rb_page_size - 1)) {
> +        return;
> +    }
> +
> +    ram_block_discard_range(rb, ram_offset, rb_page_size);
> +    /* We ignore errors from ram_block_discard_range(), because it has
> +     * already reported them, and failing to discard a balloon page is
> +     * not fatal */
>  }
> =20
>  static const char *balloon_stat_names[] =3D {
>=20


--=20

Thanks,

David / dhildenb
