Received: from eggs.gnu.org ([2001:4830:134:3::10]:32991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMCvZ-0003Uc-HP
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMCvT-0008CP-Rx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:10:57 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMCvT-0008AB-Iu
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:10:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id f10-v6so8628125wme.3
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:10:48 -0800 (PST)
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-5-richard.henderson@linaro.org>
	<CAFEAcA-ooeVt=GRmu2Q+9DcaAs96B5AonpspVVExqQbf3kORPQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4290d696-cae9-c7bd-8c53-30376328e762@linaro.org>
Date: Mon, 12 Nov 2018 15:10:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ooeVt=GRmu2Q+9DcaAs96B5AonpspVVExqQbf3kORPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11/12/18 1:42 PM, Peter Maydell wrote:
> Adding the following change allowed me to boot:
> 
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 8b2c9b3..2f7df81 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -84,9 +84,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                            ARM_CP15_REG32(0, 0, 2, 4));
>      err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
>                            ARM_CP15_REG32(0, 0, 2, 5));
> -    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
> -                          ARM_CP15_REG32(0, 0, 2, 7));
> -
> +    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
> +                          ARM_CP15_REG32(0, 0, 2, 7))) {
> +        /*
> +         * Older kernels don't support reading ID_ISAR6. This register was
> +         * only introduced in ARMv8, so we can assume that it is zero on a
> +         * CPU that a kernel this old is running on.
> +         */
> +        ahcf->isar.id_isar6 = 0;
> +    }

Ah, right, thanks.


r~
