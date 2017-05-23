Received: from eggs.gnu.org ([2001:4830:134:3::10]:44833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD62T-0002iZ-Jo
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD62Q-0002qT-Dy
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:23:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD62Q-0002pl-82
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:23:34 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-27-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1e3f8dea-f379-245a-7a14-9dedffb90b34@redhat.com>
Date: Tue, 23 May 2017 11:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-27-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/31] target/s390x: Use unwind data for
 helper_testblock
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
>  target/s390x/mem_helper.c | 3 +++
>  target/s390x/translate.c  | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 1e31bd3..a874f8a 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -912,6 +912,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>  
>  uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>  {
> +    uintptr_t ra = GETPC();
>      CPUState *cs = CPU(s390_env_get_cpu(env));
>      uint64_t abs_addr;
>      int i;
> @@ -920,12 +921,14 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>      abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
>      if (!address_space_access_valid(&address_space_memory, abs_addr,
>                                      TARGET_PAGE_SIZE, true)) {
> +        cpu_restore_state(cs, ra);
>          program_interrupt(env, PGM_ADDRESSING, 4);
>          return 1;
>      }
>  
>      /* Check low-address protection */
>      if ((env->cregs[0] & CR0_LOWPROT) && real_addr < 0x2000) {
> +        cpu_restore_state(cs, ra);
>          program_interrupt(env, PGM_PROTECTION, 4);
>          return 1;
>      }
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 3a2151f..694e099 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4047,7 +4047,6 @@ static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
>  static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_testblock(cc_op, cpu_env, o->in2);
>      set_cc_static(s);
>      return NO_EXIT;

Reviewed-by: Thomas Huth <thuth@redhat.com>
