Received: from eggs.gnu.org ([2001:4830:134:3::10]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu8A-0003vz-Cw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu85-0003NH-CC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZu85-0003N4-5Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:19:41 -0400
References: <20170725023611.9169-1-rth@twiddle.net>
	<20170725023611.9169-4-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8d315977-9984-5c04-e944-8135fd56a090@redhat.com>
Date: Tue, 25 Jul 2017 09:19:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170725023611.9169-4-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/s390x: Use unwind info in STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 25.07.2017 04:36, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/misc_helper.c | 3 ++-
>  target/s390x/translate.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 376dbd68c2..ab8551f605 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -388,7 +388,8 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>      if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
>          ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
>          /* valid function code, invalid reserved bits */
> -        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        cpu_restore_state(ENV_GET_CPU(env), GETPC());

(I'd vote for a local variable ra)

> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
>      }
>  
>      sel1 = r0 & STSI_R0_SEL1_MASK;
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 9b0c35efa2..57f09154be 100644
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
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
