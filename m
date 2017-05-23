Received: from eggs.gnu.org ([2001:4830:134:3::10]:49048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6H7-0005qt-3B
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6H2-0006wj-2h
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6H1-0006vx-SR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:38:40 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-9-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ebdade2-9f43-17c0-9a3b-feed330ed038@redhat.com>
Date: Tue, 23 May 2017 11:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-9-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/31] target/s390x: Use unwind data for
 helper_clm
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
>  target/s390x/mem_helper.c | 11 ++++++-----
>  target/s390x/translate.c  |  1 -
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index d04850b..5f38ac3 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -243,16 +243,16 @@ uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
>  uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
>                       uint64_t addr)
>  {
> -    uint8_t r, d;
> -    uint32_t cc;
> +    uintptr_t ra = GETPC();
> +    uint32_t cc = 0;
>  
>      HELPER_LOG("%s: r1 0x%x mask 0x%x addr 0x%" PRIx64 "\n", __func__, r1,
>                 mask, addr);
> -    cc = 0;
> +
>      while (mask) {
>          if (mask & 8) {
> -            d = cpu_ldub_data(env, addr);
> -            r = (r1 & 0xff000000UL) >> 24;
> +            uint8_t d = cpu_ldub_data_ra(env, addr, ra);
> +            uint8_t r = extract32(r1, 24, 8);
>              HELPER_LOG("mask 0x%x %02x/%02x (0x%" PRIx64 ") ", mask, r, d,
>                         addr);
>              if (r < d) {
> @@ -267,6 +267,7 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
>          mask = (mask << 1) & 0xf;
>          r1 <<= 8;
>      }
> +
>      HELPER_LOG("\n");
>      return cc;
>  }
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index aefbc90..84f09b1 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1930,7 +1930,6 @@ static ExitStatus op_clm(DisasContext *s, DisasOps *o)
>      TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
>      TCGv_i32 t1 = tcg_temp_new_i32();
>      tcg_gen_extrl_i64_i32(t1, o->in1);
> -    potential_page_fault(s);
>      gen_helper_clm(cc_op, cpu_env, t1, m3, o->in2);
>      set_cc_static(s);
>      tcg_temp_free_i32(t1);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
