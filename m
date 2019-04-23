Received: from eggs.gnu.org ([209.51.188.92]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvn2-0003qg-KF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvn0-0002n8-LN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvmy-0002eQ-Mq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:48:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so20300669wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:48:46 -0700 (PDT)
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
Date: Tue, 23 Apr 2019 15:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub.jermar@kernkonzept.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Leon Alrae <leon.alrae@imgtec.com>

Hi Jakub,

On 4/23/19 1:00 PM, Jakub Jermář wrote:
> This commit addresses QEMU Bug #1825311:
> 
>   mips_cpu_handle_mmu_fault renders all accessed pages executable
> 
> It allows finer-grained control over whether the accessed page should be
> executable by moving the decision to the underlying map_address
> function, which has more information for this.
> 
> As a result, pages that have the XI bit set in the TLB and are accessed
> for read/write, don't suddenly end up being executable.
> 

Fixes: https://bugs.launchpad.net/qemu/+bug/1825311

> Signed-off-by: Jakub Jermář <jakub.jermar@kernkonzept.com>
> ---
>  target/mips/helper.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..132d073fbe 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>                          target_ulong address, int rw, int access_type)
>  {
>      *physical = address;
> -    *prot = PAGE_READ | PAGE_WRITE;
> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>  
> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>      else
>          *physical = address;
>  
> -    *prot = PAGE_READ | PAGE_WRITE;
> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>  
> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>                  *prot = PAGE_READ;
>                  if (n ? tlb->D1 : tlb->D0)
>                      *prot |= PAGE_WRITE;
> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
> +                    *prot |= PAGE_EXEC;
> +                }

This was indeed missed in commit 2fb58b73746e.

>                  return TLBRET_MATCH;
>              }
>              return TLBRET_DIRTY;
> @@ -182,7 +185,7 @@ static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
>      } else {
>          /* The segment is unmapped */
>          *physical = physical_base | (real_address & segmask);
> -        *prot = PAGE_READ | PAGE_WRITE;
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          return TLBRET_MATCH;
>      }
>  }
> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>      }
>      if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
> +                     TARGET_PAGE_SIZE);
>          ret = 0;
>      } else if (ret < 0)
>  #endif
> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>                                             address, rw, access_type, mmu_idx);
>                  if (ret == TLBRET_MATCH) {
>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                            mmu_idx, TARGET_PAGE_SIZE);
> +                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
> +                            TARGET_PAGE_SIZE);
>                      ret = 0;
>                      return ret;
>                  }
> 

Your patch looks correct, but I'd like to test it.
Do you have a reproducer?
Can you describe the command line you used?

Thanks,

Phil.
