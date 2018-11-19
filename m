Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOhLq-00079T-Nn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gOhLn-00058h-I6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:04:22 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-6-berrange@redhat.com>
	<5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
	<20181119102732.GF19532@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5a677a31-ce10-cc2a-58b1-5589c20970da@redhat.com>
Date: Mon, 19 Nov 2018 12:04:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181119102732.GF19532@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w1XmENmuiVk6BxWDw2RoHqYHAKraHIdaL"
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: add iotests helpers for dealing
 with TLS certificates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1XmENmuiVk6BxWDw2RoHqYHAKraHIdaL
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <5a677a31-ce10-cc2a-58b1-5589c20970da@redhat.com>
Subject: Re: [PATCH 5/6] tests: add iotests helpers for dealing with TLS
 certificates
References: <20181116155325.22428-1-berrange@redhat.com>
 <20181116155325.22428-6-berrange@redhat.com>
 <5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
 <20181119102732.GF19532@redhat.com>
In-Reply-To: <20181119102732.GF19532@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.11.18 11:27, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 16, 2018 at 10:39:03AM -0600, Eric Blake wrote:
>> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
>>> Add helpers to common.tls for creating TLS certificates for a CA,
>>> server and client.
>>
>> MUCH appreciated!  We NEED this coverage, easily automated.
>>
>>>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>   tests/qemu-iotests/common.tls | 139 +++++++++++++++++++++++++++++++=
+++
>>>   1 file changed, 139 insertions(+)
>>>   create mode 100644 tests/qemu-iotests/common.tls
>>>
>>> diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/commo=
n.tls
>>> new file mode 100644
>>
>> I was a bit surprised that this wasn't 100755, but this matches the fa=
ct
>> that none of the other common.* are executable. And after thinking mor=
e, it
>> makes sense - they aren't standalone scripts, but designed to be sourc=
ed,
>> and 'source' doesn't care about execute bits.
>>
>>> +tls_dir=3D"${TEST_DIR}/tls"
>>> +
>>> +function tls_x509_cleanup()
>>> +{
>>> +    rm -f ${tls_dir}/*.pem
>>> +    rm -f ${tls_dir}/*/*.pem
>>> +    rmdir ${tls_dir}/*
>>> +    rmdir ${tls_dir}
>>
>> Why not just:
>> rm -rf $tls_dir
>=20
> Yeah, I guess we could do that for simplicity
>=20
>> Also, the quoting is a bit inconsistent. if ${TEST_DIR} can contain sp=
aces,
>> then all uses of ${tls_dir} need to be in "".
>=20
> Hmm, yes.

Which by the way is a very good reason *not* to blindly use "rm -r".

So far we only seem to have one instance of "rm -r" in the iotests (and
that is on three files, so I don't even know why that has -r), and I'm
glad about that.

I prefer for scripts to only delete what they have created and not
blindly delete something.  Wildcards are already kind of pushing it.

Maybe the user has created the tls dir beforehand, then I'd prefer for
the iotests not to just delete it and everything in it.  But the worst
of course would be if we get escaping wrong somewhere (as demonstrated
here) and suddenly we delete a completely unrelated directory by
accident.  Anyone remember Steam's 'rm -rf "$STEAMROOT"/*'?

Everyone knows they have to be careful with deleting things, but most of
the time it is a bother if you're in an interactive shell and know your
directory structure and all the arguments you're passing perfectly well.
 But a script doesn't know either, and "it's a bother" is not really an
argument if you have to write the code just once.

Max


--w1XmENmuiVk6BxWDw2RoHqYHAKraHIdaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvymKUACgkQ9AfbAGHV
z0COcQf/Rn7Twj+wGfild2Cpl2zeEclXbCKGGpYnKAZ59azr6LcUqihGtFQQOfnn
MLYz0fyJKnwbppVt/hyykup2AwnlD4Jb2FgmaJxBJZq8SDwDzyk892yW05bdmdZQ
J/mm8KGwDs7ByjWart3HsWL973Ve9oJ8Z0ASb7mewJHKMAT1BapkdvCtCwM7hd6D
dbHM9HrOo4yr/bi7vo0ZZJEq/gmsVO3jXbrZDw33SlS9IcGEtp4wAA9ydPS9Yg7z
VCL2WNHhkwW4VpyfN24uQgaFDV+8yT5MXsDUHhAcnrICcROHhBe4pts3wPWml5pe
Odpdjf1gB+2E53t/6WnDb8Zd9ftrEg==
=JpQU
-----END PGP SIGNATURE-----

--w1XmENmuiVk6BxWDw2RoHqYHAKraHIdaL--
