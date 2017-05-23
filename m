Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6P0-000160-V3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6Ow-0003vs-V8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6Ow-0003vK-On
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:46:50 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-14-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c79ccc5-dc7a-d019-4335-ce0b0464f472@redhat.com>
Date: Tue, 23 May 2017 11:46:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-14-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/31] target/s390x: Use unwind data for
 helper_lam
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
> index d1a7bcd..4ecec74 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -450,10 +450,11 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t v1, uint64_t addr)
>  /* load access registers r1 to r3 from memory at a2 */
>  void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  {
> +    uintptr_t ra = GETPC();
>      int i;
>  
>      for (i = r1;; i = (i + 1) % 16) {
> -        env->aregs[i] = cpu_ldl_data(env, a2);
> +        env->aregs[i] = cpu_ldl_data_ra(env, a2, ra);
>          a2 += 4;
>  
>          if (i == r3) {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index f9d05b6..1fc58a1 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2626,7 +2626,6 @@ static ExitStatus op_lam(DisasContext *s, DisasOps *o)
>  {
>      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
>      TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
> -    potential_page_fault(s);
>      gen_helper_lam(cpu_env, r1, o->in2, r3);
>      tcg_temp_free_i32(r1);
>      tcg_temp_free_i32(r3);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
