Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMbLV-0007om-4y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMbLQ-0005dU-U2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:10:49 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b25586af-43e2-4ad1-f426-cd1de59610ce@redhat.com>
Date: Wed, 6 Dec 2017 16:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171204125505.29203-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 3/5] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04.12.2017 13:55, David Hildenbrand wrote:
> Needed for machine check handling inside Linux (when restoring registers).
> 
> Except for SIGP and machine checks, we don't make use of the register
> yet. Suficient for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 6d766ce1e7..2c6ab329fb 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -146,6 +146,17 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
>      timer_mod(env->tod_timer, env->tod_basetime + time);
>  }
>  
> +/* Set Tod Programmable Field */
> +void HELPER(sckpf)(CPUS390XState *env)
> +{
> +    uint32_t val = env->regs[0];
> +
> +    if (val & 0xffff0000UL) {

I think you could drop the "UL" suffix here.

> +        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
> +    }
> +    env->todpr = val;
> +}
> +
>  /* Store Clock Comparator */
>  uint64_t HELPER(stckc)(CPUS390XState *env)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 26cf993405..48b031894a 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3922,6 +3922,13 @@ static ExitStatus op_sckc(DisasContext *s, DisasOps *o)
>      return NO_EXIT;
>  }
>  
> +static ExitStatus op_sckpf(DisasContext *s, DisasOps *o)
> +{
> +    check_privileged(s);
> +    gen_helper_sckpf(cpu_env);
> +    return NO_EXIT;
> +}
> +
>  static ExitStatus op_stckc(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
