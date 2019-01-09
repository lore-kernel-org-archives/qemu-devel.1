Received: from eggs.gnu.org ([209.51.188.92]:47075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghDer-00036I-GO
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghDZ4-0006nM-Id
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:06:36 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
	<87pnt7bflk.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
Date: Wed, 9 Jan 2019 14:06:22 +0100
MIME-Version: 1.0
In-Reply-To: <87pnt7bflk.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r1YJLh0MQq6Njgvu6OtH0zDursJv3MaRH"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r1YJLh0MQq6Njgvu6OtH0zDursJv3MaRH
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org>
 <20190107163606.GL23773@natto.ory.fergeau.eu>
 <87pnt7bflk.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnt7bflk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.01.19 11:36, Markus Armbruster wrote:
> Copying block maintainers for help with assessing the bug's (non-)impac=
t
> on security.
>=20
> Christophe Fergeau <cfergeau@redhat.com> writes:
>=20
>> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>>>> Adding Markus to cc: list, I forgot to do it when sending the patch=
=2E
>>>>
>>>> Also worth backporting via qemu-stable, now in cc.
>>>>
>>>>>
>>>>> Christophe
>>>>>
>>>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:=

>>>>>> commit 8bca4613 added support for %% in json strings when interpol=
ating,
>>>>>> but in doing so, this broke handling of % when not interpolating a=
s the
>>>>>> '%' is skipped in both cases.
>>>>>> This commit ensures we only try to handle %% when interpolating.
>>>
>>> Impact?
>>>
>>> If you're unable to assess, could you give us at least a reproducer?
>>
>> This all came from https://lists.freedesktop.org/archives/spice-devel/=
2018-December/046644.html
>> Setting up a VM with libvirt with <graphics type=3D'spice' autoport=3D=
'yes' passwd=3D'password%'/>
>> fails to start with:
>>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: Asserti=
on `*ptr' failed.
>>
>> If you use 'password%%' as the password instead, when trying to connec=
t
>> to the VM, you type 'password%' as the password instead of 'password%%=
'
>> as configured in the domain XML.
>=20
> Thanks.
>=20
> As the commit message says, the bug bites when we parse a string
> containing '%s' with !ctxt->ap.  The parser then swallows a character.
> If it swallows the terminating '"', it fails the assertion.
>=20
> We parse with !ctxt->ap in the following cases:
>=20
> * Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
>   tests/test-visitor-serialization.c)
>=20
>   Plenty of tests, but we still failed to cover the buggy case :(
>=20
> * QMP input (monitor.c)
>=20
> * QGA input (qga/main.c)
>=20
> * qobject_from_json()
>=20
>   - JSON pseudo-filenames (block.c)
>=20
>     These are pseudo-filenames starting with "json:".
>=20
>   - JSON key pairs (block/rbd.c)
>=20
>     As far as I can tell, these can come only from pseudo-filenames
>     starting with "rbd:".
>=20
>   - JSON command line option arguments of -display and -blockdev
>     (qobject-input-visitor.c)
>=20
>     Reproducer: -blockdev '{"%"}'
>=20
> Command line, QMP and QGA input are trusted.
>=20
> Filenames are trusted when they come from command line, QMP or HMP.
> They are untrusted when they come from from image file headers.
> Example: QCOW2 backing file name.  Note that this is *not* the security=

> boundary between host and guest.  It's the boundary between host and an=

> image file from an untrusted source.
>=20
> I can't see how the bug could be exploited.  Neither failing an
> assertion nor skipping a character in a filename of your choice is
> interesting.  We don't support compiling with NDEBUG.
>=20
> Kevin, Max, do you agree?

I wouldn't call it "not interesting" if adding an image to your VM at
runtime can crash the whole thing.

(qemu-img create -f qcow2 -u -b 'json:{"%"}' foo.qcow2 64M)

Whether this is a security issue...  I don't know, but it is a DoS.

Max


--r1YJLh0MQq6Njgvu6OtH0zDursJv3MaRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw18c4ACgkQ9AfbAGHV
z0AnBgf/bVue5dg8bxbWChDYhKxCqiHlFVVKdJVPls6AqXhhaWuSaWpyerfnh30o
u7FBkHnlzdAXRewE4f8fDSEf+59fswLKaNUXBvmMFgxAVNfK/kgsAlwQP8JIofz/
DXZpNDwJ0Wtfz4uKPRPxTmw6f+Zjdg1iRnKOOLU4IBwPEGg8nBEWQh4GxiYYVZZA
ezwDjreE2wCAwHX9IkBNxWZhhe/3y5Znwb/Umq8m5Uhc54bcC/gl8dF3fP7a4XJF
D1O1AcHqte3ktYWhLdwNnpJfumXC8QEDKhhwfu5X5z3EZ/0BTobdl3mEzGiCWZrp
wUet/0eHD9Cca7KZIDERqpVgxHYXug==
=8ni1
-----END PGP SIGNATURE-----

--r1YJLh0MQq6Njgvu6OtH0zDursJv3MaRH--
