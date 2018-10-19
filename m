Received: from eggs.gnu.org ([2001:4830:134:3::10]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTsM-0005wV-Ik
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDTsI-0004JV-BQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDTsA-0003B2-Hd
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:27:26 -0400
References: <20181019122449.26387-1-rka@sysgo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e408c3b6-bba1-d121-a2b0-ab0507285091@redhat.com>
Date: Fri, 19 Oct 2018 14:27:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181019122449.26387-1-rka@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Clear RF on SYSCALL instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: Rudolf Marek <rudolf.marek@sysgo.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 19/10/2018 14:24, Roman Kapl wrote:
> From: Rudolf Marek <rudolf.marek@sysgo.com>
> 
> Fix the SYSCALL instruction in 64-bit (long mode). The RF flag
> should be cleared in R11 as well as in the RFLAGS. Intel
> and AMD CPUs behave same. AMD has this documented in the
> APM vol 3.
> 
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> Signed-off-by: Rudolf Marek <rudolf.marek@sysgo.com>
> ---
>  target/i386/seg_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> index 33714bc6e1..63e265cb38 100644
> --- a/target/i386/seg_helper.c
> +++ b/target/i386/seg_helper.c
> @@ -991,11 +991,11 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
>          int code64;
>  
>          env->regs[R_ECX] = env->eip + next_eip_addend;
> -        env->regs[11] = cpu_compute_eflags(env);
> +        env->regs[11] = cpu_compute_eflags(env) & ~RF_MASK;
>  
>          code64 = env->hflags & HF_CS64_MASK;
>  
> -        env->eflags &= ~env->fmask;
> +        env->eflags &= ~(env->fmask | RF_MASK);
>          cpu_load_eflags(env, env->eflags, 0);
>          cpu_x86_load_seg_cache(env, R_CS, selector & 0xfffc,
>                             0, 0xffffffff,
> 

Queued, thanks.

Paolo
