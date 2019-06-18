Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C227C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4682082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jk0MDf+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4682082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMRk-0005mw-Eu
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMOw-0004OB-8y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMOr-0007Bw-Tj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdMOl-000777-L2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMEiHg193182;
 Tue, 18 Jun 2019 22:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=c92XFEZz5Ssmx4XN4AZAKRfa67rOySwTPmAk3dWPZ30=;
 b=Jk0MDf+2R1ZWEeZfw6MDVW09VAtVerzq/loq88wsBLBON3PWt4WIB82Hw4/AvVG6JPI7
 U6rSNuQxcUCby3J1WDz1fEZG0/i3Qn/Nx9RTHSwwlVrBLAaE5bk/U0G/ICehA0Vcc+e5
 lVKJJCEQZ0thhnw1WajuqpZ8dPtswZKI+vLj00EfCLmK3hqNG0N3rig0+DDhjYmfqdUy
 NYzBCjz0riPrDg8KfmPB+cCLiq0QMiUhLfZZnwZ5NqYc8ymY5XJXsVUrbFnCpyX1UWYs
 BW35wgfRklTjHjrhiykNEBU/rvS5aGsm2ANLwZoCCPXYf6DPRnWOl2GiGQ2HYxxFHJQ4 JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t780983t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:16:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMF7cl069333;
 Tue, 18 Jun 2019 22:16:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t77ymreby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:16:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5IMG9Vh018851;
 Tue, 18 Jun 2019 22:16:09 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 15:16:09 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-5-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <87902b78-6f44-8eb3-3473-a45a635341b7@oracle.com>
Date: Tue, 18 Jun 2019 15:16:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175658.135869-5-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180178
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU PATCH v3 4/9] KVM: i386: Block migration for
 vCPUs exposed with nested virtualization
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/2019 10:56 AM, Liran Alon wrote:
> Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
> added a migration blocker for vCPU exposed with Intel VMX.
> However, migration should also be blocked for vCPU exposed with
> AMD SVM.
>
> Both cases should be blocked because QEMU should extract additional
> vCPU state from KVM that should be migrated as part of vCPU VMState.
> E.g. Whether vCPU is running in guest-mode or host-mode.
>
> Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   target/i386/cpu.c |  6 ------
>   target/i386/cpu.h | 24 ++++++++++++++++++++++++
>   target/i386/kvm.c | 12 ++++++------
>   3 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 536d7d152044..197201087e65 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5170,12 +5170,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>       return rv;
>   }
>   
> -#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
> -                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
> -                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
> -#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
> -                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
> -                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
>   static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index fce6660bac00..79d9495ceb0c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -728,6 +728,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>   
>   #define CPUID_VENDOR_HYGON    "HygonGenuine"
>   
> +#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
> +                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
> +                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
> +#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
> +                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
> +                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
> +
>   #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
>   #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
>   
> @@ -1866,6 +1873,23 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
>       }
>   }
>   
> +static inline bool cpu_has_vmx(CPUX86State *env)
> +{
> +    return (IS_INTEL_CPU(env) &&
> +            (env->features[FEAT_1_ECX] & CPUID_EXT_VMX));
> +}
> +
> +static inline bool cpu_has_svm(CPUX86State *env)
> +{
> +    return (IS_AMD_CPU(env) &&
> +            (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM));
> +}
> +
> +static inline bool cpu_has_nested_virt(CPUX86State *env)
> +{
> +    return (cpu_has_vmx(env) || cpu_has_svm(env));
> +}
> +
>   /* fpu_helper.c */
>   void update_fp_status(CPUX86State *env);
>   void update_mxcsr_status(CPUX86State *env);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index c8fd53055d37..f43e2d69859e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -906,7 +906,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>   }
>   
>   static Error *invtsc_mig_blocker;
> -static Error *vmx_mig_blocker;
> +static Error *nested_virt_mig_blocker;
>   
>   #define KVM_MAX_CPUID_ENTRIES  100
>   
> @@ -1270,13 +1270,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                     !!(c->ecx & CPUID_EXT_SMX);
>       }
>   
> -    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
> -        error_setg(&vmx_mig_blocker,
> -                   "Nested VMX virtualization does not support live migration yet");
> -        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
> +    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
> +        error_setg(&nested_virt_mig_blocker,
> +                   "Nested virtualization does not support live migration yet");
> +        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
> -            error_free(vmx_mig_blocker);
> +            error_free(nested_virt_mig_blocker);
>               return r;
>           }
>       }

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran

