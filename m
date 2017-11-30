Received: from eggs.gnu.org ([2001:4830:134:3::10]:39009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNYX-0006jm-N6
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNYT-00023C-0H
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:03:05 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-17-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f73b4fa-1b0e-b973-20fa-0631d225b0a4@redhat.com>
Date: Thu, 30 Nov 2017 13:02:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 16/16] s390x/tcg:
 drop potential_page_fault()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 29.11.2017 21:27, David Hildenbrand wrote:
> Only one user left, get rid of it so we don't get any new users.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 1ce1390699..26cf993405 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -240,12 +240,6 @@ static void update_cc_op(DisasContext *s)
>      }
>  }
>  
> -static void potential_page_fault(DisasContext *s)
> -{
> -    update_psw_addr(s);
> -    update_cc_op(s);
> -}
> -
>  static inline uint64_t ld_code2(CPUS390XState *env, uint64_t pc)
>  {
>      return (uint64_t)cpu_lduw_code(env, pc);
> @@ -2939,7 +2933,8 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
>  
>      /* In a parallel context, stop the world and single step.  */
>      if (tb_cflags(s->tb) & CF_PARALLEL) {
> -        potential_page_fault(s);
> +        update_psw_addr(s);
> +        update_cc_op(s);
>          gen_exception(EXCP_ATOMIC);
>          return EXIT_NORETURN;
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
