Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fuHc0-0003UK-T2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fuHbx-0004zG-28
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:31:20 -0400
References: <153537327445.92657.5884855110375406189.stgit@lep8c.aus.stglabs.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9ab7a80d-9289-2d65-9d87-238cfa69f456@vivier.eu>
Date: Mon, 27 Aug 2018 15:25:47 +0200
MIME-Version: 1.0
In-Reply-To: <153537327445.92657.5884855110375406189.stgit@lep8c.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: elf: mmap all the target-pages
 of hostpage for data segment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, riku.voipio@iki.fi
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Le 27/08/2018 à 14:37, Shivaprasad G Bhat a écrit :
> If the hostpage size is greater than the TARGET_PAGESIZE, the
> target-pages of size TARGET_PAGESIZE are marked valid only till the
> length requested during the elfload. The glibc attempts to consume unused
> space in the last page of data segment(__libc_memalign() in
> elf/dl-minimal.c). The GLRO(dl_pagesize) is actually the host pagesize as
> set in the auxillary vectors. So, there is no explicit mmap request for
> the remaining target-pages on the last hostpage. The glibc assumes that
> particular space as available and subsequent attempts to use
> those addresses lead to crash as the target_mmap has not marked them valid
> for those target-pages.
> 
> The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PPC64
> host where the fork fails to access the thread_id as it is allocated on a
> page not marked valid. The recent glibc doesnt have checks for thread-id in
> fork, but the issue can manifest somewhere else, none the less.
> 
> The fix here is to map all the target-pages of the hostpage during the
> ELF load for data segment to allow the glibc for proper consumption.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> ---
>  linux-user/elfload.c |   24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8638612aec..1d86034c8d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1438,9 +1438,17 @@ struct exec
>  
>  /* Necessary parameters */
>  #define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
> -#define TARGET_ELF_PAGESTART(_v) ((_v) & \
> -                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
> -#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
> +#define TARGET_ELF_PAGESTART(_v, _s) \
> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +         (_v) & ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +         (_v) & ~(abi_ulong)(_s - 1));
> +#define TARGET_ELF_PAGEOFFSET(_v, _s) \
> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +         (_v) & (TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +         (_v) & (_s - 1));
> +#define TARGET_ELF_PAGELENGTH(_v, _s) \
> +        ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +         TARGET_PAGE_ALIGN(_v) : HOST_PAGE_ALIGN(_v));

I think it's only possible if the PT_LOAD p_align value is greater or
equal to qemu_host_page_size.

See 33143c446e ("linux-user: fix ELF load alignment error").

You could check this with qemu-s390x or qemu-arm on ppc64 host.

Thanks,
Laurent
