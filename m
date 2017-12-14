Received: from eggs.gnu.org ([2001:4830:134:3::10]:33373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePPzH-0003pU-2d
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePPzD-00019t-PM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:39:31 -0500
Date: Thu, 14 Dec 2017 09:39:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214093907.GA14433@stefanha-x1.localdomain>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 06:35:51PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> With this series we can now write tests using Python rather than C.
> For complex tests this can reduce the test development time, we can focus=
 on
> the test purposes instead of his implementation details.
>=20
> - 1,2: we already have Python classes to run Block tests, move all the
>   non Block-related methods to qtest.py,
> - 3: default TEST_DIR to TMPDIR,
> - 4: add a method to restrict tests to a list of supported machines,
> - 5: since the Block tests are output sensitive, do not mess with their
>   current tuned iotests::main(unittest), add a more generic one in qtest.=
py,
> - 6: finally modify the tests Makefile to run C/Python tests with the same
>   rule.

Python tests are great for functional tests of qemu-system-* that
interact via the command-line and QMP monitor.  From this perspective I
think the series is good.

> to have a better idea, here is a snippet from the next series:
>=20
>     class TestSdCardSpecV2(qtest.QMPTestCase):
>         [...]
>         def test_power_on_spec_v2(self):
>             self.bus.do_cmd(GO_IDLE_STATE)
>             [...]
>             # verify Card ID
>             data =3D self.bus.do_cmd(ALL_SEND_CID)
>             oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
>             self.assertEqual(oid, "XY") # QEMU default
>             self.assertEqual(pnm, "QEMU!") # QEMU default
>             self.assertEqual(psn, 0xdeadbeef) # QEMU default

Device qtests are better done in C than Python.  Python is not good at
binary I/O and porting this to Python 3 will be extra work later (Python
2 is set for End-of-Life in 2020, see https://pythonclock.org/).

More importantly, we already have libqos in C with a guest memory
allocator, PCI, and virtio support.  Fragmenting the small amount effort
that goes into device testing will delay libqos reaching critical mass.
Critical mass is where libqos provides all the infrastructure you need
to set up a device and focus on your actual test instead of machine,
bus, or device initialization.  Starting a Python device testing effort
will just lead to duplication and 2 underdeveloped device testing
frameworks.

Is there a specific reason why adding SD Card support to libqos is not
possible in C?

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMka7AAoJEJykq7OBq3PIwjEH/1aDJDH2vRICBz4YrSsHUF+K
TnSSYAARihSKPbQQd75xpo65ZhBQ8lpw9Ea/Lr+4dMmKtfHHNrou7ALyngp8dLye
f5lRqjR8AqO74kDyg2CS58LMR3ETrSTzrkQsUUeAs7KLy/tneQsH07KniHA5pTp+
3Up183fZDiDwxiaMP+gdXl2uNkw5i1YYH28WrYssZ9Kebe7rBnFSRV0S+DZqOjVh
zPFRR51LqkvGDWAa0kmW2eKeAWKD8ZewcmSfkQs2GyifXa+WjiLGevoTXrU1UpHP
R4iQB3pJLCnlx25s40C9IlELFdnZmGWy9uAhl4mwMGoy6DVtdJ3h5V3jZMhfbLI=
=0Kk0
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
