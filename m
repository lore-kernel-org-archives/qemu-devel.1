Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6bi-0006oR-Pd
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6bi-0004fA-16
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6bh-0004eE-S8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:00:01 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-21-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb1bc79a-5d96-1830-176c-5a1c78fe144f@redhat.com>
Date: Tue, 23 May 2017 11:59:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-21-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/31] target/s390x: Use unwind data for
 helper_tr
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
>  target/s390x/mem_helper.c | 10 +++++-----
>  target/s390x/translate.c  |  1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index d37e691..748a6e8 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -707,13 +707,13 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
>  void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
>                  uint64_t trans)
>  {
> -    int i;
> +    uintptr_t ra = GETPC();
> +    uint32_t i;
>  
>      for (i = 0; i <= len; i++) {
> -        uint8_t byte = cpu_ldub_data(env, array + i);
> -        uint8_t new_byte = cpu_ldub_data(env, trans + byte);
> -
> -        cpu_stb_data(env, array + i, new_byte);
> +        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
> +        uint8_t new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
> +        cpu_stb_data_ra(env, array + i, new_byte, ra);
>      }
>  }
>  
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index e8eefec..b506cee 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4070,7 +4070,6 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
>  static ExitStatus op_tr(DisasContext *s, DisasOps *o)
>  {
>      TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
> -    potential_page_fault(s);
>      gen_helper_tr(cpu_env, l, o->addr1, o->in2);
>      tcg_temp_free_i32(l);
>      set_cc_static(s);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
