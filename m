Received: from eggs.gnu.org ([2001:4830:134:3::10]:44528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMAXl-0007qC-5U
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMAXk-0005pp-Dd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:13 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMAXj-0005pJ-WD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:12 -0500
Received: by mail-oi1-x243.google.com with SMTP id j202-v6so6866919oih.10
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:38:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108175246.13416-3-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 11:37:50 +0000
Message-ID: <CAFEAcA_WJMAsHWx+OTO+j0eTsHodpXkyxLv6cAdXxgjsCmTYhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: Fill in ARMISARegisters
 for kvm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 November 2018 at 17:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

>      /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
>       * we know these will only support creating one kind of guest CPU,
>       * which is its preferred CPU type. Fortunately these old kernels
> @@ -474,8 +497,71 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      ahcf->target = init.target;
>      ahcf->dtb_compatible = "arm,arm-v8";
>
> +    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
> +                         ARM64_SYS_REG(3, 0, 0, 4, 0));
> +    if (unlikely(err < 0)) {
> +        /*
> +         * Before v4.15, the kernel only exposed a limited number of system
> +         * registers, not including any of the interesting AArch64 ID regs.
> +         * For the most part we could leave these fields as zero with minimal
> +         * effect, since this does not affect the values seen by the guest.

These older kernels do implement reading of id_isar0 through
id_isar5, though -- we could read and use those values rather than
leaving them zero.

> +         *
> +         * However, it could cause problems down the line for QEMU,
> +         * so provide a minimal v8.0 default.
> +         *
> +         * ??? Could read MIDR and use knowledge from cpu64.c.
> +         * ??? Could map a page of memory into our temp guest and
> +         *     run the tiniest of hand-crafted kernels to extract
> +         *     the values seen by the guest.
> +         * ??? Either of these sounds like too much effort just
> +         *     to work around running a modern host kernel.
> +         */
> +        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
> +        err = 0;

Doesn't this code path leave everything except id_aa64pfr0 as
zero, thus leaving us with the "could cause problems down the
line" situation ?

thanks
-- PMM
