Received: from eggs.gnu.org ([2001:4830:134:3::10]:38368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYXsI-0008N5-JI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYXsH-0003CZ-Mm
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:21:46 -0400
Date: Fri, 21 Jul 2017 15:21:40 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170721132140.xy2uqronprhzjiga@aurel32.net>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
	<87tw266rm3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87tw266rm3.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 12/23]
 target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 2017-07-21 10:56, Alex Benn=E9e wrote:
>=20
> Richard Henderson <rth@twiddle.net> writes:
>=20
> > On 07/20/2017 05:04 AM, Alex Benn=E9e wrote:
> >> +static softfloat_flags softfloat_mapping_table[] =3D {
> >> +    { float_flag_inexact  , softfloat_flag_inexact },
> >> +    { float_flag_underflow, softfloat_flag_underflow },
> >> +    { float_flag_overflow , softfloat_flag_overflow },
> >> +    { float_flag_invalid  , softfloat_flag_invalid },
> >> +};
> >> +/* FIXME: 2a has no infinite flag */
> >> +
> >> +static uint8_t sync_softfloat_flags_from_2a(float_status *flags2a)
> >> +{
> >> +    uint8_t flags =3D flags2a->float_exception_flags;
> >> +    int i;
> >> +    if (flags) {
> >> +        for (i =3D 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
> >> +            struct softfloat_flags *map =3D &softfloat_mapping_table[=
i];
> >> +            if (flags & map->float2a_flag) {
> >> +                softfloat_raiseFlags(map->float3c_flag);
> >> +            }
> >> +        }
> >> +    } else {
> >> +        softfloat_exceptionFlags =3D 0;
> >> +    }
> >> +
> >> +    return softfloat_exceptionFlags;
> >> +}
> >> +
> >
> > For conversions like this IMO it's better to make the compiler do the
> > work. C.f. target/alpha/fpu_helper.c and CONVERT_BIT.
>=20
> Cool, I'll look at that.
>=20
> > BTW, I think these TLS variables that softfloat3a are using are going
> > to be a real problem.  It's one thing to do it temporarily like you
> > are here, coordinating between 2a and 3c, but later, when the front
> > end is fully converted?  That's just nonsense.
>=20
> Wouldn't the other option to be to drop float_status out of the guests
> CPUEnv and grab it from the TLS variable instead? Of course all guests
> would need to be MTTCG enabled for that to work.

As said in another email, some architectures actually use more than one
float_status. We therefore need to implement a solution like the one
proposed by Richard.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
