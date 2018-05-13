Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfEV-0002Iu-K4
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfES-0007Jo-Ga
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:51:27 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfES-0007Ja-CA
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:51:24 -0400
Received: by mail-qt0-x242.google.com with SMTP id f5-v6so11913508qth.2
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:51:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5cb90df6-bf2e-f268-3f96-efe9450498c3@amsat.org>
Date: Sat, 12 May 2018 21:51:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/9] target/riscv: Introduce
 cpu_riscv_get_fcsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/cpu.h        | 1 +
>  target/riscv/fpu_helper.c | 6 ++++++
>  target/riscv/op_helper.c  | 3 +--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34abc383e3..f2bc243b95 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -265,6 +265,7 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
>                                            uint32_t exception, uintptr_t pc);
>  
>  target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
> +target_ulong cpu_riscv_get_fcsr(CPURISCVState *env);
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
>  
>  #define TB_FLAGS_MMU_MASK  3
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index abbadead5c..41c7352115 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -37,6 +37,12 @@ target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
>      return hard;
>  }
>  
> +target_ulong cpu_riscv_get_fcsr(CPURISCVState *env)
> +{
> +    return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
> +         | (env->frm << FSR_RD_SHIFT);
> +}
> +
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
>  {
>      int soft = 0;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 3abf52453c..fd2d8c0a9d 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -423,8 +423,7 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
>          return env->frm;
>      case CSR_FCSR:
>          validate_mstatus_fs(env, GETPC());
> -        return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
> -                | (env->frm << FSR_RD_SHIFT);
> +        return cpu_riscv_get_fcsr(env);
>      /* rdtime/rdtimeh is trapped and emulated by bbl in system mode */
>  #ifdef CONFIG_USER_ONLY
>      case CSR_TIME:
> 
