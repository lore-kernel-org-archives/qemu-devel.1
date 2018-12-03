Received: from eggs.gnu.org ([2001:4830:134:3::10]:56725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTqTs-0008Li-Jx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTqTn-0003Lh-9Q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:49:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTqTn-0003Dn-1x
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:49:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id y185so7286205wmd.1
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:49:49 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-5-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 15:49:46 +0000
Message-ID: <87lg56390l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/16] tcg/aarch64: Fold away "noaddr"
 branch routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> There are one use apiece for these.  There is no longer a need for
> preserving branch offset operands, as we no longer re-translate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index a41b633960..28de0226fb 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1129,23 +1129,6 @@ static inline void tcg_out_goto_long(TCGContext *s=
, tcg_insn_unit *target)
>      }
>  }
>
> -static inline void tcg_out_goto_noaddr(TCGContext *s)
> -{
> -    /* We pay attention here to not modify the branch target by reading =
from
> -       the buffer. This ensure that caches and memory are kept coherent =
during
> -       retranslation.  Mask away possible garbage in the high bits for t=
he
> -       first translation, while keeping the offset bits for retranslatio=
n. */
> -    uint32_t old =3D tcg_in32(s);
> -    tcg_out_insn(s, 3206, B, old);
> -}
> -
> -static inline void tcg_out_goto_cond_noaddr(TCGContext *s, TCGCond c)
> -{
> -    /* See comments in tcg_out_goto_noaddr.  */
> -    uint32_t old =3D tcg_in32(s) >> 5;
> -    tcg_out_insn(s, 3202, B_C, c, old);
> -}
> -
>  static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
>  {
>      tcg_out_insn(s, 3207, BLR, reg);
> @@ -1192,7 +1175,7 @@ static inline void tcg_out_goto_label(TCGContext *s=
, TCGLabel *l)
>  {
>      if (!l->has_value) {
>          tcg_out_reloc(s, s->code_ptr, R_AARCH64_JUMP26, l, 0);
> -        tcg_out_goto_noaddr(s);
> +        tcg_out_insn(s, 3206, B, 0);
>      } else {
>          tcg_out_goto(s, l->u.value_ptr);
>      }
> @@ -1523,7 +1506,7 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg =
addr_reg, TCGMemOp opc,
>
>      /* If not equal, we jump to the slow path. */
>      *label_ptr =3D s->code_ptr;
> -    tcg_out_goto_cond_noaddr(s, TCG_COND_NE);
> +    tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
>  }
>
>  #endif /* CONFIG_SOFTMMU */


--
Alex Benn=C3=A9e
