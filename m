Received: from eggs.gnu.org ([2001:4830:134:3::10]:52664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD4nF-0006hi-L9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD4nC-0002qw-E8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD4nC-0002qX-8T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:03:46 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-2-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e876585a-e0ef-d82a-8d36-a6dabc0724d3@redhat.com>
Date: Tue, 23 May 2017 10:03:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/31] target/s390: Use
 cpu_loop_exit_restore for tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 0c6a0d9..e3325a4 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -41,15 +41,9 @@
>  void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>                int mmu_idx, uintptr_t retaddr)
>  {
> -    int ret;
> -
> -    ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> +    int ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>      if (unlikely(ret != 0)) {
> -        if (likely(retaddr)) {
> -            /* now we have a real cpu fault */
> -            cpu_restore_state(cs, retaddr);
> -        }
> -        cpu_loop_exit(cs);
> +        cpu_loop_exit_restore(cs, retaddr);
>      }
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
