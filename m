Received: from eggs.gnu.org ([2001:4830:134:3::10]:36313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNPe-0008Na-DC
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNPb-0006lM-AD
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:53:54 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-12-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <072cfc9a-2be3-ab36-2a54-1113971b1566@redhat.com>
Date: Thu, 30 Nov 2017 12:53:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 11/16] s390x/tcg: use
 s390_program_interrupt() in DIAG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 21:26, David Hildenbrand wrote:
> Now we can drop the two save statements in the translate function.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/translate.c   | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 02654617b3..ee6179ef89 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -101,7 +101,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>      }
>  
>      if (r) {
> -        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, GETPC());
>      }
>  }
>  
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 76b222b0ce..cf8ffa217e 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2124,9 +2124,6 @@ static ExitStatus op_diag(DisasContext *s, DisasOps *o)
>      TCGv_i32 func_code = tcg_const_i32(get_field(s->fields, i2));
>  
>      check_privileged(s);
> -    update_psw_addr(s);
> -    gen_op_calc_cc(s);
> -
>      gen_helper_diag(cpu_env, r1, r3, func_code);
>  
>      tcg_temp_free_i32(func_code);
> 

Maybe merge it with patch 06/16 ?

 Thomas
