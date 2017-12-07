Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eN4nP-0001zb-UJ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eN4nM-00046z-Qc
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:37:35 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eN4nM-00045A-JV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:37:32 -0500
Received: by mail-pf0-x242.google.com with SMTP id a90so5773658pfk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 14:37:32 -0800 (PST)
References: <20171203063548.10297-1-doug16k@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f70d49d-30ff-384f-c942-8f1dbc2cd53c@linaro.org>
Date: Thu, 7 Dec 2017 14:37:27 -0800
MIME-Version: 1.0
In-Reply-To: <20171203063548.10297-1-doug16k@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Add AVX, AVX-512,
 MPX support to x86_cpu_dump_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/02/2017 10:35 PM, Doug Gale wrote:
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
> Fix MSB LSB showing when SSE is disabled
>  target/i386/helper.c | 95 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index f63eb3d3f4..03812b6e87 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -543,6 +543,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>          }
>      }
>      cpu_fprintf(f, "EFER=%016" PRIx64 "\n", env->efer);
> +    cpu_fprintf(f, "XCR0=%016" PRIx64 "\n", env->xcr0);
>      if (flags & CPU_DUMP_FPU) {
>          int fptag;
>          fptag = 0;
> @@ -565,21 +566,91 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>              else
>                  cpu_fprintf(f, " ");
>          }
> -        if (env->hflags & HF_CS64_MASK)
> -            nb = 16;
> -        else
> +
> +        if (env->hflags & HF_CS64_MASK) {
> +            if (env->xcr0 & XSTATE_Hi16_ZMM_MASK) {
> +                /* AVX-512 32 registers enabled */
> +                nb = 32;
> +            } else {
> +                /* 64-bit mode, 16 registers */
> +                nb = 16;
> +            }
> +        } else {
> +            /* 32 bit mode, 8 registers */
>              nb = 8;
> -        for(i=0;i<nb;i++) {
> -            cpu_fprintf(f, "XMM%02d=%08x%08x%08x%08x",
> -                        i,
> -                        env->xmm_regs[i].ZMM_L(3),
> -                        env->xmm_regs[i].ZMM_L(2),
> -                        env->xmm_regs[i].ZMM_L(1),
> -                        env->xmm_regs[i].ZMM_L(0));
> -            if ((i & 1) == 1)
> +        }
> +
> +        /* sse register width in units of 64 bits */
> +        int zmm_width;
> +        char zmm_name;
> +        if (env->xcr0 & XSTATE_ZMM_Hi256_MASK) {
> +            /* 512-bit "ZMM" - AVX-512 registers enabled */
> +            zmm_width = 8;
> +            zmm_name = 'Z';
> +        } else if (env->xcr0 & XSTATE_YMM_MASK) {
> +            /* 256-bit "YMM" - AVX enabled */
> +            zmm_width = 4;
> +            zmm_name = 'Y';
> +        } else if (env->cr[4] & CR4_OSFXSR_MASK) {
> +            /* 128-bit "XMM" - SSE enabled */
> +            zmm_width = 2;
> +            zmm_name = 'X';
> +        } else {
> +            /* SSE not enabled */
> +            zmm_width = 0;
> +            zmm_name = 0;

You should exit the function here ...

> +        }
> +
> +        if (zmm_width > 0) {
> +            cpu_fprintf(f, "      MSB%*sLSB\n",
> +                        -(zmm_width * 16 + zmm_width - 7), "");
> +        }
> +
> +        for (i = 0; i < nb; i++) {
> +            if (zmm_width == 0) {
> +                cpu_fprintf(f, "SSE not enabled\n");
> +                break;
> +            }

... rather than performing this test in a loop.
Or indeed, printing anything at all.

I assume this is in order to examine registers in the monitor under kvm?


r~
