Received: from eggs.gnu.org ([2001:4830:134:3::10]:48123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2KL-0005w8-Hc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2KK-000051-GZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:37:09 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea2KK-0008WI-BK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:37:08 -0500
Received: by mail-ot0-x241.google.com with SMTP id p16so5519915otf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:37:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-17-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-17-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 16:36:47 +0000
Message-ID: <CAFEAcA_4pnkHpLB7GfTzi+CfoXXy-pk3NgKELQae29OZL7L=Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/20] fpu/softfloat: re-factor float to
 int/uint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> We share the common int64/uint64_pack_decomposed function across all
> the helpers and simply limit the final result depending on the final
> size.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> v2
>   - apply float_flg_invalid fixes next patch
> ---
>  fpu/softfloat.c         | 1011 +++++++++++------------------------------=
------
>  include/fpu/softfloat.h |   13 +
>  2 files changed, 235 insertions(+), 789 deletions(-)
>

> -/*----------------------------------------------------------------------=
------
> -| Returns the result of converting the double-precision floating-point v=
alue
> -| `a' to the 64-bit two's complement integer format.  The conversion is
> -| performed according to the IEC/IEEE Standard for Binary Floating-Point
> -| Arithmetic---which means in particular that the conversion is rounded
> -| according to the current rounding mode.  If `a' is a NaN, the largest
> -| positive integer is returned.  Otherwise, if the conversion overflows,=
 the
> -| largest integer with the same sign as `a' is returned.
> +| Standard for Binary Floating-Point Arithmetic.
>  *-----------------------------------------------------------------------=
-----*/
>
> -int64_t float64_to_int64(float64 a, float_status *status)
> +int float32_lt_quiet(float32 a, float32 b, float_status *status)
>  {
> -    flag aSign;
> -    int aExp;
> -    int shiftCount;
> -    uint64_t aSig, aSigExtra;
> -    a =3D float64_squash_input_denormal(a, status);
> +    flag aSign, bSign;
> +    uint32_t av, bv;
> +    a =3D float32_squash_input_denormal(a, status);
> +    b =3D float32_squash_input_denormal(b, status);
>
> -    aSig =3D extractFloat64Frac( a );
> -    aExp =3D extractFloat64Exp( a );
> -    aSign =3D extractFloat64Sign( a );
> -    if ( aExp ) aSig |=3D LIT64( 0x0010000000000000 );
> -    shiftCount =3D 0x433 - aExp;
> -    if ( shiftCount <=3D 0 ) {
> -        if ( 0x43E < aExp ) {
> +    if (    ( ( extractFloat32Exp( a ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( a ) )
> +         || ( ( extractFloat32Exp( b ) =3D=3D 0xFF ) && extractFloat32Fr=
ac( b ) )
> +       ) {
> +        if (float32_is_signaling_nan(a, status)
> +         || float32_is_signaling_nan(b, status)) {


Is this actually you changing existing code, or is it just that
diff has got confused? If the latter, perhaps whatever the
"think a bit harder" flag to diff is might make the patch
easier to read?

thanks
-- PMM
