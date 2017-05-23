Received: from eggs.gnu.org ([2001:4830:134:3::10]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7PU-00054u-Iw
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7PP-00015j-Nf
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD7PP-00015W-GX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:51:23 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-25-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dc757386-48c3-e0bd-5c67-29316d2d69ac@redhat.com>
Date: Tue, 23 May 2017 12:51:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-25-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/31] target/s390x: Use unwind data for
 helper_lctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 9 +++++----
>  target/s390x/translate.c  | 1 -
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 26960e4..b169e0e 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -851,18 +851,19 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  
>  void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  {
> +    uintptr_t ra = GETPC();
>      S390CPU *cpu = s390_env_get_cpu(env);
>      bool PERchanged = false;
> -    int i;
>      uint64_t src = a2;
> -    uint32_t val;
> +    uint32_t i;
>  
>      for (i = r1;; i = (i + 1) % 16) {
> -        val = cpu_ldl_data(env, src);
> +        uint32_t val = cpu_ldl_data_ra(env, src, ra);
>          if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
>              PERchanged = true;
>          }
> -        env->cregs[i] = (env->cregs[i] & 0xFFFFFFFF00000000ULL) | val;
> +        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
> +        HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%x\n", i, src, val);
>          src += sizeof(uint32_t);
>  
>          if (i == r3) {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 886991e..4d964a8 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2545,7 +2545,6 @@ static ExitStatus op_lctl(DisasContext *s, DisasOps *o)
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
>      TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_lctl(cpu_env, r1, o->in2, r3);
>      tcg_temp_free_i32(r1);
>      tcg_temp_free_i32(r3);

Reviewed-by: Thomas Huth <thuth@redhat.com>
