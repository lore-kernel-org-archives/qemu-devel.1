Received: from eggs.gnu.org ([209.51.188.92]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1h0dTM-0008EU-1K
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1h0dTL-0007Sz-2t
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:36:55 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1h0dTK-0007QO-Ql
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 21:36:55 -0500
Received: by mail-yw1-xc42.google.com with SMTP id i204so2978780ywb.0
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 18:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-32-cota@braap.org>
	<878sy3ncjp.fsf@zen.linaroharston>
In-Reply-To: <878sy3ncjp.fsf@zen.linaroharston>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 3 Mar 2019 18:36:42 -0800
Message-ID: <CAMo8BfKAGOCNqY3tHrF5DhB16n8Goia3LcFrNk1R0=bGH3SoLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Mon, Feb 25, 2019 at 6:55 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Emilio G. Cota <cota@braap.org> writes:
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/xtensa/translate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> > index 46e1338448..c140742562 100644
> > --- a/target/xtensa/translate.c
> > +++ b/target/xtensa/translate.c
> > @@ -882,7 +882,7 @@ static inline unsigned xtensa_op0_insn_len(DisasCon=
text *dc, uint8_t op0)
> >  static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
> >  {
> >      xtensa_isa isa =3D dc->config->isa;
> > -    unsigned char b[MAX_INSN_LENGTH] =3D {cpu_ldub_code(env, dc->pc)};
> > +    unsigned char b[MAX_INSN_LENGTH] =3D {translator_ldub(env, dc->pc)=
};
> >      unsigned len =3D xtensa_op0_insn_len(dc, b[0]);
> >      xtensa_format fmt;
> >      int slot, slots;
> > @@ -914,7 +914,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, =
DisasContext *dc)
> >                        dc->pc);
> >      }
> >      for (i =3D 1; i < len; ++i) {
> > -        b[i] =3D cpu_ldub_code(env, dc->pc + i);
> > +        b[i] =3D translator_ldub(env, dc->pc + i);
> >      }
> >      xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
> >      fmt =3D xtensa_format_decode(isa, dc->insnbuf);
>
> There is also:
>
>   static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContex=
t *dc)
>   {
>       uint8_t b0 =3D cpu_ldub_code(env, dc->pc);
>       return xtensa_op0_insn_len(dc, b0);
>   }
>
> Or is this usage a re-read of something we've already got?

FWIW xtensa_insn_len is used to look into the instruction that
follows the one that has just been translated, but it may only
touch the same page as the last translated instruction.

--=20
Thanks.
-- Max
