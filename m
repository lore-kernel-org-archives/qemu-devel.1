Received: from eggs.gnu.org ([2001:4830:134:3::10]:45292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dLmwt-0002S9-Ds
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dLmwp-00014W-Ei
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dLmwp-00013d-56
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:49:43 -0400
Date: Fri, 16 Jun 2017 16:49:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170616084936.GG30118@pxdev.xzpeter.org>
References: <1497544575-18628-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170615163630eucas1p1f7fc8849597e8402e1c537769f4255d6@eucas1p1.samsung.com>
	<1497544575-18628-3-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497544575-18628-3-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] migration: introduce
 qemu_ufd_copy_ioctl helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

On Thu, Jun 15, 2017 at 07:36:14PM +0300, Alexey Perevalov wrote:
> Just for placing auxilary operations inside helper,
> auxilary operations like: track received pages,
> notify about copying operation in futher patches.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  migration/postcopy-ram.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 743ca6c..38a429a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -561,6 +561,26 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>      return 0;
>  }
>  
> +static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> +        void *from_addr, uint64_t pagesize)
> +{
> +    if (from_addr) {
> +        struct uffdio_copy copy_struct;
> +        copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> +        copy_struct.src = (uint64_t)(uintptr_t)from_addr;
> +        copy_struct.len = pagesize;
> +        copy_struct.mode = 0;
> +        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> +    } else {
> +        struct uffdio_zeropage zero_struct;
> +        zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
> +        zero_struct.range.len = pagesize;
> +        zero_struct.mode = 0;
> +        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> +    }
> +    return 0;

Remove this line?

> +}
> +
>  /*
>   * Place a host page (from) at (host) atomically
>   * returns 0 on success
> @@ -568,20 +588,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>                          RAMBlock *rb)
>  {
> -    struct uffdio_copy copy_struct;
>      size_t pagesize = qemu_ram_pagesize(rb);
>  
> -    copy_struct.dst = (uint64_t)(uintptr_t)host;
> -    copy_struct.src = (uint64_t)(uintptr_t)from;
> -    copy_struct.len = pagesize;
> -    copy_struct.mode = 0;
> -
>      /* copy also acks to the kernel waking the stalled thread up
>       * TODO: We can inhibit that ack and only do it if it was requested
>       * which would be slightly cheaper, but we'd have to be careful
>       * of the order of updating our page state.
>       */
> -    if (ioctl(mis->userfault_fd, UFFDIO_COPY, &copy_struct)) {
> +    if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize)) {

(hmm I know "from" won't be zero, but naturally if without the context
 I would doubt it. Shall we add an assert here? You call.)

Besides:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

>          int e = errno;
>          error_report("%s: %s copy host: %p from: %p (size: %zd)",
>                       __func__, strerror(e), host, from, pagesize);
> @@ -605,12 +619,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>  
>      pagesize = qemu_ram_pagesize(rb);
>      if (pagesize == getpagesize()) {
> -        struct uffdio_zeropage zero_struct;
> -        zero_struct.range.start = (uint64_t)(uintptr_t)host;
> -        zero_struct.range.len = getpagesize();
> -        zero_struct.mode = 0;
> -
> -        if (ioctl(mis->userfault_fd, UFFDIO_ZEROPAGE, &zero_struct)) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, 0, getpagesize())) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> -- 
> 1.9.1
> 

-- 
Peter Xu
