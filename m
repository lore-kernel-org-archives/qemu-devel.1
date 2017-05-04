Received: from eggs.gnu.org ([2001:4830:134:3::10]:52967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6LiE-0003Ne-5E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6LiA-0006OP-7L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6Li9-0006O3-V2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:42:46 -0400
Date: Thu, 4 May 2017 15:42:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170504184241.GB3482@thinpad.lan.raisama.net>
References: <20170504145658.5506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504145658.5506-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Richard W.M. Jones" <rjones@redhat.com>

On Thu, May 04, 2017 at 03:56:58PM +0100, Daniel P. Berrange wrote:
> Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
> the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
> HyperV, Xen, BHyve) all do the same thing, which leaves
> TCG as the odd one out.
> 
> The CPUID is used by software to detect when running in a
> virtual environment and change behaviour in certain ways.
> For example, systemd supports a ConditionVirtualization=
> setting in unit files. Currently they have to resort to
> custom hacks like looking for 'fw-cfg' entry in the
> /proc/device-tree file. The virt-what command has the
> same hacks & needs.
> 
> This change thus proposes a signature TCGTCGTCGTCG to be
> reported when running under TCG.
> 
> NB1, for reasons I don't undersatnd 'cpu_x86_cpuid' function
> clamps the requested CPUID leaf based on env->cpuid_level.

That's how CPUID is specified: Intel SDM says: "If a value
entered for CPUID.EAX is higher than the maximum input value for
basic or extended function for that processor then the data for
the highest basic information leaf is returned."

> The latter comes from the CPU model definitions, and is
> lower than 0x40000000, so the CPUID signature request just
> gets turned into a completely different request. eg when
> using '-cpu qemu64', the 0x40000000 request from the guest
> gets clamped to 0xD and thus returns totally bogus data.
> I just removed the clamping code, but someone who understands
> this might have a better suggestion.
> 

I would rewrite that code as:

    switch (index & 0xF0000000) {
    case 0:
        [...] // check cpuid_level
    case 0x40000000:
        if (index > 0x40000001) {
            /* Not sure what we should do here. Intel and KVM
             * documentation is not explicit about it, but it
             * looks like KVM will return the highest _basic_
             * leaf (env->cpuid_level) on that case.
             */
            index = env->cpuid_level;
        }
        [...]
    case 0x80000000:
        [...] // check cpuid_xlevel
    case 0xC0000000:
        [...] // check cpuid_xlevel2
    default:
       /* Intel documentation states that invalid EAX input will
        * return the same information as EAX=cpuid_level
        * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
        */
        index = env->cpuid_level;
    }

> NB2, for KVM, we added a flag for '-cpu kvm=off' to let you
> hide the KVMKVMKVM signature from guests. Presumably we should
> add a 'tcg=off' flag for the same reason ?

I don't like "kvm=off" because it sounds like it disables KVM
completely. "tcg=off" would be misleading as well.

What about a generic "hypervisor-cpuid=off" property?

> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  target/i386/cpu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 13c0985..ac2776e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2626,6 +2626,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      X86CPU *cpu = x86_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
>      uint32_t pkg_offset;
> +    uint32_t signature[3];
>  
>      /* test if maximum index reached */
>      if (index & 0x80000000) {
> @@ -2646,8 +2647,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              }
>          }
>      } else {
> -        if (index > env->cpuid_level)
> +        /* XXX this just breaks CPUID turning guest requests
> +         * into something totally different, thus returning
> +         * garbage data
> +         */
> +        if (0 && index > env->cpuid_level) {
>              index = env->cpuid_level;
> +        }
>      }
>  
>      switch(index) {
> @@ -2872,6 +2878,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          break;
>      }
> +    case 0x40000000:
> +        /* XXX add flag to let us hide this */
> +        memcpy(signature, "TCGTCGTCGTCG", 12);

This shouldn't be seen by any guests if not using TCG. Probably
that will never happen with the current code, but I would make
this conditional on tcg_enabled() just in case.

Note that the CPUID code at kvm_arch_init_vcpu() will ignore the
values here. Probably worth mentioning that in a comment so
people don't get confused.

> +        *eax = 0x40000001;

Should we really return 0x40000001 here, if we still don't have
anything being returned on CPUID[0x40000001]?

If we really want to return 0x40000001 here, an explicit
"case 0x40000001:" line returning all-zeroes would make that
intention clearer.

> +        *ebx = signature[0];
> +        *ecx = signature[1];
> +        *edx = signature[2];
> +        break;
>      case 0x80000000:
>          *eax = env->cpuid_xlevel;
>          *ebx = env->cpuid_vendor1;
> -- 
> 2.9.3
> 

-- 
Eduardo
