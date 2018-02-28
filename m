Received: from eggs.gnu.org ([2001:4830:134:3::10]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqvcm-0007Ci-KY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqvci-0005PC-Ks
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:54:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqvci-0005Oq-Ei
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:53:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D749740FB647
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 06:53:50 +0000 (UTC)
Date: Wed, 28 Feb 2018 14:53:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228065340.GU18962@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/29] postcopy: use UFFDIO_ZEROPAGE
 only when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:15:59PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use a flag on the RAMBlock to state whether it has the
> UFFDIO_ZEROPAGE capability, use it when it's available.
> 
> This allows the use of postcopy on tmpfs as well as hugepage
> backed files.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c                    | 15 +++++++++++++++
>  include/exec/cpu-common.h |  3 +++
>  migration/postcopy-ram.c  | 13 ++++++++++---
>  3 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 0ec73bc917..1dc15298c2 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -99,6 +99,11 @@ static MemoryRegion io_mem_unassigned;
>   */
>  #define RAM_RESIZEABLE (1 << 2)
>  
> +/* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
> + * zero the page and wake waiting processes.
> + * (Set during postcopy)
> + */
> +#define RAM_UF_ZEROPAGE (1 << 3)
>  #endif
>  
>  #ifdef TARGET_PAGE_BITS_VARY
> @@ -1767,6 +1772,16 @@ bool qemu_ram_is_shared(RAMBlock *rb)
>      return rb->flags & RAM_SHARED;
>  }
>  
> +bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_UF_ZEROPAGE;
> +}
> +
> +void qemu_ram_set_uf_zeroable(RAMBlock *rb)
> +{
> +    rb->flags |= RAM_UF_ZEROPAGE;
> +}
> +
>  /* Called with iothread lock held.  */
>  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
>  {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 0d861a6289..24d335f95d 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -73,6 +73,9 @@ void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
>  bool qemu_ram_is_shared(RAMBlock *rb);
> +bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
> +void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> +
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index bec6c2c66b..6297979700 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -490,6 +490,10 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>          error_report("%s userfault: Region doesn't support COPY", __func__);
>          return -1;
>      }
> +    if (reg_struct.ioctls & ((__u64)1 << _UFFDIO_ZEROPAGE)) {
> +        RAMBlock *rb = qemu_ram_block_by_name(block_name);
> +        qemu_ram_set_uf_zeroable(rb);
> +    }

So the zeroable flag is only set after a listening operation of
postcopy migration.  One thing I am a bit worried is that if someone
else wants to use the flag for a RAMBlock he/she may not notice this.
Say, qemu_ram_is_uf_zeroable() is not valid if there is no such an
incoming postcopy migration.

Maybe worth add a comment in the flag definition about this?

Not a big deal (considering that I see no potential QEMU user for
userfaultfd in short peroid), so no matter what:

Reviewed-by: Peter Xu <peterx@redhat.com>

>  
>      return 0;
>  }
> @@ -699,11 +703,14 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>                               RAMBlock *rb)
>  {
> +    size_t pagesize = qemu_ram_pagesize(rb);
>      trace_postcopy_place_page_zero(host);
>  
> -    if (qemu_ram_pagesize(rb) == getpagesize()) {
> -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpagesize(),
> -                                rb)) {
> +    /* Normal RAMBlocks can zero a page using UFFDIO_ZEROPAGE
> +     * but it's not available for everything (e.g. hugetlbpages)
> +     */
> +    if (qemu_ram_is_uf_zeroable(rb)) {
> +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pagesize, rb)) {
>              int e = errno;
>              error_report("%s: %s zero host: %p",
>                           __func__, strerror(e), host);
> -- 
> 2.14.3
> 

-- 
Peter Xu
