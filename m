Received: from eggs.gnu.org ([2001:4830:134:3::10]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNSm-0002Gh-AM
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNSl-0007qE-GA
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:57:08 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-15-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09a247d7-112d-1aba-2b1a-a111db5dd5a5@redhat.com>
Date: Thu, 30 Nov 2017 12:57:01 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 14/16] s390x/tcg:
 use s390_program_interrupt() in STSI
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

On 29.11.2017 21:26, David Hildenbrand wrote:
> STSI needs some more love, but let's do one step at a time.
> We can now drop potential_page_fault().
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/translate.c   | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index a911bff706..6d766ce1e7 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -184,7 +184,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>      if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
>          ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
>          /* valid function code, invalid reserved bits */
> -        program_interrupt(env, PGM_SPECIFICATION, 4);
> +        s390_program_interrupt(env, PGM_SPECIFICATION, 4, GETPC());
>      }
>  
>      sel1 = r0 & STSI_R0_SEL1_MASK;
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index f26fa64a78..1ce1390699 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3988,7 +3988,6 @@ static ExitStatus op_stpt(DisasContext *s, DisasOps *o)
>  static ExitStatus op_stsi(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_stsi(cc_op, cpu_env, o->in2, regs[0], regs[1]);
>      set_cc_static(s);
>      return NO_EXIT;

Reviewed-by: Thomas Huth <thuth@redhat.com>
