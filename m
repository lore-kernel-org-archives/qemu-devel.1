Received: from eggs.gnu.org ([2001:4830:134:3::10]:45122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8OfQ-0002hv-9X
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8OfP-00010O-4r
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:16:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8OfO-0000zz-Uu
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:16:23 -0400
Date: Wed, 10 May 2017 12:16:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170510101620.q3mob35aivxz324g@aurel32.net>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-5-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509180715.22910-5-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/s390x: Implement LOAD PAIR
 DISJOINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Eric Bischoff <ebischoff@nerim.net>

On 2017-05-09 11:07, Richard Henderson wrote:
> From: Eric Bischoff <ebischoff@nerim.net>
> 
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Eric Bischoff <ebischoff@nerim.net>
> Message-Id: <20170228120134.7921-1-ebischoff@suse.com>
> [rth: Combine the two via insn->data; free the address temps.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/insn-data.def |  4 +++-
>  target/s390x/translate.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)

[snip]

> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 2b66a4e..8de0177 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2559,6 +2559,7 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
>      tcg_temp_free_i32(r3);
>      return NO_EXIT;
>  }
> +
>  static ExitStatus op_lra(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> @@ -2759,6 +2760,31 @@ static ExitStatus op_lm64(DisasContext *s, DisasOps *o)
>      return NO_EXIT;
>  }
>  
> +static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i64 a1, a2;
> +    TCGMemOp mop = s->insn->data;
> +
> +    /* In a parallel context, stop the world and single step.  */
> +    if (parallel_cpus) {
> +        potential_page_fault(s);
> +        gen_helper_exit_atomic(cpu_env);
> +        return EXIT_NORETURN;
> +    }

One small additional comment about this patch I haven't spotted at the
first review. The exit_atomic helper is properly restoring the CPU state
passing the return address to cpu_loop_exit_atomic, so I believe the
potential_page_fault call is not necessary. That said, it doesn't hurt
either.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
