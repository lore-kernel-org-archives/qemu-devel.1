Received: from eggs.gnu.org ([2001:4830:134:3::10]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0qS-0005zg-VO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0qR-0002aD-KU
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:50:05 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
Date: Tue, 9 Jan 2018 14:49:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SO4bNFYvuR35zXvepUcjE5xchd8RBweVU"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SO4bNFYvuR35zXvepUcjE5xchd8RBweVU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
Subject: Re: [PATCH v2 6/6] iotest 201: new test for qmp nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-7-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/201     | 130 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/201.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 136 insertions(+)
>  create mode 100644 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out
>=20

pep8 complains:

$ pep8 tests/qemu-iotests/201
tests/qemu-iotests/201:31:1: E302 expected 2 blank lines, found 1
tests/qemu-iotests/201:68:17: E128 continuation line under-indented for
visual indent
tests/qemu-iotests/201:69:17: E128 continuation line under-indented for
visual indent

I don't mind cleaning those up (if you don't have to respin because of
my comments on 5/6).

> +import os
> +import sys
> +import iotests
> +import time
> +from iotests import qemu_img, qemu_io, filter_qemu_io, QemuIoInteracti=
ve
> +
> +nbd_port =3D '10900'
> +nbd_uri =3D 'nbd+tcp://localhost:' + nbd_port + '/exp'

Is this still going to be safe when we improve the testsuite to run
multiple tests in parallel?  Wouldn't it be safer to dynamically choose
the port, instead of hard-coding one?

> +disk =3D os.path.join(iotests.test_dir, 'disk')
> +
> +class TestNbdServerRemove(iotests.QMPTestCase):
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, disk, '1M')
> +
> +        self.vm =3D iotests.VM().add_drive(disk)
> +        self.vm.launch()
> +
> +        address =3D {
> +            'type': 'inet',
> +            'data': {
> +                'host': 'localhost',
> +                'port': nbd_port

Again, for a one-shot test, this works; but it doesn't lend itself to
parallel testing.  Maybe do a loop with incrementing port numbers until
one succeeds, if we can reliably detect when a port is already in use?

> +    def assertConnectFailed(self, qemu_io_output):
> +        self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
> +                         "can't open device nbd+tcp://localhost:10900/=
exp: " +

Worth parameterizing or filtering this assertion to match the rest of
the parameterization of nbd_port?

> +                         "Requested export not available\nserver repor=
ted: " +
> +                         "export 'exp' not present")
> +
> +    def do_test_connect_after_remove(self, force=3DNone):
> +        args =3D ('-r', '-f', 'raw', '-c', 'read 0 512', nbd_uri)
> +        self.assertReadOk(qemu_io(*args))
> +        self.remove_export('exp', force)
> +        self.assertExportNotFound('exp')
> +        self.assertConnectFailed(qemu_io(*args))
> +
> +    def test_connect_after_remove_default(self):
> +        self.do_test_connect_after_remove()
> +
> +    def test_connect_after_remove_safe(self):
> +        self.do_test_connect_after_remove(False)
> +
> +    def test_connect_after_remove_force(self):
> +        self.do_test_connect_after_remove(True)

May need updates if my comments on 3/6 result in us having three states
rather than just 2 (the difference being whether there is a knob for
choosing to let existing clients gracefully disconnect with all pending
I/O completed, and/or failing the nbd-server-remove if a client is still
connected).

> +++ b/tests/qemu-iotests/201.out
> @@ -0,0 +1,5 @@
> +.......
> +----------------------------------------------------------------------=

> +Ran 7 tests

I'm not a fan of python tests that are difficult to debug.  Your
additions to 147 in patch 4/6 are okay (hard to debug, but an
incremental addition); but is it possible to rewrite this test in a bit
more verbose manner?  See test 194 and this message for more details:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00234.html

> +
> +OK
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 3e688678dd..15df7678b3 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -197,3 +197,4 @@
>  197 rw auto quick
>  198 rw auto
>  200 rw auto
> +201 rw auto quick
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SO4bNFYvuR35zXvepUcjE5xchd8RBweVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVKu4ACgkQp6FrSiUn
Q2qLvQgAgywWe7e0ylNFvj1PFrQoNbEZOoi4iEQksRab8FJkJOPq9b8TOX1zNI/+
+QMQwl+ftvYd5DddlaRMAEraknF7qJPXiu9nhV+gx0c/ANBpzkRRI0wOtSbtezz1
4BSCnS0wqvJxGpntW/Ao+lwmZ/cBrCQeo5ivjMAXZC1hyuRr+6K40cKap1pZ0mt5
v9BrvDgQTj5a02VjRQ1xfN+NpNH+cxJdsw0Xk7jCX8Ljkf5qh/J19rR9OQBOTirX
6C3qRWsRjqvrvst0cHM5fXvfy4GjjQlQRwFdD5gFv9tqb8HhIHzTrq4OUMbHxS8Z
P6NEskcEPKQlNeBp8e5Ccy5Vg3y69A==
=r/04
-----END PGP SIGNATURE-----

--SO4bNFYvuR35zXvepUcjE5xchd8RBweVU--
