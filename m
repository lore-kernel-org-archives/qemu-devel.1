Received: from eggs.gnu.org ([2001:4830:134:3::10]:45669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0ldY-0003CE-FP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0ldU-0005ZV-Ic
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:15:28 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0ldU-0005Z3-7I
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:15:24 -0400
Received: by mail-wm0-x242.google.com with SMTP id l9so20648387wmh.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 03:15:24 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-4-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-4-git-send-email-cota@braap.org>
Date: Tue, 27 Mar 2018 11:15:21 +0100
Message-ID: <87y3id964m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 03/14] softfloat: fix {min,
 max}nummag for same-abs-value inputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> Before 8936006 ("fpu/softfloat: re-factor minmax", 2018-02-21),
> we used to return +Zero for maxnummag(-Zero,+Zero); after that
> commit, we return -Zero.
>
> Fix it by making {min,max}nummag consistent with {min,max}num,
> deferring to the latter when the absolute value of the operands
> is the same.
>
> With this fix we now pass fp-test.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Oops. I guess it didn't show up in any of the testing, which is likely
given how poorly RISU exercises the boundary conditions.

I'll grab this patch as I'm fixing up some other bugs in ARM handling.

> ---
>  fpu/softfloat.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e124df9..ee615a9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1700,7 +1700,6 @@ static FloatParts minmax_floats(FloatParts a, Float=
Parts b, bool ismin,
>          return pick_nan(a, b, s);
>      } else {
>          int a_exp, b_exp;
> -        bool a_sign, b_sign;
>
>          switch (a.cls) {
>          case float_class_normal:
> @@ -1731,20 +1730,22 @@ static FloatParts minmax_floats(FloatParts a, Flo=
atParts b, bool ismin,
>              break;
>          }
>
> -        a_sign =3D a.sign;
> -        b_sign =3D b.sign;
> -        if (ismag) {
> -            a_sign =3D b_sign =3D 0;
> +        if (ismag && (a_exp !=3D b_exp || a.frac !=3D b.frac)) {
> +            bool a_less =3D a_exp < b_exp;
> +            if (a_exp =3D=3D b_exp) {
> +                a_less =3D a.frac < b.frac;
> +            }
> +            return a_less ^ ismin ? b : a;
>          }
>
> -        if (a_sign =3D=3D b_sign) {
> +        if (a.sign =3D=3D b.sign) {
>              bool a_less =3D a_exp < b_exp;
>              if (a_exp =3D=3D b_exp) {
>                  a_less =3D a.frac < b.frac;
>              }
> -            return a_sign ^ a_less ^ ismin ? b : a;
> +            return a.sign ^ a_less ^ ismin ? b : a;
>          } else {
> -            return a_sign ^ ismin ? b : a;
> +            return a.sign ^ ismin ? b : a;
>          }
>      }
>  }


--
Alex Benn=C3=A9e
