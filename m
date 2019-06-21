Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4486AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E1D208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Izrus1F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E1D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIt1-0008R4-9D
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heIfn-0006ap-RD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heIfk-0001Po-OA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:29:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heIfk-0001Jw-G4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:29:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LCIurv126074;
 Fri, 21 Jun 2019 12:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=7Om/XcX5uiN9afAx+/JBRISqmdT9rJKM4+L3jH9Fz2I=;
 b=Izrus1F08i2eljCxHgOm8iG2FtylOAn7j/jrBBRqdmG2eaZL7OU4RnotkG6uJ9fZZtY5
 7LnwXOKfFKlJH6jQqUc4lZJ1Srl41yvyOZAFay8ZmY0bT1+7Ap2LZZgaJwX0RrNWueth
 7UW56OozucApznwcfS0/1SD/UyrOBNDcJa5flPC/N4Ok0KYouUEBV2TyrHs9+DWYBrgD
 wwF+WAlmR7N/UGgSOPyPoQ3h90kMUMiitUt/A24iiUvV1k11s/+Uk7/FVSgaUBxC4NwJ
 ltElDpRYtEa25gq8kNfUPx4fPHoqsMmIXX0IjnpqBK7P2MQ2ptLbJdpJ164MwBaWfAen PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t7809p90p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 12:29:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LCRh5T095226;
 Fri, 21 Jun 2019 12:29:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t77yp66dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 12:29:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LCTZj8022405;
 Fri, 21 Jun 2019 12:29:35 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 05:29:35 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
Date: Fri, 21 Jun 2019 15:29:32 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210105
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for
 save and restore nested state
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 21 Jun 2019, at 14:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> From: Liran Alon <liran.alon@oracle.com>
>=20
> Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce =
KVM_CAP_NESTED_STATE")
> introduced new IOCTLs to extract and restore vCPU state related to
> Intel VMX & AMD SVM.
>=20
> Utilize these IOCTLs to add support for migration of VMs which are
> running nested hypervisors.
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
> Tested-by: Maran Wilson <maran.wilson@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Message-Id: <20190619162140.133674-9-liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> accel/kvm/kvm-all.c   |   8 ++
> include/sysemu/kvm.h  |   1 +
> target/i386/cpu.h     |   3 +
> target/i386/kvm.c     |  80 ++++++++++++++++++++
> target/i386/machine.c | 198 =
++++++++++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 290 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f0f5ab8..e3cf728 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -87,6 +87,7 @@ struct KVMState
> #ifdef KVM_CAP_SET_GUEST_DEBUG
>     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
> #endif
> +    int max_nested_state_len;
>     int many_ioeventfds;
>     int intx_set_mask;
>     bool sync_mmu;
> @@ -1681,6 +1682,8 @@ static int kvm_init(MachineState *ms)
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
> @@ -2248,6 +2251,11 @@ int kvm_has_debugregs(void)
>     return kvm_state->debugregs;
> }
>=20
> +int kvm_max_nested_state_length(void)
> +{
> +    return kvm_state->max_nested_state_len;
> +}
> +
> int kvm_has_many_ioeventfds(void)
> {
>     if (!kvm_enabled()) {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 64f55e5..acd90ae 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -210,6 +210,7 @@ bool kvm_has_sync_mmu(void);
> int kvm_has_vcpu_events(void);
> int kvm_has_robust_singlestep(void);
> int kvm_has_debugregs(void);
> +int kvm_max_nested_state_length(void);
> int kvm_has_pit_state2(void);
> int kvm_has_many_ioeventfds(void);
> int kvm_has_gsi_routing(void);
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bf0c9c2..17116ef 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1360,6 +1360,9 @@ typedef struct CPUX86State {
> #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>     void *xsave_buf;
> #endif
> +#if defined(CONFIG_KVM)
> +    struct kvm_nested_state *nested_state;
> +#endif
> #if defined(CONFIG_HVF)
>     HVFX86EmulatorState *hvf_emul;
> #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f9872f1..e924663 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1324,6 +1324,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>     struct kvm_cpuid_entry2 *c;
>     uint32_t signature[3];
>     int kvm_base =3D KVM_CPUID_SIGNATURE;
> +    int max_nested_state_len;
>     int r;
>     Error *local_err =3D NULL;
>=20
> @@ -1658,6 +1659,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
>     if (has_xsave) {
>         env->xsave_buf =3D qemu_memalign(4096, sizeof(struct =
kvm_xsave));
>     }
> +
> +    max_nested_state_len =3D kvm_max_nested_state_length();
> +    if (max_nested_state_len > 0) {
> +        assert(max_nested_state_len >=3D offsetof(struct =
kvm_nested_state, data));
> +        env->nested_state =3D g_malloc0(max_nested_state_len);
> +
> +        env->nested_state->size =3D max_nested_state_len;
> +
> +        if (IS_INTEL_CPU(env)) {

I think it=E2=80=99s better to change this to: =E2=80=9Cif =
(cpu_has_vmx(env))=E2=80=9D {

> +            struct kvm_vmx_nested_state_hdr *vmx_hdr =3D
> +                &env->nested_state->hdr.vmx;
> +
> +            env->nested_state->format =3D =
KVM_STATE_NESTED_FORMAT_VMX;
> +            vmx_hdr->vmxon_pa =3D -1ull;
> +            vmx_hdr->vmcs12_pa =3D -1ull;
> +        }
> +    }

I think we should add here:
} else if (cpu_has_svm(env)) {
    env->nested_state->format =3D KVM_STATE_NESTED_FORMAT_SVM;
}

> +
>     cpu->kvm_msr_buf =3D g_malloc0(MSR_BUF_SIZE);
>=20
>     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
> @@ -1682,12 +1701,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
> int kvm_arch_destroy_vcpu(CPUState *cs)
> {
>     X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
>=20
>     if (cpu->kvm_msr_buf) {
>         g_free(cpu->kvm_msr_buf);
>         cpu->kvm_msr_buf =3D NULL;
>     }
>=20
> +    if (env->nested_state) {
> +        g_free(env->nested_state);
> +        env->nested_state =3D NULL;
> +    }
> +
>     return 0;
> }
>=20
> @@ -3411,6 +3436,52 @@ static int kvm_get_debugregs(X86CPU *cpu)
>     return 0;
> }
>=20
> +static int kvm_put_nested_state(X86CPU *cpu)
> +{
> +    CPUX86State *env =3D &cpu->env;
> +    int max_nested_state_len =3D kvm_max_nested_state_length();
> +
> +    if (max_nested_state_len <=3D 0) {
> +        return 0;
> +    }
> +
> +    assert(env->nested_state->size <=3D max_nested_state_len);
> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, =
env->nested_state);
> +}
> +
> +static int kvm_get_nested_state(X86CPU *cpu)
> +{
> +    CPUX86State *env =3D &cpu->env;
> +    int max_nested_state_len =3D kvm_max_nested_state_length();
> +    int ret;
> +
> +    if (max_nested_state_len <=3D 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * It is possible that migration restored a smaller size into
> +     * nested_state->hdr.size than what our kernel support.
> +     * We preserve migration origin nested_state->hdr.size for
> +     * call to KVM_SET_NESTED_STATE but wish that our next call
> +     * to KVM_GET_NESTED_STATE will use max size our kernel support.
> +     */
> +    env->nested_state->size =3D max_nested_state_len;
> +
> +    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, =
env->nested_state);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE) {
> +        env->hflags |=3D HF_GUEST_MASK;
> +    } else {
> +        env->hflags &=3D ~HF_GUEST_MASK;
> +    }
> +
> +    return ret;
> +}
> +
> int kvm_arch_put_registers(CPUState *cpu, int level)
> {
>     X86CPU *x86_cpu =3D X86_CPU(cpu);
> @@ -3418,6 +3489,11 @@ int kvm_arch_put_registers(CPUState *cpu, int =
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
> @@ -3533,6 +3609,10 @@ int kvm_arch_get_registers(CPUState *cs)
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
> index a39ce7f..a6afdf8 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -231,6 +231,15 @@ static int cpu_pre_save(void *opaque)
>         env->segs[R_SS].flags &=3D ~(env->segs[R_SS].flags & =
DESC_DPL_MASK);
>     }
>=20
> +#ifdef CONFIG_KVM
> +    /* Verify we have nested virtualization state from kernel if =
required */
> +    if (cpu_has_nested_virt(env) && !env->nested_state) {
> +        error_report("Guest enabled nested virtualization but kernel =
"
> +                "does not support saving of nested state");
> +        return -EINVAL;
> +    }
> +#endif

Paolo, just note that this will effectively block migration for AMD vCPU =
exposed with SVM.
I think it=E2=80=99s the right thing to do but you were afraid of =
backwards compatibility regarding this no?

-Liran

> +
>     return 0;
> }
>=20
> @@ -278,6 +287,16 @@ static int cpu_post_load(void *opaque, int =
version_id)
>     env->hflags &=3D ~HF_CPL_MASK;
>     env->hflags |=3D (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & =
HF_CPL_MASK;
>=20
> +#ifdef CONFIG_KVM
> +    if ((env->hflags & HF_GUEST_MASK) &&
> +        (!env->nested_state ||
> +        !(env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE))) {
> +        error_report("vCPU set in guest-mode inconsistent with "
> +                     "migrated kernel nested state");
> +        return -EINVAL;
> +    }
> +#endif
> +
>     env->fpstt =3D (env->fpus_vmstate >> 11) & 7;
>     env->fpus =3D env->fpus_vmstate & ~0x3800;
>     env->fptag_vmstate ^=3D 0xff;
> @@ -851,6 +870,182 @@ static const VMStateDescription vmstate_tsc_khz =
=3D {
>     }
> };
>=20
> +#ifdef CONFIG_KVM
> +
> +static bool vmx_vmcs12_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +    return (nested_state->size >
> +            offsetof(struct kvm_nested_state, data.vmx[0].vmcs12));
> +}
> +
> +static const VMStateDescription vmstate_vmx_vmcs12 =3D {
> +    .name =3D "cpu/kvm_nested_state/vmx/vmcs12",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D vmx_vmcs12_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(data.vmx[0].vmcs12,
> +                            struct kvm_nested_state,
> +                            KVM_STATE_NESTED_VMX_VMCS_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool vmx_shadow_vmcs12_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +    return (nested_state->size >
> +            offsetof(struct kvm_nested_state, =
data.vmx[0].shadow_vmcs12));
> +}
> +
> +static const VMStateDescription vmstate_vmx_shadow_vmcs12 =3D {
> +    .name =3D "cpu/kvm_nested_state/vmx/shadow_vmcs12",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D vmx_shadow_vmcs12_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(data.vmx[0].shadow_vmcs12,
> +                            struct kvm_nested_state,
> +                            KVM_STATE_NESTED_VMX_VMCS_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool vmx_nested_state_needed(void *opaque)
> +{
> +    struct kvm_nested_state *nested_state =3D opaque;
> +
> +    return ((nested_state->format =3D=3D KVM_STATE_NESTED_FORMAT_VMX) =
&&
> +            ((nested_state->hdr.vmx.vmxon_pa !=3D -1ull) ||
> +             (nested_state->hdr.vmx.smm.flags & =
KVM_STATE_NESTED_SMM_VMXON)));
> +}
> +
> +static const VMStateDescription vmstate_vmx_nested_state =3D {
> +    .name =3D "cpu/kvm_nested_state/vmx",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D vmx_nested_state_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_U64(hdr.vmx.vmxon_pa, struct kvm_nested_state),
> +        VMSTATE_U64(hdr.vmx.vmcs12_pa, struct kvm_nested_state),
> +        VMSTATE_U16(hdr.vmx.smm.flags, struct kvm_nested_state),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription*[]) {
> +        &vmstate_vmx_vmcs12,
> +        &vmstate_vmx_shadow_vmcs12,
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
> +    .name =3D "cpu/kvm_nested_state/svm",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D svm_nested_state_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool nested_state_needed(void *opaque)
> +{
> +    X86CPU *cpu =3D opaque;
> +    CPUX86State *env =3D &cpu->env;
> +
> +    return (env->nested_state &&
> +            (vmx_nested_state_needed(env->nested_state) ||
> +             svm_nested_state_needed(env->nested_state)));
> +}
> +
> +static int nested_state_post_load(void *opaque, int version_id)
> +{
> +    X86CPU *cpu =3D opaque;
> +    CPUX86State *env =3D &cpu->env;
> +    struct kvm_nested_state *nested_state =3D env->nested_state;
> +    int min_nested_state_len =3D offsetof(struct kvm_nested_state, =
data);
> +    int max_nested_state_len =3D kvm_max_nested_state_length();
> +
> +    /*
> +     * If our kernel don't support setting nested state
> +     * and we have received nested state from migration stream,
> +     * we need to fail migration
> +     */
> +    if (max_nested_state_len <=3D 0) {
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
> +                vmstate_kvm_nested_state,
> +                struct kvm_nested_state),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +#endif
> +
> static bool mcg_ext_ctl_needed(void *opaque)
> {
>     X86CPU *cpu =3D opaque;
> @@ -1113,6 +1308,9 @@ VMStateDescription vmstate_x86_cpu =3D {
> #ifndef TARGET_X86_64
>         &vmstate_efer32,
> #endif
> +#ifdef CONFIG_KVM
> +        &vmstate_nested_state,
> +#endif
>         NULL
>     }
> };
> --=20
> 1.8.3.1
>=20
>=20


