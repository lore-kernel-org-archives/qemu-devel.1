Received: from eggs.gnu.org ([2001:4830:134:3::10]:36650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGVdn-0002ll-CU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGVdl-00029v-V8
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:20:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGVdl-00029K-OE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:20:13 -0400
Date: Thu, 1 Jun 2017 21:20:11 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170601192011.crq6igwuln4hyjw5@aurel32.net>
References: <20170601101438.28732-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170601101438.28732-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: wire up cpu type + id
 for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com

On 2017-06-01 12:14, David Hildenbrand wrote:
> Let's properly expose the CPU type (machine-type number) via "STORE CPU
> ID" and "STORE SUBSYSTEM INFORMATION".
>=20
> As TCG emulates basic mode, the CPU identification number has the format
> "Annnnn", whereby A is the CPU address, and n are parts of the CPU serial
> number (0 for us for now).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> Tested stidp with a kvm-unit-test that is still being worked on (waiting
> for Thomas' interception test to integrate). I think we are missing quite
> some "operand alignment checks" in other handlers, too.
>=20
> ---
>  target/s390x/cpu.h         |  1 -
>  target/s390x/cpu_models.c  |  2 --
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 +-
>  target/s390x/misc_helper.c | 26 +++++++++++++++++++++++---
>  target/s390x/translate.c   | 11 ++++-------
>  6 files changed, 29 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index c74b419..02bd8bf 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -147,7 +147,6 @@ typedef struct CPUS390XState {
>      CPU_COMMON
> =20
>      uint32_t cpu_num;
> -    uint32_t machine_type;
> =20
>      uint64_t tod_offset;
>      uint64_t tod_basetime;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index b6220c8..99ec0c8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -710,8 +710,6 @@ static inline void apply_cpu_model(const S390CPUModel=
 *model, Error **errp)
> =20
>      if (kvm_enabled()) {
>          kvm_s390_apply_cpu_model(model, errp);
> -    } else if (model) {
> -        /* FIXME TCG - use data for stdip/stfl */
>      }
> =20
>      if (!*errp) {
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 0b70770..0c8f745 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -121,6 +121,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, =
i64, i64)
>  DEF_HELPER_1(per_check_exception, void, env)
>  DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
> +DEF_HELPER_2(stidp, void, env, i64)
> =20
>  DEF_HELPER_2(xsch, void, env, i64)
>  DEF_HELPER_2(csch, void, env, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 55a7c52..83e7d01 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -902,7 +902,7 @@
>  /* STORE CPU ADDRESS */
>      C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16, stap, 0)
>  /* STORE CPU ID */
> -    C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64, stidp, 0)
> +    C(0xb202, STIDP,   S,     Z,   0, a2, 0, 0, stidp, 0)
>  /* STORE CPU TIMER */
>      C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
>  /* STORE FACILITY LIST */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 1b9f448..f682511 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -383,6 +383,7 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
>  uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>                        uint64_t r0, uint64_t r1)
>  {
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
>      int cc =3D 0;
>      int sel1, sel2;
> =20
> @@ -402,12 +403,14 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t =
a0,
>          if ((sel1 =3D=3D 1) && (sel2 =3D=3D 1)) {
>              /* Basic Machine Configuration */
>              struct sysib_111 sysib;
> +            char type[5] =3D {};
> =20
>              memset(&sysib, 0, sizeof(sysib));
>              ebcdic_put(sysib.manuf, "QEMU            ", 16);
> -            /* same as machine type number in STORE CPU ID */
> -            ebcdic_put(sysib.type, "QEMU", 4);
> -            /* same as model number in STORE CPU ID */
> +            /* same as machine type number in STORE CPU ID, but in EBCDI=
C */
> +            snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type=
);
> +            ebcdic_put(sysib.type, type, 4);
> +            /* model number (not stored in STORE CPU ID for z/Architecur=
e) */
>              ebcdic_put(sysib.model, "QEMU            ", 16);
>              ebcdic_put(sysib.sequence, "QEMU            ", 16);
>              ebcdic_put(sysib.plant, "QEMU", 4);
> @@ -736,3 +739,20 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t =
addr)
>      env->regs[0] =3D deposit64(env->regs[0], 0, 8, max_m1);
>      return (count_m1 >=3D max_m1 ? 0 : 3);
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +void HELPER(stidp)(CPUS390XState *env, uint64_t addr)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    uint64_t cpuid =3D s390_cpuid_from_cpu_model(cpu->model);
> +
> +    if (addr & 0x7) {
> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);
> +        return;
> +    }
> +
> +    /* basic mode, write the cpu address into the first 4 bit of the ID =
*/
> +    cpuid |=3D ((uint64_t)env->cpu_num & 0xf) << 54;
> +    cpu_stq_data(env, addr, cpuid);
> +}
> +#endif

I don't really see the point of using an helper instead of just updating
the existing code. From what I understand the cpuid does not change at
runtime, so the s390_cpuid_from_cpu_model function can also be called=20
=66rom translate.c.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
