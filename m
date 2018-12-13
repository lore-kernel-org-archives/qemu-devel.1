Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXPFS-00072F-Aa
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8789a7fed=anthony.perard@citrix.com>)
	id 1gXPFO-0000GZ-4q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:33:46 -0500
Date: Thu, 13 Dec 2018 11:33:33 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181213113333.GZ18875@perard.uk.xensource.com>
References: <20181211160224.22181-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181211160224.22181-1-olaf@aepfle.de>
Subject: Re: [Qemu-devel] [PATCH v1] xen_disk: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On Tue, Dec 11, 2018 at 05:02:24PM +0100, Olaf Hering wrote:
> There are some code paths that clobber ioreq->buf, which leads to a huge
> memory leak after a few hours of runtime. One code path is
> qemu_aio_complete, which might be called recursive. Another one is

I think it's s/recursive/recursively/.

> ioreq_reset, which might clobber ioreq->buf as well.
> 
> Add wrappers to free ioreq->buf before reassignment.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

That patch seems fine, with a few coding style issues, and is going to
be needed to be forward ported to Paul's reimplementation (not yet
merged).

> ---
>  hw/block/xen_disk.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 36eff94f84..e15eefe625 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -103,12 +103,24 @@ struct XenBlkDev {
>  
>  /* ------------------------------------------------------------- */
>  
> +static void ioreq_buf_alloc(struct ioreq *ioreq, size_t alignment)

You have the parameter `alignment` but don't actually use it, I don't
think it's needed.

> +{
> +    if (ioreq->buf)
> +        qemu_vfree(ioreq->buf);

You could call ioreq_buf_free here instead of duplicating the code.

> +    ioreq->buf = qemu_memalign(XC_PAGE_SIZE, ioreq->size);
> +}
> +static void ioreq_buf_free(struct ioreq *ioreq)
> +{
> +    if (ioreq->buf)
> +        qemu_vfree(ioreq->buf);
> +    ioreq->buf = NULL;
> +}

Thanks,

-- 
Anthony PERARD
