Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRIdo-0008KH-A6
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRIcF-00019F-HW
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:16:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRIcF-00017W-B4
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:16:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id c126so18824447wmh.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 07:16:03 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-39-cota@braap.org>
Date: Mon, 26 Nov 2018 15:16:00 +0000
Message-ID: <87k1kz50pb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 38/48] translator: implement 2-pass
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The second pass only occurs when a plugin has subscribed to
> TB translation events.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg.h              |  8 ++++
>  accel/tcg/translator.c | 91 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index d5afe25c97..479b57d65f 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -720,6 +720,14 @@ struct TCGContext {
>
>      TCGLabel *exitreq_label;
>
<snip>
>      }
>
> +    if (tb_trans_cb && first_pass) {
> +        qemu_plugin_tb_trans_cb(cpu, plugin_tb);
> +        first_pass =3D false;
> +        goto translate;
> +    }
> +

So the only reason we are doing this two pass tango is to ensure the
plugin can insert TCG ops before the actual translation has occurred?

I think we can do better, especially as the internal structures of
TCGops are implemented as a list so ops and be inserted before and after
other ops. This is currently only done by the optimiser at the moment,
see:

  TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int =
narg);
  TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int n=
arg);

and all the base tcg ops end up going to tcg_emit_op which just appends
to the tail. But if we can come up with a neater way to track the op
used before the current translated expression we could do away with two
phases translation completely.

>      /* Emit code to exit the TB, as indicated by db->is_jmp.  */
>      ops->tb_stop(db, cpu);
>      gen_tb_end(db->tb, db->num_insns - bp_insn);


--
Alex Benn=C3=A9e
