Received: from eggs.gnu.org ([209.51.188.92]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gpZ6Y-0006dD-Lw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gpZ6X-0003FQ-AS
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:43:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1gpZ6P-00035W-Ck
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:43:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x11DTLlV120683
	for <qemu-devel@nongnu.org>; Fri, 1 Feb 2019 08:43:16 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qcpmqj11j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:43:15 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 1 Feb 2019 13:43:13 -0000
Date: Fri, 1 Feb 2019 19:13:08 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20190130233605.22163-1-muriloo@linux.ibm.com>
	<20190130233605.22163-3-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130233605.22163-3-muriloo@linux.ibm.com>
Message-Id: <20190201134308.GA26981@dhcp-9-109-195-223.in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 30, 2019 at 09:36:05PM -0200, Murilo Opsfelder Araujo wrote:
> The commit 7197fb4058bcb68986bae2bb2c04d6370f3e7218 ("util/mmap-alloc:
> fix hugetlb support on ppc64") fixed Huge TLB mappings on ppc64.
> 
> However, we still need to consider the underlying huge page size
> during munmap() because it requires that both address and length be a
> multiple of the underlying huge page size for Huge TLB mappings.
> Quote from "Huge page (Huge TLB) mappings" paragraph under NOTES
> section of the munmap(2) manual:
> 
>   "For munmap(), addr and length must both be a multiple of the
>   underlying huge page size."
> 
> On ppc64, the munmap() in qemu_ram_munmap() does not work for Huge TLB
> mappings because the mapped segment can be aligned with the underlying
> huge page size, not aligned with the native system page size, as
> returned by getpagesize().
> 
> This has the side effect of not releasing huge pages back to the pool
> after a hugetlbfs file-backed memory device is hot-unplugged.
> 
> This patch fixes the situation in qemu_ram_mmap() and
> qemu_ram_munmap() by considering the underlying page size on ppc64.
> 
> After this patch, memory hot-unplug releases huge pages back to the
> pool.
> 
> Fixes: 7197fb4058bcb68986bae2bb2c04d6370f3e7218
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

I tried to test the patch in POWER8,

Distro: Fedora
Host Kernel: 5.0.0-rc3-gdbaaa7d30 (upstream)
Guest Kernel: 5.0.0-rc3-gdbaaa7d30 (upstream)
Qemu: 3.1.50 (v3.1.0-1313-gbd08d7ec4d-dirty) (upstream)
+ mmap-alloc: unfold qemu_ram_mmap()
+ mmap-alloc: fix hugetlbfs misaligned length in ppc64

1. object_add and object_del works,

Allocated 256M from host with 16M Hugepage
# echo 16 > /proc/sys/vm/nr_hugepages

# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:       16
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

(qemu) object_add memory-backend-file,id=mem1,size=256M,mem-path=/dev/hugepages
# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:       16
HugePages_Rsvd:       16
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

(qemu) object_del mem1

# cat /proc/meminfo | grep Huge
AnonHugePages:    671744 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:       16
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

2. Perform complete hotplug-hotunplug works,

Hotplug memory:

(qemu) object_add memory-backend-file,id=mem1,size=256M,mem-path=/dev/hugepages

On Host:
# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:       16
HugePages_Rsvd:       16
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

(qemu) device_add pc-dimm,id=dimm1,memdev=mem1

# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

Inside guest:
[   27.380848] pseries-hotplug-mem: Attempting to hot-add 1 LMB(s) at index 80000010
[   27.420225] lpar: Attempting to resize HPT to shift 23
[   27.619202] lpar: Hash collision while resizing HPT
[   27.620113] Unable to resize hash page table to target order 23: -28
[   27.748767] pseries-hotplug-mem: Memory at 100000000 (drc index 80000010) was hot-added

Hotunplug memory:

(qemu) device_del dimm1

# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

(qemu) object_del mem1 

# cat /proc/meminfo | grep Huge
AnonHugePages:    737280 kB
ShmemHugePages:        0 kB
HugePages_Total:      16
HugePages_Free:       16
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB
Hugetlb:          262144 kB

Inside guest:
[   29.640670] pseries-hotplug-mem: Attempting to hot-remove 1 LMB(s) at 80000010
[   29.710276] Offlined Pages 4096
[   29.733824] lpar: Attempting to resize HPT to shift 22
[   29.880381] lpar: Hash collision while resizing HPT
[   29.881521] Unable to resize hash page table to target order 22: -28
[   29.900542] pseries-hotplug-mem: Memory at 100000000 (drc index 80000010) was hot-removed


Thanks Murilo,

-- Bala

> ---
>  exec.c                    |  4 ++--
>  include/qemu/mmap-alloc.h |  2 +-
>  util/mmap-alloc.c         | 22 ++++++++++++++++------
>  util/oslib-posix.c        |  2 +-
>  4 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index da3e635f91..0db6d8bf34 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1871,7 +1871,7 @@ static void *file_ram_alloc(RAMBlock *block,
>      if (mem_prealloc) {
>          os_mem_prealloc(fd, area, memory, smp_cpus, errp);
>          if (errp && *errp) {
> -            qemu_ram_munmap(area, memory);
> +            qemu_ram_munmap(fd, area, memory);
>              return NULL;
>          }
>      }
> @@ -2392,7 +2392,7 @@ static void reclaim_ramblock(RAMBlock *block)
>          xen_invalidate_map_cache_entry(block->host);
>  #ifndef _WIN32
>      } else if (block->fd >= 0) {
> -        qemu_ram_munmap(block->host, block->max_length);
> +        qemu_ram_munmap(block->fd, block->host, block->max_length);
>          close(block->fd);
>  #endif
>      } else {
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index 50385e3f81..ef04f0ed5b 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -9,6 +9,6 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
> 
>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> 
> -void qemu_ram_munmap(void *ptr, size_t size);
> +void qemu_ram_munmap(int fd, void *ptr, size_t size);
> 
>  #endif
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index f71ea038c8..8565885420 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -80,6 +80,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>      int flags;
>      int guardfd;
>      size_t offset;
> +    size_t pagesize;
>      size_t total;
>      void *guardptr;
>      void *ptr;
> @@ -100,7 +101,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>       * anonymous memory is OK.
>       */
>      flags = MAP_PRIVATE;
> -    if (fd == -1 || qemu_fd_getpagesize(fd) == getpagesize()) {
> +    pagesize = qemu_fd_getpagesize(fd);
> +    if (fd == -1 || pagesize == getpagesize()) {
>          guardfd = -1;
>          flags |= MAP_ANONYMOUS;
>      } else {
> @@ -109,6 +111,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>      }
>  #else
>      guardfd = -1;
> +    pagesize = getpagesize();
>      flags = MAP_PRIVATE | MAP_ANONYMOUS;
>  #endif
> 
> @@ -120,7 +123,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> 
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
> -    assert(align >= getpagesize());
> +    assert(align >= pagesize);
> 
>      flags = MAP_FIXED;
>      flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> @@ -143,17 +146,24 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>       * a guard page guarding against potential buffer overflows.
>       */
>      total -= offset;
> -    if (total > size + getpagesize()) {
> -        munmap(ptr + size + getpagesize(), total - size - getpagesize());
> +    if (total > size + pagesize) {
> +        munmap(ptr + size + pagesize, total - size - pagesize);
>      }
> 
>      return ptr;
>  }
> 
> -void qemu_ram_munmap(void *ptr, size_t size)
> +void qemu_ram_munmap(int fd, void *ptr, size_t size)
>  {
> +    size_t pagesize;
> +
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
> -        munmap(ptr, size + getpagesize());
> +#if defined(__powerpc64__) && defined(__linux__)
> +        pagesize = qemu_fd_getpagesize(fd);
> +#else
> +        pagesize = getpagesize();
> +#endif
> +        munmap(ptr, size + pagesize);
>      }
>  }
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4ce1ba9ca4..37c5854b9c 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -226,7 +226,7 @@ void qemu_vfree(void *ptr)
>  void qemu_anon_ram_free(void *ptr, size_t size)
>  {
>      trace_qemu_anon_ram_free(ptr, size);
> -    qemu_ram_munmap(ptr, size);
> +    qemu_ram_munmap(-1, ptr, size);
>  }
> 
>  void qemu_set_block(int fd)
> -- 
> 2.20.1
> 
> 
