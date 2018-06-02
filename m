Received: from eggs.gnu.org ([2001:4830:134:3::10]:57430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fP97l-0002hp-WE
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fP97l-0002vC-2G
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:11:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fP97k-0002u6-Sw
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 12:11:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id k190-v6so7436141oib.9
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 09:11:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180602141446.29982-2-stefanha@redhat.com>
References: <20180602141446.29982-1-stefanha@redhat.com>
	<20180602141446.29982-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Jun 2018 17:11:03 +0100
Message-ID: <CAFEAcA9BdH+Qj9S17kVagbTP4B6j+SS64mmSbKu4Yf4H6EKOjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 1/2] target/arm: add "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On 2 June 2018 at 15:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Define a "cortex-m0" ARMv6-M CPU model.
>
> Most of the register reset values set by other CPU models are not
> relevant for the cut-down ARMv6-M architecture.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  target/arm/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5d60893a07..aac224d809 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1215,6 +1215,16 @@ static void arm11mpcore_initfn(Object *obj)
>      cpu->reset_auxcr = 1;
>  }
>
> +static void cortex_m0_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V6);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +
> +    /* TODO ARMv6-M doesn't support coprocessors, so how is this value accessed? */
> +    cpu->midr = 0x410cc200;

The MIDR is a memory-mapped register on M-profile (at 0xed00ed00);
we implement this in hw/intc/armv7m_nvic.c.

> +}
> +
>  static void cortex_m3_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -1796,6 +1806,8 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "arm1136",     .initfn = arm1136_initfn },
>      { .name = "arm1176",     .initfn = arm1176_initfn },
>      { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
> +    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> +                             .class_init = arm_v7m_class_init /* TODO rename? */ },

We use v7m for a lot of stuff that's really M-profile in
general (eg the v8m cortex-m33), so I wouldn't worry too
much about renaming the function.

thanks
-- PMM
