Received: from eggs.gnu.org ([2001:4830:134:3::10]:57202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLuT-0001Dp-1p
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLuP-0008Os-Uk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:37:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnLuP-0008Od-OI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:37:09 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-12-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <90e51e4d-26d2-ebfd-626f-ec718e6521f3@redhat.com>
Date: Thu, 31 Aug 2017 11:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/11] target/s390x: use
 program_interrupt() in per_check_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:06, David Hildenbrand wrote:
> I am not sure if we are handling ilen the right way here. ilen should
> always match the instruction triggering the exception. This is relevant
> for per exceptions triggered via EXECUTE instructions. The ilen to be
> indicated has to match the EXECUTE instruction.
> 
> Clean it up for now but leave ilen as is, we can fix that later.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index eb7accc0ce..ac9657f23f 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -445,14 +445,11 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
>  #ifndef CONFIG_USER_ONLY
>  void HELPER(per_check_exception)(CPUS390XState *env)
>  {
> -    CPUState *cs = CPU(s390_env_get_cpu(env));
> +    uint32_t ilen;
>  
>      if (env->per_perc_atmid) {
> -        env->int_pgm_code = PGM_PER;
> -        env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, env->per_address));
> -
> -        cs->exception_index = EXCP_PGM;
> -        cpu_loop_exit(cs);
> +        ilen = get_ilen(cpu_ldub_code(env, env->per_address));
> +        program_interrupt(env, PGM_PER, ilen);
>      }
>  }

The changes basically look fine to me, but may I suggest to
1) Add a comment to the code about your concerns with ilen
2) Change the patch description to focus on the work that is actually
done here instead of only talking about your ilen concerns?

 Thanks,
  Thomas
