Received: from eggs.gnu.org ([2001:4830:134:3::10]:43249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=358328803=Paul.Durrant@citrix.com>)
	id 1dUpMw-0007nz-3U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=358328803=Paul.Durrant@citrix.com>)
	id 1dUpMs-0001G5-UI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:14:02 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:65419
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=358328803=Paul.Durrant@citrix.com>)
	id 1dUpMs-0001Dl-Fx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:13:58 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Jul 2017 07:13:55 +0000
Message-ID: <fb883dba577345bbb28fcf2221776edd@AMSPEX02CL01.citrite.net>
References: <1499726403-10129-1-git-send-email-igor.druzhinin@citrix.com>
	<1499726403-10129-4-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1499726403-10129-4-git-send-email-igor.druzhinin@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/4] xen/mapcache: introduce
 xen_replace_cache_entry()
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
> Sent: 11 July 2017 00:40
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: Igor Druzhinin <igor.druzhinin@citrix.com>; sstabellini@kernel.org;
> Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
> <Paul.Durrant@citrix.com>; pbonzini@redhat.com
> Subject: [PATCH v3 3/4] xen/mapcache: introduce
> xen_replace_cache_entry()
>=20
> This new call is trying to update a requested map cache entry
> according to the changes in the physmap. The call is searching
> for the entry, unmaps it and maps again at the same place using
> a new guest address. If the mapping is dummy this call will
> make it real.
>=20
> This function makes use of a new xenforeignmemory_map2() call
> with an extended interface that was recently introduced in
> libxenforeignmemory [1].
>=20
> [1] https://www.mail-archive.com/xen-devel@lists.xen.org/msg113007.html
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

LGTM

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  configure                     | 18 +++++++++
>  hw/i386/xen/xen-mapcache.c    | 85
> +++++++++++++++++++++++++++++++++++++++----
>  include/hw/xen/xen_common.h   | 14 +++++++
>  include/sysemu/xen-mapcache.h | 11 +++++-
>  4 files changed, 119 insertions(+), 9 deletions(-)
>=20
> diff --git a/configure b/configure
> index c571ad1..ad6156b 100755
> --- a/configure
> +++ b/configure
> @@ -2021,6 +2021,24 @@ EOF
>      # Xen unstable
>      elif
>          cat > $TMPC <<EOF &&
> +#undef XC_WANT_COMPAT_MAP_FOREIGN_API
> +#include <xenforeignmemory.h>
> +int main(void) {
> +  xenforeignmemory_handle *xfmem;
> +
> +  xfmem =3D xenforeignmemory_open(0, 0);
> +  xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
> +
> +  return 0;
> +}
> +EOF
> +        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
> +      then
> +      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs"
> +      xen_ctrl_version=3D41000
> +      xen=3Dyes
> +    elif
> +        cat > $TMPC <<EOF &&
>  #undef XC_WANT_COMPAT_DEVICEMODEL_API
>  #define __XEN_TOOLS__
>  #include <xendevicemodel.h>
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index 39cb511..8bc63e0 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -151,6 +151,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f,
> void *opaque)
>  }
>=20
>  static void xen_remap_bucket(MapCacheEntry *entry,
> +                             void *vaddr,
>                               hwaddr size,
>                               hwaddr address_index,
>                               bool dummy)
> @@ -167,7 +168,9 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>      err =3D g_malloc0(nb_pfn * sizeof (int));
>=20
>      if (entry->vaddr_base !=3D NULL) {
> -        ram_block_notify_remove(entry->vaddr_base, entry->size);
> +        if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
> +            ram_block_notify_remove(entry->vaddr_base, entry->size);
> +        }
>          if (munmap(entry->vaddr_base, entry->size) !=3D 0) {
>              perror("unmap fails");
>              exit(-1);
> @@ -181,11 +184,11 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>      }
>=20
>      if (!dummy) {
> -        vaddr_base =3D xenforeignmemory_map(xen_fmem, xen_domid,
> -                                           PROT_READ | PROT_WRITE,
> +        vaddr_base =3D xenforeignmemory_map2(xen_fmem, xen_domid,
> vaddr,
> +                                           PROT_READ | PROT_WRITE, 0,
>                                             nb_pfn, pfns, err);
>          if (vaddr_base =3D=3D NULL) {
> -            perror("xenforeignmemory_map");
> +            perror("xenforeignmemory_map2");
>              exit(-1);
>          }
>      } else {
> @@ -193,7 +196,7 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>           * We create dummy mappings where we are unable to create a fore=
ign
>           * mapping immediately due to certain circumstances (i.e. on res=
ume
> now)
>           */
> -        vaddr_base =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> +        vaddr_base =3D mmap(vaddr, size, PROT_READ | PROT_WRITE,
>                            MAP_ANON | MAP_SHARED, -1, 0);
>          if (vaddr_base =3D=3D NULL) {
>              perror("mmap");
> @@ -201,6 +204,10 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>          }
>      }
>=20
> +    if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
> +        ram_block_notify_add(vaddr_base, size);
> +    }
> +
>      entry->vaddr_base =3D vaddr_base;
>      entry->paddr_index =3D address_index;
>      entry->size =3D size;
> @@ -213,7 +220,6 @@ static void xen_remap_bucket(MapCacheEntry
> *entry,
>          entry->flags &=3D ~(XEN_MAPCACHE_ENTRY_DUMMY);
>      }
>=20
> -    ram_block_notify_add(entry->vaddr_base, entry->size);
>      bitmap_zero(entry->valid_mapping, nb_pfn);
>      for (i =3D 0; i < nb_pfn; i++) {
>          if (!err[i]) {
> @@ -286,14 +292,14 @@ tryagain:
>      if (!entry) {
>          entry =3D g_malloc0(sizeof (MapCacheEntry));
>          pentry->next =3D entry;
> -        xen_remap_bucket(entry, cache_size, address_index, dummy);
> +        xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index !=3D address_index =
||
>                  entry->size !=3D cache_size ||
>                  !test_bits(address_offset >> XC_PAGE_SHIFT,
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
> -            xen_remap_bucket(entry, cache_size, address_index, dummy);
> +            xen_remap_bucket(entry, NULL, cache_size, address_index,
> dummy);
>          }
>      }
>=20
> @@ -490,3 +496,66 @@ void xen_invalidate_map_cache(void)
>=20
>      mapcache_unlock();
>  }
> +
> +static uint8_t *xen_replace_cache_entry_unlocked(hwaddr
> old_phys_addr,
> +                                                 hwaddr new_phys_addr,
> +                                                 hwaddr size)
> +{
> +    MapCacheEntry *entry;
> +    hwaddr address_index, address_offset;
> +    hwaddr test_bit_size, cache_size =3D size;
> +
> +    address_index  =3D old_phys_addr >> MCACHE_BUCKET_SHIFT;
> +    address_offset =3D old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +
> +    assert(size);
> +    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
> +    test_bit_size =3D size + (old_phys_addr & (XC_PAGE_SIZE - 1));
> +    if (test_bit_size % XC_PAGE_SIZE) {
> +        test_bit_size +=3D XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE)=
;
> +    }
> +    cache_size =3D size + address_offset;
> +    if (cache_size % MCACHE_BUCKET_SIZE) {
> +        cache_size +=3D MCACHE_BUCKET_SIZE - (cache_size %
> MCACHE_BUCKET_SIZE);
> +    }
> +
> +    entry =3D &mapcache->entry[address_index % mapcache->nr_buckets];
> +    while (entry && !(entry->paddr_index =3D=3D address_index &&
> +                      entry->size =3D=3D cache_size)) {
> +        entry =3D entry->next;
> +    }
> +    if (!entry) {
> +        DPRINTF("Trying to update an entry for %lx " \
> +                "that is not in the mapcache!\n", old_phys_addr);
> +        return NULL;
> +    }
> +
> +    address_index  =3D new_phys_addr >> MCACHE_BUCKET_SHIFT;
> +    address_offset =3D new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +
> +    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with %lx\n=
",
> +            old_phys_addr, new_phys_addr);
> +
> +    xen_remap_bucket(entry, entry->vaddr_base,
> +                     cache_size, address_index, false);
> +    if(!test_bits(address_offset >> XC_PAGE_SHIFT,
> +                test_bit_size >> XC_PAGE_SHIFT,
> +                entry->valid_mapping)) {
> +        DPRINTF("Unable to update a mapcache entry for %lx!\n",
> old_phys_addr);
> +        return NULL;
> +    }
> +
> +    return entry->vaddr_base + address_offset;
> +}
> +
> +uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> +                                 hwaddr new_phys_addr,
> +                                 hwaddr size)
> +{
> +    uint8_t *p;
> +
> +    mapcache_lock();
> +    p =3D xen_replace_cache_entry_unlocked(old_phys_addr,
> new_phys_addr, size);
> +    mapcache_unlock();
> +    return p;
> +}
> diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> index e00ddd7..e28ed48 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -78,6 +78,20 @@ static inline void
> *xenforeignmemory_map(xc_interface *h, uint32_t dom,
>=20
>  extern xenforeignmemory_handle *xen_fmem;
>=20
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
> +
> +static inline void *xenforeignmemory_map2(xenforeignmemory_handle
> *h,
> +                                          uint32_t dom, void *addr,
> +                                          int prot, int flags, size_t pa=
ges,
> +                                          const xen_pfn_t arr[/*pages*/]=
,
> +                                          int err[/*pages*/])
> +{
> +    assert(addr =3D=3D NULL && flags =3D=3D 0);
> +    return xenforeignmemory_map(h, dom, prot, pages, arr, err);
> +}
> +
> +#endif
> +
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
>=20
>  typedef xc_interface xendevicemodel_handle;
> diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-
> mapcache.h
> index 01daaad..b38962c 100644
> --- a/include/sysemu/xen-mapcache.h
> +++ b/include/sysemu/xen-mapcache.h
> @@ -21,7 +21,9 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr
> size,
>  ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
>  void xen_invalidate_map_cache_entry(uint8_t *buffer);
>  void xen_invalidate_map_cache(void);
> -
> +uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> +                                 hwaddr new_phys_addr,
> +                                 hwaddr size);
>  #else
>=20
>  static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
> @@ -50,6 +52,13 @@ static inline void xen_invalidate_map_cache(void)
>  {
>  }
>=20
> +uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> +                                 hwaddr new_phys_addr,
> +                                 hwaddr size)
> +{
> +    abort();
> +}
> +
>  #endif
>=20
>  #endif /* XEN_MAPCACHE_H */
> --
> 2.7.4
