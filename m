Received: from eggs.gnu.org ([2001:4830:134:3::10]:52687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eOoFd-0007qj-H5
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eOoFY-0002Ce-Il
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:21:53 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eOoFY-0002CD-B4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:21:48 -0500
Received: by mail-wr0-x22b.google.com with SMTP id v105so21937757wrc.3
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:21:48 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-17-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171211125705.16120-17-alex.bennee@linaro.org>
Date: Tue, 12 Dec 2017 17:21:45 +0000
Message-ID: <87h8sv980m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 16/19] fpu/softfloat: re-factor int/uint
 to float
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> These are considerably simpler as the lower order integers can just
> use the higher order conversion function. As the decomposed fractional
> part is a full 64 bit rounding and inexact handling comes from the
> pack functions.
<snip>
>
> +/*
> + * Integer to float conversions
> + *
> + * Returns the result of converting the two's complement integer `a'
> + * to the floating-point format. The conversion is performed according
> + * to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> + */
> +
> +static decomposed_parts int_to_float(int64_t a, float_status *status)
> +{
> +    decomposed_parts r;
> +    if (a =3D=3D 0) {
> +        r.cls =3D float_class_zero;
> +    } else if (a =3D=3D (1ULL << 63)) {

As the re-pack code can handle -0 we need to explicitly set it here as
we are building decomposed_parts from scratch:

    if (a =3D=3D 0) {
        r.cls =3D float_class_zero;
        r.sign =3D false;
    } else if (a =3D=3D (1ULL << 63)) {

And also at:
> +
> +/*
> + * Unsigned Integer to float conversions
> + *
> + * Returns the result of converting the unsigned integer `a' to the
> + * floating-point format. The conversion is performed according to the
> + * IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> + */
> +
> +static decomposed_parts uint_to_float(uint64_t a, float_status *status)
> +{
> +    decomposed_parts r;
> +    if (a =3D=3D 0) {
> +        r.cls =3D float_class_zero;
> +    } else {

Now reads:

    decomposed_parts r =3D { .sign =3D false};

    if (a =3D=3D 0) {
        r.cls =3D float_class_zero;
    } else {
        int spare_bits =3D clz64(a) - 1;
        r.cls =3D float_class_normal;


--
Alex Benn=C3=A9e
