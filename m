Received: from eggs.gnu.org ([209.51.188.92]:39258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grJ4O-0007BX-Ra
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grItz-0007X7-0Q
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 03:49:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1grIty-0007QN-Of
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 03:49:50 -0500
References: <20190205162253.9155-1-david@redhat.com>
	<69586972-35c7-4941-4b65-6b49fed66532@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f6797f15-759a-3a1a-a7bd-9f22a6dc34f1@redhat.com>
Date: Wed, 6 Feb 2019 09:49:19 +0100
MIME-Version: 1.0
In-Reply-To: <69586972-35c7-4941-4b65-6b49fed66532@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 06.02.19 04:08, Richard Henderson wrote:
> On 2/5/19 4:22 PM, David Hildenbrand wrote:
>> +static inline bool float128_is_normal(float128 a)
>> +{
>> +    return ((a.high + (1ULL << 47)) & -1ULL >> 1) >=3D 1ULL << 48;
>=20
> I believe this is off by one: 1 << 48 and >=3D 1 << 49.
>=20
> The exponent is at [62:48].  The trick is adding 1, letting Inf+NaN ove=
rflow
> into the sign, masking out the sign, and checking that the result >=3D =
2 to
> eliminate Inf+NaN (0) and Zero+Denormal (1).

Right, the exponent must not be 0 or all 1's. so after adding 1, it must
be >=3D2.

Yesterday it all made sense on my sheet of paper :) Let's verify against
float64

float64 has an exponent of 11:

return ((float64_val(a) + (1ULL << 52)) & -1ULL >> 1) >=3D 1ULL << 53;

float128 has an exponent of 15, the difference is 4. So 52 -> 48, 53 -> 4=
9.

So you're right.

>=20
> I think this is clearer as
>=20
>   (((a.high >> 48) + 1) & 0x7fff) >=3D 2.>
> It might be worth applying this to the other formats for clarity...
>=20

Yes, this makes it much clearer, will send a patch for the others as
well, thanks!

>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
