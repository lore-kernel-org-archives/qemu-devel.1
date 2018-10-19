Received: from eggs.gnu.org ([2001:4830:134:3::10]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQR3-0008RL-4P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQR1-0002sD-UP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:47:08 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-4-mreitz@redhat.com>
	<20181015195343.GA31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b998c3a-dce4-9ba1-35e7-90466605a4b9@redhat.com>
Date: Fri, 19 Oct 2018 10:46:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181015195343.GA31060@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jMlJQzfQYpeRZPC7WXQc8JAR7JXxh7j1s"
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Use Python byte strings where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jMlJQzfQYpeRZPC7WXQc8JAR7JXxh7j1s
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <9b998c3a-dce4-9ba1-35e7-90466605a4b9@redhat.com>
Subject: Re: [PATCH 3/9] iotests: Use Python byte strings where appropriate
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-4-mreitz@redhat.com>
 <20181015195343.GA31060@habkost.net>
In-Reply-To: <20181015195343.GA31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 21:53, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 04:14:47PM +0200, Max Reitz wrote:
>> Since byte strings are no longer the default in Python 3, we have to
>> explicitly use them where we need to, which is mostly when working wit=
h
>> structures.  It also means that we need to open a file in binary mode
>> when we want to use structures.
>>
>> On the other hand, we have to accomodate for the fact that some
>> functions (still) work with byte strings but we want to use unicode
>> strings (in Python 3 at least, and it does not matter in Python 2).
>> This includes base64 encoding, but it is most notable when working wit=
h
>> the subprocess module: Either we set univeral_newlines to True so that=

>> the default streams are opened in text mode (hence this parameter is
>> aliased as "text" as of 3.7), or, if that is not possible, we have to
>> decode the output to a normal string.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> [...]
>> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
>> index 9e0cad76f9..1225334cb8 100755
>> --- a/tests/qemu-iotests/149
>> +++ b/tests/qemu-iotests/149
>> @@ -79,7 +79,7 @@ class LUKSConfig(object):
>> =20
>>      def first_password_base64(self):
>>          (pw, slot) =3D self.first_password()
>> -        return base64.b64encode(pw)
>> +        return base64.b64encode(pw.encode('ascii')).decode('ascii')
>=20
> Would we want to have a test case for non-ascii passwords in the
> future?  In that case you would probably need to make
> self.passwords[] contain byte strings instead of text.

I remember someone once providing a non-ASCII initial password to some
system for me.  I remember the system was running Windows, and I was
running Linux, so the system expected ISO-8859-1, while I was sending UTF=
-8.

The moral of the story is that you probably don't want non-ASCII
passwords.  And if we do want to test them, well, we'll need to decide
on an encoding then (or use byte strings, as you suggest).

> In either case, using 'ascii' as the encoding everywhere will
> ensure the code will not try to be too smart about string
> encodings if that happens.  I like that.
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks for reviewing!

Max


--jMlJQzfQYpeRZPC7WXQc8JAR7JXxh7j1s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJmf0ACgkQ9AfbAGHV
z0DJ+Qf8DSD6c+SZOnH7eDNa/UjBgLemkvU0OVlSsTsWC8WmggFb7/qfxqPDu8m8
ruCxqZNjxPl6tHWtWVHqwFyUwQdNjscHe8mUmxba98yYDhUFC3bWWXOgJ/nc7X9R
vDhz6x4Ft/U+tMAAzQVNxBHZ1G5Cw8OCNQAVtuwj3dxYO7ES0WPVCeDYzKmeb9sU
mZtQjHKaysW7kBBDjLbrvCXf2qerGJRnTiPpOi/+rWVaRoZ1gQ4Uy4h45k6m7GQM
Lhai8Icmk7aRj+tOVvi3Ppow3PiT2qqTJLGXhPw5b+G/wy50Est7i5jPM+8uif7i
dtRe9w7/gfxnK2S1AOzJoojpJgRJ7A==
=wcQX
-----END PGP SIGNATURE-----

--jMlJQzfQYpeRZPC7WXQc8JAR7JXxh7j1s--
