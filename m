Received: from eggs.gnu.org ([209.51.188.92]:51310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF5x-0004Uc-12
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmF5v-0003wU-35
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:45:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmF5u-0003vF-QD
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:45:15 -0500
References: <20190123073402.28465-1-r@hev.cc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f79c9b64-5219-302e-1f0b-750e35ecb1fe@redhat.com>
Date: Wed, 23 Jan 2019 10:45:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190123073402.28465-1-r@hev.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v1] i386: hvf: Fix smp boot hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heiher <r@hev.cc>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On 23/01/19 08:34, Heiher wrote:
> The machine that with hvf accelerator and smp sometimes boot hangs
> because all processors are executing instructions at startup,
> including early I/O emulations. We should just allow the bootstrap
> processor to initialize the machine and then to wake up slave
> processors by interrupt.
> 
> Signed-off-by: Heiher <r@hev.cc>
> ---
>  target/i386/hvf/hvf.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index e193022c03..0921fcba45 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -499,7 +499,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
>      }
>  
>      hv_vm_sync_tsc(0);
> -    cpu->halted = 0;
>      hv_vcpu_invalidate_tlb(cpu->hvf_fd);
>      hv_vcpu_flush(cpu->hvf_fd);
>  }
> @@ -582,8 +581,6 @@ int hvf_init_vcpu(CPUState *cpu)
>  
>      wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
>  
> -    hvf_reset_vcpu(cpu);

Why this?

>      x86cpu = X86_CPU(cpu);
>      x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
>  
> @@ -659,8 +656,6 @@ int hvf_vcpu_exec(CPUState *cpu)
>      int ret = 0;
>      uint64_t rip = 0;
>  
> -    cpu->halted = 0;
> -
>      if (hvf_process_events(cpu)) {
>          return EXCP_HLT;
>      }
> 

Looks good apart from the question above.

Paoo
