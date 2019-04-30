Received: from eggs.gnu.org ([209.51.188.92]:59886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRWV-0000pO-JQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRWU-0001p9-CM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRWU-0001os-7B
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:06:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id g8so10637220otl.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190430031238.40499-1-yangchuanlong@huawei.com>
In-Reply-To: <20190430031238.40499-1-yangchuanlong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:05:58 +0100
Message-ID: <CAFEAcA-HkovdX3XayW22=wJ2i0cECV_Jm3OjTv3zsHLMhgsKDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] target/arm/arm-powerctl: mask the cpuid
 with affinity bits when get cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Chuanlong <yangchuanlong@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>

On Tue, 30 Apr 2019 at 04:22, Yang Chuanlong <yangchuanlong@huawei.com> wrote:
>
> Currently, the cpuid passed from the device tree may still contain
> non-affinity fields, which will cause arm_set_cpu_on failure.
> Therefore, we mask the cpuid with affinity fields here to
> improve qemu compatibility.
>
> Signed-off-by: Yang Chuanlong <yangchuanlong@huawei.com>
> ---
>  target/arm/arm-powerctl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index f77a950db6..ef9fec0b4d 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -31,7 +31,13 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
>  {
>      CPUState *cpu;
>
> -    DPRINTF("cpu %" PRId64 "\n", id);
> +#ifdef TARGET_AARCH64
> +    id &= ARM64_AFFINITY_MASK;
> +#else
> +    id &= ARM32_AFFINITY_MASK;
> +#endif
> +
> +    DPRINTF("cpu %" PRId64 " after mask affinity\n", id);
>
>      CPU_FOREACH(cpu) {
>          ARMCPU *armcpu = ARM_CPU(cpu);

Hi -- could you explain what the code path is where we
end up passing a wrong value into this function? I'm
wondering if this is the best place to fix it, or if maybe
the calling function is at fault.

Also, you can't use #ifdef TARGET_AARCH64 here to distinguish
a 64-bit from a 32-bit CPU, because the qemu-system-aarch64
binary (which is built with TARGET_AARCH64) also supports all
the 32-bit CPUs.

thanks
-- PMM
