Received: from eggs.gnu.org ([2001:4830:134:3::10]:36752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehBfN-0000FV-Is
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ehBfG-0006BA-38
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:00:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ehBfF-00068i-I6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:00:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w119xx4B123629
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 05:00:15 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fuxahejfh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 05:00:15 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 10:00:12 -0000
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 11:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180131181742.2037-2-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <7cefb712-9af5-7a01-3a94-0bd02a2563d1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@redhat.com, agraf@suse.de, rth@twiddle.net

On 31/01/2018 19:17, Cornelia Huck wrote:
> On s390x, pci support is implemented via a set of instructions
> (no mmio). Unfortunately, none of them are documented in the
> PoP; the code is based upon the existing implementation for KVM
> and the Linux zpci driver.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/s390x/helper.h      |   9 ++++
>   target/s390x/insn-data.def |  15 +++++++
>   target/s390x/misc_helper.c | 109 ++++++++++++++++++++++++++++++++++++=
+++++++++
>   target/s390x/translate.c   | 101 ++++++++++++++++++++++++++++++++++++=
+++++
>   4 files changed, 234 insertions(+)
>
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 59a1d9869b..9887efbb3a 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -172,4 +172,13 @@ DEF_HELPER_2(stcrw, void, env, i64)
>   DEF_HELPER_3(stsch, void, env, i64, i64)
>   DEF_HELPER_3(tsch, void, env, i64, i64)
>   DEF_HELPER_2(chsc, void, env, i64)
> +
> +DEF_HELPER_2(clp, void, env, i32)
> +DEF_HELPER_3(pcilg, void, env, i32, i32)
> +DEF_HELPER_3(pcistg, void, env, i32, i32)
> +DEF_HELPER_4(stpcifc, void, env, i32, i64, i32)
> +DEF_HELPER_3(sic, void, env, i64, i64)
> +DEF_HELPER_3(rpcit, void, env, i32, i32)
> +DEF_HELPER_5(pcistb, void, env, i32, i32, i64, i32)
> +DEF_HELPER_4(mpcifc, void, env, i32, i64, i32)
>   #endif
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 11ee43dcbc..b9841631a8 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1067,4 +1067,19 @@
>       /* ??? Not listed in PoO ninth edition, but there's a linux drive=
r that
>          uses it: "A CHSC subchannel is usually present on LPAR only." =
 */
>       C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
> +
> +/* zPCI Instructions */
> +    /* None of these instructions are documented in the PoP, so this i=
s all
> +       based upon target/s390x/kvm.c and Linux code and likely incompl=
ete */
> +    C(0xebd0, PCISTB, RSY_a, PCI, la2, 0, 0, 0, pcistb, 0)
> +    /* SIC does not really depend on pci, but it is unclear from the c=
ode
> +       with which facility it becomes available */
> +    C(0xebd1, SIC, RSY_a, Z, r1, r3, 0, 0, sic, 0)
> +    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
> +    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
> +    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
> +    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
> +    C(0xe3d0, MPCIFC, RXY_a, PCI, la2, 0, 0, 0, mpcifc, 0)
> +    C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)
> +
>   #endif /* CONFIG_USER_ONLY */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 86da6aab7e..6f5103f3b5 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -36,6 +36,7 @@
>   #include "hw/s390x/ebcdic.h"
>   #include "hw/s390x/s390-virtio-hcall.h"
>   #include "hw/s390x/sclp.h"
> +#include "hw/s390x/s390-pci-inst.h"
>   #endif
>
>   /* #define DEBUG_HELPER */
> @@ -560,3 +561,111 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64=
_t addr)
>       env->regs[0] =3D deposit64(env->regs[0], 0, 8, (max_bytes / 8) - =
1);
>       return count_bytes >=3D max_bytes ? 0 : 3;
>   }
> +
> +#ifndef CONFIG_USER_ONLY
> +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D clp_service_call(cpu, r2, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D pcilg_service_call(cpu, r1, r2, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D pcistg_service_call(cpu, r1, r2, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
> +                     uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D stpcifc_service_call(cpu, r1, fiba, ar, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
> +{
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D css_do_sic(env, r1 & 0xffff, (r3 >> 27) & 0x7);
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D rpcit_service_call(cpu, r1, r2, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
> +                    uint64_t gaddr, uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D pcistb_service_call(cpu, r1, r3, gaddr, ar, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(mpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
> +                    uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D mpcifc_service_call(cpu, r1, fiba, ar, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +#endif
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index df0b41606d..2a3314601a 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4777,6 +4777,106 @@ static ExitStatus op_zero2(DisasContext *s, Dis=
asOps *o)
>       return NO_EXIT;
>   }
>
> +#ifndef CONFIG_USER_ONLY
> +static ExitStatus op_clp(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
> +
> +    check_privileged(s);
> +    gen_helper_clp(cpu_env, r2);
> +    tcg_temp_free_i32(r2);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_pcilg(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
> +
> +    check_privileged(s);
> +    gen_helper_pcilg(cpu_env, r1, r2);
> +    tcg_temp_free_i32(r1);
> +    tcg_temp_free_i32(r2);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_pcistg(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
> +
> +    check_privileged(s);
> +    gen_helper_pcistg(cpu_env, r1, r2);
> +    tcg_temp_free_i32(r1);
> +    tcg_temp_free_i32(r2);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
> +
> +    check_privileged(s);
> +    gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
> +    tcg_temp_free_i32(ar);
> +    tcg_temp_free_i32(r1);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_sic(DisasContext *s, DisasOps *o)
> +{
> +    check_privileged(s);
> +    gen_helper_sic(cpu_env, o->in1, o->in2);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_rpcit(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r2 =3D tcg_const_i32(get_field(s->fields, r2));
> +
> +    check_privileged(s);
> +    gen_helper_rpcit(cpu_env, r1, r2);
> +    tcg_temp_free_i32(r1);
> +    tcg_temp_free_i32(r2);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_pcistb(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r3 =3D tcg_const_i32(get_field(s->fields, r3));
> +    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
> +
> +    check_privileged(s);
> +    gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
> +    tcg_temp_free_i32(ar);
> +    tcg_temp_free_i32(r1);
> +    tcg_temp_free_i32(r3);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_mpcifc(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));
> +
> +    check_privileged(s);
> +    gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
> +    tcg_temp_free_i32(ar);
> +    tcg_temp_free_i32(r1);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +#endif
> +
>   /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>   /* The "Cc OUTput" generators.  Given the generated output (and in so=
me cases
>      the original inputs), update the various cc data structures in ord=
er to
> @@ -5708,6 +5808,7 @@ enum DisasInsnEnum {
>   #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facili=
ty */
>   #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facili=
ty */
>   #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
> +#define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
>
>   static const DisasInsn insn_info[] =3D {
>   #include "insn-data.def"

Hi,

I am not an expert for TCG but the patches are looking clean to me.

And since I also rapidly tested with multibus, virtio_pci_block, and all=20
went good so:

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
