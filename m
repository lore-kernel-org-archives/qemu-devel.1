Received: from eggs.gnu.org ([2001:4830:134:3::10]:33109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6ybN-0004Yd-8Z
	for qemu-devel@nongnu.org; Sat, 06 May 2017 08:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6ybM-0002pn-5H
	for qemu-devel@nongnu.org; Sat, 06 May 2017 08:14:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6ybL-0002pN-Vx
	for qemu-devel@nongnu.org; Sat, 06 May 2017 08:14:20 -0400
Date: Sat, 6 May 2017 14:14:17 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170506121417.pfgksfgkpptr6z5p@aurel32.net>
References: <20170502192300.2124-1-rth@twiddle.net>
	<20170502192300.2124-19-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502192300.2124-19-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v6 18/25] target/s390: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 2017-05-02 12:22, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/translate.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 01c6217..f7c2123 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -608,11 +608,16 @@ static void gen_op_calc_cc(DisasContext *s)
>      set_cc_static(s);
>  }
>  
> -static int use_goto_tb(DisasContext *s, uint64_t dest)
> +static bool use_exit_tb(DisasContext *s)
>  {
> -    if (unlikely(s->singlestep_enabled) ||
> -        (s->tb->cflags & CF_LAST_IO) ||
> -        (s->tb->flags & FLAG_MASK_PER)) {
> +    return (s->singlestep_enabled ||
> +            (s->tb->cflags & CF_LAST_IO) ||
> +            (s->tb->flags & FLAG_MASK_PER));
> +}
> +
> +static bool use_goto_tb(DisasContext *s, uint64_t dest)
> +{
> +    if (unlikely(use_exit_tb(s))) {
>          return false;
>      }
>  #ifndef CONFIG_USER_ONLY
> @@ -5426,8 +5431,10 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
>          /* Exit the TB, either by raising a debug exception or by return.  */
>          if (do_debug) {
>              gen_exception(EXCP_DEBUG);
> -        } else {
> +        } else if (use_exit_tb(&dc)) {
>              tcg_gen_exit_tb(0);
> +        } else {
> +            tcg_gen_lookup_and_goto_ptr(psw_addr);
>          }
>          break;
>      default:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
