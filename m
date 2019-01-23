Received: from eggs.gnu.org ([209.51.188.92]:53032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIWs-00029r-Ti
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIJl-0005bm-U2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:11:47 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-2-mreitz@redhat.com>
	<fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
Date: Wed, 23 Jan 2019 14:06:27 +0100
MIME-Version: 1.0
In-Reply-To: <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tdY5Ad7LZIgG3Fy42LkHk06mwNV8nudaI"
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tdY5Ad7LZIgG3Fy42LkHk06mwNV8nudaI
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <64732cb4-b586-2e38-b2b4-880359c56a3e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-2-mreitz@redhat.com>
 <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
In-Reply-To: <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.01.19 21:55, Eric Blake wrote:
> On 12/21/18 5:47 PM, Max Reitz wrote:
>> In some cases, we may want to deal with qemu-nbd errors (e.g. by
>> launching it in a different configuration until it no longer throws
>> any).  In that case, we do not want its output ending up in the test
>> output.
>>
>> It may still be useful for handling the error, though, so add a new
>> function that works basically like qemu_nbd(), only that it returns th=
e
>> qemu-nbd output instead of making it end up in the log.  In contrast t=
o
>> qemu_img_pipe(), it does still return the exit code as well, though,
>=20
> In contrast to qemu_nbd(),

But qemu_nbd() does return the exit code.  qemu_img_pipe() doesn't.

>> because that is even more important for error handling.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index d537538ba0..9c3eb9e2f8 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -190,6 +190,20 @@ def qemu_nbd(*args):
>>      '''Run qemu-nbd in daemon mode and return the parent's exit code'=
''
>>      return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
>> =20
>> +def qemu_nbd_pipe(*args):
>> +    '''Run qemu-nbd in daemon mode and return both the parent's exit =
code
>> +       and its output'''
>> +    subp =3D subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args)=
,
>> +                            stdout=3Dsubprocess.PIPE,
>> +                            stderr=3Dsubprocess.STDOUT,
>> +                            universal_newlines=3DTrue)
>> +    exitcode =3D subp.wait()
>> +    if exitcode < 0:
>> +        sys.stderr.write('qemu-nbd received signal %i: %s\n' %
>> +                         (-exitcode,
>> +                          ' '.join(qemu_nbd_args + ['--fork'] + list(=
args))))
>> +    return exitcode, subp.communicate()[0]
>> +
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for reviewing!

Max


--tdY5Ad7LZIgG3Fy42LkHk06mwNV8nudaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIZtMACgkQ9AfbAGHV
z0DfHQf/QrZm2Ak2abE+kaZQYlPD6orCK5Yag2yO04fOhKKh4prJ+lScHkECIwu7
9TUqJyLPPHBOuiieRbZzKzM+Nas11fa0vVkfT2r8eKiqQd0ZN9b4hfQc/oQ931vy
L1BsKYQyBzXR9vMXvwQuW1KYdO0VR44uq1dBK507W66X3z+kkdYx7DlDb2CSssUA
U3YD1EJyNXUlTvLJFox1b/1Q1Z6AGzsyJia1UUJLFv6Jopepy4I1kHOIn/b6XR18
8OVvF+JriIG1EqLa/dhaiREqa1p32PblOuULesURLXiE5JNbIppMrzyJ+b60NwHZ
83mJGSbyoNLLFYCBSnmnI6+2cMXCcA==
=aoDq
-----END PGP SIGNATURE-----

--tdY5Ad7LZIgG3Fy42LkHk06mwNV8nudaI--
