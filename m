Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fxqgt-0003MT-Hu
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fxqgp-0003gj-G0
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:35:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fxqgp-0003Sf-22
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:35:03 -0400
References: <20180827084037.25316-1-simon.hausmann@qt.io>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0f69941d-51ea-4cc1-d668-416e697ae754@vivier.eu>
Date: Thu, 6 Sep 2018 11:34:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180827084037.25316-1-simon.hausmann@qt.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: add support for
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
Cc: Sami Nurmenniemi <sami.nurmenniemi@qt.io>, Riku Voipio <riku.voipio@iki.fi>

Le 27/08/2018 à 10:40, Simon Hausmann a écrit :
> Most flags to madvise() are just hints, so typically ignoring the
> syscall and returning okay is fine. However applications exist that do
> rely on MADV_DONTNEED behavior to guarantee that upon subsequent access
> the mapping is refreshed from the backing file or zero for anonymous
> mappings. The file backed mappings this is tricky - hence the original
> comment - but for anonymous mappings it is safe to forward. We just need
> to remember which those mappings are, which is now stored in the flags.
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Sami Nurmenniemi <sami.nurmenniemi@qt.io>
> Signed-off-by: Simon Hausmann <simon.hausmann@qt.io>
> 
> --
> v2:
>   - align start and len on host page size
> v3:
>   - align start and len to target page size as it may be bigger than
>     host
>   - use immediate return in do_syscall
>   - forward MADV_DONTNEED advice only for anonymously mapped pages
>   - remember which mappings are anonymous in the page flags and preserve
>     those bits across mprotect calls.
> ---
>  accel/tcg/translate-all.c |  8 +++++--
>  bsd-user/mmap.c           |  8 +++----
>  include/exec/cpu-all.h    | 11 ++++++++-
>  linux-user/elfload.c      |  3 ++-
>  linux-user/mmap.c         | 49 +++++++++++++++++++++++++++++++++++----
>  linux-user/qemu.h         |  1 +
>  linux-user/syscall.c      | 12 ++++------
>  7 files changed, 72 insertions(+), 20 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 898c3bb3d1..467fbd9aeb 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2481,7 +2481,8 @@ int page_get_flags(target_ulong address)
>  /* Modify the flags of a page and invalidate the code if necessary.
>     The flag PAGE_WRITE_ORG is positioned automatically depending
>     on PAGE_WRITE.  The mmap_lock should already be held.  */
> -void page_set_flags(target_ulong start, target_ulong end, int flags)
> +void page_set_flags(target_ulong start, target_ulong end, int flags,
> +                    enum page_set_flags_mode mode)

Is it possible to not add the mode, and only use "flags" to set the new
flag? Using page_get_flags() to keep flags that needed to be kept?

>  {
>      target_ulong addr, len;
>  
> @@ -2513,7 +2514,10 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
>              p->first_tb) {
>              tb_invalidate_phys_page(addr, 0);
>          }
> -        p->flags = flags;
> +        if (mode == PAGE_SET_ALL_FLAGS)
> +            p->flags = flags;
> +        else /* PAGE_SET_PROTECTION */
> +            p->flags |= (p->flags & ~(PAGE_BITS - 1)) | (flags & PAGE_BITS);
>      }
>  }
>  
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 17f4cd80aa..4bfac81af4 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -125,7 +125,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
>          if (ret != 0)
>              goto error;
>      }
> -    page_set_flags(start, start + len, prot | PAGE_VALID);
> +    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);

Why do you remove the PAGE_VALID flag?

...
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8638612aec..c59cf4359c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1702,7 +1702,8 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong last_bss, int prot)
>  
>      /* Ensure that the bss page(s) are valid */
>      if ((page_get_flags(last_bss-1) & prot) != prot) {
> -        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot | PAGE_VALID);
> +        page_set_flags(elf_bss & TARGET_PAGE_MASK, last_bss, prot,
> +                       PAGE_SET_PROTECTION);
>      }

PAGE_VALID?

>  
>      if (host_start < host_map_start) {
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 41e0983ce8..fff29ee04b 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -124,7 +124,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
>          if (ret != 0)
>              goto error;
>      }
> -    page_set_flags(start, start + len, prot | PAGE_VALID);
> +    page_set_flags(start, start + len, prot, PAGE_SET_PROTECTION);
>      mmap_unlock();

PAGE_VALID?

...
> +int target_madvise(abi_ulong start, abi_ulong len, int advice)
> +{
> +    abi_ulong end, addr;
> +    int ret;
> +
> +    len = TARGET_PAGE_ALIGN(len);
> +    start &= TARGET_PAGE_MASK;
> +
> +    if (!guest_range_valid(start, len)) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    /* A straight passthrough may not be safe because qemu sometimes
> +       turns private file-backed mappings into anonymous mappings.
> +       Most flags are hints so we ignore them.
> +       One exception is made for MADV_DONTNEED on anonymous mappings,
> +       that applications may rely on to zero out pages. */
> +    if (advice & MADV_DONTNEED) {
> +        end = start + len;
> +        for (addr = start; addr < end; addr += TARGET_PAGE_SIZE) {
> +            if (page_get_flags(addr) & PAGE_MAP_ANONYMOUS) {
> +                ret = madvise(g2h(addr), TARGET_PAGE_SIZE, MADV_DONTNEED);

these values must be aligned on host page size.

Thanks,
Laurent
