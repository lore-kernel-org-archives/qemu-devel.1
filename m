Received: from eggs.gnu.org ([2001:4830:134:3::10]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebsoj-00064l-8v
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ebsog-0003MJ-23
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ebsof-0003Kx-Om
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 13:52:05 -0500
Date: Wed, 17 Jan 2018 18:51:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180117185153.GB2416@work-vm>
References: <20171203063548.10297-1-doug16k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171203063548.10297-1-doug16k@gmail.com>
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
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

* Doug Gale (doug16k@gmail.com) wrote:
> Signed-off-by: Doug Gale <doug16k@gmail.com>

Hi Doug,
  Had you ever seen the top half of YMM* be none-zero?
All my tests with this are showing it as zero even though in the guest
I'm seeing some cases of gdb being non-zero.
(I'm starting to suspect it's not the printing code)

Dave

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
> +
> +            cpu_fprintf(f, "%cMM%02d=", zmm_name, i);
> +            int qw;
> +            for (qw = zmm_width; qw > 0; qw -= 2) {
> +                /* ':' separator every 64 bits */
> +                cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
> +                            env->xmm_regs[i].ZMM_Q(qw - 1),
> +                            env->xmm_regs[i].ZMM_Q(qw - 2),
> +                            qw > 2 ? ":" : "");
> +            }
> +
> +            /* two registers per line for 128-bit registers */
> +            if (zmm_width > 2 || (i & 1)) {
>                  cpu_fprintf(f, "\n");
> -            else
> +            } else {
>                  cpu_fprintf(f, " ");
> +            }
> +        }
> +
> +        if (env->xcr0 & XSTATE_OPMASK_MASK) {
> +            /* AVX-512 opmask registers */
> +            for (i = 0; i < 8; ++i) {
> +                cpu_fprintf(f, "K%d=%08" PRIx64 "%s", i, env->opmask_regs[i],
> +                           (i & 3) == 3 ? "\n" : " ");
> +            }
> +        }
> +
> +        if (env->xcr0 & XSTATE_BNDREGS_MASK) {
> +            /* MPX bound registers */
> +            for (i = 0; i < 4; ++i) {
> +                cpu_fprintf(f, "BND%d=%016" PRIx64 ":%016" PRIx64 "%s",
> +                            i, env->bnd_regs[i].ub, env->bnd_regs[i].lb,
> +                            (i & 1) ? "\n" : " ");
> +            }
> +        }
> +
> +        if (env->xcr0 & XSTATE_BNDCSR_MASK) {
> +            /* MPX bound status/config registers */
> +            cpu_fprintf(f, "BNDCFGU=%016" PRIx64 " BNDSTATUS=%016" PRIx64 "\n",
> +                        env->bndcs_regs.cfgu, env->bndcs_regs.sts);
>          }
>      }
>      if (flags & CPU_DUMP_CODE) {
> -- 
> 2.14.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
