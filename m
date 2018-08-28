Received: from eggs.gnu.org ([2001:4830:134:3::10]:36245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ful86-0004km-5K
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 17:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ful82-0007gT-85
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 17:02:25 -0400
References: <153546966871.75539.10980006517656536139.stgit@lep8c.aus.stglabs.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ed3c0388-a9fe-2fdf-c54e-27d690eb5def@vivier.eu>
Date: Tue, 28 Aug 2018 23:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <153546966871.75539.10980006517656536139.stgit@lep8c.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: elf: mmap all the
 target-pages of hostpage for data segment
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

Le 28/08/2018 à 17:22, Shivaprasad G Bhat a écrit :
> If the hostpage size is greater than the TARGET_PAGESIZE, the
> target-pages of size TARGET_PAGESIZE are marked valid only till the
> length requested during the elfload. The glibc attempts to consume unused
> space in the last page of data segment(__libc_memalign() in
> elf/dl-minimal.c). If PT_LOAD p_align is greater than or
> equal to hostpage size, the GLRO(dl_pagesize) is actually the host pagesize
> as set in the auxillary vectors. So, there is no explicit mmap request for
> the remaining target-pages on the last hostpage. The glibc assumes that
> particular space as available and subsequent attempts to use
> those addresses lead to crash as the target_mmap has not marked them valid
> for target-pages as valid.
> 
> The issue is seen when trying to chroot to 16.04-x86_64 ubuntu on a PPC64
> host where the fork fails to access the thread_id as it is allocated on a
> page not marked valid. The recent glibc doesnt have checks for thread-id in
> fork, but the issue can manifest somewhere else, none the less.
> 
> The fix here is to map all the target-pages of the hostpage during the
> elfload if the p_align is greater than or equal to hostpage size, for
> data segment to allow the glibc for proper consumption.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
> ---
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05730.html
> Changes from v1:
>    - Made the conditionals consistent with the commit "33143c446e" and
>      changed the commit message accordingly.
> 
>  linux-user/elfload.c |   37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8638612aec..cced43f45c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1438,9 +1438,23 @@ struct exec
>  
>  /* Necessary parameters */
>  #define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
> -#define TARGET_ELF_PAGESTART(_v) ((_v) & \
> -                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
> -#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
> +#define TARGET_ELF_PAGESTART(_v, _a, _s, _m) \
> +        (((_a & ~_m) != 0) ? \
> +         (_v) & ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +         ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +          (_v) & ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +          (_v) & ~(abi_ulong)(_s - 1)));
> +#define TARGET_ELF_PAGEOFFSET(_v, _a, _s, _m) \
> +        (((_a & ~_m) != 0) ? \
> +         (_v) & (TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +         ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +          (_v) & (TARGET_ELF_EXEC_PAGESIZE - 1) : \
> +          (_v) & (_s - 1)));
> +#define TARGET_ELF_PAGELENGTH(_v, _a, _s, _m) \
> +        (((_a & ~_m) != 0) ? \
> +         TARGET_PAGE_ALIGN(_v) : \
> +         ((TARGET_ELF_EXEC_PAGESIZE > _s) ? \
> +          TARGET_PAGE_ALIGN(_v) : HOST_PAGE_ALIGN(_v)));

I think you should use eppnt->p_align instead of info->alignment and 
simplify this to:

#define TARGET_ELF_EXEC_PAGESIZE \
        (((eppnt->p_align & ~qemu_host_page_mask) != 0) ? \
         TARGET_PAGE_SIZE : MAX(qemu_host_page_size, TARGET_PAGE_SIZE))
#define TARGET_ELF_PAGELENGTH(_v) ROUND_UP((_v), TARGET_ELF_EXEC_PAGESIZE)

Thanks,
Laurent
