Received: from eggs.gnu.org ([2001:4830:134:3::10]:48634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eiyyW-0004R1-VX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eiyyO-0005eq-JV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:51:37 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eiyyN-0005bH-VF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:51:28 -0500
Received: by mail-wm0-x243.google.com with SMTP id v123so2173793wmd.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 00:51:27 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-2-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 08:51:24 +0000
Message-ID: <871shyxzzn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 01/20] tcg: Allow multiple word entries
 into the constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This will be required for storing vector constants.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-pool.inc.c | 115 +++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 93 insertions(+), 22 deletions(-)
>
> diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
> index 8a85131405..ecf7c9282b 100644
> --- a/tcg/tcg-pool.inc.c
> +++ b/tcg/tcg-pool.inc.c
> @@ -22,39 +22,110 @@
>
>  typedef struct TCGLabelPoolData {
>      struct TCGLabelPoolData *next;
> -    tcg_target_ulong data;
>      tcg_insn_unit *label;
> -    intptr_t addend;
> -    int type;
> +    int32_t addend;
> +    uint16_t rtype;
> +    uint16_t nlong;
> +    tcg_target_ulong data[];
>  } TCGLabelPoolData;
>
>
> -static void new_pool_label(TCGContext *s, tcg_target_ulong data, int typ=
e,
> -                           tcg_insn_unit *label, intptr_t addend)
> +static TCGLabelPoolData *new_pool_alloc(TCGContext *s, int nlong, int rt=
ype,
> +                                        tcg_insn_unit *label, int addend)
>  {
> -    TCGLabelPoolData *n =3D tcg_malloc(sizeof(*n));
> -    TCGLabelPoolData *i, **pp;
> +    TCGLabelPoolData *n =3D tcg_malloc(sizeof(TCGLabelPoolData)
> +                                     + sizeof(tcg_target_ulong) * nlong);
>
> -    n->data =3D data;
>      n->label =3D label;
> -    n->type =3D type;
>      n->addend =3D addend;
> +    n->rtype =3D rtype;
> +    n->nlong =3D nlong;
> +    return n;
> +}
> +
> +static void new_pool_insert(TCGContext *s, TCGLabelPoolData *n)
> +{
> +    TCGLabelPoolData *i, **pp;
> +    int nlong =3D n->nlong;
>
>      /* Insertion sort on the pool.  */
> -    for (pp =3D &s->pool_labels; (i =3D *pp) && i->data < data; pp =3D &=
i->next) {
> -        continue;
> +    for (pp =3D &s->pool_labels; (i =3D *pp) !=3D NULL; pp =3D &i->next)=
 {
> +        if (nlong > i->nlong) {
> +            break;
> +        }
> +        if (nlong < i->nlong) {
> +            continue;
> +        }
> +        if (memcmp(n->data, i->data, sizeof(tcg_target_ulong) * nlong) >=
=3D 0) {
> +            break;
> +        }
>      }
>      n->next =3D *pp;
>      *pp =3D n;
>  }
>
> +/* The "usual" for generic integer code.  */
> +static inline void new_pool_label(TCGContext *s, tcg_target_ulong d, int=
 rtype,
> +                                  tcg_insn_unit *label, int addend)
> +{
> +    TCGLabelPoolData *n =3D new_pool_alloc(s, 1, rtype, label, addend);
> +    n->data[0] =3D d;
> +    new_pool_insert(s, n);
> +}
> +
> +/* For v64 or v128, depending on the host.  */
> +static inline void new_pool_l2(TCGContext *s, int rtype, tcg_insn_unit *=
label,
> +                               int addend, tcg_target_ulong d0,
> +                               tcg_target_ulong d1)
> +{
> +    TCGLabelPoolData *n =3D new_pool_alloc(s, 2, rtype, label, addend);
> +    n->data[0] =3D d0;
> +    n->data[1] =3D d1;
> +    new_pool_insert(s, n);
> +}
> +
> +/* For v128 or v256, depending on the host.  */
> +static inline void new_pool_l4(TCGContext *s, int rtype, tcg_insn_unit *=
label,
> +                               int addend, tcg_target_ulong d0,
> +                               tcg_target_ulong d1, tcg_target_ulong d2,
> +                               tcg_target_ulong d3)
> +{
> +    TCGLabelPoolData *n =3D new_pool_alloc(s, 4, rtype, label, addend);
> +    n->data[0] =3D d0;
> +    n->data[1] =3D d1;
> +    n->data[2] =3D d2;
> +    n->data[3] =3D d3;
> +    new_pool_insert(s, n);
> +}
> +
> +/* For v256, for 32-bit host.  */
> +static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *=
label,
> +                               int addend, tcg_target_ulong d0,
> +                               tcg_target_ulong d1, tcg_target_ulong d2,
> +                               tcg_target_ulong d3, tcg_target_ulong d4,
> +                               tcg_target_ulong d5, tcg_target_ulong d6,
> +                               tcg_target_ulong d7)
> +{
> +    TCGLabelPoolData *n =3D new_pool_alloc(s, 8, rtype, label, addend);
> +    n->data[0] =3D d0;
> +    n->data[1] =3D d1;
> +    n->data[2] =3D d2;
> +    n->data[3] =3D d3;
> +    n->data[4] =3D d4;
> +    n->data[5] =3D d5;
> +    n->data[6] =3D d6;
> +    n->data[7] =3D d7;
> +    new_pool_insert(s, n);
> +}
> +
>  /* To be provided by cpu/tcg-target.inc.c.  */
>  static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
>
>  static bool tcg_out_pool_finalize(TCGContext *s)
>  {
>      TCGLabelPoolData *p =3D s->pool_labels;
> -    tcg_target_ulong d, *a;
> +    TCGLabelPoolData *l =3D NULL;
> +    void *a;
>
>      if (p =3D=3D NULL) {
>          return true;
> @@ -62,24 +133,24 @@ static bool tcg_out_pool_finalize(TCGContext *s)
>
>      /* ??? Round up to qemu_icache_linesize, but then do not round
>         again when allocating the next TranslationBlock structure.  */
> -    a =3D (void *)ROUND_UP((uintptr_t)s->code_ptr, sizeof(tcg_target_ulo=
ng));
> +    a =3D (void *)ROUND_UP((uintptr_t)s->code_ptr,
> +                         sizeof(tcg_target_ulong) * p->nlong);
>      tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
>      s->data_gen_ptr =3D a;
>
> -    /* Ensure the first comparison fails.  */
> -    d =3D p->data + 1;
> -
>      for (; p !=3D NULL; p =3D p->next) {
> -        if (p->data !=3D d) {
> -            d =3D p->data;
> -            if (unlikely((void *)a > s->code_gen_highwater)) {
> +        size_t size =3D sizeof(tcg_target_ulong) * p->nlong;
> +        if (!l || l->nlong !=3D p->nlong || memcmp(l->data, p->data, siz=
e)) {
> +            if (unlikely(a > s->code_gen_highwater)) {
>                  return false;
>              }
> -            *a++ =3D d;
> +            memcpy(a, p->data, size);
> +            a +=3D size;
> +            l =3D p;
>          }
> -        patch_reloc(p->label, p->type, (intptr_t)(a - 1), p->addend);
> +        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
>      }
>
> -    s->code_ptr =3D (void *)a;
> +    s->code_ptr =3D a;
>      return true;
>  }


--
Alex Benn=C3=A9e
