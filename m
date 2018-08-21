Received: from eggs.gnu.org ([2001:4830:134:3::10]:36882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1C9-0003J1-04
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs18T-0002Ha-8B
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:31:33 -0400
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<20180821025104.19604-3-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8bc0288e-e16c-c136-9701-0c3466f6f0dd@redhat.com>
Date: Tue, 21 Aug 2018 09:31:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180821025104.19604-3-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] target/s390x: add BAL and BALR
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 21.08.2018 04:50, Pavel Zbitskiy wrote:
> These instructions are provided for compatibility purposes and are
> used only by old software, in the new code BAS and BASR are preferred.
> The difference between the old and new instruction exists only in the
> 24-bit mode.
>=20
> In addition, fix BAS polluting high 32 bits of the first operand in
> 24- and 31-bit addressing modes.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/insn-data.def |  3 +++
>  target/s390x/translate.c   | 55 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 5c6f33ed9c..9c7b434fca 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -102,6 +102,9 @@
>      D(0x9400, NI,      SI,    Z,   la1, i2_8u, new, 0, ni, nz64, MO_UB=
)
>      D(0xeb54, NIY,     SIY,   LD,  la1, i2_8u, new, 0, ni, nz64, MO_UB=
)
> =20
> +/* BRANCH AND LINK */
> +    C(0x0500, BALR,    RR_a,  Z,   0, r2_nz, r1, 0, bal, 0)
> +    C(0x4500, BAL,     RX_a,  Z,   0, a2, r1, 0, bal, 0)
>  /* BRANCH AND SAVE */
>      C(0x0d00, BASR,    RR_a,  Z,   0, r2_nz, r1, 0, bas, 0)
>      C(0x4d00, BAS,     RX_a,  Z,   0, a2, r1, 0, bas, 0)
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 57c03cbf58..111d575c41 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -84,14 +84,22 @@ static uint64_t inline_branch_hit[CC_OP_MAX];
>  static uint64_t inline_branch_miss[CC_OP_MAX];
>  #endif
> =20
> -static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
> +static void pc_to_link_info(TCGv_i64 out, DisasContext *s, uint64_t pc=
)
>  {
> -    if (!(s->base.tb->flags & FLAG_MASK_64)) {
> -        if (s->base.tb->flags & FLAG_MASK_32) {
> -            return pc | 0x80000000;
> +    TCGv_i64 tmp;
> +
> +    if (s->base.tb->flags & FLAG_MASK_32) {
> +        if (s->base.tb->flags & FLAG_MASK_64) {
> +            tcg_gen_movi_i64(out, pc);
> +            return;
>          }
> +        pc |=3D 0x80000000;
>      }
> -    return pc;
> +    assert(!(s->base.tb->flags & FLAG_MASK_64));
> +    tmp =3D tcg_temp_new_i64();
> +    tcg_gen_movi_i64(tmp, pc);

these two can be combined into a tcg_const_i64()

> +    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
> +    tcg_temp_free_i64(tmp);
>  }
> =20
>  static TCGv_i64 psw_addr;
> @@ -1453,7 +1461,40 @@ static DisasJumpType op_ni(DisasContext *s, Disa=
sOps *o)
> =20
>  static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
>  {
> -    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
> +    pc_to_link_info(o->out, s, s->pc_tmp);
> +    if (o->in2) {
> +        tcg_gen_mov_i64(psw_addr, o->in2);
> +        per_branch(s, false);
> +        return DISAS_PC_UPDATED;
> +    } else {
> +        return DISAS_NEXT;
> +    }
> +}
> +
> +static void save_link_info(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i64 t;
> +
> +    if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
> +        pc_to_link_info(o->out, s, s->pc_tmp);
> +        return;
> +    }
> +    gen_op_calc_cc(s);
> +    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
> +    tcg_gen_ori_i64(o->out, o->out, ((s->ilen / 2) << 30) | s->pc_tmp)=
;
> +    t =3D tcg_temp_new_i64();
> +    tcg_gen_shri_i64(t, psw_mask, 16);
> +    tcg_gen_andi_i64(t, t, 0x0f000000);
> +    tcg_gen_or_i64(o->out, o->out, t);
> +    tcg_gen_extu_i32_i64(t, cc_op);
> +    tcg_gen_shli_i64(t, t, 28);
> +    tcg_gen_or_i64(o->out, o->out, t);
> +    tcg_temp_free_i64(t);
> +}
> +
> +static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
> +{
> +    save_link_info(s, o);
>      if (o->in2) {
>          tcg_gen_mov_i64(psw_addr, o->in2);
>          per_branch(s, false);
> @@ -1465,7 +1506,7 @@ static DisasJumpType op_bas(DisasContext *s, Disa=
sOps *o)
> =20
>  static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
>  {
> -    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
> +    pc_to_link_info(o->out, s, s->pc_tmp);

We could not pass the pc explicitly, but maybe the function can be
reused this way.

>      return help_goto_direct(s, s->base.pc_next + 2 * get_field(s->fiel=
ds, i2));
>  }
> =20
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>


Conny, can you fixup that one tcg_const_i64() ? Thanks!

--=20

Thanks,

David / dhildenb
