Received: from eggs.gnu.org ([2001:4830:134:3::10]:45226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlSo-0002xM-7n
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlSm-0001GK-On
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:18:30 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-2-mreitz@redhat.com>
	<6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8bb155f-4ff7-46d8-116f-c4e6be2c161c@redhat.com>
Date: Thu, 10 May 2018 08:18:22 -0500
MIME-Version: 1.0
In-Reply-To: <6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
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

On 05/10/2018 08:12 AM, Eric Blake wrote:

Oh, I just had a thought:

>> +++ b/scripts/qapi/visit.py
>> @@ -40,10 +40,20 @@ def gen_visit_object_members(name, base, members,=20

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if variants.default_tag_va=
lue is None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t +=3D mcgen('''
>> +=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_name)s;
>> +''',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 c_name=3Dc_name(variants.tag_member.name))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t +=3D mcgen('''
>> +=C2=A0=C2=A0=C2=A0 if (obj->has_%(c_name)s) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D obj->%(c_na=
me)s;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %(c_name)s =3D %(enum_cons=
t)s;

In this branch of code, is it worth also generating:

%has_(c_name)s =3D true;

That way, the rest of the C code does not have to check=20
has_discriminator, because the process of assigning the default will=20
ensure that has_discriminator is always true later on.  It does have the=20
effect that output would never omit the discriminator - but that might=20
be a good thing: if we ever have an output union that used to have a=20
mandatory discriminator and want to now make it optional, we don't want=20
to break older clients that expected the discriminator to be present.=20
It does obscure whether input relied on the default, but I don't think=20
that hurts.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
