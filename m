Received: from eggs.gnu.org ([2001:4830:134:3::10]:48879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaTd-0002KW-Sl
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaTS-0006zM-Bu
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:31:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaTR-0006w8-Ol
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:30:58 -0400
Received: by mail-oi1-x243.google.com with SMTP id u130-v6so1726140oie.7
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-4-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:30:32 +0000
Message-ID: <CAFEAcA8gf_qTB554MAzJf1nKv7UK_7_+vdbm=C+9erwyk9XOTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5] target/arm: Introduce read_sys_reg32
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2018 at 12:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Assert that the value to be written is the correct size.
> No change in functionality here, just mirroring the same
> function from kvm64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm32.c | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)

> -    struct kvm_one_reg idregs[] = {
> -        {
> -            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
> -            | ENCODE_CP_REG(15, 0, 0, 0, 0, 0, 0),
> -            .addr = (uintptr_t)&midr,
> -        },
> -        {
> -            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
> -            | ENCODE_CP_REG(15, 0, 0, 0, 1, 0, 0),
> -            .addr = (uintptr_t)&id_pfr0,
> -        },
> -        {
> -            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
> -            | KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1,
> -            .addr = (uintptr_t)&mvfr1,
> -        },
> -    };
>
>      if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>          return false;
> @@ -77,16 +69,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       */
>      ahcf->dtb_compatible = "arm,arm-v7";
>
> -    for (i = 0; i < ARRAY_SIZE(idregs); i++) {
> -        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &idregs[i]);
> -        if (ret) {
> -            break;
> -        }
> -    }
> +    err |= read_sys_reg32(fdarray[2], &midr, ARM_CP15_REG32(0, 0, 0, 0));
> +    err |= read_sys_reg32(fdarray[2], &id_pfr0, ARM_CP15_REG32(0, 0, 1, 0));


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
with the declaration of 'i' removed.

(Confusingly, ENCODE_CP_REG and ARM_CP15_REG32 take the
op1/crn/crm/op2 arguments in different orders.)

thanks
-- PMM
