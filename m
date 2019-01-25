Received: from eggs.gnu.org ([209.51.188.92]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqCm-0007vZ-Su
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmqCk-0005LN-K1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:47 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmqCk-0005KE-8j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 20:22:46 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so3738882pld.6
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 17:22:46 -0800 (PST)
References: <20190118140758.829-1-farosas@linux.ibm.com>
	<20190118140758.829-2-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <df9a0457-b9fa-5a50-4ff9-0e37966139dd@ozlabs.ru>
Date: Fri, 25 Jan 2019 12:22:38 +1100
MIME-Version: 1.0
In-Reply-To: <20190118140758.829-2-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/7] target/ppc: Move exception
 vector offset computation into a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com



On 19/01/2019 01:07, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0ec7ae1ad4..337a3ef8bb 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -65,6 +65,25 @@ static inline void dump_syscall(CPUPPCState *env)
>                    ppc_dump_gpr(env, 6), env->nip);
>  }
>  
> +static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
> +{
> +    uint64_t offset;

nit: uninitialized variable. It should not matter though as cpu_abort()
has __attribute__ ((__noreturn__)) but still inaccurate imho.

Other than that

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> +
> +    switch (ail) {
> +    case AIL_0001_8000:
> +        offset = 0x18000;
> +        break;
> +    case AIL_C000_0000_0000_4000:
> +        offset = 0xc000000000004000ull;
> +        break;
> +    default:
> +        cpu_abort(cs, "Invalid AIL combination %d\n", ail);
> +        break;
> +    }
> +
> +    return offset;
> +}
> +
>  /* Note that this function should be greatly optimized
>   * when called with a constant excp, from ppc_hw_interrupt
>   */
> @@ -685,17 +704,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>      /* Handle AIL */
>      if (ail) {
>          new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
> -        switch(ail) {
> -        case AIL_0001_8000:
> -            vector |= 0x18000;
> -            break;
> -        case AIL_C000_0000_0000_4000:
> -            vector |= 0xc000000000004000ull;
> -            break;
> -        default:
> -            cpu_abort(cs, "Invalid AIL combination %d\n", ail);
> -            break;
> -        }
> +        vector |= ppc_excp_vector_offset(cs, ail);
>      }
>  
>  #if defined(TARGET_PPC64)
> 

-- 
Alexey
