Received: from eggs.gnu.org ([2001:4830:134:3::10]:53278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAby7-00062p-Ds
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAby2-0007LA-Ef
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:57:23 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAby2-0007Kv-7R
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:57:18 -0400
Received: by mail-qk0-x244.google.com with SMTP id b131so11922041qkg.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 06:57:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
	<20180423031639.GB19804@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
Date: Mon, 23 Apr 2018 10:57:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180423031639.GB19804@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="rLaLsgicbyu9htIWyDjZ1L5kun3MoFnBT"
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rLaLsgicbyu9htIWyDjZ1L5kun3MoFnBT
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
References: <20180421211652.14794-1-f4bug@amsat.org>
 <CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
 <20180423031639.GB19804@umbus.fritz.box>
In-Reply-To: <20180423031639.GB19804@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/23/2018 12:16 AM, David Gibson wrote:
> On Sun, Apr 22, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
>> On 21 April 2018 at 22:16, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> =
wrote:
>>> This fixes the following ASan warning:
>>>
>>>   $ mips64el-softmmu/qemu-system-mips64el -M boston -kernel vmlinux.g=
z.itb -nographic
>>>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned addr=
ess 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>>>   0x7f95cd7e4264: note: pointer points here
>>>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 =
30 00 00  00 00 00 03 00 00 00 14
>>>                 ^
>>>
>>> Reported-by: AddressSanitizer
>>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>>> ---
>>>  hw/core/loader-fit.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
>>> index 0c4a7207f4..1a69697f89 100644
>>> --- a/hw/core/loader-fit.c
>>> +++ b/hw/core/loader-fit.c
>>> @@ -93,6 +93,8 @@ static int fit_image_addr(const void *itb, int img,=
 const char *name,
>>>                            hwaddr *addr)
>>>  {
>>>      const void *prop;
>>> +    fdt32_t v32;
>>> +    fdt64_t v64;
>>>      int len;
>>>
>>>      prop =3D fdt_getprop(itb, img, name, &len);
>>> @@ -102,10 +104,12 @@ static int fit_image_addr(const void *itb, int =
img, const char *name,
>>>
>>>      switch (len) {
>>>      case 4:
>>> -        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>> +        memcpy(&v32, prop, sizeof(v32));
>>> +        *addr =3D fdt32_to_cpu(v32);
>=20
> So, assuming the base of the fdt is aligned (which I'd expect), then
> properties should also be 32-bit aligned, so this shouldn't be
> necessary.  They may not be 64-bit aligned, so the equivalent for
> length 8 *is* required.
>=20
> (Really old fdt versions did attempt to 64-bit align larger
> properties, but it caused a bunch of other complications)
>=20
>> If we need to do an unaligned load, then ldl_p() is the
>> right way to do it. (We could also just do
>>  *addr =3D ldl_be_p(prop) but we maybe don't want to
>> bake in knowledge that FDT is big-endian).

Since it is, ldl_be_p() seems the clever/cleaner way indeed, but then we
assume we know the underlying type of fdt32_t; while using memcpy we
respect the FDT API.

>> This does make me suspicious that maybe we're not using
>> the fdt APIs right here though. Since 'prop' is the return
>> value of fdt_getprop(), shouldn't libfdt be providing
>> APIs for "give me the fdt32 here" that don't require
>> the libfdt user to either implement its own unaligned
>> access helpers or invoke C undefined behaviour? David,
>> any suggestions?
>=20
> It's pretty much correct usage.  Properties in fdt - as in Open
> Firmware - are defined to be bytestrings.  libfdt is concerned with
> extracting those bytestrings from the tree encoding, and parsing
> what's inside the bytestring is mostly out of scope for it.
>=20
> Mostly.. because we do have some helpers for common cases -
> e.g. fdt_setprop_u32().  We don't currently have an fdt_getprop_u32()
> or fdt_getprop_u64().  I'm not in principle opposed to adding them,
> but the right interface isn't immediately obvious to me: we can't just
> return a u32/u64, because then we have no way of reporting errors
> (like "no such property").

At the time of the fdt_getprop() call we don't know if the property is
u32/u64.


--rLaLsgicbyu9htIWyDjZ1L5kun3MoFnBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrd5jcACgkQ4+MsLN6t
wN7gfw//Z8NnmQOcbtLu0Pjs8IgX39OSs1ObtaSti3OLeOloxhrxhgCQginBqCvW
oqKXGSWL3+Z/I8YzVPCtZKNNRqgKE5Ml8s/tdOJRc+8PjsE76Y/brqUWrLJTesR6
gfZDuxX3zXpZ1xQQpQNyUEznUejePOMsZVxrkBDXqaeAdTN1vgWnHTAqFai+w0OT
cw7uU7ai0/IfHb/SQJtSPO5ER1UWvRl0hi99yCGhlA9ft2GgFA3b6ctZjHBJ0ObL
4FaUqGn7bTUzKgoitw1rwPfCQw/RExO1IRLRX5JFYYft0ma+6vWw5qLaAj/kxlkR
w+9cPQU6+GszHT0Mb0dgFflYESjTsIEtbiO4Znl/2ev4XjSWCMsS4q5wIfaqwxgA
nkhbF+IbuytvZdWhNXdYc1EYPcjPfVlM0X+pHUcWN/UAWLwzePdG5yW8aAuoA1f2
9y/9bSYlPhuKLl7Bg38UkIqAi6/JWoWT4z19yWRmGKLGGXcvjOAm0VpylzuB2CdG
3lX9/aKwSqJfx8ACVRk3qUZAcU5D0l3CGRY3yEV666GvD2tF86MTOQ6bbaRNh//F
1BNfE5DTp0TexiRDtRTzdhMC8T2Id3NfC/KpXrc5a9GVifgmoTibiAghcKi+sSUS
BxylG4/o+medMAmg6zmALejUhH7OxSzrKeBEueqZlxCIuZ/dEG4=
=qAiw
-----END PGP SIGNATURE-----

--rLaLsgicbyu9htIWyDjZ1L5kun3MoFnBT--
