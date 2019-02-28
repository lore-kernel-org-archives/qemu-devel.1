Received: from eggs.gnu.org ([209.51.188.92]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHT9-0000XC-6S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHT7-0004O0-3b
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:55:07 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-20-david@redhat.com>
	<f2a03544-24c2-71f7-41f2-d53b7e6b7909@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <21b14487-116f-f0bc-732f-1e9f8e0c2212@redhat.com>
Date: Thu, 28 Feb 2019 09:54:57 +0100
MIME-Version: 1.0
In-Reply-To: <f2a03544-24c2-71f7-41f2-d53b7e6b7909@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 19/33] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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

On 27.02.19 17:20, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> +    for (dst_idx =3D 0; dst_idx < NUM_VEC_ELEMENTS(es); dst_idx++) {
>> +        src_idx =3D dst_idx / 2;
>> +        if (!high) {
>> +            src_idx +=3D NUM_VEC_ELEMENTS(es) / 2;
>> +        }
>> +        if (dst_idx % 2 =3D=3D 0) {
>> +            read_vec_element_i64(tmp, v2, src_idx, es);
>> +        } else {
>> +            read_vec_element_i64(tmp, v3, src_idx, es);
>> +        }
>> +        write_vec_element_i64(tmp, dst_v, dst_idx, es);
>> +    }
>=20
> TODO: Note that you do not need a vector temporary here, so long as you=
 load
> both source elements before writing, and you iterate in the proper dire=
ction.
>=20
> For VMRL, iterate forward as you do now.  The element access order for =
MO_32:
>=20
>  read  v2: 2   3
>  read  v3:   2   3
>  write v1: 0 1 2 3
>=20
> For VMRH, iterate backward:
>=20
>  read  v2: 1   0
>  read  v3:   1   0
>  write v1: 3 2 1 0
>=20
>=20
> r~
>=20

Let's have a look for VMRH when iterating forward (My brain is a little
slow in the morning):

v1[0] =3D v2[0]
v1[1] =3D v3[0]
v1[2] =3D v2[1]
v1[3] =3D v3[1]

If all would overlap

v1[0] =3D v1[0]
v1[1] =3D v1[0] -> v1[0] already modified
v1[2] =3D v1[1] -> v1[1] already modified
v1[3] =3D v1[1] -> v1[1] already modified

When iterating backwards:

v1[3] =3D v3[1]
v1[2] =3D v2[1]
v1[1] =3D v3[0]
v1[0] =3D v2[0]

If all would overlap

v1[3] =3D v1[1]
v1[2] =3D v1[1]
v1[1] =3D v1[0]
v1[0] =3D v1[0]


VMRH when iterating forward:

v1[0] =3D v2[2]
v1[1] =3D v3[2]
v1[2] =3D v2[3]
v1[3] =3D v3[3]

If all would overlap

v1[0] =3D v1[2]
v1[1] =3D v1[2]
v1[2] =3D v1[3]
v1[3] =3D v1[3]

Perfect :) I'll split up the two cases! Thanks!

--=20

Thanks,

David / dhildenb
