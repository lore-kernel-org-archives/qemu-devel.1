Received: from eggs.gnu.org ([2001:4830:134:3::10]:58356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enjx8-0001Nr-5l
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1enjx4-0005zz-TR
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:49:50 -0500
References: <1518824446-20235-1-git-send-email-cota@braap.org>
	<1518824446-20235-4-git-send-email-cota@braap.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <751466b5-ac87-bc6f-75db-f8d953044af0@redhat.com>
Date: Mon, 19 Feb 2018 12:49:10 +0100
MIME-Version: 1.0
In-Reply-To: <1518824446-20235-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] target/s390x: convert to TranslatorOps
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

Can you keep DisasContext named dc instead of s? Avoids unnecessary
changes. (e.g. s390x_tr_tb_stop()). And also matches what e.g. i386 does
in their code.

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 170 ++++++++++++++++++++++++---------------=
--------
>  1 file changed, 86 insertions(+), 84 deletions(-)
>=20
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index dd504a1..2b27a69 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -55,10 +55,12 @@ struct DisasContext {
>      DisasContextBase base;
>      const DisasInsn *insn;
>      DisasFields *fields;
> +    uint64_t next_page_start;
>      uint64_t ex_value;
>      uint64_t pc, next_pc;
>      uint32_t ilen;
>      enum cc_op cc_op;
> +    bool do_debug;
>  };
> =20
>  /* Information carried about a condition to be evaluated.  */
> @@ -6108,101 +6110,92 @@ static DisasJumpType translate_one(CPUS390XSta=
te *env, DisasContext *s)
>      return ret;
>  }
> =20
> -void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
> +static int s390x_tr_init_disas_context(DisasContextBase *dcbase,
> +                                       CPUState *cs, int max_insns)
>  {
> -    CPUS390XState *env =3D cs->env_ptr;
> -    DisasContext dc;
> -    uint64_t next_page_start;
> -    int num_insns, max_insns;
> -    DisasJumpType status;
> -    bool do_debug;
> +    DisasContext *s =3D container_of(dcbase, DisasContext, base);
> =20
> -    dc.base.pc_first =3D tb->pc;
>      /* 31-bit mode */
> -    if (!(tb->flags & FLAG_MASK_64)) {
> -        dc.base.pc_first &=3D 0x7fffffff;
> +    if (!(s->base.tb->flags & FLAG_MASK_64)) {
> +        s->base.pc_first &=3D 0x7fffffff;
> +        s->base.pc_next =3D s->base.pc_first;
>      }
> -    dc.base.pc_next =3D dc.base.pc_first;
> -    dc.base.tb =3D tb;
> -    dc.base.singlestep_enabled =3D cs->singlestep_enabled;
> =20
> -    dc.pc =3D dc.base.pc_first;
> -    dc.cc_op =3D CC_OP_DYNAMIC;
> -    dc.ex_value =3D dc.base.tb->cs_base;
> -    do_debug =3D cs->singlestep_enabled;
> +    s->pc =3D s->base.pc_first;
> +    s->cc_op =3D CC_OP_DYNAMIC;
> +    s->ex_value =3D s->base.tb->cs_base;
> +    s->do_debug =3D s->base.singlestep_enabled;
> +    s->next_page_start =3D (s->base.pc_first & TARGET_PAGE_MASK) +
> +        TARGET_PAGE_SIZE;

Does it really make sense to store this pre calculation? Can't you
simply do that in ops->translate_insn?

> +static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUSta=
te *cs,
> +                                      const CPUBreakpoint *bp)
> +{
> +    DisasContext *s =3D container_of(dcbase, DisasContext, base);
> =20
> -        if (num_insns =3D=3D max_insns && (tb_cflags(tb) & CF_LAST_IO)=
) {
> -            gen_io_start();
> -        }
> +    s->base.is_jmp =3D DISAS_PC_STALE;
> +    s->do_debug =3D true;

Can we drop s->do_debug and instead use DISAS_TOO_MANY like the other
architectures? (if I understood that part correctly :) )

> +    /* The address covered by the breakpoint must be included in
> +       [tb->pc, tb->pc + tb->size) in order to for it to be
> +       properly cleared -- thus we increment the PC here so that
> +       the logic setting tb->size below does the right thing.  */
> +    s->pc +=3D 2;
> +    s->base.pc_next +=3D 2;
> +    return true;
> +}
> =20


--=20

Thanks,

David / dhildenb
