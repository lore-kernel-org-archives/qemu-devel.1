Received: from eggs.gnu.org ([2001:4830:134:3::10]:59320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ftBm6-0005qx-NP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ftBm3-0007x7-Ga
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:05:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ftBm3-0007ue-6K
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:05:11 -0400
References: <20180824094330.8908-1-simon.hausmann@qt.io>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2ea5c955-1020-3cd9-4dce-046a7d6132cf@vivier.eu>
Date: Fri, 24 Aug 2018 15:04:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180824094330.8908-1-simon.hausmann@qt.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: add support for
 MADV_DONTNEED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Hausmann <simon.hausmann@qt.io>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Sami Nurmenniemi <sami.nurmenniemi@qt.io>

Le 24/08/2018 à 11:43, Simon Hausmann a écrit :
> Most flags to madvise() are just hints, so typically ignoring the
> syscall and returning okay is fine. However applications exist that do
> rely on MADV_DONTNEED behavior to guarantee that upon subsequent access
> the mapping is refreshed from the backing file or zero for anonymous
> mappings.
> 
> Signed-off-by: Simon Hausmann <simon.hausmann@qt.io>
> ---

Please add here an history of the changes:
v2: align start and len on host page size

>  linux-user/mmap.c    | 21 +++++++++++++++++++++
>  linux-user/qemu.h    |  1 +
>  linux-user/syscall.c |  6 +-----
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 41e0983ce8..6b308d4e13 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -762,3 +762,24 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>      mmap_unlock();
>      return new_addr;
>  }
> +
> +int target_madvise(abi_ulong start, abi_ulong len, int flags)
> +{
> +    len = HOST_PAGE_ALIGN(len);
> +    start &= qemu_host_page_mask;

I think you should instead align the start and len to the target page
size because it can be bigger than the host page size (for instance for
ppc64)

> +    if (!guest_range_valid(start, len)) {
> +        errno = TARGET_EINVAL;

get_errno() translates host errno to target errno, so it must be:

           errno = EINVAL.

> +        return -1;
> +    }
> +
> +    /* A straight passthrough may not be safe because qemu sometimes
> +       turns private file-backed mappings into anonymous mappings.
> +       Most flags are hints, except for MADV_DONTNEED that applications
> +       may rely on to zero out pages, so we pass that through.
> +       Otherwise returning success is ok. */
> +    if (flags & MADV_DONTNEED) {
> +        return madvise(g2h(start), len, MADV_DONTNEED);

It's not correct for file mapped memory when the offset is not aligned
with the host page size, in this case the file is copied in memory and
it will be zero-ed instead of have been updated (it's what is explained
in the comment you removed).

I don't see easy fix for that... perhaps adding a flag in the page flags
to store the page is a backing a file but has been read to do the
appropriate thing.

> +    }
> +    return 0;
> +}
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index b4959e41c6..4b68019904 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -437,6 +437,7 @@ int target_munmap(abi_ulong start, abi_ulong len);
>  abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>                         abi_ulong new_size, unsigned long flags,
>                         abi_ulong new_addr);
> +int target_madvise(abi_ulong start, abi_ulong len, int flags);
>  extern unsigned long last_brk;
>  extern abi_ulong mmap_next_start;
>  abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 202aa777ad..023874ac8c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11874,11 +11874,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  
>  #ifdef TARGET_NR_madvise
>      case TARGET_NR_madvise:
> -        /* A straight passthrough may not be safe because qemu sometimes
> -           turns private file-backed mappings into anonymous mappings.
> -           This will break MADV_DONTNEED.
> -           This is a hint, so ignoring and returning success is ok.  */
> -        ret = get_errno(0);
> +        ret = get_errno(target_madvise(arg1, arg2, arg3));

This has changed recently, you muse use now

           return get_errno(target_madvise(arg1, arg2, arg3);

you can also return directly negative target errno from the function and
don't use get_errno() here.

Thanks,
Laurent
