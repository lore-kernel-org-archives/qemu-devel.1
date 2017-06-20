Received: from eggs.gnu.org ([2001:4830:134:3::10]:33011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNDfe-00017n-KE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNDfb-00040l-Ex
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:33:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNDfb-00040P-5t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 03:33:51 -0400
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-15-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <071f5f1b-6ecd-0695-f9bf-e026b5ecb4b3@redhat.com>
Date: Tue, 20 Jun 2017 09:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170620000405.3391-15-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 14/18] target/s390x: Tidy SRST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 20.06.2017 02:04, Richard Henderson wrote:
> Since we require all registers saved on input, read R0 from ENV instead
> of passing it manually.  Recognize the specification exception when R0
> contains incorrect data.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: David Hildenbrand <david@redhat.com>

> ---
>  target/s390x/helper.h     |  2 +-
>  target/s390x/mem_helper.c | 11 ++++++++---
>  target/s390x/translate.c  |  2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index c014820..cd51b89 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -12,7 +12,7 @@ DEF_HELPER_FLAGS_3(divs32, TCG_CALL_NO_WG, s64, env, s64, s64)
>  DEF_HELPER_FLAGS_3(divu32, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
>  DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
> -DEF_HELPER_4(srst, i64, env, i64, i64, i64)
> +DEF_HELPER_3(srst, i64, env, i64, i64)
>  DEF_HELPER_4(clst, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(mvn, TCG_CALL_NO_WG, void, env, i32, i64, i64)
>  DEF_HELPER_FLAGS_4(mvo, TCG_CALL_NO_WG, void, env, i32, i64, i64)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index df082f5..990858e 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -538,12 +538,17 @@ static inline void set_length(CPUS390XState *env, int reg, uint64_t length)
>  }
>  
>  /* search string (c is byte to search, r2 is string, r1 end of string) */
> -uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
> -                      uint64_t str)
> +uint64_t HELPER(srst)(CPUS390XState *env, uint64_t end, uint64_t str)
>  {
>      uintptr_t ra = GETPC();
>      uint32_t len;
> -    uint8_t v, c = r0;
> +    uint8_t v, c = env->regs[0];
> +
> +    /* Bits 32-55 must contain all 0.  */
> +    if (env->regs[0] & 0xffffff00u) {
> +        cpu_restore_state(ENV_GET_CPU(env), ra);
> +        program_interrupt(env, PGM_SPECIFICATION, 6);
> +    }
>  
>      str = wrap_address(env, str);
>      end = wrap_address(env, end);
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index f8989ec..4a860f1 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4256,7 +4256,7 @@ static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
>  
>  static ExitStatus op_srst(DisasContext *s, DisasOps *o)
>  {
> -    gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
> +    gen_helper_srst(o->in1, cpu_env, o->in1, o->in2);
>      set_cc_static(s);
>      return_low128(o->in2);
>      return NO_EXIT;
> 


-- 

Thanks,

David
