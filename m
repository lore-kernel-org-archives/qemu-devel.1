Received: from eggs.gnu.org ([2001:4830:134:3::10]:43321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5zh-0001jJ-VD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5ze-0008PP-PL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD5ze-0008OU-GW
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:20:42 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-12-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <78e4379f-6d2d-512d-0ee0-7ac043b2036c@redhat.com>
Date: Tue, 23 May 2017 11:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-12-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/31] target/s390x: Use unwind data for
 helper_mvpg
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
>  target/s390x/helper.h     | 2 +-
>  target/s390x/mem_helper.c | 9 +++++----
>  target/s390x/translate.c  | 3 +--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index d6cc513..2b4e7be 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -12,7 +12,7 @@ DEF_HELPER_FLAGS_3(divs64, TCG_CALL_NO_WG, s64, env, s64, s64)
>  DEF_HELPER_FLAGS_4(divu64, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
>  DEF_HELPER_4(srst, i64, env, i64, i64, i64)
>  DEF_HELPER_4(clst, i64, env, i64, i64, i64)
> -DEF_HELPER_4(mvpg, void, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(mvpg, TCG_CALL_NO_WG, i32, env, i64, i64, i64)
>  DEF_HELPER_4(mvst, i64, env, i64, i64, i64)
>  DEF_HELPER_FLAGS_4(ex, TCG_CALL_NO_WG, void, env, i32, i64, i64)
>  DEF_HELPER_FLAGS_4(stam, TCG_CALL_NO_WG, void, env, i32, i64, i32)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 7c9e7c7..9ef9f4a 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -373,11 +373,12 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
>  }
>  
>  /* move page */
> -void HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
> +uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
>  {
> -    /* XXX missing r0 handling */
> -    env->cc_op = 0;
> -    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, 0);
> +    /* ??? missing r0 handling, which includes access keys, but more
> +       importantly optional suppression of the exception!  */
> +    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, GETPC());
> +    return 0; /* data moved */
>  }
>  
>  /* string copy (c is string terminator) */
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 735aa82..a1edc79 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2921,8 +2921,7 @@ static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
>  
>  static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
>  {
> -    potential_page_fault(s);
> -    gen_helper_mvpg(cpu_env, regs[0], o->in1, o->in2);
> +    gen_helper_mvpg(cc_op, cpu_env, regs[0], o->in1, o->in2);
>      set_cc_static(s);
>      return NO_EXIT;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>

(but I'd maybe move this patch right after the helper_mvc patch in your
series, since it uses fast_memmove, too, so it's easier to review this
patch here in the right context)
