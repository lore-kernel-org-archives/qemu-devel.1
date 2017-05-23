Received: from eggs.gnu.org ([2001:4830:134:3::10]:56083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6o3-0001ab-RE
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6o0-0004nH-Mv
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6o0-0004mi-Cg
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:12:44 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-26-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <38ac78c3-efce-2d07-43dc-1d669cdc4bf0@redhat.com>
Date: Tue, 23 May 2017 12:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-26-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/31] target/s390x: Use unwind data for
 helper_stctl
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
>  target/s390x/mem_helper.c | 10 ++++++----
>  target/s390x/translate.c  |  2 --
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index b169e0e..1e31bd3 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -880,11 +880,12 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  
>  void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  {
> -    int i;
> +    uintptr_t ra = GETPC();
>      uint64_t dest = a2;
> +    uint32_t i;
>  
>      for (i = r1;; i = (i + 1) % 16) {
> -        cpu_stq_data(env, dest, env->cregs[i]);
> +        cpu_stq_data_ra(env, dest, env->cregs[i], ra);
>          dest += sizeof(uint64_t);
>  
>          if (i == r3) {
> @@ -895,11 +896,12 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  
>  void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  {
> -    int i;
> +    uintptr_t ra = GETPC();
>      uint64_t dest = a2;
> +    uint32_t i;
>  
>      for (i = r1;; i = (i + 1) % 16) {
> -        cpu_stl_data(env, dest, env->cregs[i]);
> +        cpu_stl_data_ra(env, dest, env->cregs[i], ra);
>          dest += sizeof(uint32_t);
>  
>          if (i == r3) {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4d964a8..3a2151f 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3617,7 +3617,6 @@ static ExitStatus op_stctg(DisasContext *s, DisasOps *o)
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
>      TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_stctg(cpu_env, r1, o->in2, r3);
>      tcg_temp_free_i32(r1);
>      tcg_temp_free_i32(r3);
> @@ -3629,7 +3628,6 @@ static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
>      TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_stctl(cpu_env, r1, o->in2, r3);
>      tcg_temp_free_i32(r1);
>      tcg_temp_free_i32(r3);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
