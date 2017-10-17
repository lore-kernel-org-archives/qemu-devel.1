Received: from eggs.gnu.org ([2001:4830:134:3::10]:34798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4b9T-0007Me-Qw
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4b9Q-0003dp-LC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:19:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4b9Q-0003dG-9B
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 19:19:56 -0400
Date: Tue, 17 Oct 2017 19:19:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017231954.GR1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-19-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 18/50] tcg: Reserve temporary index 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 10:25:37 -0700, Richard Henderson wrote:
> Since we cast indicies to pointers, reserving 0 allows

s/indicies/indices/

> us to use NULL for unused/dummy instead of (T *)-1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
(snip)
> @@ -737,7 +737,7 @@ extern bool parallel_cpus;
>  static inline size_t temp_idx(TCGTemp *ts)
>  {
>      ptrdiff_t n = ts - tcg_ctx.temps;
> -    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
> +    tcg_debug_assert(n > 0 && n < tcg_ctx.nb_temps);
>      return n;
>  }
>  
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 129aecca60..7cf39f7067 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -333,7 +333,10 @@ void tcg_context_init(TCGContext *s)
>      int *sorted_args;
>  
>      memset(s, 0, sizeof(*s));
> -    s->nb_globals = 0;
> +    /* Reserve temp index 0 so that, with the funny casting that we do,
> +       the first one doesn't look like NULL.  */
> +    s->nb_globals = 1;
> +    s->nb_temps = 1;
>  
>      /* Count total number of arguments and allocate the corresponding
>         space */

I like this change, although operating on the 0th element makes
me uneasy.

For instance, I managed to trigger the above assert by manually calling dump_regs
(it is otherwise called before aborting, which is why you missed it.)
This fixes it:

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7cf39f7..49176e0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2034,7 +2034,7 @@ static void dump_regs(TCGContext *s)
     int i;
     char buf[64];
 
-    for(i = 0; i < s->nb_temps; i++) {
+    for (i = 1; i < s->nb_temps; i++) {
         ts = &s->temps[i];
         printf("  %10s: ", tcg_get_arg_str_ptr(s, buf, sizeof(buf), ts));
         switch(ts->val_type) {

Is it worth changing other [0, nb_temps/globals) loops to start from 1?

Thanks,

		E.
