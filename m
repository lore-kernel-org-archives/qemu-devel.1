Received: from eggs.gnu.org ([209.51.188.92]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gp8yt-0004DC-Sb
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gp8ys-0007NW-Cg
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:49:59 -0500
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:49587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gp8ys-0007La-0q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:49:58 -0500
Received: from player159.ha.ovh.net (unknown [10.109.143.249])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7C3AB14FDA6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 10:49:55 +0100 (CET)
Date: Thu, 31 Jan 2019 10:49:42 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190131104942.77053099@bahia.lan>
In-Reply-To: <20190130233605.22163-2-muriloo@linux.ibm.com>
References: <20190130233605.22163-1-muriloo@linux.ibm.com>
	<20190130233605.22163-2-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] mmap-alloc: unfold qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cao jin <caoj.fnst@cn.fujitsu.com>, David Gibson <david@gibson.dropbear.id.au>, Fabiano Rosas <farosas@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, mopsfelder@gmail.com

On Wed, 30 Jan 2019 21:36:04 -0200
Murilo Opsfelder Araujo <muriloo@linux.ibm.com> wrote:

> Unfold parts of qemu_ram_mmap() for the sake of understanding, moving
> declarations to the top, and keeping architecture-specifics in the
> ifdef-else blocks.  No changes in the function behaviour.
> 
> Give ptr and ptr1 meaningful names:
>   ptr  -> guardptr : pointer to the PROT_NONE guard region
>   ptr1 -> ptr      : pointer to the mapped memory returned to caller
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  util/mmap-alloc.c | 53 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index fd329eccd8..f71ea038c8 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -77,11 +77,19 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>  
>  void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>  {
> +    int flags;
> +    int guardfd;
> +    size_t offset;
> +    size_t total;
> +    void *guardptr;
> +    void *ptr;
> +
>      /*
>       * Note: this always allocates at least one extra page of virtual address
>       * space, even if size is already aligned.
>       */
> -    size_t total = size + align;
> +    total = size + align;
> +
>  #if defined(__powerpc64__) && defined(__linux__)
>      /* On ppc64 mappings in the same segment (aka slice) must share the same
>       * page size. Since we will be re-allocating part of this segment
> @@ -91,16 +99,22 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>       * We do this unless we are using the system page size, in which case
>       * anonymous memory is OK.
>       */
> -    int anonfd = fd == -1 || qemu_fd_getpagesize(fd) == getpagesize() ? -1 : fd;
> -    int flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
> -    void *ptr = mmap(0, total, PROT_NONE, flags | MAP_PRIVATE, anonfd, 0);
> +    flags = MAP_PRIVATE;
> +    if (fd == -1 || qemu_fd_getpagesize(fd) == getpagesize()) {
> +        guardfd = -1;
> +        flags |= MAP_ANONYMOUS;
> +    } else {
> +        guardfd = fd;
> +        flags |= MAP_NORESERVE;
> +    }
>  #else
> -    void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +    guardfd = -1;
> +    flags = MAP_PRIVATE | MAP_ANONYMOUS;
>  #endif
> -    size_t offset;
> -    void *ptr1;
>  
> -    if (ptr == MAP_FAILED) {
> +    guardptr = mmap(0, total, PROT_NONE, flags, guardfd, 0);
> +
> +    if (guardptr == MAP_FAILED) {
>          return MAP_FAILED;
>      }
>  
> @@ -108,19 +122,20 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>      /* Always align to host page size */
>      assert(align >= getpagesize());
>  
> -    offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> -    ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
> -                MAP_FIXED |
> -                (fd == -1 ? MAP_ANONYMOUS : 0) |
> -                (shared ? MAP_SHARED : MAP_PRIVATE),
> -                fd, 0);
> -    if (ptr1 == MAP_FAILED) {
> -        munmap(ptr, total);
> +    flags = MAP_FIXED;
> +    flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> +    flags |= shared ? MAP_SHARED : MAP_PRIVATE;
> +    offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
> +
> +    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd, 0);
> +
> +    if (ptr == MAP_FAILED) {
> +        munmap(guardptr, total);
>          return MAP_FAILED;
>      }
>  
>      if (offset > 0) {
> -        munmap(ptr, offset);
> +        munmap(guardptr, offset);
>      }
>  
>      /*
> @@ -129,10 +144,10 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>       */
>      total -= offset;
>      if (total > size + getpagesize()) {
> -        munmap(ptr1 + size + getpagesize(), total - size - getpagesize());
> +        munmap(ptr + size + getpagesize(), total - size - getpagesize());
>      }
>  
> -    return ptr1;
> +    return ptr;
>  }
>  
>  void qemu_ram_munmap(void *ptr, size_t size)
