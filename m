Received: from eggs.gnu.org ([209.51.188.92]:52850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIWs-0001yE-Lx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIJm-0005cA-JL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:11:47 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
Date: Wed, 23 Jan 2019 14:05:24 +0100
MIME-Version: 1.0
In-Reply-To: <b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dghNEwfQbfA5SNQtcUegQTK3VgUqXDsCl"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be
 run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dghNEwfQbfA5SNQtcUegQTK3VgUqXDsCl
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
In-Reply-To: <b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.01.19 21:50, John Snow wrote:
>=20
>=20
> On 12/21/18 6:47 PM, Max Reitz wrote:
>> To do this, we need to allow creating the NBD server on various ports
>> instead of a single one (which may not even work if you run just one
>> instance, because something entirely else might be using that port).
>>
>> So we just pick a random port in [32768, 32768 + 1024) and try to crea=
te
>> a server there.  If that fails, we just retry until something sticks.
>>
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
>> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
>> index 3e10a9969e..82513279b0 100755
>> --- a/tests/qemu-iotests/147
>> +++ b/tests/qemu-iotests/147
>> @@ -19,13 +19,17 @@
>>  #
>> =20
>>  import os
>> +import random
>>  import socket
>>  import stat
>>  import time
>>  import iotests
>> -from iotests import cachemode, imgfmt, qemu_img, qemu_nbd
>> +from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_p=
ipe
>> =20
>> -NBD_PORT =3D 10811
>> +NBD_PORT_START      =3D 32768
>> +NBD_PORT_END        =3D NBD_PORT_START + 1024
>> +NBD_IPV6_PORT_START =3D NBD_PORT_END
>> +NBD_IPV6_PORT_END   =3D NBD_IPV6_PORT_START + 1024
>> =20
>>  test_img =3D os.path.join(iotests.test_dir, 'test.img')
>>  unix_socket =3D os.path.join(iotests.test_dir, 'nbd.socket')
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
>=20
> My only half-empty question is if we are guaranteed to have a locale an=
d
> environment such that this string will always be present when we
> encounter that specific error?
>=20
> I suppose even if not, that it'll just fail hard and it's no worse than=

> what we had before.

I can tell you at least that my locale is de_DE.UTF-8.

>> +        self.fail(msg)
>> +
>>      def _server_up(self, *args):
>> -        self.assertEqual(qemu_nbd('-f', imgfmt, test_img, *args), 0)
>> +        self.assertTrue(self._try_server_up(*args))
>> =20
>>      def test_inet(self):
>> -        self._server_up('-b', 'localhost', '-p', str(NBD_PORT))
>> +        while True:
>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_EN=
D)
>> +            if self._try_server_up('-b', 'localhost', '-p', str(nbd_p=
ort)):
>> +                break
>=20
> Why not just iterate over the range so that once the range is exhausted=

> we're guaranteed to fail?

Hm.  With this approach chances are higher that the first port you try
works, so it does have a benefit.  I'm not sure whether it's actually a
problem that this will pretty much break down if everything in the range
is allocated, because I can't see that happening.

Iterating over a range wouldn't make the code easier because I would
have to account for the error case. O:-)

>> +
>>          address =3D { 'type': 'inet',
>>                      'data': {
>>                          'host': 'localhost',
>> -                        'port': str(NBD_PORT)
>> +                        'port': str(nbd_port)
>>                      } }
>> -        self.client_test('nbd://localhost:%i' % NBD_PORT,
>> +        self.client_test('nbd://localhost:%i' % nbd_port,
>>                           flatten_sock_addr(address))
>> =20
>>      def test_unix(self):
>> @@ -130,8 +146,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
>>          except OSError:
>>              pass
>> =20
>> -    def _server_up(self, address, export_name=3DNone, export_name2=3D=
None):
>> +    # Returns False on EADDRINUSE; fails an assertion on other errors=
=2E
>> +    # Returns True on success.
>> +    def _try_server_up(self, address, export_name=3DNone, export_name=
2=3DNone):
>>          result =3D self.server.qmp('nbd-server-start', addr=3Daddress=
)
>> +        if 'error' in result and \
>> +           'Address already in use' in result['error']['desc']:
>> +            return False
>>          self.assert_qmp(result, 'return', {})
>> =20
>>          if export_name is None:
>> @@ -146,20 +167,28 @@ class BuiltinNBD(NBDBlockdevAddBase):
>>                                       name=3Dexport_name2)
>>              self.assert_qmp(result, 'return', {})
>> =20
>> +        return True
>> +
>> +    def _server_up(self, address, export_name=3DNone, export_name2=3D=
None):
>> +        self.assertTrue(self._try_server_up(address, export_name, exp=
ort_name2))
>> =20
>>      def _server_down(self):
>>          result =3D self.server.qmp('nbd-server-stop')
>>          self.assert_qmp(result, 'return', {})
>> =20
>>      def do_test_inet(self, export_name=3DNone):
>> -        address =3D { 'type': 'inet',
>> -                    'data': {
>> -                        'host': 'localhost',
>> -                        'port': str(NBD_PORT)
>> -                    } }
>> -        self._server_up(address, export_name)
>> +        while True:
>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_EN=
D)
>> +            address =3D { 'type': 'inet',
>> +                        'data': {
>> +                            'host': 'localhost',
>> +                            'port': str(nbd_port)
>> +                        } }
>> +            if self._try_server_up(address, export_name):
>> +                break
>> +
>>          export_name =3D export_name or 'nbd-export'
>> -        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, export_=
name),
>> +        self.client_test('nbd://localhost:%i/%s' % (nbd_port, export_=
name),
>>                           flatten_sock_addr(address), export_name)
>>          self._server_down()
>> =20
>> @@ -173,15 +202,19 @@ class BuiltinNBD(NBDBlockdevAddBase):
>>          self.do_test_inet('shadow')
>> =20
>>      def test_inet_two_exports(self):
>> -        address =3D { 'type': 'inet',
>> -                    'data': {
>> -                        'host': 'localhost',
>> -                        'port': str(NBD_PORT)
>> -                    } }
>> -        self._server_up(address, 'exp1', 'exp2')
>> -        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp1')=
,
>> +        while True:
>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_EN=
D)
>> +            address =3D { 'type': 'inet',
>> +                        'data': {
>> +                            'host': 'localhost',
>> +                            'port': str(nbd_port)
>> +                        } }
>> +            if self._try_server_up(address, 'exp1', 'exp2'):
>> +                break
>> +
>> +        self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp1')=
,
>>                           flatten_sock_addr(address), 'exp1', 'node1',=
 False)
>> -        self.client_test('nbd://localhost:%i/%s' % (NBD_PORT, 'exp2')=
,
>> +        self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp2')=
,
>>                           flatten_sock_addr(address), 'exp2', 'node2',=
 False)
>>          result =3D self.vm.qmp('blockdev-del', node_name=3D'node1')
>>          self.assert_qmp(result, 'return', {})
>> @@ -197,20 +230,25 @@ class BuiltinNBD(NBDBlockdevAddBase):
>>          except socket.gaierror:
>>              # IPv6 not available, skip
>>              return
>> -        address =3D { 'type': 'inet',
>> -                    'data': {
>> -                        'host': '::1',
>> -                        'port': str(NBD_PORT),
>> -                        'ipv4': False,
>> -                        'ipv6': True
>> -                    } }
>> +
>> +        while True:
>> +            nbd_port =3D random.randrange(NBD_IPV6_PORT_START, NBD_IP=
V6_PORT_END)
>> +            address =3D { 'type': 'inet',
>> +                        'data': {
>> +                            'host': '::1',
>> +                            'port': str(nbd_port),
>> +                            'ipv4': False,
>> +                            'ipv6': True
>> +                        } }
>> +            if self._try_server_up(address):
>> +                break
>> +
>>          filename =3D { 'driver': 'raw',
>>                       'file': {
>>                           'driver': 'nbd',
>>                           'export': 'nbd-export',
>>                           'server': flatten_sock_addr(address)
>>                       } }
>> -        self._server_up(address)
>>          self.client_test(filename, flatten_sock_addr(address), 'nbd-e=
xport')
>>          self._server_down()
>> =20
>>
>=20
> I guess my only other observation is that we have a lot of "while True"=

> loops now, is it worth creating some kind of helper that does the dirty=

> work of finding a serviceable port or nah?

Seems reasonable, I'll see how it looks.

> If none of my observations spark joy:
>=20
> 1-3: Reviewed-By: John Snow <jsnow@redhat.com>

Thanks!

Max


--dghNEwfQbfA5SNQtcUegQTK3VgUqXDsCl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIZpQACgkQ9AfbAGHV
z0BGmAgAkp/0EQbdoopg/svgmLu3PfrMRmOF99fQjtm77l25uE4g6QdrD8oRbuq+
4va+1BfV2BCAIy3zbOkDSYuBUMqBj/zKC8SbDi0Ly7d8vDL19fvsyLVQmLUYZfj8
0qlppyyzEaGJ35XAy6PjL8lZEdkFIGeuURLLQbkYAI9wgnZY+OlDtXk/0XQN0t81
k4EySuB3R0hi297u5ou++YjvGHIXHb+pjErpsyTk1m1T4EH4P6ADB+vXcT+ZtyY1
9qAx1HLNkDarHmefL+qJBTj3/HN6WUshsknxiseGdMJYdf8CS7wF3ECQlUoji4o7
PI+4gBemK2X0l9trg6mdjNrkiRNYuw==
=Y178
-----END PGP SIGNATURE-----

--dghNEwfQbfA5SNQtcUegQTK3VgUqXDsCl--
