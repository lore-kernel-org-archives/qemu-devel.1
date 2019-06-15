Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBEC31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EDF21848
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4R5m1onQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EDF21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbx2M-0003MS-4y
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hbx0y-0002MD-Po
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hbx0w-00080Y-Bo
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:57:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hbx0v-0007yx-OW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:57:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F0icV0183392;
 Sat, 15 Jun 2019 00:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=SI8odzHe50M8MLIO7ZdRVBs7w1wUXG5Eg4SbB+9xGPk=;
 b=4R5m1onQuuasxwyFC8OOitkfMSqowOatEr7LVaIFv3JhZUFVmcUKEMRa9sXKOBLkoFDx
 lz5yQLsuJTFAj0IxQcyIkNah654S7I6zH6eBycByOI/vjg+gwCdF+XmB0kmfmE3ys79P
 3rlLXMhXQ7PjFUJLs0A5L3cn/rj7734vmyd0sCg+BojdEktW9aX6kw0W7YsQ6XQLWzCb
 iAK3yO8MBWkwUW4W69AdPsj6W5MRuVpD6CbsElU4CLJz11pV8HgJLnGqSJ/MBmRmDvMU
 zppiCcIKPcgk7hRW0dMALaMMypuuQ3tu5tZaFT1ZwPATY0BydWndlJqvVAb0zUqGdXVo BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t05nr9s3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 00:57:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F0v0ae175008;
 Sat, 15 Jun 2019 00:57:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t1jpkcywk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 00:57:45 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5F0vi1H010050;
 Sat, 15 Jun 2019 00:57:44 GMT
Received: from [10.0.0.13] (/109.66.72.187)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 14 Jun 2019 17:57:44 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190615004256.16367-4-pbonzini@redhat.com>
Date: Sat, 15 Jun 2019 03:57:40 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB7EDEC6-BD44-460E-B7B2-29060631E4FF@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-4-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906150003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906150003
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 3/7] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 15 Jun 2019, at 3:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> From: Liran Alon <liran.alon@oracle.com>
>=20
> Kernel commit c4f55198c7c2 ("kvm: x86: Introduce =
KVM_CAP_EXCEPTION_PAYLOAD")
> introduced a new KVM capability which allows userspace to correctly
> distinguish between pending and injected exceptions.
>=20
> This distinguish is important in case of nested virtualization =
scenarios
> because a L2 pending exception can still be intercepted by the L1 =
hypervisor
> while a L2 injected exception cannot.
>=20
> Furthermore, when an exception is attempted to be injected by QEMU,
> QEMU should specify the exception payload (CR2 in case of #PF or
> DR6 in case of #DB) instead of having the payload already delivered in
> the respective vCPU register. Because in case exception is injected to
> L2 guest and is intercepted by L1 hypervisor, then payload needs to be
> reported to L1 intercept (VMExit handler) while still preserving
> respective vCPU register unchanged.
>=20
> This commit adds support for QEMU to properly utilise this new KVM
> capability (KVM_CAP_EXCEPTION_PAYLOAD).
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> target/i386/cpu.c        | 10 ++---
> target/i386/cpu.h        | 13 +++++-
> target/i386/hvf/hvf.c    | 10 +++--
> target/i386/hvf/x86hvf.c |  4 +-
> target/i386/kvm.c        | 95 +++++++++++++++++++++++++++++++++-------
> target/i386/machine.c    | 61 +++++++++++++++++++++++++-
> 6 files changed, 163 insertions(+), 30 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c1ab86d63e..4e19969111 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4777,7 +4777,9 @@ static void x86_cpu_reset(CPUState *s)
>     memset(env->mtrr_fixed, 0, sizeof(env->mtrr_fixed));
>=20
>     env->interrupt_injected =3D -1;
> -    env->exception_injected =3D -1;
> +    env->exception_nr =3D -1;
> +    env->exception_pending =3D 0;
> +    env->exception_injected =3D 0;

Note: I the patch-series I will submit I will add here:
+    env->exception_has_payload =3D false;
+    env->exception_payload =3D 0;

>     env->nmi_injected =3D false;
> #if !defined(CONFIG_USER_ONLY)
>     /* We hard-wire the BSP to the first CPU. */
> @@ -5173,12 +5175,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>     return rv;
> }
>=20
> -#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 =3D=3D =
CPUID_VENDOR_INTEL_1 && \
> -                           (env)->cpuid_vendor2 =3D=3D =
CPUID_VENDOR_INTEL_2 && \
> -                           (env)->cpuid_vendor3 =3D=3D =
CPUID_VENDOR_INTEL_3)
> -#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 =3D=3D =
CPUID_VENDOR_AMD_1 && \
> -                         (env)->cpuid_vendor2 =3D=3D =
CPUID_VENDOR_AMD_2 && \
> -                         (env)->cpuid_vendor3 =3D=3D =
CPUID_VENDOR_AMD_3)
> static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> {
>     CPUState *cs =3D CPU(dev);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bd06523a53..bbeb7a9521 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -729,6 +729,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>=20
> #define CPUID_VENDOR_HYGON    "HygonGenuine"
>=20
> +#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 =3D=3D =
CPUID_VENDOR_INTEL_1 && \
> +                           (env)->cpuid_vendor2 =3D=3D =
CPUID_VENDOR_INTEL_2 && \
> +                           (env)->cpuid_vendor3 =3D=3D =
CPUID_VENDOR_INTEL_3)
> +#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 =3D=3D =
CPUID_VENDOR_AMD_1 && \
> +                         (env)->cpuid_vendor2 =3D=3D =
CPUID_VENDOR_AMD_2 && \
> +                         (env)->cpuid_vendor3 =3D=3D =
CPUID_VENDOR_AMD_3)
> +
> #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit =
capability */
> #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
>=20
> @@ -1332,10 +1339,14 @@ typedef struct CPUX86State {
>=20
>     /* For KVM */
>     uint32_t mp_state;
> -    int32_t exception_injected;
> +    int32_t exception_nr;
>     int32_t interrupt_injected;
>     uint8_t soft_interrupt;
> +    uint8_t exception_pending;
> +    uint8_t exception_injected;
>     uint8_t has_error_code;
> +    uint8_t exception_has_payload;
> +    uint64_t exception_payload;
>     uint32_t ins_len;
>     uint32_t sipi_vector;
>     bool tsc_valid;
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 2751c8125c..dc4bb63536 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -605,7 +605,9 @@ static void hvf_store_events(CPUState *cpu, =
uint32_t ins_len, uint64_t idtvec_in
>     X86CPU *x86_cpu =3D X86_CPU(cpu);
>     CPUX86State *env =3D &x86_cpu->env;
>=20
> -    env->exception_injected =3D -1;
> +    env->exception_nr =3D -1;
> +    env->exception_pending =3D 0;
> +    env->exception_injected =3D 0;
>     env->interrupt_injected =3D -1;
>     env->nmi_injected =3D false;
>     if (idtvec_info & VMCS_IDT_VEC_VALID) {
> @@ -619,7 +621,8 @@ static void hvf_store_events(CPUState *cpu, =
uint32_t ins_len, uint64_t idtvec_in
>             break;
>         case VMCS_IDT_VEC_HWEXCEPTION:
>         case VMCS_IDT_VEC_SWEXCEPTION:
> -            env->exception_injected =3D idtvec_info & =
VMCS_IDT_VEC_VECNUM;
> +            env->exception_nr =3D idtvec_info & VMCS_IDT_VEC_VECNUM;
> +            env->exception_injected =3D 1;
>             break;
>         case VMCS_IDT_VEC_PRIV_SWEXCEPTION:
>         default:
> @@ -912,7 +915,8 @@ int hvf_vcpu_exec(CPUState *cpu)
>             macvm_set_rip(cpu, rip + ins_len);
>             break;
>         case VMX_REASON_VMCALL:
> -            env->exception_injected =3D EXCP0D_GPF;
> +            env->exception_nr =3D EXCP0D_GPF;
> +            env->exception_injected =3D 1;
>             env->has_error_code =3D true;
>             env->error_code =3D 0;
>             break;
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index df8e946fbc..e0ea02d631 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -362,8 +362,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
>     if (env->interrupt_injected !=3D -1) {
>         vector =3D env->interrupt_injected;
>         intr_type =3D VMCS_INTR_T_SWINTR;
> -    } else if (env->exception_injected !=3D -1) {
> -        vector =3D env->exception_injected;
> +    } else if (env->exception_nr !=3D -1) {
> +        vector =3D env->exception_nr;
>         if (vector =3D=3D EXCP03_INT3 || vector =3D=3D EXCP04_INTO) {
>             intr_type =3D VMCS_INTR_T_SWEXCEPTION;
>         } else {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 53f95b02a0..dca76830ec 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -104,6 +104,7 @@ static uint32_t =
num_architectural_pmu_fixed_counters;
> static int has_xsave;
> static int has_xcrs;
> static int has_pit_state2;
> +static int has_exception_payload;
>=20
> static bool has_msr_mcg_ext_ctl;
>=20
> @@ -584,15 +585,51 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int =
code, void *addr)
>     /* Hope we are lucky for AO MCE */
> }
>=20
> +static void kvm_reset_exception(CPUX86State *env)
> +{
> +	env->exception_nr =3D -1;
> +	env->exception_pending =3D 0;
> +	env->exception_injected =3D 0;

Note: In the patch-series I will submit I will add here:
+       env->exception_has_payload =3D false;
+       env->exception_payload =3D 0;

> +}
> +
> +static void kvm_queue_exception(CPUX86State *env,
> +                                int32_t exception_nr,
> +                                uint8_t exception_has_payload,
> +                                uint64_t exception_payload)
> +{
> +    assert(env->exception_nr =3D=3D -1);
> +    assert(!env->exception_pending);
> +    assert(!env->exception_injected);

Note: In the patch-series I will submit I will add here:
+    assert(!env->exception_has_payload);

> +
> +    env->exception_nr =3D exception_nr;
> +
> +    if (has_exception_payload) {
> +        env->exception_pending =3D 1;
> +
> +        env->exception_has_payload =3D exception_has_payload;
> +        env->exception_payload =3D exception_payload;
> +    } else {
> +        env->exception_injected =3D 1;
> +
> +        if (exception_has_payload) {
> +            if (exception_nr =3D=3D EXCP01_DB) {
> +                env->dr[6] =3D exception_payload;
> +            } else if (exception_nr =3D=3D EXCP0E_PAGE) {
> +                env->cr[2] =3D exception_payload;
> +            }
> +        }

Note: In the patch-series I will submit, I have changed this
to verify that #DB & #PF always have env->exception_has_payload set to =
true
and other cases have it set to false.

> +    }
> +}
> +
> static int kvm_inject_mce_oldstyle(X86CPU *cpu)
> {
>     CPUX86State *env =3D &cpu->env;
>=20
> -    if (!kvm_has_vcpu_events() && env->exception_injected =3D=3D =
EXCP12_MCHK) {
> +    if (!kvm_has_vcpu_events() && env->exception_nr =3D=3D =
EXCP12_MCHK) {
>         unsigned int bank, bank_num =3D env->mcg_cap & 0xff;
>         struct kvm_x86_mce mce;
>=20
> -        env->exception_injected =3D -1;
> +	kvm_reset_exception(env);
>=20
>         /*
>          * There must be at least one bank in use if an MCE is =
pending.
> @@ -1573,6 +1610,16 @@ int kvm_arch_init(MachineState *ms, KVMState =
*s)
>=20
>     hv_vpindex_settable =3D kvm_check_extension(s, =
KVM_CAP_HYPERV_VP_INDEX);
>=20
> +    has_exception_payload =3D kvm_check_extension(s, =
KVM_CAP_EXCEPTION_PAYLOAD);
> +    if (has_exception_payload) {
> +        ret =3D kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, =
true);
> +        if (ret < 0) {
> +            error_report("kvm: Failed to enable exception payload =
cap: %s",
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
>     ret =3D kvm_get_supported_msrs(s);
>     if (ret < 0) {
>         return ret;
> @@ -2877,8 +2924,16 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int =
level)
>         return 0;
>     }
>=20
> -    events.exception.injected =3D (env->exception_injected >=3D 0);
> -    events.exception.nr =3D env->exception_injected;
> +    events.flags =3D 0;
> +
> +    if (has_exception_payload) {
> +        events.flags |=3D KVM_VCPUEVENT_VALID_PAYLOAD;
> +        events.exception.pending =3D env->exception_pending;
> +        events.exception_has_payload =3D env->exception_has_payload;
> +        events.exception_payload =3D env->exception_payload;
> +    }
> +    events.exception.nr =3D env->exception_nr;
> +    events.exception.injected =3D env->exception_injected;
>     events.exception.has_error_code =3D env->has_error_code;
>     events.exception.error_code =3D env->error_code;
>=20
> @@ -2891,7 +2946,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int =
level)
>     events.nmi.masked =3D !!(env->hflags2 & HF2_NMI_MASK);
>=20
>     events.sipi_vector =3D env->sipi_vector;
> -    events.flags =3D 0;
>=20
>     if (has_msr_smbase) {
>         events.smi.smm =3D !!(env->hflags & HF_SMM_MASK);
> @@ -2941,8 +2995,19 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
>     if (ret < 0) {
>        return ret;
>     }
> -    env->exception_injected =3D
> -       events.exception.injected ? events.exception.nr : -1;
> +
> +    if (events.flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
> +        env->exception_pending =3D events.exception.pending;
> +        env->exception_has_payload =3D events.exception_has_payload;
> +        env->exception_payload =3D events.exception_payload;
> +    } else {
> +        env->exception_pending =3D 0;
> +        env->exception_has_payload =3D false;
> +    }
> +    env->exception_injected =3D events.exception.injected;
> +    env->exception_nr =3D
> +        (env->exception_pending || env->exception_injected) ?
> +        events.exception.nr : -1;
>     env->has_error_code =3D events.exception.has_error_code;
>     env->error_code =3D events.exception.error_code;
>=20
> @@ -2994,12 +3059,12 @@ static int kvm_guest_debug_workarounds(X86CPU =
*cpu)
>     unsigned long reinject_trap =3D 0;
>=20
>     if (!kvm_has_vcpu_events()) {
> -        if (env->exception_injected =3D=3D EXCP01_DB) {
> +        if (env->exception_nr =3D=3D EXCP01_DB) {
>             reinject_trap =3D KVM_GUESTDBG_INJECT_DB;
>         } else if (env->exception_injected =3D=3D EXCP03_INT3) {
>             reinject_trap =3D KVM_GUESTDBG_INJECT_BP;
>         }
> -        env->exception_injected =3D -1;
> +        kvm_reset_exception(env);
>     }
>=20
>     /*
> @@ -3320,13 +3385,13 @@ int kvm_arch_process_async_events(CPUState =
*cs)
>=20
>         kvm_cpu_synchronize_state(cs);
>=20
> -        if (env->exception_injected =3D=3D EXCP08_DBLE) {
> +        if (env->exception_nr =3D=3D EXCP08_DBLE) {
>             /* this means triple fault */
>             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>             cs->exit_request =3D 1;
>             return 0;
>         }
> -        env->exception_injected =3D EXCP12_MCHK;
> +        kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
>         env->has_error_code =3D 0;
>=20
>         cs->halted =3D 0;
> @@ -3541,14 +3606,12 @@ static int kvm_handle_debug(X86CPU *cpu,
>     }
>     if (ret =3D=3D 0) {
>         cpu_synchronize_state(cs);
> -        assert(env->exception_injected =3D=3D -1);
> +        assert(env->exception_nr =3D=3D -1);
>=20
>         /* pass to guest */
> -        env->exception_injected =3D arch_info->exception;
> +        kvm_queue_exception(env, arch_info->exception,
> +                            EXCP01_DB, arch_info->dr6);

There is a bug here I will fix in my patch-series:
Third argument should be (arch_info->exception =3D=3D EXCP01_DB).

>         env->has_error_code =3D 0;
> -        if (arch_info->exception =3D=3D EXCP01_DB) {
> -            env->dr[6] =3D arch_info->dr6;
> -        }
>     }
>=20
>     return ret;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 225b5d433b..41460be54b 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -199,6 +199,21 @@ static const VMStateDescription vmstate_fpreg =3D =
{
>     }
> };
>=20
> +static bool is_vmx_enabled(CPUX86State *env)
> +{
> +    return (IS_INTEL_CPU(env) && (env->cr[4] & CR4_VMXE_MASK));
> +}
> +
> +static bool is_svm_enabled(CPUX86State *env)
> +{
> +    return (IS_AMD_CPU(env) && (env->efer & MSR_EFER_SVME));
> +}
> +
> +static bool is_nested_virt_enabled(CPUX86State *env)
> +{
> +    return (is_vmx_enabled(env) || is_svm_enabled(env));
> +}

I have later realised that this nested_virt_enabled() function is not =
enough to determine if nested_state is required to be sent.
This is because it may be that vCPU is running L2 but have momentarily =
entered SMM due to SMI.
In this case, CR4 & MSR_EFER are saved in SMRAM and are set to 0 on =
entering to SMM.
This means that in case (env->hflags & HF_SMM_MASK), we theoretically =
should have read saved CR4 & MSR_EFER from SMRAM.
However, because we cannot reference guest memory at this point (Not =
valid in case we migrate guest in post-copy), I should change
code to assume that in case (env->hflags & HF_SMM_MASK), we need to =
assume that nested-state is needed.
This should break backwards-compatability migration only in very rare =
cases and therefore I think it should be sufficient.
Any objections to this idea?

> +
> static int cpu_pre_save(void *opaque)
> {

In my next patch-series I have added logic to cpu_pre_save that converts
a pending exception to an injected exception in case there is an =
exception pending
and nested-virtualization is not enabled. During this conversion, I also =
make sure
to apply the exception payload to the respective vCPU register (i.e. CR2 =
in case of #PF
or DR6 in case of #DB).
I have realised this is required because otherwise exception-info =
VMState subsection
will be deemed not needed and exception-payload will be lost.
Something like this:

+    /*
+     * When vCPU is running L2 and exception is still pending,
+     * it can potentially be intercepted by L1 hypervisor.
+     * In contrast to an injected exception which cannot be
+     * intercepted anymore.
+     *
+     * Furthermore, when a L2 exception is intercepted by L1
+     * hypervisor, it's exception payload (CR2/DR6 on #PF/#DB)
+     * should not be set yet in the respective vCPU register.
+     * Thus, in case an exception is pending, it is
+     * important to save the exception payload seperately.
+     *
+     * Therefore, if an exception is not in a pending state
+     * or guest is not running a nested hypervisor, it is
+     * not important to distinguish between a pending and
+     * injected exception and we don't need to store seperately
+     * the exception payload.
+     *
+     * In order to preserve better backwards-compatabile migration,
+     * convert a pending exception to an injected exception in
+     * case it is not important to distingiush between them
+     * as described above.
+     */
+    if (!is_nested_virt_enabled(env) && env->exception_pending) {
+        env->exception_pending =3D 0;
+        env->exception_injected =3D 1;
+
+        if (env->exception_nr =3D=3D EXCP01_DB) {
+            assert(env->exception_has_payload);
+            env->dr[6] =3D env->exception_payload;
+        } else if (env->exception_nr =3D=3D EXCP0E_PAGE) {
+            assert(env->exception_has_payload);
+            env->cr[2] =3D env->exception_payload;
+        } else {
+            assert(!env->exception_has_payload);
+        }
+    }
+

>     X86CPU *cpu =3D opaque;
> @@ -278,6 +293,23 @@ static int cpu_post_load(void *opaque, int =
version_id)
>     env->hflags &=3D ~HF_CPL_MASK;
>     env->hflags |=3D (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & =
HF_CPL_MASK;
>=20
> +    /*
> +     * There are cases that we can get valid exception_nr with both
> +     * exception_pending and exception_clear being cleared. This can =
happen in
> +     * one of the following scenarios:
> +     * 1) Source is older QEMU without KVM_CAP_EXCEPTION_PAYLOAD =
support.
> +     * 2) Source is running on kernel without =
KVM_CAP_EXCEPTION_PAYLOAD support.
> +     * 3) "cpu/exception_info" subsection not sent because there is =
no exception
> +     *	  pending or guest wasn't running L2.
> +     *
> +     * In those cases, we can just deduce that a valid exception_nr =
means
> +     * we can treat the exception as already injected.
> +     */
> +    if ((env->exception_nr !=3D -1) &&
> +        !env->exception_pending && !env->exception_injected) {
> +        env->exception_injected =3D 1;
> +    }
> +
>     env->fpstt =3D (env->fpus_vmstate >> 11) & 7;
>     env->fpus =3D env->fpus_vmstate & ~0x3800;
>     env->fptag_vmstate ^=3D 0xff;
> @@ -323,6 +355,32 @@ static bool steal_time_msr_needed(void *opaque)
>     return cpu->env.steal_time_msr !=3D 0;
> }
>=20
> +static bool exception_info_needed(void *opaque)
> +{
> +    X86CPU *cpu =3D opaque;
> +
> +    /*
> +     * Differenting between pending and injected exceptions
> +     * is only important when running L2.
> +     */
> +    return (cpu->env.exception_pending &&
> +            is_nested_virt_enabled(&cpu->env));
> +}
> +
> +static const VMStateDescription vmstate_exception_info =3D {
> +    .name =3D "cpu/exception_info",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D exception_info_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(env.exception_pending, X86CPU),
> +        VMSTATE_UINT8(env.exception_injected, X86CPU),
> +        VMSTATE_UINT8(env.exception_has_payload, X86CPU),
> +        VMSTATE_UINT64(env.exception_payload, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> static const VMStateDescription vmstate_steal_time_msr =3D {
>     .name =3D "cpu/steal_time_msr",
>     .version_id =3D 1,
> @@ -1035,7 +1093,7 @@ VMStateDescription vmstate_x86_cpu =3D {
>         VMSTATE_INT32(env.interrupt_injected, X86CPU),
>         VMSTATE_UINT32(env.mp_state, X86CPU),
>         VMSTATE_UINT64(env.tsc, X86CPU),
> -        VMSTATE_INT32(env.exception_injected, X86CPU),
> +        VMSTATE_INT32(env.exception_nr, X86CPU),
>         VMSTATE_UINT8(env.soft_interrupt, X86CPU),
>         VMSTATE_UINT8(env.nmi_injected, X86CPU),
>         VMSTATE_UINT8(env.nmi_pending, X86CPU),
> @@ -1059,6 +1117,7 @@ VMStateDescription vmstate_x86_cpu =3D {
>         /* The above list is not sorted /wrt version numbers, watch =
out! */
>     },
>     .subsections =3D (const VMStateDescription*[]) {
> +        &vmstate_exception_info,
>         &vmstate_async_pf_msr,
>         &vmstate_pv_eoi_msr,
>         &vmstate_steal_time_msr,
> --=20
> 2.21.0
>=20
>=20


