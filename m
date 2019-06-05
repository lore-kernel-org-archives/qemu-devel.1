Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2797C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C682083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C682083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQAw-0005OL-Qe
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:17:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYQ9a-0004mc-2f
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hYQ9Y-00022r-5m
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hYQ9Q-0001tk-Kh; Wed, 05 Jun 2019 03:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABE35308626C;
	Wed,  5 Jun 2019 07:15:54 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E10A5C5DE;
	Wed,  5 Jun 2019 07:15:51 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-5-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7c0c0ef2-6ab4-fdf9-9507-d1f460bfbd51@redhat.com>
Date: Wed, 5 Jun 2019 09:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190512083624.8916-5-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 05 Jun 2019 07:15:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/13] target/arm/kvm: Move the get/put of
 fpsimd registers out
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	abologna@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 5/12/19 10:36 AM, Andrew Jones wrote:
> Move the getting/putting of the fpsimd registers out of
> kvm_arch_get/put_registers() into their own helper functions
> to prepare for alternatively getting/putting SVE registers.
> 
> No functional change.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/kvm64.c | 148 +++++++++++++++++++++++++++------------------
>  1 file changed, 88 insertions(+), 60 deletions(-)
> 
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index ba232b27a6d3..61947f3716e1 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -706,13 +706,53 @@ int kvm_arm_cpreg_level(uint64_t regidx)
>  #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>  
> +static int kvm_arch_put_fpsimd(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_one_reg reg;
> +    uint32_t fpr;
> +    int i, ret;
> +
> +    for (i = 0; i < 32; i++) {
> +        uint64_t *q = aa64_vfp_qreg(env, i);
> +#ifdef HOST_WORDS_BIGENDIAN
> +        uint64_t fp_val[2] = { q[1], q[0] };
> +        reg.addr = (uintptr_t)fp_val;
> +#else
> +        reg.addr = (uintptr_t)q;
> +#endif
> +        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    fpr = vfp_get_fpsr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
I don't think you need this assignment
> +    fpr = vfp_get_fpcr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>  int kvm_arch_put_registers(CPUState *cs, int level)
>  {
>      struct kvm_one_reg reg;
> -    uint32_t fpr;
>      uint64_t val;
> -    int i;
> -    int ret;
> +    int i, ret;
>      unsigned int el;
>  
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -802,33 +842,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          }
>      }
>  
> -    /* Advanced SIMD and FP registers. */
> -    for (i = 0; i < 32; i++) {
> -        uint64_t *q = aa64_vfp_qreg(env, i);
> -#ifdef HOST_WORDS_BIGENDIAN
> -        uint64_t fp_val[2] = { q[1], q[0] };
> -        reg.addr = (uintptr_t)fp_val;
> -#else
> -        reg.addr = (uintptr_t)q;
> -#endif
> -        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> -        if (ret) {
> -            return ret;
> -        }
> -    }
> -
> -    reg.addr = (uintptr_t)(&fpr);
> -    fpr = vfp_get_fpsr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> -    if (ret) {
> -        return ret;
> -    }
> -
> -    fpr = vfp_get_fpcr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_arch_put_fpsimd(cs);
>      if (ret) {
>          return ret;
>      }
> @@ -849,14 +863,54 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>      return ret;
>  }
>  
> +static int kvm_arch_get_fpsimd(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    struct kvm_one_reg reg;
> +    uint32_t fpr;
> +    int i, ret;
> +
> +    for (i = 0; i < 32; i++) {
> +        uint64_t *q = aa64_vfp_qreg(env, i);
> +        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> +        reg.addr = (uintptr_t)q;
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        } else {
> +#ifdef HOST_WORDS_BIGENDIAN
> +            uint64_t t;
> +            t = q[0], q[0] = q[1], q[1] = t;
> +#endif
> +        }
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    vfp_set_fpsr(env, fpr);
> +
> +    reg.addr = (uintptr_t)(&fpr);
same here
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    vfp_set_fpcr(env, fpr);
> +
> +    return 0;
> +}
> +
>  int kvm_arch_get_registers(CPUState *cs)
>  {
>      struct kvm_one_reg reg;
>      uint64_t val;
> -    uint32_t fpr;
>      unsigned int el;
> -    int i;
> -    int ret;
> +    int i, ret;
>  
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> @@ -945,36 +999,10 @@ int kvm_arch_get_registers(CPUState *cs)
>          env->spsr = env->banked_spsr[i];
>      }
>  
> -    /* Advanced SIMD and FP registers */
> -    for (i = 0; i < 32; i++) {
> -        uint64_t *q = aa64_vfp_qreg(env, i);
> -        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -        reg.addr = (uintptr_t)q;
> -        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> -        if (ret) {
> -            return ret;
> -        } else {
> -#ifdef HOST_WORDS_BIGENDIAN
> -            uint64_t t;
> -            t = q[0], q[0] = q[1], q[1] = t;
> -#endif
> -        }
> -    }
> -
> -    reg.addr = (uintptr_t)(&fpr);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> -    if (ret) {
> -        return ret;
> -    }
> -    vfp_set_fpsr(env, fpr);
> -
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    ret = kvm_arch_get_fpsimd(cs);
>      if (ret) {
>          return ret;
>      }
> -    vfp_set_fpcr(env, fpr);
>  
>      ret = kvm_get_vcpu_events(cpu);
>      if (ret) {
> 

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


