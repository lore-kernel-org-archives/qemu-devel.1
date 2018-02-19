Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enijG-0006ak-FK
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enijE-0007iI-Do
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:31:26 -0500
References: <1518824446-20235-1-git-send-email-cota@braap.org>
	<1518824446-20235-3-git-send-email-cota@braap.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <44b3fca5-f4e2-2660-63c3-bf78c79d5bd6@redhat.com>
Date: Mon, 19 Feb 2018 11:31:21 +0100
MIME-Version: 1.0
In-Reply-To: <1518824446-20235-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] target/s390x: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

On 17.02.2018 00:40, Emilio G. Cota wrote:
> Notes:
>=20
> - Kept ctx.pc and ctx.next_pc; it would be very confusing
>   to have ctx.base.pc_next and ctx.next_pc !
>   Instead, just updated ctx.base.pc_next where relevant.

So we now have

ctx.pc
 -> same as ctx.base.pc_next
 -> points at the untranslated / currently being translated pc
ctx.next_pc
 -> points at the next pc during translation
 -> initialized to to s->pc + ilen
 -> if there is a branch, it is changed to branch target

ctx.base.pc_first -> "first guest instruction in this TB"
ctx.base.pc_next -> "next guest instruction in this TB"


ctx.next_pc is only valid during translate_one(), after that the value
is synced back to ctx.pc. (and you sync it back to dc.base.pc_next). It
is actually a temporary variable to determine the pc to executed after
next_pc.

So what about the following:

1. Drop ctx.pc and use ctx.base.pc_next instead
2. Rename ctx.next_pc to ctx.pc_tmp and add a comment like

/*
 * During translate_one(), pc_tmp is used to determine the instruction
 * to be executed after base.pc_next - e.g. next sequential instruction
 * or a branch target.
 */

>=20
> - Did not convert num_insns and is_jmp, since the corresponding
>   code will go away in the next patch.
>=20
> - Avoided a checkpatch error in use_exit_tb.
>=20
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 85 ++++++++++++++++++++++++----------------=
--------
>  1 file changed, 43 insertions(+), 42 deletions(-)
>=20
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 5346791..dd504a1 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -52,14 +52,13 @@ typedef struct DisasInsn DisasInsn;
>  typedef struct DisasFields DisasFields;
> =20
>  struct DisasContext {
> -    struct TranslationBlock *tb;
> +    DisasContextBase base;
>      const DisasInsn *insn;
>      DisasFields *fields;
>      uint64_t ex_value;
>      uint64_t pc, next_pc;
>      uint32_t ilen;
>      enum cc_op cc_op;
> -    bool singlestep_enabled;


>  };
> =20
>  /* Information carried about a condition to be evaluated.  */
> @@ -81,8 +80,8 @@ static uint64_t inline_branch_miss[CC_OP_MAX];
> =20
>  static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
>  {
> -    if (!(s->tb->flags & FLAG_MASK_64)) {
> -        if (s->tb->flags & FLAG_MASK_32) {
> +    if (!(s->base.tb->flags & FLAG_MASK_64)) {
> +        if (s->base.tb->flags & FLAG_MASK_32) {
>              return pc | 0x80000000;
>          }
>      }
> @@ -196,7 +195,7 @@ static void per_branch(DisasContext *s, bool to_nex=
t)
>  #ifndef CONFIG_USER_ONLY
>      tcg_gen_movi_i64(gbea, s->pc);
> =20
> -    if (s->tb->flags & FLAG_MASK_PER) {
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
>          TCGv_i64 next_pc =3D to_next ? tcg_const_i64(s->next_pc) : psw=
_addr;
>          gen_helper_per_branch(cpu_env, gbea, next_pc);
>          if (to_next) {
> @@ -210,7 +209,7 @@ static void per_branch_cond(DisasContext *s, TCGCon=
d cond,
>                              TCGv_i64 arg1, TCGv_i64 arg2)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    if (s->tb->flags & FLAG_MASK_PER) {
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
>          TCGLabel *lab =3D gen_new_label();
>          tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
> =20
> @@ -250,7 +249,7 @@ static inline uint64_t ld_code4(CPUS390XState *env,=
 uint64_t pc)
> =20
>  static int get_mem_index(DisasContext *s)
>  {
> -    switch (s->tb->flags & FLAG_MASK_ASC) {
> +    switch (s->base.tb->flags & FLAG_MASK_ASC) {
>      case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
>          return 0;
>      case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
> @@ -315,7 +314,7 @@ static inline void gen_trap(DisasContext *s)
>  #ifndef CONFIG_USER_ONLY
>  static void check_privileged(DisasContext *s)
>  {
> -    if (s->tb->flags & FLAG_MASK_PSTATE) {
> +    if (s->base.tb->flags & FLAG_MASK_PSTATE) {
>          gen_program_exception(s, PGM_PRIVILEGED);
>      }
>  }
> @@ -324,7 +323,7 @@ static void check_privileged(DisasContext *s)
>  static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
>  {
>      TCGv_i64 tmp =3D tcg_temp_new_i64();
> -    bool need_31 =3D !(s->tb->flags & FLAG_MASK_64);
> +    bool need_31 =3D !(s->base.tb->flags & FLAG_MASK_64);
> =20
>      /* Note that d2 is limited to 20 bits, signed.  If we crop negativ=
e
>         displacements early we create larger immedate addends.  */
> @@ -537,9 +536,9 @@ static void gen_op_calc_cc(DisasContext *s)
> =20
>  static bool use_exit_tb(DisasContext *s)
>  {
> -    return (s->singlestep_enabled ||
> -            (tb_cflags(s->tb) & CF_LAST_IO) ||
> -            (s->tb->flags & FLAG_MASK_PER));
> +    return s->base.singlestep_enabled ||
> +            (tb_cflags(s->base.tb) & CF_LAST_IO) ||
> +            (s->base.tb->flags & FLAG_MASK_PER);
>  }
> =20
>  static bool use_goto_tb(DisasContext *s, uint64_t dest)
> @@ -548,7 +547,7 @@ static bool use_goto_tb(DisasContext *s, uint64_t d=
est)
>          return false;
>      }
>  #ifndef CONFIG_USER_ONLY
> -    return (dest & TARGET_PAGE_MASK) =3D=3D (s->tb->pc & TARGET_PAGE_M=
ASK) ||
> +    return (dest & TARGET_PAGE_MASK) =3D=3D (s->base.tb->pc & TARGET_P=
AGE_MASK) ||
>             (dest & TARGET_PAGE_MASK) =3D=3D (s->pc & TARGET_PAGE_MASK)=
;
>  #else
>      return true;
> @@ -1150,7 +1149,7 @@ static DisasJumpType help_goto_direct(DisasContex=
t *s, uint64_t dest)
>          per_breaking_event(s);
>          tcg_gen_goto_tb(0);
>          tcg_gen_movi_i64(psw_addr, dest);
> -        tcg_gen_exit_tb((uintptr_t)s->tb);
> +        tcg_gen_exit_tb((uintptr_t)s->base.tb);
>          return DISAS_GOTO_TB;
>      } else {
>          tcg_gen_movi_i64(psw_addr, dest);
> @@ -1211,14 +1210,14 @@ static DisasJumpType help_branch(DisasContext *=
s, DisasCompare *c,
>              /* Branch not taken.  */
>              tcg_gen_goto_tb(0);
>              tcg_gen_movi_i64(psw_addr, s->next_pc);
> -            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
> +            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
> =20
>              /* Branch taken.  */
>              gen_set_label(lab);
>              per_breaking_event(s);
>              tcg_gen_goto_tb(1);
>              tcg_gen_movi_i64(psw_addr, dest);
> -            tcg_gen_exit_tb((uintptr_t)s->tb + 1);
> +            tcg_gen_exit_tb((uintptr_t)s->base.tb + 1);
> =20
>              ret =3D DISAS_GOTO_TB;
>          } else {
> @@ -1241,7 +1240,7 @@ static DisasJumpType help_branch(DisasContext *s,=
 DisasCompare *c,
>              update_cc_op(s);
>              tcg_gen_goto_tb(0);
>              tcg_gen_movi_i64(psw_addr, s->next_pc);
> -            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
> +            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
> =20
>              gen_set_label(lab);
>              if (is_imm) {
> @@ -1990,7 +1989,7 @@ static DisasJumpType op_cdsg(DisasContext *s, Dis=
asOps *o)
>      addr =3D get_address(s, 0, b2, d2);
>      t_r1 =3D tcg_const_i32(r1);
>      t_r3 =3D tcg_const_i32(r3);
> -    if (tb_cflags(s->tb) & CF_PARALLEL) {
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>          gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
>      } else {
>          gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
> @@ -2008,7 +2007,7 @@ static DisasJumpType op_csst(DisasContext *s, Dis=
asOps *o)
>      int r3 =3D get_field(s->fields, r3);
>      TCGv_i32 t_r3 =3D tcg_const_i32(r3);
> =20
> -    if (tb_cflags(s->tb) & CF_PARALLEL) {
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>          gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2)=
;
>      } else {
>          gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
> @@ -2968,7 +2967,7 @@ static DisasJumpType op_lpd(DisasContext *s, Disa=
sOps *o)
>      TCGMemOp mop =3D s->insn->data;
> =20
>      /* In a parallel context, stop the world and single step.  */
> -    if (tb_cflags(s->tb) & CF_PARALLEL) {
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>          update_psw_addr(s);
>          update_cc_op(s);
>          gen_exception(EXCP_ATOMIC);
> @@ -2990,7 +2989,7 @@ static DisasJumpType op_lpd(DisasContext *s, Disa=
sOps *o)
> =20
>  static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
>  {
> -    if (tb_cflags(s->tb) & CF_PARALLEL) {
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>          gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
>      } else {
>          gen_helper_lpq(o->out, cpu_env, o->in2);
> @@ -3040,7 +3039,7 @@ static DisasJumpType op_mov2e(DisasContext *s, Di=
sasOps *o)
>      o->in2 =3D NULL;
>      o->g_in2 =3D false;
> =20
> -    switch (s->tb->flags & FLAG_MASK_ASC) {
> +    switch (s->base.tb->flags & FLAG_MASK_ASC) {
>      case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
>          tcg_gen_movi_i64(ar1, 0);
>          break;
> @@ -4408,7 +4407,7 @@ static DisasJumpType op_stmh(DisasContext *s, Dis=
asOps *o)
> =20
>  static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
>  {
> -    if (tb_cflags(s->tb) & CF_PARALLEL) {
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>          gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
>      } else {
>          gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
> @@ -4497,8 +4496,8 @@ static DisasJumpType op_tam(DisasContext *s, Disa=
sOps *o)
>  {
>      int cc =3D 0;
> =20
> -    cc |=3D (s->tb->flags & FLAG_MASK_64) ? 2 : 0;
> -    cc |=3D (s->tb->flags & FLAG_MASK_32) ? 1 : 0;
> +    cc |=3D (s->base.tb->flags & FLAG_MASK_64) ? 2 : 0;
> +    cc |=3D (s->base.tb->flags & FLAG_MASK_32) ? 1 : 0;
>      gen_op_movi_cc(s, cc);
>      return DISAS_NEXT;
>  }
> @@ -5998,7 +5997,7 @@ static DisasJumpType translate_one(CPUS390XState =
*env, DisasContext *s)
>      }
> =20
>  #ifndef CONFIG_USER_ONLY
> -    if (s->tb->flags & FLAG_MASK_PER) {
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
>          TCGv_i64 addr =3D tcg_const_i64(s->pc);
>          gen_helper_per_ifetch(cpu_env, addr);
>          tcg_temp_free_i64(addr);
> @@ -6093,7 +6092,7 @@ static DisasJumpType translate_one(CPUS390XState =
*env, DisasContext *s)
>      }
> =20
>  #ifndef CONFIG_USER_ONLY
> -    if (s->tb->flags & FLAG_MASK_PER) {
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
>          /* An exception might be triggered, save PSW if not already do=
ne.  */
>          if (ret =3D=3D DISAS_NEXT || ret =3D=3D DISAS_PC_STALE) {
>              tcg_gen_movi_i64(psw_addr, s->next_pc);
> @@ -6113,26 +6112,26 @@ void gen_intermediate_code(CPUState *cs, struct=
 TranslationBlock *tb)
>  {
>      CPUS390XState *env =3D cs->env_ptr;
>      DisasContext dc;
> -    target_ulong pc_start;
>      uint64_t next_page_start;
>      int num_insns, max_insns;
>      DisasJumpType status;
>      bool do_debug;
> =20
> -    pc_start =3D tb->pc;
> -
> +    dc.base.pc_first =3D tb->pc;
>      /* 31-bit mode */
>      if (!(tb->flags & FLAG_MASK_64)) {
> -        pc_start &=3D 0x7fffffff;
> +        dc.base.pc_first &=3D 0x7fffffff;
>      }
> +    dc.base.pc_next =3D dc.base.pc_first;
> +    dc.base.tb =3D tb;
> +    dc.base.singlestep_enabled =3D cs->singlestep_enabled;
> =20
> -    dc.tb =3D tb;
> -    dc.pc =3D pc_start;
> +    dc.pc =3D dc.base.pc_first;
>      dc.cc_op =3D CC_OP_DYNAMIC;
> -    dc.ex_value =3D tb->cs_base;
> -    do_debug =3D dc.singlestep_enabled =3D cs->singlestep_enabled;
> +    dc.ex_value =3D dc.base.tb->cs_base;
> +    do_debug =3D cs->singlestep_enabled;
> =20
> -    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SI=
ZE;
> +    next_page_start =3D (dc.base.pc_first & TARGET_PAGE_MASK) + TARGET=
_PAGE_SIZE;
> =20
>      num_insns =3D 0;
>      max_insns =3D tb_cflags(tb) & CF_COUNT_MASK;
> @@ -6149,7 +6148,7 @@ void gen_intermediate_code(CPUState *cs, struct T=
ranslationBlock *tb)
>          tcg_gen_insn_start(dc.pc, dc.cc_op);
>          num_insns++;
> =20
> -        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
> +        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))=
) {
>              status =3D DISAS_PC_STALE;
>              do_debug =3D true;
>              /* The address covered by the breakpoint must be included =
in
> @@ -6157,6 +6156,7 @@ void gen_intermediate_code(CPUState *cs, struct T=
ranslationBlock *tb)
>                 properly cleared -- thus we increment the PC here so th=
at
>                 the logic setting tb->size below does the right thing. =
 */
>              dc.pc +=3D 2;
> +            dc.base.pc_next +=3D 2;

I don't like that it is updated here directly

>              break;
>          }
> =20
> @@ -6165,6 +6165,7 @@ void gen_intermediate_code(CPUState *cs, struct T=
ranslationBlock *tb)
>          }
> =20
>          status =3D translate_one(env, &dc);
> +        dc.base.pc_next =3D dc.pc;

but synced back here

Let's just try to get rid of duplicate variables.



--=20

Thanks,

David / dhildenb
