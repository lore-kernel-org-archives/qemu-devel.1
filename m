Received: from eggs.gnu.org ([2001:4830:134:3::10]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjHNv-00086O-Fb
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjHNt-0004S9-6G
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:26:31 -0500
Date: Thu, 2 Mar 2017 14:06:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170302030617.GO12571@umbus.fritz.box>
References: <20170302023611.15541-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <20170302023611.15541-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v4] exec, kvm,
 target-ppc: Move getrampagesize() to common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 01:36:11PM +1100, Alexey Kardashevskiy wrote:
> getrampagesize() returns the largest supported page size and mainly
> used to know if huge pages are enabled.
>=20
> However is implemented in target-ppc/kvm.c and not available
> in TCG or other architectures.
>=20
> This renames and moves gethugepagesize() to mmap-alloc.c where
> fd-based analog of it is already implemented. This renames and moves
> getrampagesize() to exec.c as it seems to be the common place for
> helpers like this.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied, thanks.

> ---
> Changes:
> v4:
> * removed numa.h from kvm.c as it is not needed there anymore
>=20
> v3:
> * in exec.c, moved "include numa.h" under #ifndef CONFIG_USER_ONLY to
> fix linux-user target build
>=20
> v2:
> * rebased on top of ppc-for-2.9-20170301
> ---
>  include/exec/ram_addr.h   |   1 +
>  include/qemu/mmap-alloc.h |   2 +
>  exec.c                    |  82 ++++++++++++++++++++++++++++++++++
>  target/ppc/kvm.c          | 109 +++-------------------------------------=
------
>  util/mmap-alloc.c         |  25 +++++++++++
>  5 files changed, 115 insertions(+), 104 deletions(-)
>=20
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 3e79466a44..cd432e73ae 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -52,6 +52,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_a=
ddr_t offset)
>      return (char *)block->host + offset;
>  }
> =20
> +long qemu_getrampagesize(void);
>  ram_addr_t last_ram_offset(void);
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>                                     bool share, const char *mem_path,
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index 933c024ac5..50385e3f81 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -5,6 +5,8 @@
> =20
>  size_t qemu_fd_getpagesize(int fd);
> =20
> +size_t qemu_mempath_getpagesize(const char *mem_path);
> +
>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> =20
>  void qemu_ram_munmap(void *ptr, size_t size);
> diff --git a/exec.c b/exec.c
> index 3adf2b1861..4c90cbf366 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -42,6 +42,7 @@
>  #include "exec/memory.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/numa.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace-root.h"
> @@ -1251,6 +1252,87 @@ void qemu_mutex_unlock_ramlist(void)
>  }
> =20
>  #ifdef __linux__
> +/*
> + * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
> + * may or may not name the same files / on the same filesystem now as
> + * when we actually open and map them.  Iterate over the file
> + * descriptors instead, and use qemu_fd_getpagesize().
> + */
> +static int find_max_supported_pagesize(Object *obj, void *opaque)
> +{
> +    char *mem_path;
> +    long *hpsize_min =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> +        mem_path =3D object_property_get_str(obj, "mem-path", NULL);
> +        if (mem_path) {
> +            long hpsize =3D qemu_mempath_getpagesize(mem_path);
> +            if (hpsize < *hpsize_min) {
> +                *hpsize_min =3D hpsize;
> +            }
> +        } else {
> +            *hpsize_min =3D getpagesize();
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +long qemu_getrampagesize(void)
> +{
> +    long hpsize =3D LONG_MAX;
> +    long mainrampagesize;
> +    Object *memdev_root;
> +
> +    if (mem_path) {
> +        mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> +    } else {
> +        mainrampagesize =3D getpagesize();
> +    }
> +
> +    /* it's possible we have memory-backend objects with
> +     * hugepage-backed RAM. these may get mapped into system
> +     * address space via -numa parameters or memory hotplug
> +     * hooks. we want to take these into account, but we
> +     * also want to make sure these supported hugepage
> +     * sizes are applicable across the entire range of memory
> +     * we may boot from, so we take the min across all
> +     * backends, and assume normal pages in cases where a
> +     * backend isn't backed by hugepages.
> +     */
> +    memdev_root =3D object_resolve_path("/objects", NULL);
> +    if (memdev_root) {
> +        object_child_foreach(memdev_root, find_max_supported_pagesize, &=
hpsize);
> +    }
> +    if (hpsize =3D=3D LONG_MAX) {
> +        /* No additional memory regions found =3D=3D> Report main RAM pa=
ge size */
> +        return mainrampagesize;
> +    }
> +
> +    /* If NUMA is disabled or the NUMA nodes are not backed with a
> +     * memory-backend, then there is at least one node using "normal" RA=
M,
> +     * so if its page size is smaller we have got to report that size in=
stead.
> +     */
> +    if (hpsize > mainrampagesize &&
> +        (nb_numa_nodes =3D=3D 0 || numa_info[0].node_memdev =3D=3D NULL)=
) {
> +        static bool warned;
> +        if (!warned) {
> +            error_report("Huge page support disabled (n/a for main memor=
y).");
> +            warned =3D true;
> +        }
> +        return mainrampagesize;
> +    }
> +
> +    return hpsize;
> +}
> +#else
> +long qemu_getrampagesize(void)
> +{
> +    return getpagesize();
> +}
> +#endif
> +
> +#ifdef __linux__
>  static int64_t get_file_size(int fd)
>  {
>      int64_t size =3D lseek(fd, 0, SEEK_END);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 18f33f2d93..0b8763cda5 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -28,7 +28,6 @@
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
> -#include "sysemu/numa.h"
>  #include "kvm_ppc.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/device_tree.h"
> @@ -43,8 +42,10 @@
>  #include "trace.h"
>  #include "exec/gdbstub.h"
>  #include "exec/memattrs.h"
> +#include "exec/ram_addr.h"
>  #include "sysemu/hostmem.h"
>  #include "qemu/cutils.h"
> +#include "qemu/mmap-alloc.h"
>  #if defined(TARGET_PPC64)
>  #include "hw/ppc/spapr_cpu_core.h"
>  #endif
> @@ -331,106 +332,6 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, stru=
ct kvm_ppc_smmu_info *info)
>      kvm_get_fallback_smmu_info(cpu, info);
>  }
> =20
> -static long gethugepagesize(const char *mem_path)
> -{
> -    struct statfs fs;
> -    int ret;
> -
> -    do {
> -        ret =3D statfs(mem_path, &fs);
> -    } while (ret !=3D 0 && errno =3D=3D EINTR);
> -
> -    if (ret !=3D 0) {
> -        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> -                strerror(errno));
> -        exit(1);
> -    }
> -
> -#define HUGETLBFS_MAGIC       0x958458f6
> -
> -    if (fs.f_type !=3D HUGETLBFS_MAGIC) {
> -        /* Explicit mempath, but it's ordinary pages */
> -        return getpagesize();
> -    }
> -
> -    /* It's hugepage, return the huge page size */
> -    return fs.f_bsize;
> -}
> -
> -/*
> - * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
> - * may or may not name the same files / on the same filesystem now as
> - * when we actually open and map them.  Iterate over the file
> - * descriptors instead, and use qemu_fd_getpagesize().
> - */
> -static int find_max_supported_pagesize(Object *obj, void *opaque)
> -{
> -    char *mem_path;
> -    long *hpsize_min =3D opaque;
> -
> -    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> -        mem_path =3D object_property_get_str(obj, "mem-path", NULL);
> -        if (mem_path) {
> -            long hpsize =3D gethugepagesize(mem_path);
> -            if (hpsize < *hpsize_min) {
> -                *hpsize_min =3D hpsize;
> -            }
> -        } else {
> -            *hpsize_min =3D getpagesize();
> -        }
> -    }
> -
> -    return 0;
> -}
> -
> -static long getrampagesize(void)
> -{
> -    long hpsize =3D LONG_MAX;
> -    long mainrampagesize;
> -    Object *memdev_root;
> -
> -    if (mem_path) {
> -        mainrampagesize =3D gethugepagesize(mem_path);
> -    } else {
> -        mainrampagesize =3D getpagesize();
> -    }
> -
> -    /* it's possible we have memory-backend objects with
> -     * hugepage-backed RAM. these may get mapped into system
> -     * address space via -numa parameters or memory hotplug
> -     * hooks. we want to take these into account, but we
> -     * also want to make sure these supported hugepage
> -     * sizes are applicable across the entire range of memory
> -     * we may boot from, so we take the min across all
> -     * backends, and assume normal pages in cases where a
> -     * backend isn't backed by hugepages.
> -     */
> -    memdev_root =3D object_resolve_path("/objects", NULL);
> -    if (memdev_root) {
> -        object_child_foreach(memdev_root, find_max_supported_pagesize, &=
hpsize);
> -    }
> -    if (hpsize =3D=3D LONG_MAX) {
> -        /* No additional memory regions found =3D=3D> Report main RAM pa=
ge size */
> -        return mainrampagesize;
> -    }
> -
> -    /* If NUMA is disabled or the NUMA nodes are not backed with a
> -     * memory-backend, then there is at least one node using "normal" RA=
M,
> -     * so if its page size is smaller we have got to report that size in=
stead.
> -     */
> -    if (hpsize > mainrampagesize &&
> -        (nb_numa_nodes =3D=3D 0 || numa_info[0].node_memdev =3D=3D NULL)=
) {
> -        static bool warned;
> -        if (!warned) {
> -            error_report("Huge page support disabled (n/a for main memor=
y).");
> -            warned =3D true;
> -        }
> -        return mainrampagesize;
> -    }
> -
> -    return hpsize;
> -}
> -
>  static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t=
 shift)
>  {
>      if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
> @@ -462,7 +363,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
> =20
>      if (!max_cpu_page_size) {
> -        max_cpu_page_size =3D getrampagesize();
> +        max_cpu_page_size =3D qemu_getrampagesize();
>      }
> =20
>      /* Convert to QEMU form */
> @@ -523,7 +424,7 @@ bool kvmppc_is_mem_backend_page_size_ok(char *obj_pat=
h)
>      long pagesize;
> =20
>      if (mempath) {
> -        pagesize =3D gethugepagesize(mempath);
> +        pagesize =3D qemu_mempath_getpagesize(mempath);
>      } else {
>          pagesize =3D getpagesize();
>      }
> @@ -2207,7 +2108,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
>      /* Find the largest hardware supported page size that's less than
>       * or equal to the (logical) backing page size of guest RAM */
>      kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
> -    rampagesize =3D getrampagesize();
> +    rampagesize =3D qemu_getrampagesize();
>      best_page_shift =3D 0;
> =20
>      for (i =3D 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 2f55f5e94f..3ec029a9ea 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -40,6 +40,31 @@ size_t qemu_fd_getpagesize(int fd)
>      return getpagesize();
>  }
> =20
> +size_t qemu_mempath_getpagesize(const char *mem_path)
> +{
> +#ifdef CONFIG_LINUX
> +    struct statfs fs;
> +    int ret;
> +
> +    do {
> +        ret =3D statfs(mem_path, &fs);
> +    } while (ret !=3D 0 && errno =3D=3D EINTR);
> +
> +    if (ret !=3D 0) {
> +        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> +                strerror(errno));
> +        exit(1);
> +    }
> +
> +    if (fs.f_type =3D=3D HUGETLBFS_MAGIC) {
> +        /* It's hugepage, return the huge page size */
> +        return fs.f_bsize;
> +    }
> +#endif
> +
> +    return getpagesize();
> +}
> +
>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>  {
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYt4wnAAoJEGw4ysog2bOSMiEQAL3sQAY6qX0lNwbSzaaQ5F+0
TrUiVEmy7jzxIcMUz8uX0GEUBEimX5LII7MbuAdh1/JAZt4ME15ep8l67akE0keh
fOvguIpxcpiAHPuIZ2j7VpgHlQ3gLS8vgAY6dw1dmTLy4HgNWhnxMUdbGl/Xo7jd
MS0SmMO0pJEpOAmY/fVmSL7V75ytQSLrCkj+/SxOm3BnCPZZ51IgNYCRDHE23/oK
s1mZTTflqsVNA1u/6R5wg/HpHjeLKO80KM3Tki2rWkzbuzwqC0maHbT0nvSeORyz
MgsZ3YYIjOaPHTA6QPxKDr/+arza23Co6fp/Qj7YNG3KxU/NHC+hMheqtF0ECnDs
Xg79bEyKVzw7KWIeyh0XiAcFYcNFWbHkjqaHgKlCw77gtgW09spmhZPVHvUoerwS
X5hPZzxVIFSuKLIimAnn2rWEp8t2QQqDMyL7sfmk7XvAQ2kvqsk5HdN38bNr/1qb
N9BKYOYVYkkLAfhBx24pf+XVz/7fEfUtUVizwSuQySaeqpFYvbJIo3TWsVBthPbE
63IDAOZjzcNu6NEQZl296nwsmcmtSg1z0ClLGgXdGWKWFlyKytvX74Y0lAB6xu75
m0M7RQ0LA+oe1jJ93VMm3CtYjcKQGj9OrZ5D1lCHieZeP13zYEmMk/96Ye4LMSpR
51K3SMza2a22ZPBYwYCg
=kM7m
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
