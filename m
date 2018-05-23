Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSqm-0003Hu-Bc
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSqg-0003Ya-Ck
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:26:40 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSqg-0003YO-83
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:26:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id f1-v6so27739625qtj.6
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:26:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-14-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d87c4c82-9762-efd1-19fd-3cfdf57466c1@amsat.org>
Date: Wed, 23 May 2018 09:26:29 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-14-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/30] RISC-V: Implement
 mstatus.TSR/TW/TVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Matthew Suozzo <msuozzo@google.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

Hi Michael,

On 05/22/2018 09:15 PM, Michael Clark wrote:
> This adds the necessary minimum to support S-mode
> virtualization for priv ISA >= v1.10
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Matthew Suozzo <msuozzo@google.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> 
> Co-authored-by: Matthew Suozzo <msuozzo@google.com>

Isn't it simply another Signed-off-by?

> Co-authored-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/csr.c       | 17 +++++++++++++----
>  target/riscv/op_helper.c | 25 +++++++++++++++++++++----
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b4452388ff02..509215327243 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -313,7 +313,8 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>          }
>          mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
>              MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> -            MSTATUS_MPP | MSTATUS_MXR;
> +            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> +            MSTATUS_TW;
>      }
>  
>      /* silenty discard mstatus.mpp writes for unsupported modes */
> @@ -654,7 +655,11 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
>      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>          *val = 0;
>      } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> -        *val = env->satp;
> +        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +            return -1;
> +        } else {
> +            *val = env->satp;
> +        }
>      } else {
>          *val = env->sptbr;
>      }
> @@ -675,8 +680,12 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>          validate_vm(env, get_field(val, SATP_MODE)) &&
>          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>      {
> -        tlb_flush(CPU(riscv_env_get_cpu(env)));
> -        env->satp = val;
> +        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +            return -1;
> +        } else {
> +            tlb_flush(CPU(riscv_env_get_cpu(env)));
> +            env->satp = val;
> +        }
>      }
>      return 0;
>  }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81bd1a77ea90..77c79ba36e0b 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -82,6 +82,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>  
> +    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> +        get_field(env->mstatus, MSTATUS_TSR)) {
> +        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
>      target_ulong mstatus = env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
>      mstatus = set_field(mstatus,
> @@ -125,16 +130,28 @@ void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
>  
> -    cs->halted = 1;
> -    cs->exception_index = EXCP_HLT;
> -    cpu_loop_exit(cs);
> +    if (env->priv == PRV_S &&
> +        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> +        get_field(env->mstatus, MSTATUS_TW)) {
> +        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    } else {
> +        cs->halted = 1;
> +        cs->exception_index = EXCP_HLT;
> +        cpu_loop_exit(cs);
> +    }
>  }
>  
>  void helper_tlb_flush(CPURISCVState *env)
>  {
>      RISCVCPU *cpu = riscv_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
> -    tlb_flush(cs);
> +    if (env->priv == PRV_S &&
> +        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> +        get_field(env->mstatus, MSTATUS_TVM)) {
> +        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    } else {
> +        tlb_flush(cs);
> +    }
>  }
>  
>  #endif /* !CONFIG_USER_ONLY */
> 
