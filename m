Received: from eggs.gnu.org ([209.51.188.92]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gpZ9f-0007n2-KS
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gpZ9e-0004eZ-IF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:46:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1gpZ9e-0004Z7-Bb
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:46:50 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x11DjiVU156888
	for <qemu-devel@nongnu.org>; Fri, 1 Feb 2019 08:46:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qcp22v37p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:46:04 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 1 Feb 2019 13:44:51 -0000
Date: Fri, 1 Feb 2019 19:14:44 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20190130233605.22163-1-muriloo@linux.ibm.com>
	<20190130233605.22163-2-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130233605.22163-2-muriloo@linux.ibm.com>
Message-Id: <20190201134444.GB26981@dhcp-9-109-195-223.in.ibm.com>
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
Cc: qemu-devel@nongnu.org

On Wed, Jan 30, 2019 at 09:36:04PM -0200, Murilo Opsfelder Araujo wrote:
> Unfold parts of qemu_ram_mmap() for the sake of understanding, moving
> declarations to the top, and keeping architecture-specifics in the
> ifdef-else blocks.  No changes in the function behaviour.
> 
> Give ptr and ptr1 meaningful names:
>   ptr  -> guardptr : pointer to the PROT_NONE guard region
>   ptr1 -> ptr      : pointer to the mapped memory returned to caller
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

> ---
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
> -- 
> 2.20.1
> 
> 
