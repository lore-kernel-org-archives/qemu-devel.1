Received: from eggs.gnu.org ([2001:4830:134:3::10]:54311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCXw-0001hC-UG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCXv-0007Qj-Nt
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:13:36 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-2-mreitz@redhat.com>
	<6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
	<c8bb155f-4ff7-46d8-116f-c4e6be2c161c@redhat.com>
	<4c7382dc-724f-4420-ea8d-b4d1bf0edf84@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a89fba24-836e-8c1a-f50c-8564b486b9f0@redhat.com>
Date: Fri, 11 May 2018 13:13:28 -0500
MIME-Version: 1.0
In-Reply-To: <4c7382dc-724f-4420-ea8d-b4d1bf0edf84@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/13] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/11/2018 12:59 PM, Max Reitz wrote:
> On 2018-05-10 15:18, Eric Blake wrote:
>> On 05/10/2018 08:12 AM, Eric Blake wrote:
>>
>> Oh, I just had a thought:
>>
>>>> +++ b/scripts/qapi/visit.py
>>>> @@ -40,10 +40,20 @@ def gen_visit_object_members(name, base, members=
,
>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants.default_tag_=
value is None:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret +=3D mcgen('''
>>>> +=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_name)s;
>>>> +''',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 c_name=3Dc_name(variants.tag_member.name))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret +=3D mcgen('''
>>>> +=C2=A0=C2=A0=C2=A0 if (obj->has_%(c_name)s) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_=
name)s;
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D %(enum_co=
nst)s;
>>
>> In this branch of code, is it worth also generating:
>>
>> %has_(c_name)s =3D true;
>=20
> You mean obj->has_%(c_name)s, and then also set obj->%(c_name)s?

Umm, yeah ;)

In fact, I think it is as simple as:

if variants:
     if variants.default_tag_value:
         ret +=3D mcgen('''
if (!obj->has_%(c_name)s) {
     obj->has_%(c_name)s =3D true;
     obj->%(c_name)s =3D %(enum_const)s;
}
''')
     ret +=3D mcgen('''
switch (obj->%(c_name)s) {
...

and you are back to not needing a temporary variable.

>=20
>> That way, the rest of the C code does not have to check
>> has_discriminator, because the process of assigning the default will
>> ensure that has_discriminator is always true later on.=C2=A0 It does h=
ave the
>> effect that output would never omit the discriminator - but that might
>> be a good thing: if we ever have an output union that used to have a
>> mandatory discriminator and want to now make it optional, we don't wan=
t
>> to break older clients that expected the discriminator to be present. =
It
>> does obscure whether input relied on the default, but I don't think th=
at
>> hurts.
>=20
> Also, it would make code a bit simpler because it can cover the !has_X
> case under X =3D=3D default_X.
>=20
> But OTOH, you could make that case for any optional value -- except
> where "is missing" has special value.

My preference - special-casing "is missing" is prone to abuse.  I don't=20
want to support that if we can at all avoid it.  The sane semantics is=20
that the default is populated as soon as we detect that something is=20
missing, and whether the user relies on the default by leaving the=20
discriminator absent, or explicitly supplies the discriminator set to=20
the default, the behavior should always be the same.

>=20
> And that's the tricky part: I think it's hard to say that a missing
> discriminator never has special meaning.

It won't, if we decide right now that we don't want to let it :)

>  We only need the
> default-variant so we know which variant of the union to pick; but we
> don't know that the fact that the discriminator value was missing does
> not have special meaning.
>=20
> Of course, we can simply foreclose that by setting it here.

And that's the way I'm leaning.

>=20
> I don't have money in this game, so I suppose it's yours and Markus's
> call. :-)

Markus, what's your preference?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
