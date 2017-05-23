Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5cp-0002y7-3t
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5cl-0000pu-8U
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD5ck-0000oM-W9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:57:03 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-5-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52641a4b-80b1-3e9e-fdff-21ad0bd591ed@redhat.com>
Date: Tue, 23 May 2017 10:56:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-5-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/31] target/s390x: Use unwind data for
 helper_xc
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
>  target/s390x/mem_helper.c | 25 ++++++++++++-------------
>  target/s390x/translate.c  |  1 -
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 1018fe0..e0a6fad 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -68,7 +68,7 @@ static inline uint64_t adj_len_to_page(uint64_t len, uint64_t addr)
>  }
>  
>  static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
> -                        uint32_t l)
> +                        uint32_t l, uintptr_t ra)
>  {
>      int mmu_idx = cpu_mmu_index(env, false);
>  
> @@ -83,7 +83,7 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
>          } else {
>              /* We failed to get access to the whole page. The next write
>                 access will likely fill the QEMU TLB for the next iteration.  */
> -            cpu_stb_data(env, dest, byte);
> +            cpu_stb_data_ra(env, dest, byte, ra);
>              dest++;
>              l--;
>          }
> @@ -142,27 +142,26 @@ uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l, uint64_t dest,
>  uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
>                      uint64_t src)
>  {
> -    int i;
> -    unsigned char x;
> -    uint32_t cc = 0;
> +    uintptr_t ra = GETPC();
> +    uint8_t cc = 0;
> +    uint32_t i;
>  
>      HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
>                 __func__, l, dest, src);
>  
>      /* xor with itself is the same as memset(0) */
>      if (src == dest) {
> -        fast_memset(env, dest, 0, l + 1);
> +        fast_memset(env, dest, 0, l + 1, ra);
>          return 0;
>      }
>  
>      for (i = 0; i <= l; i++) {
> -        x = cpu_ldub_data(env, dest + i) ^ cpu_ldub_data(env, src + i);
> -        if (x) {
> -            cc = 1;
> -        }
> -        cpu_stb_data(env, dest + i, x);
> +        uint8_t x = cpu_ldub_data_ra(env, dest + i, ra);
> +        x ^= cpu_ldub_data_ra(env, src + i, ra);

Maybe access here src first, too?

> +        cc |= x;
> +        cpu_stb_data_ra(env, dest + i, x, ra);
>      }
> -    return cc;
> +    return cc != 0;
>  }
>  
>  /* or on array */
> @@ -196,7 +195,7 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
>      /* mvc with source pointing to the byte after the destination is the
>         same as memset with the first source byte */
>      if (dest == (src + 1)) {
> -        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1);
> +        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1, 0);
>          return;
>      }
>  
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 6aa9c90..a770407 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4166,7 +4166,6 @@ static ExitStatus op_xc(DisasContext *s, DisasOps *o)
>      /* But in general we'll defer to a helper.  */
>      o->in2 = get_address(s, 0, b2, d2);
>      t32 = tcg_const_i32(l);
> -    potential_page_fault(s);
>      gen_helper_xc(cc_op, cpu_env, t32, o->addr1, o->in2);
>      tcg_temp_free_i32(t32);
>      set_cc_static(s);

Reviewed-by: Thomas Huth <thuth@redhat.com>
