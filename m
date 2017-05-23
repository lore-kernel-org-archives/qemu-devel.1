Received: from eggs.gnu.org ([2001:4830:134:3::10]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6SP-0003bW-C7
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6SL-0006fu-CV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6SL-0006fF-6R
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:50:21 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-17-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7365e444-f8bf-bfd7-8d26-e32b0cbeac6c@redhat.com>
Date: Tue, 23 May 2017 11:50:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-17-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/31] target/s390x: Use unwind data for
 helper_mvcle
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
>  target/s390x/mem_helper.c | 7 ++++---
>  target/s390x/translate.c  | 1 -
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index b764c48..7a59be0 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -525,6 +525,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>  uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
>                         uint32_t r3)
>  {
> +    uintptr_t ra = GETPC();
>      uint64_t destlen = env->regs[r1 + 1];
>      uint64_t dest = env->regs[r1];
>      uint64_t srclen = env->regs[r3 + 1];
> @@ -553,12 +554,12 @@ uint32_t HELPER(mvcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
>      }
>  
>      for (; destlen && srclen; src++, dest++, destlen--, srclen--) {
> -        v = cpu_ldub_data(env, src);
> -        cpu_stb_data(env, dest, v);
> +        v = cpu_ldub_data_ra(env, src, ra);
> +        cpu_stb_data_ra(env, dest, v, ra);
>      }
>  
>      for (; destlen; dest++, destlen--) {
> -        cpu_stb_data(env, dest, pad);
> +        cpu_stb_data_ra(env, dest, pad, ra);
>      }
>  
>      env->regs[r1 + 1] = destlen;
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index ad2e632..c00c15e 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2887,7 +2887,6 @@ static ExitStatus op_mvcle(DisasContext *s, DisasOps *o)
>  {
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
>      TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
> -    potential_page_fault(s);
>      gen_helper_mvcle(cc_op, cpu_env, r1, o->in2, r3);
>      tcg_temp_free_i32(r1);
>      tcg_temp_free_i32(r3);

Reviewed-by: Thomas Huth <thuth@redhat.com>
