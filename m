Received: from eggs.gnu.org ([209.51.188.92]:59767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyHew-00053H-LT
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyHev-0002iA-E1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:55:10 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyHet-0002IM-3n
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:55:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id i16so10232926wrs.13
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 06:54:52 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-32-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-32-cota@braap.org>
Date: Mon, 25 Feb 2019 14:54:50 +0000
Message-ID: <878sy3ncjp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 31/38] target/xtensa: fetch code with
 translator_ld
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/xtensa/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 46e1338448..c140742562 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -882,7 +882,7 @@ static inline unsigned xtensa_op0_insn_len(DisasConte=
xt *dc, uint8_t op0)
>  static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
>  {
>      xtensa_isa isa =3D dc->config->isa;
> -    unsigned char b[MAX_INSN_LENGTH] =3D {cpu_ldub_code(env, dc->pc)};
> +    unsigned char b[MAX_INSN_LENGTH] =3D {translator_ldub(env, dc->pc)};
>      unsigned len =3D xtensa_op0_insn_len(dc, b[0]);
>      xtensa_format fmt;
>      int slot, slots;
> @@ -914,7 +914,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, Di=
sasContext *dc)
>                        dc->pc);
>      }
>      for (i =3D 1; i < len; ++i) {
> -        b[i] =3D cpu_ldub_code(env, dc->pc + i);
> +        b[i] =3D translator_ldub(env, dc->pc + i);
>      }
>      xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
>      fmt =3D xtensa_format_decode(isa, dc->insnbuf);

There is also:

  static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext =
*dc)
  {
      uint8_t b0 =3D cpu_ldub_code(env, dc->pc);
      return xtensa_op0_insn_len(dc, b0);
  }

Or is this usage a re-read of something we've already got?

--
Alex Benn=C3=A9e
