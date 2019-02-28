Received: from eggs.gnu.org ([209.51.188.92]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzGQm-00005s-Kf
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzGQj-0007Nx-Vt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:48:35 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-9-david@redhat.com>
	<23a43b55-4902-0440-8243-62aaff19c83a@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bb16025b-cda4-6613-7e10-a03c887b106a@redhat.com>
Date: Thu, 28 Feb 2019 08:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <23a43b55-4902-0440-8243-62aaff19c83a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
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

On 27.02.19 16:39, Richard Henderson wrote:
> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>> +static DisasJumpType op_vl(DisasContext *s, DisasOps *o)
>> +{
>> +    load_vec_element(s, TMP_VREG_0, 0, o->addr1, MO_64);
>> +    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
>> +    load_vec_element(s, TMP_VREG_0, 1, o->addr1, MO_64);
>> +    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
>> +    return DISAS_NEXT;
>> +}
>=20
> Isn't it just as easy to load two TCGv_i64 temps and store into the cor=
rect
> vector afterward?

Yes it is, using the existing helpers was just easier. I guess I'll
change that.

>=20
> Also, it is easy to honor the required alignment:

I think that would be wrong. It is only an alignment hint.

"Setting the alignment hint to a non-zero value
that doesn=E2=80=99t correspond to the alignment of the second operand ma=
y
reduce performance on some models."

So we must not inject an exception when unaligned. This, however would
be the result of MO_ALIGN,, right?

In essence, this is just an optimization for real hardware and can be
ignored by us completely.

>=20
>     TCGMemOp mop1, mop2;
>=20
>     if (m3 < 3) {
>         mop1 =3D mop2 =3D MO_TEQ;
>     } else if (m3 =3D=3D 3) {
>         mop1 =3D mop2 =3D MO_TEQ | MO_ALIGN;
>     } else {
>         mop1 =3D MO_TEQ | MO_ALIGN_16;
>         mop2 =3D MO_TEQ | MO_ALIGN;
>     }
>     tcg_gen_qemu_ld_i64(tmp1, o->addr1, mem_idx, mop1);
>     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
>     tcg_gen_qemu_ld_i64(tmp2, o->addr1, mem_idx, mop2);
>     write_vec_element_i64(tmp1, v1, 0, MO_64);
>     write_vec_element_i64(tmp2, v1, 1, MO_64);
>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
