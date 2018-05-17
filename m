Received: from eggs.gnu.org ([2001:4830:134:3::10]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJLyQ-0000sj-5H
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fJLyJ-0007t9-QP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:41:50 -0400
Received: from mail-co1nam03on0078.outbound.protection.outlook.com
	([104.47.40.78]:55040
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fJLyJ-0007sR-9y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:41:43 -0400
Date: Thu, 17 May 2018 18:41:28 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180517164128.27mncjmnrszmfagc@toto>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-12-edgar.iglesias@gmail.com>
	<53bfff10-2b12-e1db-d195-e4160e0aa9ff@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <53bfff10-2b12-e1db-d195-e4160e0aa9ff@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v3 11/38] target-microblaze: Make
 compute_ldst_addr always use a temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On Thu, May 17, 2018 at 11:39:41AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >=20
> > Make compute_ldst_addr always use a temp. This simplifies
> > the code a bit in preparation for adding support for
> > 64bit addresses.
> >=20
> > No functional change.
> >=20
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  target/microblaze/translate.c | 111 ++++++++++++++--------------------=
--------
> >  1 file changed, 37 insertions(+), 74 deletions(-)
> >=20
> > diff --git a/target/microblaze/translate.c b/target/microblaze/translat=
e.c
> > index 2e9a286af6..3431a07b99 100644
> > --- a/target/microblaze/translate.c
> > +++ b/target/microblaze/translate.c
> > @@ -848,7 +848,7 @@ static void dec_imm(DisasContext *dc)
> >      dc->clear_imm =3D 0;
> >  }
> > =20
> > -static inline TCGv_i32 *compute_ldst_addr(DisasContext *dc, TCGv_i32 *=
t)
> > +static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
> >  {
> >      bool extimm =3D dc->tb_flags & IMM_FLAG;
> >      /* Should be set to true if r1 is used by loadstores.  */
> > @@ -861,47 +861,47 @@ static inline TCGv_i32 *compute_ldst_addr(DisasCo=
ntext *dc, TCGv_i32 *t)
>=20
> I never noticed that git diff show line/prototype of the previous patchse=
t.
>=20
> > =20
> >      /* Treat the common cases first.  */
> >      if (!dc->type_b) {
> > -        /* If any of the regs is r0, return a ptr to the other.  */
> > +        /* If any of the regs is r0, return the value of the other reg=
.  */
>=20
> Single nit here, this comment isn't true anymore since this function
> doesn't return.
>=20
> No need to respin for this, but can you/Richard drop this comment when
> pulling?

Hi,

The function returns a value in *t.
I can change the comment to the following:
/* If any of the regs is r0, set t to the value of the other reg.  */

Cheers,
Edgar

>=20
> >          if (dc->ra =3D=3D 0) {
> > -            return &cpu_R[dc->rb];
> > +            tcg_gen_mov_i32(*t, cpu_R[dc->rb]);
> > +            return;
> >          } else if (dc->rb =3D=3D 0) {
> > -            return &cpu_R[dc->ra];
> > +            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
> > +            return;
> >          }
> > =20
> >          if (dc->rb =3D=3D 1 && dc->cpu->cfg.stackprot) {
> >              stackprot =3D true;
> >          }
> > =20
> > -        *t =3D tcg_temp_new_i32();
> >          tcg_gen_add_i32(*t, cpu_R[dc->ra], cpu_R[dc->rb]);
> > =20
> >          if (stackprot) {
> >              gen_helper_stackprot(cpu_env, *t);
> >          }
> > -        return t;
> > +        return;
> >      }
> >      /* Immediate.  */
> >      if (!extimm) {
> >          if (dc->imm =3D=3D 0) {
> > -            return &cpu_R[dc->ra];
> > +            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
> > +            return;
> >          }
> > -        *t =3D tcg_temp_new_i32();
> >          tcg_gen_movi_i32(*t, (int32_t)((int16_t)dc->imm));
> >          tcg_gen_add_i32(*t, cpu_R[dc->ra], *t);
> >      } else {
> > -        *t =3D tcg_temp_new_i32();
> >          tcg_gen_add_i32(*t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
> >      }
> > =20
> >      if (stackprot) {
> >          gen_helper_stackprot(cpu_env, *t);
> >      }
> > -    return t;
> > +    return;
> >  }
> > =20
> >  static void dec_load(DisasContext *dc)
> >  {
> > -    TCGv_i32 t, v, *addr;
> > +    TCGv_i32 v, addr;
> >      unsigned int size;
> >      bool rev =3D false, ex =3D false;
> >      TCGMemOp mop;
> > @@ -928,7 +928,8 @@ static void dec_load(DisasContext *dc)
> >                                                          ex ? "x" : "")=
;
> > =20
> >      t_sync_flags(dc);
> > -    addr =3D compute_ldst_addr(dc, &t);
> > +    addr =3D tcg_temp_new_i32();
> > +    compute_ldst_addr(dc, &addr);
> > =20
> >      /*
> >       * When doing reverse accesses we need to do two things.
> > @@ -947,17 +948,10 @@ static void dec_load(DisasContext *dc)
> >                     11 -> 00 */
> >                  TCGv_i32 low =3D tcg_temp_new_i32();
> > =20
> > -                /* Force addr into the temp.  */
> > -                if (addr !=3D &t) {
> > -                    t =3D tcg_temp_new_i32();
> > -                    tcg_gen_mov_i32(t, *addr);
> > -                    addr =3D &t;
> > -                }
> > -
> > -                tcg_gen_andi_i32(low, t, 3);
> > +                tcg_gen_andi_i32(low, addr, 3);
> >                  tcg_gen_sub_i32(low, tcg_const_i32(3), low);
> > -                tcg_gen_andi_i32(t, t, ~3);
> > -                tcg_gen_or_i32(t, t, low);
> > +                tcg_gen_andi_i32(addr, addr, ~3);
> > +                tcg_gen_or_i32(addr, addr, low);
> >                  tcg_temp_free_i32(low);
> >                  break;
> >              }
> > @@ -965,14 +959,7 @@ static void dec_load(DisasContext *dc)
> >              case 2:
> >                  /* 00 -> 10
> >                     10 -> 00.  */
> > -                /* Force addr into the temp.  */
> > -                if (addr !=3D &t) {
> > -                    t =3D tcg_temp_new_i32();
> > -                    tcg_gen_xori_i32(t, *addr, 2);
> > -                    addr =3D &t;
> > -                } else {
> > -                    tcg_gen_xori_i32(t, t, 2);
> > -                }
> > +                tcg_gen_xori_i32(addr, addr, 2);
> >                  break;
> >              default:
> >                  cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
> > @@ -982,13 +969,7 @@ static void dec_load(DisasContext *dc)
> > =20
> >      /* lwx does not throw unaligned access errors, so force alignment =
*/
> >      if (ex) {
> > -        /* Force addr into the temp.  */
> > -        if (addr !=3D &t) {
> > -            t =3D tcg_temp_new_i32();
> > -            tcg_gen_mov_i32(t, *addr);
> > -            addr =3D &t;
> > -        }
> > -        tcg_gen_andi_i32(t, t, ~3);
> > +        tcg_gen_andi_i32(addr, addr, ~3);
> >      }
> > =20
> >      /* If we get a fault on a dslot, the jmpstate better be in sync.  =
*/
> > @@ -1002,16 +983,16 @@ static void dec_load(DisasContext *dc)
> >       * address and if that succeeds we write into the destination reg.
> >       */
> >      v =3D tcg_temp_new_i32();
> > -    tcg_gen_qemu_ld_i32(v, *addr, cpu_mmu_index(&dc->cpu->env, false),=
 mop);
> > +    tcg_gen_qemu_ld_i32(v, addr, cpu_mmu_index(&dc->cpu->env, false), =
mop);
> > =20
> >      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size >=
 1) {
> >          tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
> > -        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
> > +        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> >                              tcg_const_i32(0), tcg_const_i32(size - 1))=
;
> >      }
> > =20
> >      if (ex) {
> > -        tcg_gen_mov_i32(env_res_addr, *addr);
> > +        tcg_gen_mov_i32(env_res_addr, addr);
> >          tcg_gen_mov_i32(env_res_val, v);
> >      }
> >      if (dc->rd) {
> > @@ -1024,13 +1005,12 @@ static void dec_load(DisasContext *dc)
> >          write_carryi(dc, 0);
> >      }
> > =20
> > -    if (addr =3D=3D &t)
> > -        tcg_temp_free_i32(t);
> > +    tcg_temp_free_i32(addr);
> >  }
> > =20
> >  static void dec_store(DisasContext *dc)
> >  {
> > -    TCGv_i32 t, *addr, swx_addr;
> > +    TCGv_i32 addr;
> >      TCGLabel *swx_skip =3D NULL;
> >      unsigned int size;
> >      bool rev =3D false, ex =3D false;
> > @@ -1059,21 +1039,19 @@ static void dec_store(DisasContext *dc)
> >      t_sync_flags(dc);
> >      /* If we get a fault on a dslot, the jmpstate better be in sync.  =
*/
> >      sync_jmpstate(dc);
> > -    addr =3D compute_ldst_addr(dc, &t);
> > +    /* SWX needs a temp_local.  */
> > +    addr =3D ex ? tcg_temp_local_new_i32() : tcg_temp_new_i32();
> > +    compute_ldst_addr(dc, &addr);
> > =20
> > -    swx_addr =3D tcg_temp_local_new_i32();
> >      if (ex) { /* swx */
> >          TCGv_i32 tval;
> > =20
> > -        /* Force addr into the swx_addr. */
> > -        tcg_gen_mov_i32(swx_addr, *addr);
> > -        addr =3D &swx_addr;
> >          /* swx does not throw unaligned access errors, so force alignm=
ent */
> > -        tcg_gen_andi_i32(swx_addr, swx_addr, ~3);
> > +        tcg_gen_andi_i32(addr, addr, ~3);
> > =20
> >          write_carryi(dc, 1);
> >          swx_skip =3D gen_new_label();
> > -        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, swx_addr, swx_sk=
ip);
> > +        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, addr, swx_skip);
> > =20
> >          /* Compare the value loaded at lwx with current contents of
> >             the reserved location.
> > @@ -1081,8 +1059,8 @@ static void dec_store(DisasContext *dc)
> >             this compare and the following write to be atomic. For user
> >             emulation we need to add atomicity between threads.  */
> >          tval =3D tcg_temp_new_i32();
> > -        tcg_gen_qemu_ld_i32(tval, swx_addr, cpu_mmu_index(&dc->cpu->en=
v, false),
> > -                           MO_TEUL);
> > +        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, f=
alse),
> > +                            MO_TEUL);
> >          tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
> >          write_carryi(dc, 0);
> >          tcg_temp_free_i32(tval);
> > @@ -1099,17 +1077,10 @@ static void dec_store(DisasContext *dc)
> >                     11 -> 00 */
> >                  TCGv_i32 low =3D tcg_temp_new_i32();
> > =20
> > -                /* Force addr into the temp.  */
> > -                if (addr !=3D &t) {
> > -                    t =3D tcg_temp_new_i32();
> > -                    tcg_gen_mov_i32(t, *addr);
> > -                    addr =3D &t;
> > -                }
> > -
> > -                tcg_gen_andi_i32(low, t, 3);
> > +                tcg_gen_andi_i32(low, addr, 3);
> >                  tcg_gen_sub_i32(low, tcg_const_i32(3), low);
> > -                tcg_gen_andi_i32(t, t, ~3);
> > -                tcg_gen_or_i32(t, t, low);
> > +                tcg_gen_andi_i32(addr, addr, ~3);
> > +                tcg_gen_or_i32(addr, addr, low);
> >                  tcg_temp_free_i32(low);
> >                  break;
> >              }
> > @@ -1118,20 +1089,14 @@ static void dec_store(DisasContext *dc)
> >                  /* 00 -> 10
> >                     10 -> 00.  */
> >                  /* Force addr into the temp.  */
> > -                if (addr !=3D &t) {
> > -                    t =3D tcg_temp_new_i32();
> > -                    tcg_gen_xori_i32(t, *addr, 2);
> > -                    addr =3D &t;
> > -                } else {
> > -                    tcg_gen_xori_i32(t, t, 2);
> > -                }
> > +                tcg_gen_xori_i32(addr, addr, 2);
> >                  break;
> >              default:
> >                  cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
> >                  break;
> >          }
> >      }
> > -    tcg_gen_qemu_st_i32(cpu_R[dc->rd], *addr,
> > +    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr,
> >                          cpu_mmu_index(&dc->cpu->env, false), mop);
> > =20
> >      /* Verify alignment if needed.  */
> > @@ -1143,17 +1108,15 @@ static void dec_store(DisasContext *dc)
> >           *        the alignment checks in between the probe and the me=
m
> >           *        access.
> >           */
> > -        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
> > +        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> >                              tcg_const_i32(1), tcg_const_i32(size - 1))=
;
> >      }
> > =20
> >      if (ex) {
> >          gen_set_label(swx_skip);
> >      }
> > -    tcg_temp_free_i32(swx_addr);
> > =20
> > -    if (addr =3D=3D &t)
> > -        tcg_temp_free_i32(t);
> > +    tcg_temp_free_i32(addr);
> >  }
> > =20
> >  static inline void eval_cc(DisasContext *dc, unsigned int cc,
> >=20
>=20
> Nice cleanup!
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
