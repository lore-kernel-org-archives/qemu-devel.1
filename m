Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5e9-0003kO-5T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5e8-0002n1-Et
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD5e8-0002m8-8T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:58:28 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-6-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b6c7055-df76-fd41-bd82-c72dcf3c634f@redhat.com>
Date: Tue, 23 May 2017 10:58:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-6-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/31] target/s390x: Use unwind data for
 helper_oc
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
>  target/s390x/mem_helper.c | 18 +++++++++---------
>  target/s390x/translate.c  |  1 -
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index e0a6fad..e75c2de0 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -168,20 +168,20 @@ uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
>  uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
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
> +
>      for (i = 0; i <= l; i++) {
> -        x = cpu_ldub_data(env, dest + i) | cpu_ldub_data(env, src + i);
> -        if (x) {
> -            cc = 1;
> -        }
> -        cpu_stb_data(env, dest + i, x);
> +        uint8_t x = cpu_ldub_data_ra(env, dest + i, ra);
> +        x |= cpu_ldub_data_ra(env, src + i, ra);

Maybe access to src first?

> +        cc |= x;
> +        cpu_stb_data_ra(env, dest + i, x, ra);
>      }
> -    return cc;
> +    return cc != 0;
>  }
>  
>  /* memmove */
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index a770407..6a51d56 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3082,7 +3082,6 @@ static ExitStatus op_negf128(DisasContext *s, DisasOps *o)
>  static ExitStatus op_oc(DisasContext *s, DisasOps *o)
>  {
>      TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
> -    potential_page_fault(s);
>      gen_helper_oc(cc_op, cpu_env, l, o->addr1, o->in2);
>      tcg_temp_free_i32(l);
>      set_cc_static(s);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
