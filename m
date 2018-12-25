Received: from eggs.gnu.org ([208.118.235.92]:34788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkjR-0003aD-AR
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkjO-00084a-5E
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:18:41 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkjO-00084O-1L
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 06:18:38 -0500
Received: by mail-yw1-f66.google.com with SMTP id h193so5487725ywc.4
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 03:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20181225070305.18221-1-cota@braap.org>
	<eae6d6d4-a076-e949-37c5-9acd6104d206@amsat.org>
In-Reply-To: <eae6d6d4-a076-e949-37c5-9acd6104d206@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 25 Dec 2018 12:18:25 +0100
Message-ID: <CAAdtpL7tM1_=M9pa_j7c9UMP345kEtKrHGazwmT5x_FiE9r-1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: enforce softfloat if the
 host's FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Dec 25, 2018 at 12:15 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Hi Emilio,
>
> On 12/25/18 8:03 AM, Emilio G. Cota wrote:
> > The added branch to the FMA ops is marked as unlikely and therefore
> > its impact on performance (measured with fp-bench) is within noise rang=
e
> > when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
>
> Did you forget to write here the result of your measurements?
>
> >
> > Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Oops I meant:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
> > ---
> > v2: drop the cpuid bits, since that work (1) is only a performance
> > optimization, not a correctness fix and (2) requires additional
> > consolidation work that I do not have time to do right now.
> >
> >  fpu/softfloat.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index 59eac97d10..9132d7a0b0 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -1542,6 +1542,8 @@ soft_f64_muladd(float64 a, float64 b, float64 c, =
int flags,
> >      return float64_round_pack_canonical(pr, status);
> >  }
> >
> > +static bool force_soft_fma;
> > +
> >  float32 QEMU_FLATTEN
> >  float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_st=
atus *s)
> >  {
> > @@ -1562,6 +1564,11 @@ float32_muladd(float32 xa, float32 xb, float32 x=
c, int flags, float_status *s)
> >      if (unlikely(!f32_is_zon3(ua, ub, uc))) {
> >          goto soft;
> >      }
> > +
> > +    if (unlikely(force_soft_fma)) {
> > +        goto soft;
> > +    }
> > +
> >      /*
> >       * When (a || b) =3D=3D 0, there's no need to check for under/over=
 flow,
> >       * since we know the addend is (normal || 0) and the product is 0.
> > @@ -1623,6 +1630,11 @@ float64_muladd(float64 xa, float64 xb, float64 x=
c, int flags, float_status *s)
> >      if (unlikely(!f64_is_zon3(ua, ub, uc))) {
> >          goto soft;
> >      }
> > +
> > +    if (unlikely(force_soft_fma)) {
> > +        goto soft;
> > +    }
> > +
> >      /*
> >       * When (a || b) =3D=3D 0, there's no need to check for under/over=
 flow,
> >       * since we know the addend is (normal || 0) and the product is 0.
> > @@ -7974,3 +7986,24 @@ float128 float128_scalbn(float128 a, int n, floa=
t_status *status)
> >                                           , status);
> >
> >  }
> > +
> > +static void __attribute__((constructor)) softfloat_init(void)
> > +{
> > +    union_float64 ua, ub, uc, ur;
> > +
> > +    if (QEMU_NO_HARDFLOAT) {
> > +        return;
> > +    }
> > +    /*
> > +     * Test that the host's FMA is not obviously broken. For example,
> > +     * glibc < 2.23 can perform an incorrect FMA on certain hosts; see
> > +     *   https://sourceware.org/bugzilla/show_bug.cgi?id=3D13304
> > +     */
> > +    ua.s =3D 0x0020000000000001ULL;
> > +    ub.s =3D 0x3ca0000000000000ULL;
> > +    uc.s =3D 0x0020000000000000ULL;
> > +    ur.h =3D fma(ua.h, ub.h, uc.h);
> > +    if (ur.s !=3D 0x0020000000000001ULL) {
> > +        force_soft_fma =3D true;
> > +    }
> > +}
> >
