Received: from eggs.gnu.org ([2001:4830:134:3::10]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfVW-00088z-Iv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNfVT-0000wY-Aj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNfVT-0000wI-4E
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:17:15 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-13-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02a8e924-5cb4-ac18-d021-6dd1b028ed35@redhat.com>
Date: Wed, 21 Jun 2017 15:17:11 +0200
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-13-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/15] tcg: remove inline definition of
 flush_icache_range()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com



On 21/06/2017 12:19, Yang Zhong wrote:
> Remove the inline defintion of flush_icache_range() in tcg/i386/tcg-target.h.
> add the flush_icache_range() implementation in tcg-target.inc.c for kvm/tcg
> and flush_icache_range() implementation in tcg-stub.c for disable-tcg.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>

This is used even on KVM (by non-x86 architectures).  See
cpu_flush_icache_range.

You should move all flush_icache_range implementations to a separate
header file include/exec/icache.h.

Paolo
> ---
>  accel/stubs/tcg-stub.c    | 4 ++++
>  tcg/i386/tcg-target.h     | 5 ++---
>  tcg/i386/tcg-target.inc.c | 4 ++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 91625a8..85b0239 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -83,6 +83,10 @@ void tcg_set_fpuc(CPUX86State *env)
>  {
>  }
>  
> +void flush_icache_range(uintptr_t start, uintptr_t stop)
> +{
> +}
> +
>  void cpu_loop_exit(CPUState *cpu)
>  {
>      abort();
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 73a15f7..7559cb8 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -162,9 +162,8 @@ extern bool have_popcnt;
>  # define TCG_AREG0 TCG_REG_EBP
>  #endif
>  
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> -{
> -}
> +void flush_icache_range(uintptr_t start, uintptr_t stop);
> +
>  
>  /* This defines the natural memory order supported by this
>   * architecture before guarantees made by various barrier
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 01e3b4e..6572efc 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2751,3 +2751,7 @@ void tcg_register_jit(void *buf, size_t buf_size)
>      tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
>  }
>  #endif
> +
> +void flush_icache_range(uintptr_t start, uintptr_t stop)
> +{
> +}
> 
