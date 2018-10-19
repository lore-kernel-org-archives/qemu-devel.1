Received: from eggs.gnu.org ([2001:4830:134:3::10]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDR2G-0001Hk-1h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDR2E-0000H5-S8
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:25:35 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-9-mreitz@redhat.com>
	<20181015211722.GG31060@habkost.net>
	<39b852b8-f570-a813-3e2b-2a20db94d3bb@redhat.com>
	<20181016001215.GL31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <342ed2ef-989a-28c7-99fc-1e964607dec5@redhat.com>
Date: Fri, 19 Oct 2018 11:25:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181016001215.GL31060@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2XD7CD2t62jzADpWbzKEBeXBhExeiK4GK"
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: Modify imports for Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2XD7CD2t62jzADpWbzKEBeXBhExeiK4GK
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <342ed2ef-989a-28c7-99fc-1e964607dec5@redhat.com>
Subject: Re: [PATCH 8/9] iotests: Modify imports for Python 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-9-mreitz@redhat.com>
 <20181015211722.GG31060@habkost.net>
 <39b852b8-f570-a813-3e2b-2a20db94d3bb@redhat.com>
 <20181016001215.GL31060@habkost.net>
In-Reply-To: <20181016001215.GL31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 02:12, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 08:05:02PM -0400, Cleber Rosa wrote:
>>
>>
>> On 10/15/18 5:17 PM, Eduardo Habkost wrote:
>>> On Mon, Oct 15, 2018 at 04:14:52PM +0200, Max Reitz wrote:
>>>> There are two imports that need to be modified when running the iote=
sts
>>>> under Python 3: One is StringIO, which no longer exists; instead, th=
e
>>>> StringIO class comes from the io module, so import it from there.  T=
he
>>>> other is the ConfigParser, which has just been renamed to configpars=
er.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/iotests.py            | 8 ++++++--
>>>>  tests/qemu-iotests/nbd-fault-injector.py | 7 +++++--
>>>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iote=
sts.py
>>>> index 7ca94e9278..a64ea90fb4 100644
>>>> --- a/tests/qemu-iotests/iotests.py
>>>> +++ b/tests/qemu-iotests/iotests.py
>>>> @@ -683,13 +683,17 @@ def main(supported_fmts=3D[], supported_oses=3D=
['linux'], supported_cache_modes=3D[],
>>>> =20
>>>>      # We need to filter out the time taken from the output so that =
qemu-iotest
>>>>      # can reliably diff the results against master output.
>>>> -    import StringIO
>>>> +    if sys.version_info.major >=3D 3:
>>>> +        from io import StringIO
>>>> +    else:
>>>> +        from StringIO import StringIO
>>>
>>> Considering that io.StringIO exists on Python 2.7, a comment
>>> explaining why exactly it doesn't work would be nice.

Oh, it does exist?  I didn't know. O:-)

So I suppose it's because the test runner emits just normal strings,
which in 2.x are byte strings; but io's StringIO always expects Unicode
strings.  StringIO, OTOH, accepts both (and returns Unicode strings once
you put a Unicode string into it).

>> Another possibility, that I find self explanatory:
>>
>> import io
>>
>> if sys.version_info.major >=3D 3:
>>    output =3D io.StringIO()
>> else:
>>    output =3D io.BytesIO()
>=20
> Looks nice and clean.
>=20
> But I'm not sure all output sent to `output` when running with
> Python 2 will be byte strings.  What if `unittest.TextTestRunner`
> tries to write unicode strings to `output`?

Hm.  It doesn't look this way to me in practice.  And considering that
it only really prints a test summary, I don't think there are edge cases
where it behaves differently.

So I think using BytesIO() in 2.x is better.

Max


--2XD7CD2t62jzADpWbzKEBeXBhExeiK4GK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJov8ACgkQ9AfbAGHV
z0AnHwgAvjzKU3qm+l8HGt8rVqNfMZsiNhXu+mYsSAdBAAC4Dw6DpQB5clhZw1eL
6SbgEnWuUvGFibj9S7RkUIj6/LHUFVKv5bEzliEjsh4ZGdMoqJvTf5A0p+mh2r1D
CDMdAkYf9yTJBYBtvQ1ttLAsugeFUAgzS9WI/htMRmsCLjYCxce/1MyJo3xQcuQ7
VYH39mhJA1NnMXXbTEFu6+yM5+PjdQsCCQziZt9t97V1hH2ey8nQqrHF1SkDTueT
sh9itkd0UMjc467XqdO1kZqXhf0Y3/CGYjelZAiTZobGZw+Gvh29HZ2NmMn1dlTS
gxdc/tpt/hb3Bo+ux81O3WrHdG0MrQ==
=hkrZ
-----END PGP SIGNATURE-----

--2XD7CD2t62jzADpWbzKEBeXBhExeiK4GK--
