Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwvh-00056z-Vz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwvZ-0001eL-DT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpwvZ-0001e4-73
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:33:05 -0400
Date: Thu, 7 Sep 2017 15:32:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907153259.744c2c79.cohuck@redhat.com>
In-Reply-To: <20170904154316.4148-11-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/19] target/s390x: use
 program_interrupt() in per_check_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Mon,  4 Sep 2017 17:43:07 +0200
David Hildenbrand <david@redhat.com> wrote:

> Clean it up by reusing program_interrupt(). Add a concern regarding
> ilen.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 57c02ddf1b..5096286157 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -446,14 +446,17 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
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
> +        /*
> +         * FIXME: ILEN_AUTO is most probably the right thing to use. ilen
> +         * always has to match the instruction referenced in the PSW. E.g.
> +         * if a PER interrupt is triggered via EXECUTE, we have to use ilen
> +         * of EXECUTE, while per_address contains the target of EXECUTE.
> +         */
> +        ilen = get_ilen(cpu_ldub_code(env, env->per_address));
> +        program_interrupt(env, PGM_PER, ilen);
>      }
>  }
>  

Wrapping my head around it: You preserve the current behavior, which
should probably be changed to use ILEN_AUTO to handle cases like
EXECUTE correctly?

Do you plan to do a follow up? (Should I spend some cycles on it?)
