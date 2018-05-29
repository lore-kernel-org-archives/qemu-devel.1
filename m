Received: from eggs.gnu.org ([2001:4830:134:3::10]:60863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkAw-0003lg-Uv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkAw-00026n-0x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:20:54 -0400
References: <20180529190022.D3B2FC01BBA@smcpolin-M01.vmware.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a3aebed4-6156-e0eb-2b4c-c15d3efcb2f1@vivier.eu>
Date: Tue, 29 May 2018 21:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180529190022.D3B2FC01BBA@smcpolin-M01.vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Remove extra mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steve Mcpolin <smcpolin@vmware.com>
Cc: qemu-devel@nongnu.org, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 29/05/2018 à 20:15, Steve Mcpolin a écrit :
> When a guest mmap()'d a file, an anonymous mapping was created to
> align different host and client page granularity and provide for
> beyond EOF mappings.  The file was then mapped ontop of this mapping,
> releasing the memory reserved by it.  A file based mmap does not reserve
> memory, but the anonymous map does; thus this anonymous mapping could
> could cause spurious failures.
> 
> This patch minimizes the size of the anonymous mapping to prevent spurious
> failures.
> 
> Signed-off-by: Steve Mcpolin <smcpolin@vmware.com>
> ---

v3:
  add missing flags in the second mmap()

v2:
  use REAL_HOST_PAGE_ALIGN(len) instead of HOST_PAGE_ALIGN(len)


>  linux-user/mmap.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 9168a20..7a975c8 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -453,21 +453,29 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
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
> +        if (p != MAP_FAILED && host_len > REAL_HOST_PAGE_ALIGN(len)) {
> +            void *q;
> +            q = mmap(g2h(start + len), host_len - REAL_HOST_PAGE_ALIGN(len),
> +                     prot, MAP_FIXED | (flags & MAP_TYPE) | MAP_ANONYMOUS,

Why do you restrict the flags with MAP_TYPE? Original code was not doing
that. Is this needed?

Thanks,
Laurent
