Received: from eggs.gnu.org ([209.51.188.92]:48324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grRtC-0002e5-3o
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grRt9-0006BS-Tl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:25:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1grRt2-00066O-Ka
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:25:33 -0500
Date: Wed, 6 Feb 2019 13:25:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190206131804-mutt-send-email-mst@kernel.org>
References: <cover.1549473586.git.yi.z.zhang@linux.intel.com>
	<d1a03d25ff9d68924f07726d8a27d455b059c5a7.1549473586.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a03d25ff9d68924f07726d8a27d455b059c5a7.1549473586.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V12 4/5] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Thu, Feb 07, 2019 at 01:27:19AM +0800, Zhang, Yi wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> When a file supporting DAX is used as vNVDIMM backend, mmap it with
> MAP_SYNC flag in addition which can ensure file system metadata
> synced in each guest writes to the backend file, without other QEMU
> actions (e.g., periodic fsync() by QEMU).
> 
> Current, We have below different possible use cases:
> 
> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>    a: backend is a dax supporting file.
>     - MAP_SYNC will active.
>    b: backend is not a dax supporting file.
>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> 
> 2. The rest of cases:
>    - we will never pass the MAP_SYNC to mmap2
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  include/qemu/osdep.h |  7 +++++++
>  util/mmap-alloc.c    | 24 +++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 457d24e..9a94cc3 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -115,6 +115,13 @@ extern int daemon(int, int);
>  #include "sysemu/os-win32.h"
>  #endif
>  
> +#ifdef CONFIG_LINUX
> +#include <linux/mman.h>
> +#else  /* !CONFIG_LINUX */
> +#define MAP_SYNC              0x0
> +#define MAP_SHARED_VALIDATE   0x0
> +#endif /* CONFIG_LINUX */
> +
>  #ifdef CONFIG_POSIX
>  #include "sysemu/os-posix.h"
>  #endif

It's only used in one place. Maybe put this code in mmap-alloc.c ?

> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 97bbeed..e4e55fc 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -15,6 +15,7 @@
>  #include "qemu/host-utils.h"
>  
>  #define HUGETLBFS_MAGIC       0x958458f6
> +#define MAP_SYNC_FLAGS        (MAP_SYNC | MAP_SHARED_VALIDATE)
>  

Pls don't do this, just put it in a local variable within qemu_ram_mmap.

>  #ifdef CONFIG_LINUX
>  #include <sys/vfs.h>
> @@ -101,6 +102,7 @@ void *qemu_ram_mmap(int fd,
>  #else
>      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  #endif
> +    int mmap_flags;
>      size_t offset;
>      void *ptr1;
>  
> @@ -111,13 +113,33 @@ void *qemu_ram_mmap(int fd,
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
>      assert(align >= getpagesize());
> +    mmap_flags = shared ? MAP_SHARED : MAP_PRIVATE;
> +    if (shared && is_pmem) {
> +        mmap_flags |= MAP_SYNC_FLAGS;
> +    }
>  
>      offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
>      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
>                  MAP_FIXED |
>                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> -                (shared ? MAP_SHARED : MAP_PRIVATE),
> +                mmap_flags,
>                  fd, 0);
> +
> +
> +    if (ptr1 == MAP_FAILED &&
> +        (mmap_flags & MAP_SYNC_FLAGS) == MAP_SYNC_FLAGS) {
> +        if (errno == ENOTSUP) {
> +            perror("failed to validate with mapping flags");

I don't think this warning message makes sense.
Are you trying to say:
                Warning: requesting persistence across crashes
		for file XYZ failed. Proceeding without persistence,
		data might become corrupted in case of host crash.
?

> +        }
> +        /* if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
> +         * we will remove these flags to handle compatibility.
> +         */
> +        ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> +                    MAP_FIXED |
> +                    (fd == -1 ? MAP_ANONYMOUS : 0) |
> +                    MAP_SHARED,
> +                    fd, 0);
> +    }
>      if (ptr1 == MAP_FAILED) {
>          munmap(ptr, total);
>          return MAP_FAILED;
> -- 
> 2.7.4
