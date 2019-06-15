Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053DC31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 01:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958AD21841
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 01:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xZcKA7Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958AD21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbxJm-0007G2-87
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 21:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hbxHL-0006l2-8g
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 21:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hbxHJ-0005p1-3t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 21:14:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hbxHI-0005o9-Pt
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 21:14:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F191H6114555;
 Sat, 15 Jun 2019 01:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Qah1O8khp+spXB63HwCmXcWE7pcovxdzZF58wkcMziw=;
 b=xZcKA7BvKHqvqW7XuLsY+idY/SqrSbalpcshfEGwhpevB3QnrPnqn90/ZiwnpPWTXRpT
 ZbsdidUamGokNjhTdpQi8G+Y7JynKryDiiRf1BDkXZlChhvtkjV4DFgxLrYvYo8cQSj4
 /ESMDbut+STOy5yW/HICJs/qLxBf2Qi/yaUKpmubuhlrPVhL/DWVZ2oeoxixvpIYIHaG
 gBXsxDYc06dEx+fSZnwmd3IrS5Ch6G16sag0L9Jfp//mMmqvgI8VlT0XExAkc2CBMtD9
 5MxAqFwDDscymIVnADTH0wsokfDYHVqBdC4bil3rfA9OcmiI7CRwn/w7b1krOYiO9CMl fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t04yp1rat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 01:14:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5F1D9GH012466;
 Sat, 15 Jun 2019 01:14:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t1jpkd5tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jun 2019 01:14:41 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5F1Efvr018786;
 Sat, 15 Jun 2019 01:14:41 GMT
Received: from [10.0.0.13] (/109.66.72.187)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 14 Jun 2019 18:14:40 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190615004256.16367-7-pbonzini@redhat.com>
Date: Sat, 15 Jun 2019 04:14:36 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <78981CC5-F222-4E52-95B8-ED8BBE68CC35@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-7-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906150006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9288
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906150006
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [PATCH 6/7] KVM: i386: Add support for save and
 restore nested state
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
> Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce =
KVM_CAP_NESTED_STATE")
> introduced new IOCTLs to extract and restore KVM internal state used =
to
> run a VM that is in VMX operation.
>=20
> Utilize these IOCTLs to add support of migration of VMs which are
> running nested hypervisors.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> [Simplified subsection needed functions and computation of
> kvm_min_nested_state_len(); adjusted for upstream kernel field
> names; fixed !CONFIG_KVM compilation. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> accel/kvm/kvm-all.c   |   8 ++
> include/sysemu/kvm.h  |   1 +
> target/i386/cpu.h     |   3 +
> target/i386/kvm.c     |  52 ++++++++++++
> target/i386/machine.c | 182 ++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 246 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e4ac3386cb..e1c6c067e8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -88,6 +88,7 @@ struct KVMState
> #ifdef KVM_CAP_SET_GUEST_DEBUG
>     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
> #endif
> +    uint32_t max_nested_state_len;

Note: In my next patch-series I have changed this to be =E2=80=9Cint=E2=80=
=9D.

>     int many_ioeventfds;
>     int intx_set_mask;
>     bool sync_mmu;
> @@ -1677,6 +1678,8 @@ static int kvm_init(MachineState *ms)
>     s->debugregs =3D kvm_check_extension(s, KVM_CAP_DEBUGREGS);
> #endif
>=20
> +    s->max_nested_state_len =3D kvm_check_extension(s, =
KVM_CAP_NESTED_STATE);
> +
> #ifdef KVM_CAP_IRQ_ROUTING
>     kvm_direct_msi_allowed =3D (kvm_check_extension(s, =
KVM_CAP_SIGNAL_MSI) > 0);
> #endif
> @@ -2244,6 +2247,11 @@ int kvm_has_debugregs(void)
>     return kvm_state->debugregs;
> }
>=20
> +uint32_t kvm_max_nested_state_length(void)
> +{
> +    return kvm_state->max_nested_state_len;
> +}
> +
> int kvm_has_many_ioeventfds(void)
> {
>     if (!kvm_enabled()) {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index a6d1cd190f..5eb79b594c 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -210,6 +210,7 @@ bool kvm_has_sync_mmu(void);
> int kvm_has_vcpu_events(void);
> int kvm_has_robust_singlestep(void);
> int kvm_has_debugregs(void);
> +uint32_t kvm_max_nested_state_length(void);
> int kvm_has_pit_state2(void);
> int kvm_has_many_ioeventfds(void);
> int kvm_has_gsi_routing(void);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bbeb7a9521..550d397807 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1355,6 +1355,9 @@ typedef struct CPUX86State {
> #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>     void *xsave_buf;
> #endif
> +#if defined(CONFIG_KVM)
> +    struct kvm_nested_state *nested_state;
> +#endif

Nice catch regarding CONFIG_KVM. Thanks for that. :)

> #if defined(CONFIG_HVF)
>     HVFX86EmulatorState *hvf_emul;
> #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index dca76830ec..d48fafa22b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -968,6 +968,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>     struct kvm_cpuid_entry2 *c;
>     uint32_t signature[3];
>     int kvm_base =3D KVM_CPUID_SIGNATURE;
> +    uint32_t nested_state_len;
>     int r;
>     Error *local_err =3D NULL;
>=20
> @@ -1368,6 +1369,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>     if (has_xsave) {
>         env->xsave_buf =3D qemu_memalign(4096, sizeof(struct =
kvm_xsave));
>     }
> +
> +    nested_state_len =3D kvm_max_nested_state_length();
> +    if (nested_state_len > 0) {
> +        assert(nested_state_len >=3D offsetof(struct =
kvm_nested_state, data));
> +        env->nested_state =3D g_malloc0(nested_state_len);

Paolo, why have you removed setting =E2=80=9Cenv->nested_state->size =3D =
max_nested_state_len;=E2=80=9D?

In addition, in my next patch-series I also added the following code =
here which is required:

+        if (IS_INTEL_CPU(env)) {
+            struct kvm_vmx_nested_state_hdr *vmx_hdr =3D
+                &env->nested_state->hdr.vmx_hdr;
+
+            vmx_hdr->vmxon_pa =3D -1ull;
+            vmx_hdr->vmcs12_pa =3D -1ull;
+        }

> +    }
> +
>     cpu->kvm_msr_buf =3D g_malloc0(MSR_BUF_SIZE);

Note: In my next patch-series I have also added a new =
kvm_arch_destroy_vcpu() method which is called from kvm_destroy_vcpu().
Similar to how kvm_arch_init_vcpu() is called from kvm_init_vcpu().
I use it to free both cpu->kvm_msr_buf and env->nested_state.

>=20
>     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
> @@ -3125,6 +3133,41 @@ static int kvm_get_debugregs(X86CPU *cpu)
>     return 0;
> }
>=20
> +static int kvm_put_nested_state(X86CPU *cpu)
> +{
> +    CPUX86State *env =3D &cpu->env;
> +    uint32_t nested_state_len =3D kvm_max_nested_state_length();
> +
> +    if (nested_state_len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    assert(env->nested_state->size <=3D nested_state_len);
> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, =
env->nested_state);
> +}
> +
> +static int kvm_get_nested_state(X86CPU *cpu)
> +{
> +    CPUX86State *env =3D &cpu->env;
> +    uint32_t nested_state_len =3D kvm_max_nested_state_length();
> +
> +    if (nested_state_len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * It is possible that migration restored a smaller size into
> +     * nested_state->size than what our kernel supports.
> +     * We preserve migration origin nested_state->size for
> +     * the call to KVM_SET_NESTED_STATE but wish that our next call
> +     * to KVM_GET_NESTED_STATE will use the maximum size supported by
> +     * the kernel we're running on.
> +     */
> +    env->nested_state->size =3D nested_state_len;
> +
> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, =
env->nested_state);
> +}
> +
> int kvm_arch_put_registers(CPUState *cpu, int level)
> {
>     X86CPU *x86_cpu =3D X86_CPU(cpu);
> @@ -3132,6 +3175,11 @@ int kvm_arch_put_registers(CPUState *cpu, int =
level)
>=20
>     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>=20
> +    ret =3D kvm_put_nested_state(x86_cpu);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>     if (level >=3D KVM_PUT_RESET_STATE) {
>         ret =3D kvm_put_msr_feature_control(x86_cpu);
>         if (ret < 0) {
> @@ -3247,6 +3295,10 @@ int kvm_arch_get_registers(CPUState *cs)
>     if (ret < 0) {
>         goto out;
>     }
> +    ret =3D kvm_get_nested_state(cpu);
> +    if (ret < 0) {
> +        goto out;
> +    }
>     ret =3D 0;
>  out:
>     cpu_sync_bndcs_hflags(&cpu->env);
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 41460be54b..45dbae6054 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -246,6 +246,15 @@ static int cpu_pre_save(void *opaque)
>         env->segs[R_SS].flags &=3D ~(env->segs[R_SS].flags & =
DESC_DPL_MASK);
>     }
>=20
> +#ifdef CONFIG_KVM
> +    /* Verify we have nested virtualization state from kernel if =
required */
> +    if (is_nested_virt_enabled(env) && !env->nested_state) {
> +        error_report("Guest enabled nested virtualization but kernel =
"
> +                     "do not support saving nested state");
> +        return -EINVAL;
> +    }
> +#endif
> +
>     return 0;
> }
>=20
> @@ -909,6 +918,176 @@ static const VMStateDescription vmstate_tsc_khz =
=3D {
>     }
> };
>=20
> +#ifdef CONFIG_KVM
> +static bool vmx_vmcs12_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +    return (nested_state->size > offsetof(struct kvm_nested_state,
> +                                          vmx.data[0].vmcs12));

Do you prefer this compared to checking explicitly? i.e. by:
return (nested_state->vmx.vmcs12_pa !=3D -1ull);

> +}
> +
> +static const VMStateDescription vmstate_vmx_vmcs12_state =3D {
> +	.name =3D "cpu/kvm_nested_state/vmx/vmcs12",
> +	.version_id =3D 1,
> +	.minimum_version_id =3D 1,
> +	.needed =3D vmx_vmcs12_needed,
> +	.fields =3D (VMStateField[]) {
> +	    VMSTATE_UINT8_ARRAY(vmx.data[0].vmcs12,
> +	                        struct kvm_nested_state, 0x1000),
> +	    VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool vmx_shadow_vmcs12_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +    return (nested_state->size > offsetof(struct kvm_nested_state,
> +                                          =
vmx.data[0].shadow_vmcs12));

Nice trick on how to determine if to send shadow_vmcs12 without =
requiring to check
if vmcs12 indeed have VMCS-shadowing enabled and a valid vmcs-link-ptr. =
:)

> +}
> +
> +static const VMStateDescription vmstate_vmx_shadow_vmcs12_state =3D {
> +	.name =3D "cpu/kvm_nested_state/vmx/shadow_vmcs12",
> +	.version_id =3D 1,
> +	.minimum_version_id =3D 1,
> +	.needed =3D vmx_shadow_vmcs12_needed,
> +	.fields =3D (VMStateField[]) {
> +	    VMSTATE_UINT8_ARRAY(vmx.data[0].shadow_vmcs12,
> +	                        struct kvm_nested_state, 0x1000),
> +	    VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool vmx_nested_state_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +
> +    return ((nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_VMX) =
&&
> +            (nested_state->vmx.vmxon_pa !=3D -1ull));
> +}
> +
> +static const VMStateDescription vmstate_vmx_nested_state =3D {
> +	.name =3D "cpu/kvm_nested_state/vmx",
> +	.version_id =3D 1,
> +	.minimum_version_id =3D 1,
> +	.needed =3D vmx_nested_state_needed,
> +	.fields =3D (VMStateField[]) {
> +	    VMSTATE_U64(vmx.vmxon_pa, struct kvm_nested_state),
> +	    VMSTATE_U64(vmx.vmcs_pa, struct kvm_nested_state),
> +	    VMSTATE_U16(vmx.smm.flags, struct kvm_nested_state),
> +	    VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription*[]) {
> +        &vmstate_vmx_vmcs12_state,
> +        &vmstate_vmx_shadow_vmcs12_state,
> +        NULL,
> +    }
> +};
> +
> +static bool svm_nested_state_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +
> +    return (nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_SVM);
> +}
> +
> +static const VMStateDescription vmstate_svm_nested_state =3D {
> +	.name =3D "cpu/kvm_nested_state/svm",
> +	.version_id =3D 1,
> +	.minimum_version_id =3D 1,
> +	.needed =3D svm_nested_state_needed,
> +	.fields =3D (VMStateField[]) {
> +	    VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool nested_state_needed(void *opaque)
> +{
> +    X86CPU *cpu =3D opaque;
> +    CPUX86State *env =3D &cpu->env;
> +
> +    return (is_vmx_enabled(env) && =
vmx_nested_state_needed(env->nested_state)) ||
> +           (is_svm_enabled(env) && =
svm_nested_state_needed(env->nested_state));
> +}

As I specified in an earlier email in this patch-series, this is not =
entirely accurate.
In case vCPU is running L2 and entered SMM, then is_vmx_enabled() will =
return false because CR4 is set to 0 on entering SMM.
I consider deeming nested_state needed in case hflags specifies guest is =
in SMM mode. Any objection?

> +
> +static int nested_state_post_load(void *opaque, int version_id)
> +{
> +    X86CPU *cpu =3D opaque;
> +    CPUX86State *env =3D &cpu->env;
> +    struct kvm_nested_state *nested_state =3D env->nested_state;
> +    uint32_t min_nested_state_len =3D offsetof(struct =
kvm_nested_state, data);
> +    uint32_t max_nested_state_len =3D kvm_max_nested_state_length();
> +
> +    /*
> +     * If our kernel don't support setting nested state
> +     * and we have received nested state from migration stream,
> +     * we need to fail migration
> +     */
> +    if (max_nested_state_len =3D=3D 0) {
> +        error_report("Received nested state when kernel cannot =
restore it");
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * Verify that the size of received nested_state struct
> +     * at least cover required header and is not larger
> +     * than the max size that our kernel support
> +     */
> +    if (nested_state->size < min_nested_state_len) {
> +        error_report("Received nested state size less than min: "
> +                     "len=3D%d, min=3D%d",
> +                     nested_state->size, min_nested_state_len);
> +        return -EINVAL;
> +    }
> +    if (nested_state->size > max_nested_state_len) {
> +        error_report("Recieved unsupported nested state size: "
> +                     "nested_state->size=3D%d, max=3D%d",
> +                     nested_state->size, max_nested_state_len);
> +        return -EINVAL;
> +    }
> +
> +    /* Verify format is valid */
> +    if ((nested_state->format !=3D KVM_STATE_NESTED_FORMAT_VMX) &&
> +        (nested_state->format !=3D KVM_STATE_NESTED_FORMAT_SVM)) {
> +        error_report("Received invalid nested state format: %d",
> +                     nested_state->format);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_nested_state =3D {
> +    .name =3D "cpu/kvm_nested_state",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_U16(flags, struct kvm_nested_state),
> +        VMSTATE_U16(format, struct kvm_nested_state),
> +        VMSTATE_U32(size, struct kvm_nested_state),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription*[]) {
> +        &vmstate_vmx_nested_state,
> +        &vmstate_svm_nested_state,
> +        NULL
> +    }
> +};
> +
> +static const VMStateDescription vmstate_nested_state =3D {
> +    .name =3D "cpu/nested_state",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D nested_state_needed,
> +    .post_load =3D nested_state_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(env.nested_state, X86CPU,
> +                               vmstate_kvm_nested_state,
> +                               struct kvm_nested_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +#endif
> +
> static bool mcg_ext_ctl_needed(void *opaque)
> {
>     X86CPU *cpu =3D opaque;
> @@ -1148,6 +1327,9 @@ VMStateDescription vmstate_x86_cpu =3D {
>         &vmstate_msr_intel_pt,
>         &vmstate_msr_virt_ssbd,
>         &vmstate_svm_npt,
> +#ifdef CONFIG_KVM
> +        &vmstate_nested_state,
> +#endif
>         NULL
>     }
> };
> --=20
> 2.21.0
>=20
>=20


