Received: from eggs.gnu.org ([2001:4830:134:3::10]:42220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFIbZ-0006wd-QZ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFIbW-0005TT-Mp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:49:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFIbW-0005Sz-0s
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:49:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id r10-v6so4562463wrv.6
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 05:49:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-4-richard.henderson@linaro.org>
Message-ID: <8b1fc037-77fe-9bed-7c91-75a1d13b8d20@linaro.org>
Date: Wed, 24 Oct 2018 13:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/24/18 12:37 PM, Richard Henderson wrote:
> -    int i, ret, fdarray[3];
> +    int i, err = 0, fdarray[3];

Bah.  The bit about having compile-tested for arm32 was fake news -- "i" is now
unused.  Ho hum.

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
> +    err |= read_sys_reg32(fdarray[2], &mvfr1,
> +                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
> +                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1);


r~
