Received: from eggs.gnu.org ([2001:4830:134:3::10]:50990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYsN1-0007Ob-89
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYsMx-0006cM-4z
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:19:23 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
	<20180627132747.76773eb9@redhat.com>
	<3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
	<15aad1db-2f4c-ea49-9966-a969f0c769f5@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1939f7b-76e2-eca9-2819-d0b4d9a134b1@redhat.com>
Date: Fri, 29 Jun 2018 07:19:16 -0500
MIME-Version: 1.0
In-Reply-To: <15aad1db-2f4c-ea49-9966-a969f0c769f5@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 06/28/2018 05:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>> +#ifndef QEMU_UNITS_H
>>>> +#define QEMU_UNITS_H
>>>> +
>>>> +#define KiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 10)
>>>> +#define MiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 20)
>>>> +#define GiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 30)
>>>> +#define TiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 40)
>>>> +#define PiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 50)
>>>> +#define EiB=C2=A0=C2=A0=C2=A0=C2=A0 (INT64_C(1) << 60)
>>> Shouldn't above use UINT64_C()
>>
>> Since the decision of signed vs. unsigned was intentional based on
>> review on earlier versions, it may be worth a comment in this file tha=
t
>> these constants are intentionally signed (in usage patterns, these ten=
d
>> to be multiplied by another value; and while it is easy to go to
>> unsigned by doing '1U * KiB', you can't go in the opposite direction i=
f
>> you want a signed number for '1 * KiB' unless KiB is signed).
>=20
> OK.

Actually, '1U * KiB' still ends up signed.  Why? Because as written, KiB=20
is a 64-bit quantity, but 1U is 32-bit; type promotion says that since a=20
64-bit int can represent all 32-bit unsigned values, the result of the=20
expression is still signed 64-bit.

To get unsigned KiB, you either have to use '1ULL * KiB', or KiB should=20
be changed to be (INT32_C(1) << 10) (a 32-bit constant, rather than a=20
64-bit one).

>=20
> I'll also change this tests using your suggestion:
>=20
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> @@ -709,8 +709,7 @@ static void test_opts_parse_size(void)
>                              false, &error_abort);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0),
> -                     =3D=3D, 16777215 * T_BYTE);
> +    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 16777=
215U
> * TiB);
>=20
> to avoid this error on 32-bit archs:
>=20
> source/qemu/tests/test-qemu-opts.c: In function 'test_opts_parse_size':
> source/qemu/tests/test-qemu-opts.c:713:71: error: integer overflow in
> expression [-Werror=3Doverflow]
>    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 1677721=
5 * TiB);
>                                                                        =
 ^

And this compile error is proof of the confusion when we have a signed=20
integer overflow (why it only happens on 32-bit arch and not also on=20
64-bit arch is subtle - it's because TiB is 'long long' on 32-bit, but=20
merely 'long' on 64-bit, which results in a different type after type=20
promotion - although I still find it odd that the 64-bit compiler isn't=20
warning).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
