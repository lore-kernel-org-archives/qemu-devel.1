Received: from eggs.gnu.org ([209.51.188.92]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIWr-0001y4-Eb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIKy-0006BO-R0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:13:01 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
Date: Wed, 23 Jan 2019 14:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZR5kaa5HsMn1QrNRHTCWXAQggibzIifMt"
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
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
--ZR5kaa5HsMn1QrNRHTCWXAQggibzIifMt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
In-Reply-To: <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.01.19 22:02, Eric Blake wrote:
> On 12/21/18 5:47 PM, Max Reitz wrote:
>> To do this, we need to allow creating the NBD server on various ports
>> instead of a single one (which may not even work if you run just one
>> instance, because something entirely else might be using that port).
>=20
> Can you instead reuse the ideas from nbd_server_set_tcp_port() from
> qemu-iotests/common.nbd?
>=20
>>
>> So we just pick a random port in [32768, 32768 + 1024) and try to crea=
te
>> a server there.  If that fails, we just retry until something sticks.
>=20
> That has the advantage of checking whether a port is actually in use
> (using 'ss' - although it does limit the test to Linux-only; perhaps
> using socat instead of ss could make the test portable to non-Linux?)

But doesn't that give you race conditions?  That's the point of this
series, so you can run multiple instances of 147 concurrently.

>> For the IPv6 test, we need a different range, though (just above that
>> one).  This is because "localhost" resolves to both 127.0.0.1 and ::1.=

>> This means that if you bind to it, it will bind to both, if possible, =
or
>> just one if the other is already in use.  Therefore, if the IPv6 test
>> has already taken [::1]:some_port and we then try to take
>> localhost:some_port, that will work -- only the second server will be
>> bound to 127.0.0.1:some_port alone and not [::1]:some_port in addition=
=2E
>> So we have two different servers on the same port, one for IPv4 and on=
e
>> for IPv6.
>>
>> But when we then try to connect to the server through
>> localhost:some_port, we will always end up at the IPv6 one (as long as=

>> it is up), and this may not be the one we want.
>>
>> Thus, we must make sure not to create an IPv6-only NBD server on the
>> same port as a normal "dual-stack" NBD server -- which is done by usin=
g
>> distinct port ranges, as explained above.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/147 | 98 +++++++++++++++++++++++++++++------------=
-
>>  1 file changed, 68 insertions(+), 30 deletions(-)
>>
>=20
>> @@ -88,17 +92,29 @@ class QemuNBD(NBDBlockdevAddBase):
>>          except OSError:
>>              pass
>> =20
>> +    def _try_server_up(self, *args):
>> +        status, msg =3D qemu_nbd_pipe('-f', imgfmt, test_img, *args)
>> +        if status =3D=3D 0:
>> +            return True
>> +        if 'Address already in use' in msg:
>> +            return False
>> +        self.fail(msg)
>=20
> Do you actually need to attempt a qemu-nbd process, if you take my
> suggestion of using ss to probe for an unused port?  And if not, do we
> still need qemu_nbd_pipe() added earlier in the series?
>=20
>=20
>> -        address =3D { 'type': 'inet',
>> -                    'data': {
>> -                        'host': 'localhost',
>> -                        'port': str(NBD_PORT)
>> -                    } }
>> -        self._server_up(address, export_name)
>> +        while True:
>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_EN=
D)
>=20
> common.nbd just iterates, instead of trying random ports.

I'm not sure which is better.  Iterating gives guaranteed termination,
trying random ports means the first one you try will usually work.

Max


--ZR5kaa5HsMn1QrNRHTCWXAQggibzIifMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIaFcACgkQ9AfbAGHV
z0D4Ngf+OdIJwJSWUjUztE/o+uiJU3eNhdXuWbncyoGcOGgTP6LrxxOWLDxc2Jge
h4C3r33sBbUfF8CzjwtuKD96QwKdme8NxJOkiuTkouv6l7rmVXGLMCK0bJEAJhZO
qaMRu0mQ2OivUbdQIdBPa+td94DQNueNz1A6z2O4WHW0pfmtjKrSyHZsCG5KvBYS
K1Wt14AieKdJGPf3sI7s+yUANjGb1ZDnT99e5jDyz+2MDuoBJLkPILsZUU4fzNqn
VHts62K+Xj0yjD61c7l8A6mIa/zgLhzj2mTXSuutTkDzh2GQqWLPOEcU6/DFf+we
1BJUm+QXutHhsvfRerm6HIvgnJKU/w==
=0WQA
-----END PGP SIGNATURE-----

--ZR5kaa5HsMn1QrNRHTCWXAQggibzIifMt--
