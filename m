Received: from eggs.gnu.org ([2001:4830:134:3::10]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD8vO-0004sF-FR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD8vN-0008IQ-07
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:28:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD8vM-0008I4-QV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:28:28 -0400
Date: Tue, 23 May 2017 14:28:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523122820.owcu3pt6tympfeli@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-30-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170523030312.6360-30-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 29/31] target/s390x: Use atomic operations
 for COMPARE SWAP PURGE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-22 20:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  2 +-
>  target/s390x/insn-data.def |  2 +-
>  target/s390x/mem_helper.c  | 32 ++++++++------------------------
>  target/s390x/translate.c   | 42 ++++++++++++++++++++++++++++++++++++++--=
--
>  4 files changed, 48 insertions(+), 30 deletions(-)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 2b4e7be..a2e0bf2 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -107,13 +107,13 @@ DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64=
, i64)
>  DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
> -DEF_HELPER_3(csp, i32, env, i32, i64)
>  DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
>  DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
>  DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
>  DEF_HELPER_FLAGS_2(sacf, TCG_CALL_NO_WG, void, env, i64)
>  DEF_HELPER_FLAGS_3(ipte, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
>  DEF_HELPER_2(lra, i64, env, i64)
>  DEF_HELPER_FLAGS_2(lura, TCG_CALL_NO_WG, i64, env, i64)
>  DEF_HELPER_FLAGS_2(lurag, TCG_CALL_NO_WG, i64, env, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 3c3541c..4c91f30 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -837,7 +837,7 @@
> =20
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
> -    C(0xb250, CSP,     RRE,   Z,   0, ra2, 0, 0, csp, 0)
> +    D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
>  /* DIAGNOSE (KVM hypercall) */
>      C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
>  /* INSERT STORAGE KEY EXTENDED */
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 81b27c0..4becc80 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1029,30 +1029,6 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t=
 r2)
>      return re >> 1;
>  }
> =20
> -/* compare and swap and purge */
> -uint32_t HELPER(csp)(CPUS390XState *env, uint32_t r1, uint64_t r2)
> -{
> -    S390CPU *cpu =3D s390_env_get_cpu(env);
> -    uint32_t cc;
> -    uint32_t o1 =3D env->regs[r1];
> -    uint64_t a2 =3D r2 & ~3ULL;
> -    uint32_t o2 =3D cpu_ldl_data(env, a2);
> -
> -    if (o1 =3D=3D o2) {
> -        cpu_stl_data(env, a2, env->regs[(r1 + 1) & 15]);
> -        if (r2 & 0x3) {
> -            /* flush TLB / ALB */
> -            tlb_flush(CPU(cpu));
> -        }
> -        cc =3D 0;
> -    } else {
> -        env->regs[r1] =3D (env->regs[r1] & 0xffffffff00000000ULL) | o2;
> -        cc =3D 1;
> -    }
> -
> -    return cc;
> -}
> -
>  uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint6=
4_t a2)
>  {
>      int cc =3D 0, i;
> @@ -1130,6 +1106,14 @@ void HELPER(ptlb)(CPUS390XState *env)
>      tlb_flush(CPU(cpu));
>  }
> =20
> +/* flush global tlb */
> +void HELPER(purge)(CPUS390XState *env)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +
> +    tlb_flush_all_cpus(CPU(cpu));

=46rom what I understand from the PoP, the instruction should not complete
before the TLB has been purged on all CPUs. Therefore I guess
tlb_flush_all_cpus_synced() should be used instead.

> +}
> +
>  /* load using real address */
>  uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 3e4b397..ca5be7b 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2003,11 +2003,45 @@ static ExitStatus op_cdsg(DisasContext *s, DisasO=
ps *o)
>  #ifndef CONFIG_USER_ONLY
>  static ExitStatus op_csp(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i32 r1 =3D tcg_const_i32(get_field(s->fields, r1));
> +    TCGMemOp mop =3D s->insn->data;
> +    TCGv_i64 addr, old, cc;
> +    TCGLabel *lab =3D gen_new_label();
> +
> +    /* Note that in1 =3D R1 (zero-extended expected value),
> +       out =3D R1 (original reg), out2 =3D R1+1 (new value).  */
> +
>      check_privileged(s);
> -    gen_helper_csp(cc_op, cpu_env, r1, o->in2);
> -    tcg_temp_free_i32(r1);
> -    set_cc_static(s);
> +    addr =3D tcg_temp_new_i64();
> +    old =3D tcg_temp_new_i64();
> +    tcg_gen_andi_i64(addr, o->in2, -1ULL << (mop & MO_SIZE));
> +    tcg_gen_atomic_cmpxchg_i64(old, addr, o->in1, o->out2,

Here the prep generator took the 32-bit version of in1. I guess the same
should be done for out2.

> +                               get_mem_index(s), mop | MO_ALIGN);
> +    tcg_temp_free_i64(addr);
> +
> +    /* Are the memory and expected values (un)equal?  */
> +    cc =3D tcg_temp_new_i64();
> +    tcg_gen_setcond_i64(TCG_COND_NE, cc, o->in1, old);
> +    tcg_gen_extrl_i64_i32(cc_op, cc);
> +
> +    /* Write back the output now, so that it happens before the
> +       following branch, so that we don't need local temps.  */
> +    if ((mop & MO_SIZE) =3D=3D MO_32) {
> +        tcg_gen_deposit_i64(o->out, o->out, old, 0, 32);
> +    } else {
> +        tcg_gen_mov_i64(o->out, old);
> +    }
> +    tcg_temp_free_i64(old);
> +
> +    /* If the comparison was equal, and the LSB of R2 was set,
> +       then we need to flush the TLB (for all cpus).  */
> +    tcg_gen_xori_i64(cc, cc, 1);
> +    tcg_gen_and_i64(cc, cc, o->in2);
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, cc, 0, lab);
> +    tcg_temp_free_i64(cc);
> +
> +    gen_helper_purge(cpu_env);
> +    gen_set_label(lab);
> +
>      return NO_EXIT;
>  }
>  #endif
> --=20
> 2.9.4
>=20
>=20
>=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
