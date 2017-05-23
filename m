Received: from eggs.gnu.org ([2001:4830:134:3::10]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6Iv-0006qd-Na
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6Ir-0008Fa-Is
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6Ir-0008F6-Cx
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:40:33 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-10-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d89ad981-abbc-c026-7431-78dfd1594c6e@redhat.com>
Date: Tue, 23 May 2017 11:40:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-10-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/31] target/s390x: Use unwind data for
 helper_srst
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
>  target/s390x/mem_helper.c | 3 ++-
>  target/s390x/translate.c  | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 5f38ac3..3c28f3a 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -302,6 +302,7 @@ static inline uint64_t get_address_31fix(CPUS390XState *env, int reg)
>  uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
>                        uint64_t str)
>  {
> +    uintptr_t ra = GETPC();
>      uint32_t len;
>      uint8_t v, c = r0;
>  
> @@ -319,7 +320,7 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
>              env->cc_op = 2;
>              return end;
>          }
> -        v = cpu_ldub_data(env, str + len);
> +        v = cpu_ldub_data_ra(env, str + len, ra);
>          if (v == c) {
>              /* Character found.  Set R1 to the location; R2 is unmodified.  */
>              env->cc_op = 1;
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 84f09b1..ba7d0f9 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3977,7 +3977,6 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
>  
>  static ExitStatus op_srst(DisasContext *s, DisasOps *o)
>  {
> -    potential_page_fault(s);
>      gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
>      set_cc_static(s);
>      return_low128(o->in2);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
