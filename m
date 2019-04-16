Received: from eggs.gnu.org ([209.51.188.92]:48944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKVF-0005fh-7C
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKVE-000108-4S
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:35:45 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-29-david@redhat.com>
	<604e8d87-44dd-f27e-171d-d3de05b9d183@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <40bd7734-deff-aeca-b0d5-f8e0de549c16@redhat.com>
Date: Tue, 16 Apr 2019 11:35:39 +0200
MIME-Version: 1.0
In-Reply-To: <604e8d87-44dd-f27e-171d-d3de05b9d183@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 28/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13.04.19 02:29, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +static void gen_rim_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, int32_t c=
)
>> +{
>> +    TCGv_i32 t0 =3D tcg_temp_new_i32();
>> +    TCGv_i32 t1 =3D tcg_temp_new_i32();
>> +
>> +    tcg_gen_andc_i32(t0, a, b);
>> +    tcg_gen_rotli_i32(t1, a, c & 31);
>> +    tcg_gen_and_i32(t1, t1, b);
>> +    tcg_gen_or_i32(d, t0, t1);
>=20
> The ANDC and ROTL look to be in the wrong order.
>=20
> "For each bit in the third operand (b) that is one,
> the corresponding bit *of the rotated elements* in
> the second operand replaces the corresponding bit in
> the first operand".
>=20
> I think you need
>=20
>     tcg_gen_rotli_i32(a, a, c & 31);
>     tcg_gen_and_i32(a, a, b);
>     tcg_gen_andc_i32(d, d, b);
>     tcg_gen_or_i32(d, d, a);
>=20
> with
>=20
>   { .fni4 =3D gen_rim_32, .load_dest =3D true },
>=20
>> +     const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
>> +     const uint##BITS##_t mask =3D s390_vec_read_element##BITS(v3, i)=
;        \
>> +     const uint##BITS##_t d =3D (a & ~mask) | (rotl##BITS(a, count) &=
 mask);  \
>=20
> Again, this seems to be missing the insert into "the first operand", i.=
e.
> loading from v1 as well.

Yes indeed, I misinterpreted/misread the PoP. Nice catch! (as usual,
excellent review)

>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
