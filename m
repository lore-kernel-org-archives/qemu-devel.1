Received: from eggs.gnu.org ([2001:4830:134:3::10]:60262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etBJK-0000cc-Ai
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1etBJG-0003Hi-Eu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:03:14 -0500
References: <20180301173636.19082-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <91b370e2-d5aa-98b9-a005-2fe8f77881ee@vivier.eu>
Date: Tue, 6 Mar 2018 13:02:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180301173636.19082-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/11] linux-user: fix
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

Le 01/03/2018 à 18:36, Max Filippov a écrit :
> In linux-user QEMU that runs for a target with TARGET_ABI_BITS bigger
> than L1_MAP_ADDR_SPACE_BITS an assertion in page_set_flags fires when
> mmap, munmap, mprotect, mremap or shmat is called for an address outside
> the guest address space. mmap and mprotect should return ENOMEM in such
> case.
> 
> Introduce macro guest_range_valid that verifies if address range is
> within guest address space and does not wrap around. Use that macro in
> mmap/munmap/mprotect/mremap/shmat for error checking.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - fix comparison in guest_valid: it must be 'less' to preserve the existing
>   functionality, not 'less or equal'.
> - fix guest_range_valid: it may not use guest_valid, because single range
>   that occupies all of the guest address space is valid.
> 
> These changes fix assertion in page_check_range called from open_self_maps.
> 
>  include/exec/cpu-all.h  |  2 +-
>  include/exec/cpu_ldst.h | 12 +++++++-----
>  linux-user/mmap.c       | 20 +++++++++++++++-----
>  linux-user/syscall.c    |  3 +++
>  4 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 0b141683f095..12bd049997ac 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -160,7 +160,7 @@ extern int have_guest_base;
>  extern unsigned long reserved_va;
>  
>  #define GUEST_ADDR_MAX (reserved_va ? reserved_va : \
> -                                    (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
> +                        (2ul << (TARGET_VIRT_ADDR_SPACE_BITS - 1)) - 1)

I don't understand why you do this change. Could you explain?

>  #else
>  
>  #include "exec/hwaddr.h"
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 191f2e962a3c..6528fd829ffe 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -53,14 +53,16 @@
>  
>  #if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
>  #define h2g_valid(x) 1
> +#define guest_valid(x) 1
>  #else
> -#define h2g_valid(x) ({ \
> -    unsigned long __guest = (unsigned long)(x) - guest_base; \
> -    (__guest < (1ul << TARGET_VIRT_ADDR_SPACE_BITS)) && \
> -    (!reserved_va || (__guest < reserved_va)); \
> -})
> +#define h2g_valid(x) guest_valid((unsigned long)(x) - guest_base)
> +#define guest_valid(x) ((x) < GUEST_ADDR_MAX)
>  #endif

I think you can just define h2g_valid(x) after the "endif":

  #define h2g_valid(x) guest_valid((unsigned long)(x) - guest_base)

it will be set according to the guest_valid() definition ("1" or the
result of the evaluation).

Thanks,
Laurent
