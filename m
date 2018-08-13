Received: from eggs.gnu.org ([2001:4830:134:3::10]:54500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fp8ba-0004bB-K0
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fp8bZ-0002Jp-NH
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:53:38 -0400
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
	<20180810030139.25916-3-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4418d221-b14c-eadf-06ad-7ce76f7a019b@redhat.com>
Date: Mon, 13 Aug 2018 10:53:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180810030139.25916-3-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/7] target/s390x: add BAL and
 BALR instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, richard.henderson@linaro.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 10.08.2018 05:01, Pavel Zbitskiy wrote:
> These instructions are provided for compatibility purposes and are
> used only by old software, in the new code BAS and BASR are preferred.
> The difference between the old and new instruction exists only in the
> 24-bit mode.
>=20
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/insn-data.def |  3 +++
>  target/s390x/translate.c   | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
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
> index 57c03cbf58..316ff79250 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1463,6 +1463,39 @@ static DisasJumpType op_bas(DisasContext *s, Dis=
asOps *o)
>      }
>  }
> =20
> +static void save_link_info(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i64 t;
> +
> +    if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
> +        tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));

"In the 24-bit or 31-bit addressing mode, bits 0-31 of
the first-operand location remain unchanged." I think this is also right
now broken for BAS.


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

This looks good to me (ilen really belongs to the current instruction
(not pc_tmp), which seems to be what BAL expects)

> +}
> +
> +static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
> +{
> +    save_link_info(s, o);
> +    if (o->in2) {
> +        tcg_gen_mov_i64(psw_addr, o->in2);
> +        per_branch(s, false);
> +        return DISAS_PC_UPDATED;
> +    } else {
> +        return DISAS_NEXT;
> +    }
> +}
> +
>  static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
>  {
>      tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
>=20


--=20

Thanks,

David / dhildenb
