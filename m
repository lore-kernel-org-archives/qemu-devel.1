Received: from eggs.gnu.org ([2001:4830:134:3::10]:44202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctOEc-0007uM-3g
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 20:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctOEZ-00016f-2B
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 20:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctOEY-00015a-Se
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 20:46:38 -0400
Date: Wed, 29 Mar 2017 21:46:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170330004632.GE3709@thinpad.lan.raisama.net>
References: <20170329210439.18062-1-iwona260909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329210439.18062-1-iwona260909@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iwona Kotlarska <iwona260909@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Wed, Mar 29, 2017 at 11:04:39PM +0200, Iwona Kotlarska wrote:
> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
> 
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> ---
> v1 --> v2
> Added brackets around if body.
> Changed subject.
>  target/i386/arch_dump.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 5a2e4be5d0..43992a440c 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -390,9 +390,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>      GuestPhysBlock *block;
>  
>  #ifdef TARGET_X86_64
[Reordering the diff a little bit to make my comments clearer]
> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
> +    X86CPU *first_x86_cpu = NULL;
> +    first_x86_cpu = X86_CPU(first_cpu);

There's no reason to replace that single line with these ones.

> -
> -    lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
> +    if (first_cpu != NULL) {
> +        lma = !!(first_x86_cpu->env.hflags & HF_LMA_MASK);
> +    }

This part looks OK, although personally I would prefer to write it as:
    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
so this can become a single-line patch.

I also wonder if the TARGET_X86_64 #ifdef is really necessary. Is
it possible to ever have HF_LMA_MASK set if the target is not
x86_64? But that's something for a separate patch, and unrelated
to the bug you are fixing.

>  #endif
>  
>      if (lma) {
> -- 
> 2.12.0
> 

-- 
Eduardo
