Received: from eggs.gnu.org ([2001:4830:134:3::10]:57980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6vT-0003fg-6l
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6vQ-0002Dv-2v
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6vP-0002DM-Qd
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:20:24 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-32-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <275be01b-361f-73ed-2e06-79a36d4e4035@redhat.com>
Date: Tue, 23 May 2017 12:20:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-32-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 31/31] target/s390x: Use unwind data for
 helper_mvcs/mvcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: pbonzini@gapps.redhat.com

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 8 ++++++--
>  target/s390x/translate.c  | 2 --
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 4becc80..d8d29bd 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1031,6 +1031,7 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t r2)
>  
>  uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
>  {
> +    uintptr_t ra = GETPC();
>      int cc = 0, i;
>  
>      HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
> @@ -1044,7 +1045,8 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
>  
>      /* XXX replace w/ memcpy */
>      for (i = 0; i < l; i++) {
> -        cpu_stb_secondary(env, a1 + i, cpu_ldub_primary(env, a2 + i));
> +        uint8_t x = cpu_ldub_primary_ra(env, a2 + i, ra);
> +        cpu_stb_secondary_ra(env, a1 + i, x, ra);
>      }
>  
>      return cc;
> @@ -1052,6 +1054,7 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
>  
>  uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
>  {
> +    uintptr_t ra = GETPC();
>      int cc = 0, i;
>  
>      HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
> @@ -1065,7 +1068,8 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
>  
>      /* XXX replace w/ memcpy */
>      for (i = 0; i < l; i++) {
> -        cpu_stb_primary(env, a1 + i, cpu_ldub_secondary(env, a2 + i));
> +        uint8_t x = cpu_ldub_secondary_ra(env, a2 + i, ra);
> +        cpu_stb_primary_ra(env, a1 + i, x, ra);
>      }
>  
>      return cc;
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index ca5be7b..67c85f0 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2928,7 +2928,6 @@ static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
>  {
>      int r1 = get_field(s->fields, l1);
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
>      set_cc_static(s);
>      return NO_EXIT;
> @@ -2938,7 +2937,6 @@ static ExitStatus op_mvcs(DisasContext *s, DisasOps *o)
>  {
>      int r1 = get_field(s->fields, l1);
>      check_privileged(s);
> -    potential_page_fault(s);
>      gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
>      set_cc_static(s);
>      return NO_EXIT;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
