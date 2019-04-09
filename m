Received: from eggs.gnu.org ([209.51.188.92]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqWJ-0004tS-CJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqWI-0002om-7N
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDqWI-0002nI-0w
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:10:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id k21so15496274otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190328104750.25046-1-peter.maydell@linaro.org>
	<9d4def49-7caa-c44b-7818-e81986442f18@redhat.com>
In-Reply-To: <9d4def49-7caa-c44b-7818-e81986442f18@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 14:10:21 +0100
Message-ID: <CAFEAcA_NwBsRz5KAVrkje3jqnbaTMqEPTNCds3ViLCKb_gcNWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0] target/i386: Generate #UD for LOCK
 on a register increment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 28 Mar 2019 at 11:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/03/19 11:47, Peter Maydell wrote:
> > Fix a TCG crash due to attempting an atomic increment
> > operation without having set up the address first.
> > This is a similar case to that dealt with in commit
> > e84fcd7f662a0d8198703, and we fix it in the same way.
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1807675
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/i386/translate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index 49cd298374b..b725bec37cd 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -1398,6 +1398,11 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
> >  static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
> >  {
> >      if (s1->prefix & PREFIX_LOCK) {
> > +        if (d != OR_TMP0) {
> > +            /* Lock prefix when destination is not memory */
> > +            gen_illegal_opcode(s1);
> > +            return;
> > +        }
> >          tcg_gen_movi_tl(s1->T0, c > 0 ? 1 : -1);
> >          tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
> >                                      s1->mem_index, ot | MO_LE);
> >
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Feel free to apply it yourself.

Applied to master, thanks.

-- PMM
