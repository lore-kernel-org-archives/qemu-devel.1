Received: from eggs.gnu.org ([2001:4830:134:3::10]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etW07-00022C-Ls
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etW02-00049u-Mg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:08:47 -0500
References: <20180307063651.4421-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dfec213b-12fc-6fab-3600-74bde9da3149@vivier.eu>
Date: Wed, 7 Mar 2018 11:08:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180307063651.4421-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/11] linux-user: fix
 mmap/munmap/mprotect/mremap/shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 07/03/2018 à 07:36, Max Filippov a écrit :
> In linux-user QEMU that runs for a target with TARGET_ABI_BITS bigger
> than L1_MAP_ADDR_SPACE_BITS an assertion in page_set_flags fires when
> mmap, munmap, mprotect, mremap or shmat is called for an address outside
> the guest address space. mmap and mprotect should return ENOMEM in such
> case.
> 
> Change definition of GUEST_ADDR_MAX to always be the last valid guest
> address. Account for this change in open_self_maps.
> Add macro guest_addr_valid that verifies if the guest address is valid.
> Add function guest_range_valid that verifies if address range is within
> guest address space and does not wrap around. Use that macro in
> mmap/munmap/mprotect/mremap/shmat for error checking.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v4->v5:
> - change definition of GUEST_ADDR_MAX to always be the last valid guest
>   address. Account for this change in guest_addr_valid and open_self_maps.
> - turn guest_range_valid into a function.
> 
> Changes v3->v4:
> - change GUEST_ADDR_MAX and h2g_valid definitions as suggested by Laurent
>   Vivier.
> 
> Changes v2->v3:
> - fix comparison in guest_valid: it must be 'less' to preserve the existing
>   functionality, not 'less or equal'.
> - fix guest_range_valid: it may not use guest_valid, because single range
>   that occupies all of the guest address space is valid.
> 
>  include/exec/cpu-all.h  |  6 +++++-
>  include/exec/cpu_ldst.h | 19 ++++++++++---------
>  linux-user/mmap.c       | 20 +++++++++++++++-----
>  linux-user/syscall.c    |  5 ++++-
>  4 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 0b141683f095..f4fa94e9669d 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -159,8 +159,12 @@ extern unsigned long guest_base;
>  extern int have_guest_base;
>  extern unsigned long reserved_va;
>  
> -#define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
> +#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
> +#define GUEST_ADDR_MAX (~0ul)
> +#else
> +#define GUEST_ADDR_MAX (reserved_va ? reserved_va - 1 : \
>                                      (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
> +#endif
>  #else
>  
>  #include "exec/hwaddr.h"
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 191f2e962a3c..313664e9dae8 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -51,15 +51,16 @@
>  /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
>  #define g2h(x) ((void *)((unsigned long)(target_ulong)(x) + guest_base))
>  
> -#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
> -#define h2g_valid(x) 1
> -#else
> -#define h2g_valid(x) ({ \
> -    unsigned long __guest = (unsigned long)(x) - guest_base; \
> -    (__guest < (1ul << TARGET_VIRT_ADDR_SPACE_BITS)) && \
> -    (!reserved_va || (__guest < reserved_va)); \
> -})
> -#endif
> +#define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
> +#define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
> +
> +static inline int guest_range_valid(unsigned long start, unsigned long len)
> +{
> +    if (len)
> +        return guest_addr_valid(len - 1) && start <= GUEST_ADDR_MAX - len + 1;
> +    else
> +        return guest_addr_valid(start);
> +}

I think we can consider len == 0 is invalid and use only:

  return start + (len - 1) <= GUEST_ADDR_MAX;

Thanks,
Laurent
