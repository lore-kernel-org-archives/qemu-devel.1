Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fivH7-0003a8-Kn
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fivH6-0005mY-Nz
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:26:49 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-5-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <829318c8-9921-b856-e2bb-86583f43a8e7@amsat.org>
Date: Fri, 27 Jul 2018 02:26:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 4/7] target/arm: add
 "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, Su Hang <suhang16@mails.ucas.ac.cn>, ilg@livius.net, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

Hi Stefan,

On 07/25/2018 05:59 AM, Stefan Hajnoczi wrote:
> Define a "cortex-m0" ARMv6-M CPU model.
> 
> Most of the register reset values set by other CPU models are not
> relevant for the cut-down ARMv6-M architecture.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  target/arm/cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 3848ef46aa..7e477c0d23 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1255,6 +1255,15 @@ static void arm11mpcore_initfn(Object *obj)
>      cpu->reset_auxcr = 1;
>  }
>  
> +static void cortex_m0_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V6);
> +    set_feature(&cpu->env, ARM_FEATURE_M);

What about ARM_FEATURE_THUMB2 (T32)?

Peter: Since the M0 (optionally?) supports 32x32 multiply, should this
cpu use the ARM_FEATURE_THUMB_DSP feature? Else this might trigger an
'Undefined Instruction' in disas_thumb2_insn().

And what about optional ARM_FEATURE_PMSA?
Oh this would be cortex_m0plus_initfn() for "cortex-m0-plus", ok.

> +
> +    cpu->midr = 0x410cc200;
> +}
> +
>  static void cortex_m3_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -1845,6 +1854,8 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "arm1136",     .initfn = arm1136_initfn },
>      { .name = "arm1176",     .initfn = arm1176_initfn },
>      { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
> +    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> +                             .class_init = arm_v7m_class_init },

What about renaming arm_v7m_class_init -> arm_m_profile_class_init (such
your patches 1 and 2)?

>      { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
>                               .class_init = arm_v7m_class_init },
>      { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
> 

Regards,

Phil.
