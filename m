Received: from eggs.gnu.org ([2001:4830:134:3::10]:45865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fj4gf-0003nS-Kn
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fj4gc-0005mu-FP
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:29:49 -0400
Received: from mail-cys01nam02on0727.outbound.protection.outlook.com
	([2a01:111:f400:fe45::727]:43008
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fj4gc-0005kv-24
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:29:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 27 Jul 2018 15:29:40 +0000
Message-ID: <SN6PR08MB4879EDCAD5A9D3EBC076F2C0C62A0@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-24-git-send-email-stefan.markovic@rt-rk.com>,
	<b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
In-Reply-To: <b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 23/40] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Richard.

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Saturday, July 21, 2018 8:15 PM
>=20
> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> > From: Yongbok Kim <yongbok.kim@mips.com>
> >
> > Implement nanoMIPS LLWP and SCWP instruction pair.
> >
> > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  linux-user/mips/cpu_loop.c |  25 ++++++++---
> >  target/mips/cpu.h          |   2 +
> >  target/mips/helper.h       |   2 +
> >  target/mips/op_helper.c    |  35 +++++++++++++++
> >  target/mips/translate.c    | 107 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 166 insertions(+), 5 deletions(-)
>=20
> Hmm.  Well, it's ok as far as it goes, but I'd really really like to see
> target/mips to be updated to use actual atomic operations.  Otherwise
> mips*-linux-user will never be reliable and mips*-softmmu cannot run SMP =
in
> multi-threaded mode.
>=20
> While converting the rest of target/mips to atomic operations is perhaps =
out of
> scope for this patch set, there's really no reason not to do these two
> instructions correctly from the start.  It'll save the trouble of rewriti=
ng
> them from scratch later.
>=20
> Please see target/arm/translate.c, gen_load_exclusive and gen_store_exclu=
sive,
> for the size =3D=3D 3 case.  That is arm32 doing a 64-bit "paired" atomic
> operation, just like you are attempting here.
>=20
> Note that single-copy atomic semantics apply in both cases, so LLWP must
> perform one 64-bit load, not two 32-bit loads.  The store in SCWP must ha=
ppen
> with a 64-bit atomic cmpxchg operation.

This is our work-in-progress version:

(does it look better?)

static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
                     uint32_t reg1, uint32_t reg2)
{
    TCGv taddr =3D tcg_temp_new();
    TCGv_i64 tval =3D tcg_temp_new_i64();
    TCGv tmp1 =3D tcg_temp_new();
    TCGv tmp2 =3D tcg_temp_new();
    TCGv tmp3 =3D tcg_temp_new();
    TCGLabel *l1 =3D gen_new_label();

    gen_base_offset_addr(ctx, taddr, base, offset);
    tcg_gen_andi_tl(tmp3, taddr, 0x7);
    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp3, 0, l1);
    tcg_temp_free(tmp3);
    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
    generate_exception(ctx, EXCP_AdES);

    gen_set_label(l1);
    tcg_gen_qemu_ld64(tval, taddr, ctx->mem_idx);
    tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
    gen_store_gpr(tmp1, reg1);
    tcg_temp_free(tmp1);
    gen_store_gpr(tmp2, reg2);
    tcg_temp_free(tmp2);
    tcg_gen_st_i64(tval, cpu_env, offsetof(CPUMIPSState, llval_wp));
    tcg_temp_free_i64(tval);
    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, lladdr));
    tcg_temp_free(taddr);
}

=20
static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
                     uint32_t reg1, uint32_t reg2)
{
    TCGv taddr =3D tcg_temp_new();
    TCGv lladdr =3D tcg_temp_new();
    TCGv_i64 tval =3D tcg_temp_new_i64();
    TCGv_i64 llval =3D tcg_temp_new_i64();
    TCGv_i64 val =3D tcg_temp_new_i64();
    TCGv tmp1 =3D tcg_temp_new();
    TCGv tmp2 =3D tcg_temp_new();
    TCGLabel *l1 =3D gen_new_label();
    TCGLabel *lab_fail =3D gen_new_label();
    TCGLabel *lab_done =3D gen_new_label();
=20
    gen_base_offset_addr(ctx, taddr, base, offset);
    tcg_gen_andi_tl(tmp1, taddr, 0x7);
    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp1, 0, l1);
    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
    generate_exception(ctx, EXCP_AdES);

    gen_set_label(l1);
    tcg_gen_ld_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
    tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
    gen_load_gpr(tmp1, reg1);
    gen_load_gpr(tmp2, reg2);
    tcg_gen_concat_tl_i64(tval, tmp1, tmp2);
    tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
    tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
                               ctx->mem_idx, MO_64);
    tcg_gen_setcond_i64(TCG_COND_EQ, val, val, llval);
    tcg_gen_br(lab_done);
=20
    gen_set_label(lab_fail);
    tcg_gen_movi_tl(cpu_gpr[reg2], 0);
=20
    gen_set_label(lab_done);
    tcg_gen_movi_tl(lladdr, -1);
    tcg_gen_st_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
}
