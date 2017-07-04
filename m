Received: from eggs.gnu.org ([2001:4830:134:3::10]:33230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQQN-0001Ge-V8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQQJ-0001VD-VU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:11:39 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:25442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=351b3ad51=Paul.Durrant@citrix.com>)
	id 1dSQQJ-0001SZ-Ge
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:11:35 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 4 Jul 2017 16:11:32 +0000
Message-ID: <f5b0fc3b3b4a42deb7a9359b6c3845d0@AMSPEX02CL01.citrite.net>
References: <1499183267-28623-1-git-send-email-igor.druzhinin@citrix.com>
	<1499183267-28623-3-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1499183267-28623-3-git-send-email-igor.druzhinin@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/4] xen/mapcache: add an ability to
 create dummy mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

> -----Original Message-----
> From: Igor Druzhinin
> Sent: 04 July 2017 16:48
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: Igor Druzhinin <igor.druzhinin@citrix.com>; sstabellini@kernel.org;
> Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
> <Paul.Durrant@citrix.com>; pbonzini@redhat.com
> Subject: [PATCH v2 2/4] xen/mapcache: add an ability to create dummy
> mappings
>=20
> Dummys are simple anonymous mappings that are placed instead
> of regular foreign mappings in certain situations when we need
> to postpone the actual mapping but still have to give a
> memory region to QEMU to play with.
>=20
> This is planned to be used for restore on Xen.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  hw/i386/xen/xen-mapcache.c | 40
> ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index e60156c..cd4e746 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -53,6 +53,8 @@ typedef struct MapCacheEntry {
>      uint8_t *vaddr_base;
>      unsigned long *valid_mapping;
>      uint8_t lock;
> +#define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
> +    uint8_t flags;
>      hwaddr size;
>      struct MapCacheEntry *next;
>  } MapCacheEntry;
> @@ -150,7 +152,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f,
> void *opaque)
>=20
>  static void xen_remap_bucket(MapCacheEntry *entry,
>                               hwaddr size,
> -                             hwaddr address_index)
> +                             hwaddr address_index,
> +                             bool dummy)
>  {
>      uint8_t *vaddr_base;
>      xen_pfn_t *pfns;
> @@ -177,11 +180,27 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>          pfns[i] =3D (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT=
))
> + i;
>      }
>=20
> -    vaddr_base =3D xenforeignmemory_map(xen_fmem, xen_domid,
> PROT_READ|PROT_WRITE,
> -                                      nb_pfn, pfns, err);
> -    if (vaddr_base =3D=3D NULL) {
> -        perror("xenforeignmemory_map");
> -        exit(-1);
> +    if (!dummy) {
> +        vaddr_base =3D xenforeignmemory_map(xen_fmem, xen_domid,
> +                                           PROT_READ|PROT_WRITE,
> +                                           nb_pfn, pfns, err);
> +        if (vaddr_base =3D=3D NULL) {
> +            perror("xenforeignmemory_map");
> +            exit(-1);
> +        }
> +        entry->flags &=3D ~(XEN_MAPCACHE_ENTRY_DUMMY);
> +    } else {
> +        /*
> +         * We create dummy mappings where we are unable to create a fore=
ign
> +         * mapping immediately due to certain circumstances (i.e. on res=
ume
> now)
> +         */
> +        vaddr_base =3D mmap(NULL, size, PROT_READ|PROT_WRITE,
> +                          MAP_ANON|MAP_SHARED, -1, 0);
> +        if (vaddr_base =3D=3D NULL) {
> +            perror("mmap");
> +            exit(-1);
> +        }
> +        entry->flags |=3D XEN_MAPCACHE_ENTRY_DUMMY;
>      }
>=20
>      entry->vaddr_base =3D vaddr_base;
> @@ -211,6 +230,7 @@ static uint8_t *xen_map_cache_unlocked(hwaddr
> phys_addr, hwaddr size,
>      hwaddr cache_size =3D size;
>      hwaddr test_bit_size;
>      bool translated =3D false;
> +    bool dummy =3D false;
>=20
>  tryagain:
>      address_index  =3D phys_addr >> MCACHE_BUCKET_SHIFT;
> @@ -262,14 +282,14 @@ tryagain:
>      if (!entry) {
>          entry =3D g_malloc0(sizeof (MapCacheEntry));
>          pentry->next =3D entry;
> -        xen_remap_bucket(entry, cache_size, address_index);
> +        xen_remap_bucket(entry, cache_size, address_index, dummy);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index !=3D address_index =
||
>                  entry->size !=3D cache_size ||
>                  !test_bits(address_offset >> XC_PAGE_SHIFT,
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
> -            xen_remap_bucket(entry, cache_size, address_index);
> +            xen_remap_bucket(entry, cache_size, address_index, dummy);
>          }
>      }
>=20
> @@ -282,6 +302,10 @@ tryagain:
>              translated =3D true;
>              goto tryagain;
>          }
> +        if (!dummy && runstate_check(RUN_STATE_INMIGRATE)) {
> +            dummy =3D true;
> +            goto tryagain;
> +        }
>          trace_xen_map_cache_return(NULL);
>          return NULL;
>      }
> --
> 2.7.4
