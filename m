Received: from eggs.gnu.org ([2001:4830:134:3::10]:36048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLunB-0008Ms-Ri
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fLunA-00052q-VW
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:16:49 -0400
References: <20180516152708.9ECB1A5D5F2@smcpolin-M01.vmware.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e5573e4b-51d4-ddd0-5b12-31b5da1cdb5c@vivier.eu>
Date: Thu, 24 May 2018 20:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180516152708.9ECB1A5D5F2@smcpolin-M01.vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove extra mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steve Mcpolin <smcpolin@vmware.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, riku.voipio@iki.fi

Le 16/05/2018 à 16:47, Steve Mcpolin a écrit :
> When a guest mmap()'d a file, a transient MAP_ANONYMOUS mapping was
> created, which required the kernel to reserve this memory, then
> subsequently released by applying a mapping with just the requested
> flags and fd.
> This transient mapping causes spurious failures when the available
> memory is smaller than the mapping.  This patch avoids this transient
> mapping.
> 
> Signed-off-by: Steve Mcpolin <smcpolin@vmware.com>
> ---
>  linux-user/mmap.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 9168a20..f91841f 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -453,21 +453,28 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>          /* Note: we prefer to control the mapping address. It is
>             especially important if qemu_host_page_size >
>             qemu_real_host_page_size */
> -        p = mmap(g2h(start), host_len, prot,
> -                 flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
> -        if (p == MAP_FAILED)
> -            goto fail;
> -        /* update start so that it points to the file position at 'offset' */
> -        host_start = (unsigned long)p;
> -        if (!(flags & MAP_ANONYMOUS)) {
> -            p = mmap(g2h(start), len, prot,
> +        if (flags & MAP_ANONYMOUS) {
> +            offset = 0;
> +            host_offset = 0;
> +            fd = -1;
> +        }
> +        p = mmap(g2h(start), len, prot,
>                       flags | MAP_FIXED, fd, host_offset);
> -            if (p == MAP_FAILED) {
> -                munmap(g2h(start), host_len);
> -                goto fail;
> +        host_start = (uintptr_t)p;
> +        if (p != MAP_FAILED && host_len > HOST_PAGE_ALIGN(len)) {
> +            void *q;
> +            q = mmap(g2h(start + len), host_len - HOST_PAGE_ALIGN(len),

I think you should use REAL_HOST_PAGE_ALIGN(len) above.

This is the page size used by the host mmap() (it comes from
getpagesize()), whereas HOST_PAGE_ALIGN() can come from the command line
arguments.

Thanks,
Laurent
