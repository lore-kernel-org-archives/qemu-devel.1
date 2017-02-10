Received: from eggs.gnu.org ([2001:4830:134:3::10]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rb-00065W-Hg
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rZ-00025A-Gd
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:07 -0500
Date: Fri, 10 Feb 2017 11:41:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210004151.GQ27610@umbus.fritz.box>
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-2-aik@ozlabs.ru>
	<20170102233423.GH12761@umbus.fritz.box>
	<36816bd7-9fc5-17a1-b5c2-1bfd0ece7988@ozlabs.ru>
	<396ef8ef-78b2-8ec9-e4d6-b45b05daa93b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L0TNCHh3fkwjpuuE"
Content-Disposition: inline
In-Reply-To: <396ef8ef-78b2-8ec9-e4d6-b45b05daa93b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu 1/2] exec, kvm,
 target-ppc: Move getrampagesize() to common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:48:19PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 09/02/2017 06:43, Alexey Kardashevskiy wrote:
> > On 03/01/17 10:34, David Gibson wrote:
> >> On Thu, Dec 22, 2016 at 04:22:11PM +1100, Alexey Kardashevskiy wrote:
> >>> getrampagesize() returns the largest supported page size and mainly
> >>> used to know if huge pages are enabled.
> >>>
> >>> However is implemented in target-ppc/kvm.c and not available
> >>> in TCG or other architectures.
> >>>
> >>> This renames and moves gethugepagesize() to mmap-alloc.c where
> >>> fd-based analog of it is already implemented. This renames and moves
> >>> getrampagesize() to exec.c as it seems to be the common place for
> >>> helpers like this.
> >>>
> >>> This first user for it is going to be a spapr-pci-host-bridge which
> >>> needs to know the largest RAM page size so the guest could try
> >>> using bigger IOMMU pages to save memory.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>
> >> Seems sensible to me, but I'm not comfortable merging this via my tree
> >> since it touches such core code.  Probably should go via Paolo.
> >=20
> > Paolo, ping?
>=20
> It's just code movement, go ahead.

Ok, I've merged this in my tree.


>=20
> Paolo
>=20
> >=20
> >=20
> >>
> >>> ---
> >>>  include/exec/ram_addr.h   |   1 +
> >>>  include/qemu/mmap-alloc.h |   2 +
> >>>  exec.c                    |  82 ++++++++++++++++++++++++++++++++++++
> >>>  target-ppc/kvm.c          | 105 ++----------------------------------=
----------
> >>>  util/mmap-alloc.c         |  25 +++++++++++
> >>>  5 files changed, 113 insertions(+), 102 deletions(-)
> >>>
> >>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> >>> index 54d7108a9e..3935cbcfcd 100644
> >>> --- a/include/exec/ram_addr.h
> >>> +++ b/include/exec/ram_addr.h
> >>> @@ -91,6 +91,7 @@ typedef struct RAMList {
> >>>  } RAMList;
> >>>  extern RAMList ram_list;
> >>> =20
> >>> +long qemu_getrampagesize(void);
> >>>  ram_addr_t last_ram_offset(void);
> >>>  void qemu_mutex_lock_ramlist(void);
> >>>  void qemu_mutex_unlock_ramlist(void);
> >>> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> >>> index 933c024ac5..50385e3f81 100644
> >>> --- a/include/qemu/mmap-alloc.h
> >>> +++ b/include/qemu/mmap-alloc.h
> >>> @@ -5,6 +5,8 @@
> >>> =20
> >>>  size_t qemu_fd_getpagesize(int fd);
> >>> =20
> >>> +size_t qemu_mempath_getpagesize(const char *mem_path);
> >>> +
> >>>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> >>> =20
> >>>  void qemu_ram_munmap(void *ptr, size_t size);
> >>> diff --git a/exec.c b/exec.c
> >>> index 08c558eecf..d73b477a70 100644
> >>> --- a/exec.c
> >>> +++ b/exec.c
> >>> @@ -32,6 +32,7 @@
> >>>  #endif
> >>>  #include "sysemu/kvm.h"
> >>>  #include "sysemu/sysemu.h"
> >>> +#include "sysemu/numa.h"
> >>>  #include "qemu/timer.h"
> >>>  #include "qemu/config-file.h"
> >>>  #include "qemu/error-report.h"
> >>> @@ -1218,6 +1219,87 @@ void qemu_mutex_unlock_ramlist(void)
> >>>  }
> >>> =20
> >>>  #ifdef __linux__
> >>> +/*
> >>> + * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
> >>> + * may or may not name the same files / on the same filesystem now as
> >>> + * when we actually open and map them.  Iterate over the file
> >>> + * descriptors instead, and use qemu_fd_getpagesize().
> >>> + */
> >>> +static int find_max_supported_pagesize(Object *obj, void *opaque)
> >>> +{
> >>> +    char *mem_path;
> >>> +    long *hpsize_min =3D opaque;
> >>> +
> >>> +    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> >>> +        mem_path =3D object_property_get_str(obj, "mem-path", NULL);
> >>> +        if (mem_path) {
> >>> +            long hpsize =3D qemu_mempath_getpagesize(mem_path);
> >>> +            if (hpsize < *hpsize_min) {
> >>> +                *hpsize_min =3D hpsize;
> >>> +            }
> >>> +        } else {
> >>> +            *hpsize_min =3D getpagesize();
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +long qemu_getrampagesize(void)
> >>> +{
> >>> +    long hpsize =3D LONG_MAX;
> >>> +    long mainrampagesize;
> >>> +    Object *memdev_root;
> >>> +
> >>> +    if (mem_path) {
> >>> +        mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
> >>> +    } else {
> >>> +        mainrampagesize =3D getpagesize();
> >>> +    }
> >>> +
> >>> +    /* it's possible we have memory-backend objects with
> >>> +     * hugepage-backed RAM. these may get mapped into system
> >>> +     * address space via -numa parameters or memory hotplug
> >>> +     * hooks. we want to take these into account, but we
> >>> +     * also want to make sure these supported hugepage
> >>> +     * sizes are applicable across the entire range of memory
> >>> +     * we may boot from, so we take the min across all
> >>> +     * backends, and assume normal pages in cases where a
> >>> +     * backend isn't backed by hugepages.
> >>> +     */
> >>> +    memdev_root =3D object_resolve_path("/objects", NULL);
> >>> +    if (memdev_root) {
> >>> +        object_child_foreach(memdev_root, find_max_supported_pagesiz=
e, &hpsize);
> >>> +    }
> >>> +    if (hpsize =3D=3D LONG_MAX) {
> >>> +        /* No additional memory regions found =3D=3D> Report main RA=
M page size */
> >>> +        return mainrampagesize;
> >>> +    }
> >>> +
> >>> +    /* If NUMA is disabled or the NUMA nodes are not backed with a
> >>> +     * memory-backend, then there is at least one node using "normal=
" RAM,
> >>> +     * so if its page size is smaller we have got to report that siz=
e instead.
> >>> +     */
> >>> +    if (hpsize > mainrampagesize &&
> >>> +        (nb_numa_nodes =3D=3D 0 || numa_info[0].node_memdev =3D=3D N=
ULL)) {
> >>> +        static bool warned;
> >>> +        if (!warned) {
> >>> +            error_report("Huge page support disabled (n/a for main m=
emory).");
> >>> +            warned =3D true;
> >>> +        }
> >>> +        return mainrampagesize;
> >>> +    }
> >>> +
> >>> +    return hpsize;
> >>> +}
> >>> +#else
> >>> +long qemu_getrampagesize(void)
> >>> +{
> >>> +    return getpagesize();
> >>> +}
> >>> +#endif
> >>> +
> >>> +#ifdef __linux__
> >>>  static int64_t get_file_size(int fd)
> >>>  {
> >>>      int64_t size =3D lseek(fd, 0, SEEK_END);
> >>> diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
> >>> index 6e91a4d8bb..e0abffa8ad 100644
> >>> --- a/target-ppc/kvm.c
> >>> +++ b/target-ppc/kvm.c
> >>> @@ -42,6 +42,7 @@
> >>>  #include "trace.h"
> >>>  #include "exec/gdbstub.h"
> >>>  #include "exec/memattrs.h"
> >>> +#include "exec/ram_addr.h"
> >>>  #include "sysemu/hostmem.h"
> >>>  #include "qemu/cutils.h"
> >>>  #if defined(TARGET_PPC64)
> >>> @@ -325,106 +326,6 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, =
struct kvm_ppc_smmu_info *info)
> >>>      kvm_get_fallback_smmu_info(cpu, info);
> >>>  }
> >>> =20
> >>> -static long gethugepagesize(const char *mem_path)
> >>> -{
> >>> -    struct statfs fs;
> >>> -    int ret;
> >>> -
> >>> -    do {
> >>> -        ret =3D statfs(mem_path, &fs);
> >>> -    } while (ret !=3D 0 && errno =3D=3D EINTR);
> >>> -
> >>> -    if (ret !=3D 0) {
> >>> -        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> >>> -                strerror(errno));
> >>> -        exit(1);
> >>> -    }
> >>> -
> >>> -#define HUGETLBFS_MAGIC       0x958458f6
> >>> -
> >>> -    if (fs.f_type !=3D HUGETLBFS_MAGIC) {
> >>> -        /* Explicit mempath, but it's ordinary pages */
> >>> -        return getpagesize();
> >>> -    }
> >>> -
> >>> -    /* It's hugepage, return the huge page size */
> >>> -    return fs.f_bsize;
> >>> -}
> >>> -
> >>> -/*
> >>> - * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
> >>> - * may or may not name the same files / on the same filesystem now as
> >>> - * when we actually open and map them.  Iterate over the file
> >>> - * descriptors instead, and use qemu_fd_getpagesize().
> >>> - */
> >>> -static int find_max_supported_pagesize(Object *obj, void *opaque)
> >>> -{
> >>> -    char *mem_path;
> >>> -    long *hpsize_min =3D opaque;
> >>> -
> >>> -    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> >>> -        mem_path =3D object_property_get_str(obj, "mem-path", NULL);
> >>> -        if (mem_path) {
> >>> -            long hpsize =3D gethugepagesize(mem_path);
> >>> -            if (hpsize < *hpsize_min) {
> >>> -                *hpsize_min =3D hpsize;
> >>> -            }
> >>> -        } else {
> >>> -            *hpsize_min =3D getpagesize();
> >>> -        }
> >>> -    }
> >>> -
> >>> -    return 0;
> >>> -}
> >>> -
> >>> -static long getrampagesize(void)
> >>> -{
> >>> -    long hpsize =3D LONG_MAX;
> >>> -    long mainrampagesize;
> >>> -    Object *memdev_root;
> >>> -
> >>> -    if (mem_path) {
> >>> -        mainrampagesize =3D gethugepagesize(mem_path);
> >>> -    } else {
> >>> -        mainrampagesize =3D getpagesize();
> >>> -    }
> >>> -
> >>> -    /* it's possible we have memory-backend objects with
> >>> -     * hugepage-backed RAM. these may get mapped into system
> >>> -     * address space via -numa parameters or memory hotplug
> >>> -     * hooks. we want to take these into account, but we
> >>> -     * also want to make sure these supported hugepage
> >>> -     * sizes are applicable across the entire range of memory
> >>> -     * we may boot from, so we take the min across all
> >>> -     * backends, and assume normal pages in cases where a
> >>> -     * backend isn't backed by hugepages.
> >>> -     */
> >>> -    memdev_root =3D object_resolve_path("/objects", NULL);
> >>> -    if (memdev_root) {
> >>> -        object_child_foreach(memdev_root, find_max_supported_pagesiz=
e, &hpsize);
> >>> -    }
> >>> -    if (hpsize =3D=3D LONG_MAX) {
> >>> -        /* No additional memory regions found =3D=3D> Report main RA=
M page size */
> >>> -        return mainrampagesize;
> >>> -    }
> >>> -
> >>> -    /* If NUMA is disabled or the NUMA nodes are not backed with a
> >>> -     * memory-backend, then there is at least one node using "normal=
" RAM,
> >>> -     * so if its page size is smaller we have got to report that siz=
e instead.
> >>> -     */
> >>> -    if (hpsize > mainrampagesize &&
> >>> -        (nb_numa_nodes =3D=3D 0 || numa_info[0].node_memdev =3D=3D N=
ULL)) {
> >>> -        static bool warned;
> >>> -        if (!warned) {
> >>> -            error_report("Huge page support disabled (n/a for main m=
emory).");
> >>> -            warned =3D true;
> >>> -        }
> >>> -        return mainrampagesize;
> >>> -    }
> >>> -
> >>> -    return hpsize;
> >>> -}
> >>> -
> >>>  static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint=
32_t shift)
> >>>  {
> >>>      if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
> >>> @@ -454,7 +355,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >>>          has_smmu_info =3D true;
> >>>      }
> >>> =20
> >>> -    rampagesize =3D getrampagesize();
> >>> +    rampagesize =3D qemu_getrampagesize();
> >>> =20
> >>>      /* Convert to QEMU form */
> >>>      memset(&env->sps, 0, sizeof(env->sps));
> >>> @@ -2177,7 +2078,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size,=
 unsigned int hash_shift)
> >>>      /* Find the largest hardware supported page size that's less than
> >>>       * or equal to the (logical) backing page size of guest RAM */
> >>>      kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
> >>> -    rampagesize =3D getrampagesize();
> >>> +    rampagesize =3D qemu_getrampagesize();
> >>>      best_page_shift =3D 0;
> >>> =20
> >>>      for (i =3D 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {
> >>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >>> index 5a85aa3c89..564c79109c 100644
> >>> --- a/util/mmap-alloc.c
> >>> +++ b/util/mmap-alloc.c
> >>> @@ -39,6 +39,31 @@ size_t qemu_fd_getpagesize(int fd)
> >>>      return getpagesize();
> >>>  }
> >>> =20
> >>> +size_t qemu_mempath_getpagesize(const char *mem_path)
> >>> +{
> >>> +#ifdef CONFIG_LINUX
> >>> +    struct statfs fs;
> >>> +    int ret;
> >>> +
> >>> +    do {
> >>> +        ret =3D statfs(mem_path, &fs);
> >>> +    } while (ret !=3D 0 && errno =3D=3D EINTR);
> >>> +
> >>> +    if (ret !=3D 0) {
> >>> +        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
> >>> +                strerror(errno));
> >>> +        exit(1);
> >>> +    }
> >>> +
> >>> +    if (fs.f_type =3D=3D HUGETLBFS_MAGIC) {
> >>> +        /* It's hugepage, return the huge page size */
> >>> +        return fs.f_bsize;
> >>> +    }
> >>> +#endif
> >>> +
> >>> +    return getpagesize();
> >>> +}
> >>> +
> >>>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> >>>  {
> >>>      /*
> >>
> >=20
> >=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L0TNCHh3fkwjpuuE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQxPAAoJEGw4ysog2bOSxCgP/iP5PaahPQo0aZKdPAgKQGk4
Z0au9gJMpX8POi/P5e1vyYjTTVGytjE7b/vFmC0e5O2A/6zP8DoLYDR8Eb/ctU9j
EWj2cZiWf40BKJIRRNGhnnZQ4Befhd1TbC7ee0VgpVCA3cXqAZooSaWEjweQDlum
f6VdOqfsbzznumfSGHi+TUcPoFQm7thGfYlueL3oY+hXmNVzLF+WlWgggHEfD+Fz
U8et9hk3VWPmt8pIrJRK9lne9cXM9cKLHY437JtwEixNv6fo5xW3scn2G7hKV9yt
IPxaUjt8c3YWukwr1GDj7aVvsVD1In7CX/OQgQ/gVP7P85aOleiPkL/Aa3eepkeM
rUo30mIYCYcRPQIatC5QsW18peIVgVX249EnjhpvD4qZw1PcOrm4D2fcRgqNjk9W
ERVrzK66sspVICSSPWql6q6NPyKQab33QKUav3q3bpkf7FuqGBkBCz7R7WuVsNuF
ztx3HnITa38r+84Hv1VoWvK9cGl3ZhB1bBmuT0yeZohzRuh+TxQzMwdmd9MY2xQu
G5y18h89Y7K49vKNx5zNxJOyeHtI4pVCMgj8J6B81AUugH37CjScDCrRLe80pbPU
ukeqb5xcEVdphWs16Nnhrig9UpAgYb68p9wWRt1mr4KYjrqT9T6rPfWM4X/7CDJl
KHPCyjy04aQkJA4WDHf6
=MrGm
-----END PGP SIGNATURE-----

--L0TNCHh3fkwjpuuE--
