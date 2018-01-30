Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1egVXA-0008Co-Qp
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1egVX5-0007sC-An
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:01:08 -0500
References: <20180129165210.21086-1-cohuck@redhat.com>
	<20180129165210.21086-2-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <69d20ca7-4134-4343-383e-80420225c65f@redhat.com>
Date: Tue, 30 Jan 2018 14:00:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180129165210.21086-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de

On 29.01.2018 17:52, Cornelia Huck wrote:
> On s390x, pci support is implemented via a set of instructions
> (no mmio). Unfortunately, none of them are documented in the
> PoP; the code is based upon the existing implementation for KVM
> and the Linux zpci driver.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/helper.h      |   9 ++++
>  target/s390x/insn-data.def |  13 +++++
>  target/s390x/misc_helper.c | 123 +++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/translate.c   | 123 +++++++++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 268 insertions(+)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 59a1d9869b..9887efbb3a 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -172,4 +172,13 @@ DEF_HELPER_2(stcrw, void, env, i64)
>  DEF_HELPER_3(stsch, void, env, i64, i64)
>  DEF_HELPER_3(tsch, void, env, i64, i64)
>  DEF_HELPER_2(chsc, void, env, i64)
> +
> +DEF_HELPER_2(clp, void, env, i32)
> +DEF_HELPER_3(pcilg, void, env, i32, i32)
> +DEF_HELPER_3(pcistg, void, env, i32, i32)
> +DEF_HELPER_4(stpcifc, void, env, i32, i64, i32)
> +DEF_HELPER_3(sic, void, env, i64, i64)
> +DEF_HELPER_3(rpcit, void, env, i32, i32)
> +DEF_HELPER_5(pcistb, void, env, i32, i32, i64, i32)
> +DEF_HELPER_4(mpcifc, void, env, i32, i64, i32)
>  #endif
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 11ee43dcbc..2ffc051072 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1067,4 +1067,17 @@
>      /* ??? Not listed in PoO ninth edition, but there's a linux driver=
 that
>         uses it: "A CHSC subchannel is usually present on LPAR only."  =
*/
>      C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
> +
> +/* zPCI Instructions */
> +    /* None of these instructions are documented in the PoP, so this i=
s all
> +       based upon target/s390x/kvm.c and Linux code and likely incompl=
ete */
> +    C(0xebd0, PCISTB, RSY_a, PCI, 0, 0, 0, 0, pcistb, 0)
> +    C(0xebd1, SIC, RSY_a, PCI, 0, 0, 0, 0, sic, 0)
> +    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
> +    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
> +    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
> +    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
> +    C(0xe3d0, MPCIFC, RXY_a, PCI, 0, 0, 0, 0, mpcifc, 0)
> +    C(0xe3d4, STPCIFC, RXY_a, PCI, 0, 0, 0, 0, stpcifc, 0)
> +
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 86da6aab7e..1271106628 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -36,6 +36,7 @@
>  #include "hw/s390x/ebcdic.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
>  #include "hw/s390x/sclp.h"
> +#include "hw/s390x/s390-pci-inst.h"
>  #endif
> =20
>  /* #define DEBUG_HELPER */
> @@ -560,3 +561,125 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64=
_t addr)
>      env->regs[0] =3D deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1=
);
>      return count_bytes >=3D max_bytes ? 0 : 3;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D clp_service_call(cpu, r2, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }

Hmmm, this handling should not be necessary for TCG. All we should need i=
s:

qemu_mutex_lock_iothread();
r =3D clp_service_call(cpu, r2, GETPC());
qemu_mutex_unlock_iothread();

We will handle

a) pci not configured in patch nr2 via the CPU model (will propose
something there).

b) we will handle !s390_has_feat(S390_FEAT_ZPCI) although available
later just as other instructions via the "PCI" flag you attached to the
instructions (Richard once posted a patch to do that).

> +}
> +
> +void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D pcilg_service_call(cpu, r1, r2, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D pcistg_service_call(cpu, r1, r2, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
> +                     uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D stpcifc_service_call(cpu, r1, fiba, ar, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
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
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D rpcit_service_call(cpu, r1, r2, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
> +                    uint64_t gaddr, uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D pcistb_service_call(cpu, r1, r3, gaddr, ar, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +
> +void HELPER(mpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
> +                    uint32_t ar)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r =3D -1;
> +
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        qemu_mutex_lock_iothread();
> +        r =3D mpcifc_service_call(cpu, r1, fiba, ar, GETPC());
> +        qemu_mutex_unlock_iothread();
> +    }
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }
> +}
> +#endif
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index df0b41606d..b73f7143db 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4777,6 +4777,128 @@ static ExitStatus op_zero2(DisasContext *s, Dis=
asOps *o)
>      return NO_EXIT;
>  }
> =20

> +
> +static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    int b2 =3D get_field(s->fields, b2);
> +    int d2 =3D get_field(s->fields, d2);
> +    TCGv_i64 addr;
> +    TCGv_i32 ar;
> +

You can simply drop b2, d2 and addr, and instead use in1_la2 for the
input value specification:


C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)

> +    check_privileged(s);
> +    addr =3D get_address(s, 0, b2, d2);
> +    ar =3D tcg_const_i32(b2);
> +    gen_helper_stpcifc(cpu_env, r1, addr, ar);

gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);

> +    tcg_temp_free_i64(addr);
> +    tcg_temp_free_i32(ar);
> +    tcg_temp_free_i32(r1);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +
> +static ExitStatus op_sic(DisasContext *s, DisasOps *o)
> +{
> +    int r1 =3D get_field(s->fields, r1);
> +    int r3 =3D get_field(s->fields, r3);
> +

(these two can be const)
you could use in1_r1 and in2_r3

> +    check_privileged(s);
> +    gen_helper_sic(cpu_env, regs[r1], regs[r3]);

gen_helper_sic(cpu_env, o->in1, o->in2);

> +    set_cc_static(s);

Are you sure this instruction modifies the cc? Can't spot a set_cc when
following the kvm code.

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
> +    int b2 =3D get_field(s->fields, b2);
> +    int d2 =3D get_field(s->fields, d2);

Dito, use in1_la2

> +    TCGv_i64 addr;
> +    TCGv_i32 ar;
> +
> +    check_privileged(s);
> +    addr =3D get_address(s, 0, b2, d2);
> +    ar =3D tcg_const_i32(b2);

And you can initialize this directly then

TCGv_i32 ar =3D tcg_const_i32(get_field(s->fields, b2));

... also applies to the others

> +    gen_helper_pcistb(cpu_env, r1, r3, addr, ar);
> +    tcg_temp_free_i64(addr);
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
> +    int b2 =3D get_field(s->fields, b2);
> +    int d2 =3D get_field(s->fields, d2);
> +    TCGv_i64 addr;
> +    TCGv_i32 ar;
> +

dito

> +    check_privileged(s);
> +    addr =3D get_address(s, 0, b2, d2);
> +    ar =3D tcg_const_i32(b2);
> +    gen_helper_mpcifc(cpu_env, r1, addr, ar);
> +    tcg_temp_free_i64(addr);
> +    tcg_temp_free_i32(ar);
> +    tcg_temp_free_i32(r1);
> +    set_cc_static(s);
> +    return NO_EXIT;
> +}
> +#endif
> +
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* The "Cc OUTput" generators.  Given the generated output (and in som=
e cases
>     the original inputs), update the various cc data structures in orde=
r to
> @@ -5708,6 +5830,7 @@ enum DisasInsnEnum {
>  #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facilit=
y */
>  #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facilit=
y */
>  #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
> +#define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
> =20
>  static const DisasInsn insn_info[] =3D {
>  #include "insn-data.def"
>=20

Thanks!

--=20

Thanks,

David / dhildenb
