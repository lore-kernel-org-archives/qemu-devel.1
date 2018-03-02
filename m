Received: from eggs.gnu.org ([2001:4830:134:3::10]:35511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erhwv-0004ME-GA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erhwu-0007AT-EZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:30:01 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erhwu-0007AH-8t
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:30:00 -0500
Received: by mail-ot0-x243.google.com with SMTP id f11so8301256otj.12
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 02:30:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOcSA0wqWrsRMXMv2E+Jb+MnYkD_h16NbEmxYohVJoj-w@mail.gmail.com>
References: <e2a29860b0eb2591e16a83178e305828d1b0b730.1519950018.git.alistair.francis@xilinx.com>
	<CAKmqyKOcSA0wqWrsRMXMv2E+Jb+MnYkD_h16NbEmxYohVJoj-w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 10:29:38 +0000
Message-ID: <CAFEAcA__BbzvYOxOEQ0iydLJf0WQDDTnaivMWyY2UJeLAcy7HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix the A53 L2CTLR typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 2 March 2018 at 04:34, Alistair Francis <alistair23@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 4:20 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> The cortex A53 TRM specifices that bits 24 and 25 of the L2CTLR register
>> specify the number of cores present and not the number of processors. We
>> have correctly been reporting the number of cores, so just fix the
>> comment to match the TRM.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Ah! This isn't actually what I want, I want something more like this (untested):
>
> commit ce9d9795ebff42e1f742e7dc3786e52524807c65
> Author: Alistair Francis <alistair@alistair23.me>
> Date:   Thu Mar 1 20:19:23 2018 -0800
>
>     target/arm: Report the number of cores in the cluster
>
>     Previously we assumed that we only has a single cluster, which meant we
>     could get away with reporting smp_cpus to the guest. There are cases
>     where we have two clusters (Xilinx's ZynqMP is a good example) so
>     reporting the number of smp_cpus is incorrect. Instead count the cores
>     in the cluster.
>
>     Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 9743bdc..e7b1f3c 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -42,8 +42,24 @@ static inline void unset_feature(CPUARMState *env,
> int feature)
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    /* Number of processors is in [25:24]; otherwise we RAZ */
> -    return (smp_cpus - 1) << 24;
> +    CPUState *cpu;
> +    CPUState *cpu_prev = NULL;
> +    int num_cores = 0;
> +
> +    /* Figure out the number of cores in the cluster */
> +    for (cpu = first_cpu; cpu; cpu = CPU_NEXT(cpu)) {
> +        /* Only increase the core count if the CPU we are on is the same
> +         * class as the caller and the previous cpu.
> +         */
> +        if ((CPU_GET_CLASS(cpu) == CPU_GET_CLASS(cpu_prev)) &&
> +            (CPU_GET_CLASS(cpu) == CPU_GET_CLASS(CPU(env)))) {
> +            num_cores++;
> +        }
> +        cpu_prev = cpu;
> +    }
> +
> +    /* Number of cores is in [25:24]; otherwise we RAZ */
> +    return num_cores << 24;
>  }
>  #endif

This seems a bit ad-hoc (it will give the wrong answer if we have
two clusters both of the same kind of CPU, for instance).
Maybe it would be better to have a "cluster-size" property on
the CPU (with the default being number of cores in whole system) ?

thanks
-- PMM
