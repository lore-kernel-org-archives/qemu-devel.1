Received: from eggs.gnu.org ([209.51.188.92]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1ArH-0008S7-DK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1ArF-0005Tb-EK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:15:51 -0500
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
	<20190305051134.27930-3-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
Date: Tue, 5 Mar 2019 15:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190305051134.27930-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 2/2] virtio-balloon: Restore MADV_WILLNEED
 hint on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 05.03.19 06:11, David Gibson wrote:
> Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
> deflate", the balloon device issued an madvise() MADV_WILLNEED on
> pages removed from the balloon.  That would hint to the host kernel
> that the pages were likely to be needed by the guest in the near
> future.
>=20
> It's unclear if this is actually valuable or not, and so f6deb6d9
> removed this, essentially ignoring balloon deflate requests.  However,
> concerns have been raised that this might cause a performance
> regression by causing extra latency for the guest in certain
> configurations.

I mean, it will mainly create page tables as far as I know. Any write to
a page will have an overhead either way (COW zero page). Reads *might*
be faster.

As we are working on 4k granularity in the balloon (and doing
MADV_DONTNEED on 4k granularity!), there will most probably be page
tables already either way. A page table could only be zapped if all
pages of that page table are MADV_DONTNEED'ed (or I assume never were
touched), and I am not sure if "random MADV_DONTNEED'ing of 4k pages"
will actually get rid of page tables (my assumption would be: only if a
complete range is zapped at once). I haven't looked into the details,
though (plenty of other stuff to do).

I am not sure if I share the concerns. Real-time workload should never
use the virtio-balloon in a way that anything like that would be possible=
.

>=20
> So, until we can get actual benchmark data to see if that's the case,
> this restores (by default) the old behaviour, issuing a MADV_WILLNEED
> when a page is removed from the balloon.  A new property on the
> balloon device "hint-on-deflate" can be set to false to remove this
> behaviour for testing.

This is certainly a good approach for you to finally be able to leave
the ugly land of virtio-balloon :)

But at least to me, this looks completely useless. I'll be happy to be
proven wrong as always :)

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c         | 15 +++++++++++++++
>  include/hw/virtio/virtio-balloon.h |  1 +
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e5e82b556d..69968502d9 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -146,6 +146,20 @@ static void balloon_deflate_page(VirtIOBalloon *ba=
lloon,
>              balloon->pbp =3D NULL;
>          }
>      }
> +
> +    if (balloon->hint_on_deflate) {
> +        void *host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size =
- 1));
> +        int ret;
> +
> +        /* When a page is deflated, we hint the whole host page it
> +         * lives on, since we can't do anything smaller */
> +        ret =3D qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNE=
ED);
> +        if (ret !=3D 0) {
> +            warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s=
",
> +                        strerror(errno));
> +            /* Otherwise ignore, failing to page hint shouldn't be fat=
al */
> +        }
> +    }
>  }
> =20
>  static const char *balloon_stat_names[] =3D {
> @@ -622,6 +636,7 @@ static const VMStateDescription vmstate_virtio_ball=
oon =3D {
>  static Property virtio_balloon_properties[] =3D {
>      DEFINE_PROP_BIT("deflate-on-oom", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> +    DEFINE_PROP_BOOL("hint-on-deflate", VirtIOBalloon, hint_on_deflate=
, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
> index 99dcd6d105..69732cedaa 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -45,6 +45,7 @@ typedef struct VirtIOBalloon {
>      int64_t stats_poll_interval;
>      uint32_t host_features;
>      PartiallyBalloonedPage *pbp;
> +    bool hint_on_deflate;
>  } VirtIOBalloon;
> =20
>  #endif
>=20


--=20

Thanks,

David / dhildenb
