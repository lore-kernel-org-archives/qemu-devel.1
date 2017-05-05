Received: from eggs.gnu.org ([2001:4830:134:3::10]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6hEV-00066k-Oy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6hEQ-0007oe-TM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6hEQ-0007o1-Jp
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:41:30 -0400
Date: Fri, 5 May 2017 14:41:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170505174127.GK3482@thinpad.lan.raisama.net>
References: <20170505142743.19849-1-berrange@redhat.com>
	<20170505142743.19849-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505142743.19849-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386: rewrite way CPUID index is
 validated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, May 05, 2017 at 03:27:42PM +0100, Daniel P. Berrange wrote:
> Change the nested if statements into a flat switch, to make
> it clearer what validation / capping is being performed on
> different CPUID index values.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  target/i386/cpu.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 13c0985..3d5903c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2628,26 +2628,33 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t pkg_offset;
>  
>      /* test if maximum index reached */
> -    if (index & 0x80000000) {
> +    switch (index & 0xF0000000) {
> +    case 0:
> +        /* Intel documentation states that invalid EAX input will
> +         * return the same information as EAX=cpuid_level
> +         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
> +         */
> +        if (index > env->cpuid_level) {
> +            index = env->cpuid_level;
> +        }
> +        break;

It looks like we can just move this code to the default branch,
and remove the "case 0:" branch.

> +    case 0x80000000:
>          if (index > env->cpuid_xlevel) {
> -            if (env->cpuid_xlevel2 > 0) {
> -                /* Handle the Centaur's CPUID instruction. */
> -                if (index > env->cpuid_xlevel2) {
> -                    index = env->cpuid_xlevel2;
                                    ^^^ [1]

> -                } else if (index < 0xC0000000) {
> -                    index = env->cpuid_xlevel;
                                    ^^^ [2]
> -                }
> -            } else {
> -                /* Intel documentation states that invalid EAX input will
> -                 * return the same information as EAX=cpuid_level
> -                 * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
> -                 */
> -                index =  env->cpuid_level;
                                 ^^^ [3]

> -            }
> +            index = env->cpuid_xlevel;
                            ^^^ [4]

Actually, CPUs do return the max _basic_ leaf (cpuid_level) even
when input EAX is larger than 0x80000000. (See [3])

...except for the existing code at [2], but:

* TCG doesn't support any of the Centaur features.
* KVM is not affected by [2] because CPUID
  limits are handled inside the KVM kernel code (and KVM returns
  CPUID[env->cpuid_level] on that case, see
  linux/arch/x86/kvm/cpuid.c:check_cpuid_limit())

In other words, [2] was dead code, and we only need to reproduce
behavior implemented by [3].

>          }
> -    } else {
> -        if (index > env->cpuid_level)
> -            index = env->cpuid_level;
> +        break;
> +    case 0xC0000000:
> +        if (index > env->cpuid_xlevel2) {
> +            index = env->cpuid_xlevel2;

This line reimplements [1], but (like [2]) [1] was dead code too.
But I suggest setting index=env->cpuid_level for consistency with
KVM code.

> +        }
> +        break;
> +    default:
> +        /* Intel documentation states that invalid EAX input will
> +         * return the same information as EAX=cpuid_level
> +         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
> +         */
> +        index =  env->cpuid_level;
> +        break;
>      }

What about simplifying this even further:

    if (index > 0xC0000000) {
        limit = env->cpuid_xlevel2;
    } else if (index > 0x80000000) {
        limit = env->cpuid_xlevel;
    } else {
        limit = env->cpuid_level;
    }

    if (index > limit) {
        /* Intel documentation states that invalid EAX input will
         * return the same information as EAX=cpuid_level
         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
         */
        index = env->cpuid_level;
    }

>  
>      switch(index) {
> -- 
> 2.9.3
> 

-- 
Eduardo
